require "TimedActions/ISBaseTimedAction"
require "server/schilled_mechanic"

ISRecycleVehicle = ISBaseTimedAction:derive("ISRecycleVehicle")

function string:startsWith(start)
    return self:sub(1, #start) == start
end

local PartYieldTable = {
    -- Electronics
    ["Battery"] = "GetRecycleElectronicsYield",
    ["Headlight"] = "GetRecycleElectronicsYield",
    ["Radio"] = "GetRecycleElectronicsYield",
    ["lightbar"] = "GetRecycleElectronicsYield",
    ["Heater"] = "GetRecycleElectronicsYield",
    -- Small metal sheet
    ["GloveBox"] = "GetRecycleSmallMetalSheetYield",
    ["Muffler"] = "GetRecycleSmallMetalSheetYield",
    ["GasTank"] = "GetRecycleSmallMetalSheetYield",
    ["M998Muffler"] = "GetRecycleSmallMetalSheetYield",
    -- Metal sheet
    ["Door"] = "GetRecycleMetalSheetYield",
    ["EngineDoor"] = "GetRecycleMetalSheetYield",
    ["Trunk"] = "GetRecycleMetalSheetYield",
    ["TruckBed"] = "GetRecycleMetalSheetYield",
    ["TrunkDoor"] = "GetRecycleMetalSheetYield",
    ["M998Trunk"] = "GetRecycleMetalSheetYield",
    ["M998Rooftrack"] = "GetRecycleSmallMetalSheetYield",
    ["M998BackCover"] = "GetRecycleSmallMetalSheetYield",
    -- Metal pipe
    ["Suspension"] = "GetRecycleMetalPipeYield",
    ["Brake"] = "GetRecycleMetalPipeYield",
    -- Cloth
    ["Seat"] = "GetRecycleCarSeatsYield",
    -- Military
    ["M998WindshieldArmor"] = "GetRecycleArmorYield",
    ["M998Door"] = "GetRecycleArmorYield",
    ["M998BullBar"] = "GetRecycleBigMetalPipeYield",
    ["M998Mudflaps"] = "GetRecycleSmallMetalSheetYield"
}

function PartYieldTable:FindFunctionForPart(partId)
    for k, v in pairs(self) do
        if partId:startsWith(k) then
            return v
        end
    end
    return false
end

local function predicateBlowTorch(item)
    return (item ~= nil) and
            (item:hasTag("BlowTorch") or item:getType() == "BlowTorch") and
            (item:getDrainableUsesInt() >= 10)
end

function ISRecycleVehicle:isValid()
    if not predicateBlowTorch(self.character:getPrimaryHandItem()) then
        return false
    end
    return self.vehicle and not self.vehicle:isRemovedFromWorld();
end

function ISRecycleVehicle:update()
    self.character:faceThisObject(self.vehicle)
    self.item:setJobDelta(self:getJobDelta())
    self.item:setJobType(getText("ContextMenu_RemoveBurntVehicle"))

    if self.sound ~= 0 and not self.character:getEmitter():isPlaying(self.sound) then
        self.sound = self.character:playSound("BlowTorch")
    end

    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISRecycleVehicle:start()
    self.item = self.character:getPrimaryHandItem()
    self:setActionAnim("BlowTorch")
    self:setOverrideHandModels(self.item, nil)
    self.sound = self.character:playSound("BlowTorch")
end

function ISRecycleVehicle:stop()
    if self.item then
        self.item:setJobDelta(0)
    end
    if self.sound ~= 0 then
        self.character:getEmitter():stopSound(self.sound)
    end
    ISBaseTimedAction.stop(self)
end

function ISRecycleVehicle:mergeYieldTable(allParts, allXP, newParts, xpYield)
    for item, amount in pairs(newParts) do
        if allParts[item] == nil then
            allParts[item] = amount
        else
            allParts[item] = allParts[item] + amount
        end
    end

    for perk, amount in pairs(xpYield) do
        if allXP[perk] == nil then
            allXP[perk] = amount
        else
            allXP[perk] = allXP[perk] + amount
        end
    end
end

function ISRecycleVehicle:perform()
    if self.sound ~= 0 then
        self.character:getEmitter():stopSound(self.sound)
    end

    -- Base yield
    local itemYield = {
        ["Base.MetalBar"] = 2,
        ["Base.MetalPipe"] = 4,
        ["Base.SheetMetal"] = 5,
        ["Base.SmallSheetMetal"] = 6,
        ["Base.ScrapMetal"] = 30,
    }
    local xpYield = {
        [Perks.MetalWelding] = 10,
        [Perks.Mechanics] = 10,
    }

    local totalXp = 10;
    -- Adittional yield based on installed parts
    if self.vehicle ~= nil then
        for partIndex=1,self.vehicle:getPartCount() do
            local vehiclePart = self.vehicle:getPartByIndex(partIndex-1)
            if vehiclePart then
                local partName = vehiclePart:getId()
                if partName == "Engine" then
                    local yield, xp = SchilledMechanic:GetRecycleEngineYield(vehiclePart:getCondition())
                    self:mergeYieldTable(itemYield, xpYield, yield, xp)
                else
                    local yieldFunction = PartYieldTable:FindFunctionForPart(partName)
                    if yieldFunction then
                        local yield, xp = SchilledMechanic[yieldFunction](SchilledMechanic, self.character)
                        self:mergeYieldTable(itemYield, xpYield, yield, xp)
                    else
                        print("NO YIELD FUNCTION FOR PART: " .. partName)
                    end
                end
            end
        end
    end
    for _, amount in pairs(itemYield) do
        totalXp = totalXp + (amount * 10)
    end
    SchilledMechanic:YieldToWorld(self.vehicle:getSquare(), itemYield)
    SchilledMechanic:AddXp(self.character, xpYield)
    sendClientCommand(self.character, "vehicle", "remove", { vehicle = self.vehicle:getId() })
    self.item:setJobDelta(0);
    ISBaseTimedAction.perform(self)
end

function ISRecycleVehicle:new(character, vehicle)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.vehicle = vehicle
    o.maxTime = 800 - (character:getPerkLevel(Perks.MetalWelding) * 20);
    if character:isTimedActionInstant() then o.maxTime = 10 end
    return o
end

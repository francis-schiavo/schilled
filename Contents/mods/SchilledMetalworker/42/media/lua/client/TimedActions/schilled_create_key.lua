require "TimedActions/ISBaseTimedAction"

SchilledCreateKeyAction = ISBaseTimedAction:derive("SchilledCreateKeyAction")

local SCRAP_TYPE = "Base.IronBarQuarter"
local SCRAP_COST = 1

local function hasScrap(character)
    return character:getInventory():getNumberOfItem(SCRAP_TYPE, false, true) >= SCRAP_COST
end

local function hasSkills(character)
    return character:getPerkLevel(Perks.Mechanics) >= 2
        and character:getPerkLevel(Perks.MetalWelding) >= 2
end

function SchilledCreateKeyAction:isValid()
    if not hasScrap(self.character) or not hasSkills(self.character) then
        return false
    end
    if self.keyKind == "vehicle" then
        return self.vehicle ~= nil and not self.vehicle:isRemovedFromWorld()
    elseif self.keyKind == "building" then
        local sq = self.character:getCurrentSquare()
        return sq ~= nil and sq:getBuilding() ~= nil
    elseif self.keyKind == "door" then
        return self.door ~= nil and self.door:getObjectIndex() ~= -1
    end
    return false
end

function SchilledCreateKeyAction:waitToStart()
    if self.keyKind == "vehicle" and self.vehicle then
        self.character:faceThisObject(self.vehicle)
        return self.character:shouldBeTurning()
    elseif self.keyKind == "door" and self.door then
        self.character:faceThisObject(self.door)
        return self.character:shouldBeTurning()
    end
    return false
end

function SchilledCreateKeyAction:update()
    if self.keyKind == "vehicle" and self.vehicle then
        self.character:faceThisObject(self.vehicle)
    elseif self.keyKind == "door" and self.door then
        self.character:faceThisObject(self.door)
    end
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function SchilledCreateKeyAction:start()
    self:setActionAnim("Craft")
    self.sound = self.character:playSound("GeneratorRepair")
end

function SchilledCreateKeyAction:stop()
    if self.sound then
        self.character:stopOrTriggerSound(self.sound)
        self.sound = nil
    end
    ISBaseTimedAction.stop(self)
end

function SchilledCreateKeyAction:perform()
    if self.sound then
        self.character:stopOrTriggerSound(self.sound)
        self.sound = nil
    end

    -- Item remove + key create must run on the server in MP.
    if self.keyKind == "vehicle" then
        sendClientCommand(self.character, "SchilledMetalworker", "getVehicleKey", { vehicleId = self.vehicle:getId() })
    elseif self.keyKind == "building" then
        sendClientCommand(self.character, "SchilledMetalworker", "getBuildingKey", {})
    elseif self.keyKind == "door" then
        sendClientCommand(self.character, "SchilledMetalworker", "getDoorKey", { x = self.door:getX(), y = self.door:getY(), z = self.door:getZ(), index = self.door:getObjectIndex() })
    end

    ISBaseTimedAction.perform(self)
end

function SchilledCreateKeyAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    -- Match craftRecipe time = 150, slightly faster with MetalWelding
    return math.max(50, 150 - (self.character:getPerkLevel(Perks.MetalWelding) * 5))
end

function SchilledCreateKeyAction:new(character, keyKind, target)
    local o = ISBaseTimedAction.new(self, character)
    o.keyKind = keyKind
    o.stopOnWalk = true
    o.stopOnRun = true
    o.maxTime = o:getDuration()
    if keyKind == "vehicle" then
        o.vehicle = target
    elseif keyKind == "door" then
        o.door = target
    end
    return o
end

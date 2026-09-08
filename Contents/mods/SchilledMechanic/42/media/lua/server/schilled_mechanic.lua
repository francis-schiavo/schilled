SchilledMechanic = {}

function SchilledMechanic:YieldIncreaseBySkillPercentage(player, skills)
    local skillPoints = 0
    for i=1,#skills do
        local perkLevel = player:getPerkLevel(skills[i])
        skillPoints = skillPoints + perkLevel
    end
    local factor = skillPoints / #skills
    local percentage = factor * 100 / 10
    return percentage
end

function SchilledMechanic:Yield(inventory, items)
    for item, amount in pairs(items) do
        for i=1,amount do
            inventory:AddItem(item)
        end
    end
end

function SchilledMechanic:AddXp(player, xp)
    for perk, amount in pairs(xp) do
        player:getXp():AddXP(perk, amount)
    end
end

function SchilledMechanic:YieldToWorld(square, items)
    for item, amount in pairs(items) do
        for i=1,amount do
            square:AddWorldInventoryItem(item, ZombRandFloat(0,0.9), ZombRandFloat(0,0.9), 0);
        end
    end
end

function SchilledMechanic:GetYield(percentage, min, max)
    local delta = max - min
    if delta == 0 then
        return min
    end

    local extra = math.floor(delta * percentage / 100)
    return min + extra
end

function SchilledMechanic:GetRecycleCarSeatsYield(player)
    local percentage = self:YieldIncreaseBySkillPercentage(player, { Perks.Mechanics, Perks.MetalWelding })

    local random = ZombRand(4)
    local yield = nil
    if random == 0 then
        yield = { ["Base.RippedSheets"] = self:GetYield(percentage, 8, 14) }
    elseif random == 1 then
        yield = { ["Base.DenimStrips"] = self:GetYield(percentage, 3, 7) }
    elseif random == 2 then
        yield = { ["Base.LeatherStrips"] = self:GetYield(percentage, 2, 4) }
    else
        yield = { ["Base.Sheet"] = 1 }
    end
    return yield, { [Perks.Tailoring] = 10, [Perks.Mechanics] = 10 }
end

function SchilledMechanic:GetRecycleElectronicsYield(player)
    local percentage = self:YieldIncreaseBySkillPercentage(player, { Perks.Mechanics, Perks.Electricity })
    return { ["Base.ElectronicsScrap"] = self:GetYield(percentage, 0, 4) }, { [Perks.Electricity] = 10, [Perks.Mechanics] = 10 }
end

function SchilledMechanic:GetRecycleMetalPipeYield(player)
    local percentage = self:YieldIncreaseBySkillPercentage(player, { Perks.Mechanics, Perks.MetalWelding })
    local yield = { ["Base.SteelPiece"] = self:GetYield(percentage, 1, 5) }

    local random = ZombRand(2)
    if random == 0 then
        yield["Base.MetalPipe"] = self:GetYield(percentage, 0, 1)
    else
        yield["Base.MetalBar"] = self:GetYield(percentage, 0, 1)
    end
    return yield, { [Perks.MetalWelding] = 10, [Perks.Mechanics] = 10 }
end

function SchilledMechanic:GetRecycleBigMetalPipeYield(player)
    local percentage = self:YieldIncreaseBySkillPercentage(player, { Perks.Mechanics, Perks.MetalWelding })
    local yield = { ["Base.SteelPiece"] = self:GetYield(percentage, 1, 5) }

    local random = ZombRand(2)
    if random == 0 then
        yield["Base.MetalPipe"] = self:GetYield(percentage, 0, 2)
    else
        yield["Base.MetalBar"] = self:GetYield(percentage, 0, 2)
    end
    return yield, { [Perks.MetalWelding] = 10, [Perks.Mechanics] = 10 }
end

function SchilledMechanic:GetRecycleMetalSheetYield(player)
    local percentage = self:YieldIncreaseBySkillPercentage(player, { Perks.Mechanics, Perks.MetalWelding })
    local yield = { ["Base.SteelChunk"] = self:GetYield(percentage, 2, 7) }

    local random = ZombRand(2)
    if random == 0 then
        yield["Base.SheetMetal"] = self:GetYield(percentage, 0, 1)
    else
        yield["Base.SmallSheetMetal"] = self:GetYield(percentage, 0, 2)
    end
    return yield, { [Perks.MetalWelding] = 10, [Perks.Mechanics] = 10 }
end

function SchilledMechanic:GetRecycleSmallMetalSheetYield(player)
    local percentage = self:YieldIncreaseBySkillPercentage(player, { Perks.Mechanics, Perks.MetalWelding })
    return {
        ["Base.SteelChunk"] = self:GetYield(percentage, 1, 4),
        ["Base.SmallSheetMetal"] = self:GetYield(percentage, 0, 1)
    }, { [Perks.MetalWelding] = 10, [Perks.Mechanics] = 10 }
end

function SchilledMechanic:GetRecycleArmorYield(player)
    local percentage = self:YieldIncreaseBySkillPercentage(player, { Perks.Mechanics, Perks.MetalWelding })
    local yield = { ["Base.SteelChunk"] = self:GetYield(percentage, 2, 7) }

    local random = ZombRand(4)
    if random == 0 then
        yield["Base.SheetMetal"] = self:GetYield(percentage, 1, 2)
    elseif random == 1 then
        yield["Base.SmallSheetMetal"] = self:GetYield(percentage, 1, 3)
    elseif random == 2 then
        yield["Base.MetalPipe"] = self:GetYield(percentage, 2, 4)
    else
        yield["Base.MetalBar"] = self:GetYield(percentage, 2, 4)
    end
    return yield, { [Perks.MetalWelding] = 10, [Perks.Mechanics] = 10 }
end

function SchilledMechanic:GetRecycleEngineYield(condition)
    return { ["Base.EngineParts"] = self:GetYield(condition, 1, 13) }, { [Perks.MetalWelding] = 10, [Perks.Mechanics] = 10 }
end

function SchilledMechanic:GetRecycleWoodenYield(player)
    local percentage = self:YieldIncreaseBySkillPercentage(player, { Perks.Woodwork, Perks.Mechanics })
    return {
        ["Base.Screws"] = self:GetYield(percentage, 1, 4),
        ["Base.Plank"] = self:GetYield(percentage, 0, 1)
    }, { [Perks.Woodwork] = 10, [Perks.Mechanics] = 10 }
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

local function partIdStartsWith(partId, prefix)
    return partId:sub(1, #prefix) == prefix
end

local function findYieldFunctionForPart(partId)
    for prefix, fnName in pairs(PartYieldTable) do
        if partIdStartsWith(partId, prefix) then
            return fnName
        end
    end
    return nil
end

local function mergeYieldTable(allParts, allXP, newParts, xpYield)
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

function SchilledMechanic:GetVehicleRecycleYield(vehicle, character)
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

    if vehicle ~= nil then
        for partIndex = 1, vehicle:getPartCount() do
            local vehiclePart = vehicle:getPartByIndex(partIndex - 1)
            if vehiclePart then
                local partName = vehiclePart:getId()
                if partName == "Engine" then
                    local yield, xp = self:GetRecycleEngineYield(vehiclePart:getCondition())
                    mergeYieldTable(itemYield, xpYield, yield, xp)
                else
                    local yieldFunction = findYieldFunctionForPart(partName)
                    if yieldFunction then
                        local yield, xp = self[yieldFunction](self, character)
                        mergeYieldTable(itemYield, xpYield, yield, xp)
                    end
                end
            end
        end
    end

    return itemYield, xpYield
end


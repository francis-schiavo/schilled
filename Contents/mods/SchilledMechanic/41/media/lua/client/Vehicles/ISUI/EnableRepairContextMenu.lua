require "Vehicles/ISUI/ISVehicleMechanics"

function string:startsWith(start)
    return self:sub(1, #start) == start
end

local originalContextMenu = ISVehicleMechanics.doPartContextMenu

local enabledParts = {
    "GloveBox",
    "Battery",
    "Door",
    "EngineDoor",
    "GasTank",
    "Tire",
    "Trunk",
    "TruckBed",
    "TrunkDoor",
    "Headlight",
    "Window",
    "Muffler",
    "Radio",
    "Windshield",
    "lightbar",
    "Heater",
    "M998Trunk",
    "M101A3Trunk"
}

function enabledParts:contains(partId)
    for _, v in ipairs(self) do
        if partId:startsWith(v) then
            return true
        end
    end
    return false
end

function ISVehicleMechanics:doPartContextMenu(part, x, y)
    part:getScriptPart():setRepairMechanic(true);
    local partId = part:getId()
    if enabledParts:contains(partId) then
        if part:getCondition() < 100 then
            part:getScriptPart():setRepairMechanic(true);
        elseif part:getCondition() == 100 then
            part:getScriptPart():setRepairMechanic(false);
        end
    else
        part:getScriptPart():setRepairMechanic(false);
    end

    originalContextMenu(self, part, x, y)

    if partId == "lightbar" then
        self:CustomRepairMenu(part, "Repair lightbar", { ["Base.LightBulb"] = 2, ["Base.Amplifier"] = 1 }, { ["Mechanics"] = 8, ["Electricity"] = 4 })
    elseif partId == "Heater" then
        self:CustomRepairMenu(part, "Repair heater", { ["Base.ScrapMetal"] = 10, ["Base.ElectronicsScrap"] = 5 }, { ["Mechanics"] = 10, ["Electricity"] = 4 })
    else
        local item = part:getInventoryItem()
        if item then
            item:setHaveBeenRepaired(0)
        end
    end
end

function ISVehicleMechanics:CustomRepairMenu(part, text, requiredItems, requiredSkills)
    if part:getCondition() == 100 then
        return
    end
    self.context:setVisible(true)

    local player = getSpecificPlayer(self.playerNum)
    local option = self.context:addOption(text, player, self.SchilledMechanic_OnRepair, part, requiredItems)
    option.toolTip, option.notAvailable = ContextMenuBuilder:CreateMenuTooltip(player, requiredItems, requiredSkills)
end

function ISVehicleMechanics:SchilledMechanic_OnRepair(part, requiredItems)
    ISTimedActionQueue.add(SchilledMechanicRepairPart:new(self, part, 100, requiredItems))
end

local originalContextMenu2 = ISVehicleMenu.FillMenuOutsideVehicle

local function predicateWeldingMask(item)
    return item:hasTag("WeldingMask") or item:getType() == "WeldingMask"
end

local function predicateBlowTorch(item)
    return (item:hasTag("BlowTorch") or item:getType() == "BlowTorch") and item:getDrainableUsesInt() >= 10
end

function ISVehicleMenu.onRecycle(player, vehicle)
    if luautils.walkAdj(player, vehicle:getSquare()) then
        ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), predicateBlowTorch, true);
        local mask = player:getInventory():getFirstEvalRecurse(predicateWeldingMask);
        if mask then
            ISInventoryPaneContextMenu.wearItem(mask, player:getPlayerNum());
        end
        ISTimedActionQueue.add(ISRecycleVehicle:new(player, vehicle))
    end
end

function ISVehicleMenu.FillMenuOutsideVehicle(player, context, vehicle, test)
    local playerObj = getSpecificPlayer(player)

    local recycleOption = context:addOption("Recycle vehicle", playerObj, ISVehicleMenu.onRecycle, vehicle)
    recycleOption.toolTip, recycleOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.WeldingMask"] = 1, ["Base.BlowTorch"] = 1 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 })

    originalContextMenu2(player, context, vehicle, test)
end
require "Vehicles/ISUI/ISVehicleMechanics"
require "ISUI/ISWorldObjectContextMenu"

local originalContextMenu = ISVehicleMenu.FillMenuOutsideVehicle

local function CreateCarKey(player, vehicle)
    sendClientCommand(player, "vehicle", "getKey", { vehicle = vehicle:getId() })
end

function ISVehicleMenu.FillMenuOutsideVehicle(player, context, vehicle, test)
    local playerObj = getSpecificPlayer(player)

    if not (string.match(vehicle:getScript():getName(), "Burnt") or string.match(vehicle:getScript():getName(), "Smashed")) then
        if playerObj:isRecipeKnown("Make car key") then
            local createKeyOption = context:addOption("Create vehicle key", playerObj, CreateCarKey, vehicle)
            createKeyOption.toolTip, createKeyOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.ScrapMetal"] = 5 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 })
        end
    end

    originalContextMenu(player, context, vehicle, test)
    context:removeOptionByName(getText("ContextMenu_RemoveBurntVehicle"))
end

local function createDoorKey(player, square)
    player:getInventory():AddItem("Base.Key1"):setKeyId(square:getBuilding():getDef():getKeyId())
end

local originalWorldContextMenu = ISWorldObjectContextMenu.createMenu

ISWorldObjectContextMenu.createMenu = function(player, worldobjects, x, y, test)
    local context = originalWorldContextMenu(player, worldobjects, x, y, test)

    local playerObj = getSpecificPlayer(player)

    local square = playerObj:getCurrentSquare()
    if square and square:getBuilding() and playerObj:isRecipeKnown("Make door key") then
        local createKeyOption = context:addOption("Create door key", playerObj, createDoorKey, square)
        createKeyOption.toolTip, createKeyOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.ScrapMetal"] = 5 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 })
    end
    return context
end
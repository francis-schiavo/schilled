require("Vehicles/ISUI/ISVehicleMechanics")

local originalContextMenu = ISVehicleMenu.FillMenuOutsideVehicle;

local function CreateCarKey(player, vehicle)
    sendClientCommand(player, "SchilledMetalworker", "getVehicleKey", { vehicleId = vehicle:getId() });
end

function ISVehicleMenu.FillMenuOutsideVehicle(player, context, vehicle, test)
    local playerObj = getSpecificPlayer(player);

    local RecipeKnown = playerObj:isRecipeKnown("CreateCarKey", true);
    if not (string.match(vehicle:getScript():getName(), "Burnt") or string.match(vehicle:getScript():getName(), "Smashed")) and RecipeKnown then
        local createKeyOption = context:addOption(getText("ContextMenu_CreateCarKey"), playerObj, CreateCarKey, vehicle);
        createKeyOption.toolTip, createKeyOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.ScrapMetal"] = 5 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 });
    end

    originalContextMenu(player, context, vehicle, test);
end

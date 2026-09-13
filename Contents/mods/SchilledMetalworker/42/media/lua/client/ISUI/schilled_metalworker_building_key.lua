require("ISUI/ISWorldObjectContextMenu")

local function createDoorKey(player, square)
    sendClientCommand(player, 'SchilledMetalworker', 'getBuildingKey', {})
end

local originalWorldContextMenu = ISWorldObjectContextMenu.createMenu;

ISWorldObjectContextMenu.createMenu = function(player, worldobjects, x, y, test)
    local context = originalWorldContextMenu(player, worldobjects, x, y, test);

    local playerObj = getSpecificPlayer(player);

    local square = playerObj:getCurrentSquare();
    local recipeKnown = playerObj:isRecipeKnown("CreateBuildingKey", true);
    if square and square:getBuilding() and recipeKnown then
        local createKeyOption = context:addOption(getText("ContextMenu_CreateBuildingKey"), playerObj, createDoorKey, square);
        createKeyOption.toolTip, createKeyOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.ScrapMetal"] = 5 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 });
    end
    return context;
end
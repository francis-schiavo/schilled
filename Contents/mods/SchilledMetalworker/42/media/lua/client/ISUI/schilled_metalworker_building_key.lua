require("ISUI/ISWorldObjectContextMenu")

local originalWorldContextMenu = ISWorldObjectContextMenu.createMenu;

local function createBuildingKey(player)
    sendClientCommand(player, 'SchilledMetalworker', 'getBuildingKey', {})
end

local function createDoorKey(player, door)
    local args = { x = door:getX(), y = door:getY(), z = door:getZ(), index = door:getObjectIndex() }
    sendClientCommand(player, 'SchilledMetalworker', 'getDoorKey', args)
end

ISWorldObjectContextMenu.createMenu = function(player, worldobjects, x, y, test)
    local context = originalWorldContextMenu(player, worldobjects, x, y, test);
    local playerObj = getSpecificPlayer(player);
    local square = playerObj:getCurrentSquare();

    if square and square:getBuilding() and playerObj:isRecipeKnown("CreateBuildingKey", true) then
        local createKeyOption = context:addOption(getText("ContextMenu_CreateBuildingKey"), playerObj, createBuildingKey);
        createKeyOption.toolTip, createKeyOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.ScrapMetal"] = 5 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 });
    end

    for _,obj in ipairs(worldobjects) do
        if instanceof(obj, "IsoDoor") or (instanceof(obj, "IsoThumpable") and obj:isDoor()) and playerObj:isRecipeKnown("CreateDoorKey", true) then
            local createKeyOption = context:addOption(getText("ContextMenu_CreateDoorKey"), playerObj, createDoorKey, obj);
            createKeyOption.toolTip, createKeyOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.ScrapMetal"] = 5 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 });
        end
    end

    return context;
end
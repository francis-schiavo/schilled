require("ISUI/ISWorldObjectContextMenu")
require("TimedActions/schilled_create_key")

local originalWorldContextMenu = ISWorldObjectContextMenu.createMenu;

local function createBuildingKey(player)
    ISTimedActionQueue.add(SchilledCreateKeyAction:new(player, "building"));
end

local function createDoorKey(player, door)
    ISTimedActionQueue.add(SchilledCreateKeyAction:new(player, "door", door));
end

ISWorldObjectContextMenu.createMenu = function(player, worldobjects, x, y, test)
    local context = originalWorldContextMenu(player, worldobjects, x, y, test);
    local playerObj = getSpecificPlayer(player);
    local square = playerObj:getCurrentSquare();
    local canCreateBuildingKey = playerObj:isRecipeKnown("CreateBuildingKey", true);
    local canCreateDoorKey = playerObj:isRecipeKnown("CreateDoorKey", true);

    for _, obj in ipairs(worldobjects) do
        local isDoor = instanceof(obj, "IsoDoor") or (instanceof(obj, "IsoThumpable") and obj:isDoor());
        if isDoor then
            if canCreateDoorKey then
                local createKeyOption = context:addOption(getText("ContextMenu_CreateDoorKey"), playerObj, createDoorKey, obj);
                createKeyOption.toolTip, createKeyOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.IronBarQuarter"] = 1 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 });
            end

            if square and square:getBuilding() and canCreateBuildingKey then
                local createKeyOption = context:addOption(getText("ContextMenu_CreateBuildingKey"), playerObj, createBuildingKey);
                createKeyOption.toolTip, createKeyOption.notAvailable = ContextMenuBuilder:CreateMenuTooltip(playerObj, { ["Base.IronBarQuarter"] = 1 }, { ["Mechanics"] = 2, ["MetalWelding"] = 2 });
            end
        end
    end

    return context;
end

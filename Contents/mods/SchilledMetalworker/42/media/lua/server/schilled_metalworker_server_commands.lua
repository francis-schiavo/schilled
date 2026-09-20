if isClient() then
    return
end

local Commands = {}
local SCRAP_TYPE = 'Base.IronPiece'
local SCRAP_COST = 5

local function removeScrapMetal(player)
    local inv = player:getInventory()
    if inv:getNumberOfItem(SCRAP_TYPE, false, true) < SCRAP_COST then
        return false
    end

    local itemsToRemove = inv:getSomeTypeRecurse(SCRAP_TYPE, SCRAP_COST)
    if not itemsToRemove or itemsToRemove:size() < SCRAP_COST then
        return false
    end

    for i = 0, itemsToRemove:size() - 1 do
        local item = itemsToRemove:get(i)
        local container = item and item:getContainer()
        if item and container then
            container:DoRemoveItem(item)
            sendRemoveItemFromContainer(container, item)
        end
    end

    addXp(player, Perks.MetalWelding, 25)
    return true
end

function Commands:getVehicleKey(player, vehicleId)
    local vehicle = getVehicleById(vehicleId)
    if not vehicle then
        return
    end
    if not removeScrapMetal(player) then
        return
    end
    local item = vehicle:createVehicleKey()
    if item then
        player:getInventory():AddItem(item)
        sendAddItemToContainer(player:getInventory(), item)
    end
end

function Commands:getBuildingKey(player)
    local sq = player:getCurrentSquare()
    if not (sq and sq:getBuilding()) then
        return
    end
    if not removeScrapMetal(player) then
        return
    end
    local key = instanceItem("Base.Key1")
    key:setKeyId(sq:getBuilding():getDef():getKeyId())
    ItemPickerJava.keyNamerBuilding(key, sq)

    player:getInventory():AddItem(key)
    sendAddItemToContainer(player:getInventory(), key)
end

function Commands:getDoorKey(player, args)
    local gs = getCell():getGridSquare(args.x, args.y, args.z)
    if not gs then
        print('square is nil')
        return
    end

    if args.index < 0 or args.index >= gs:getObjects():size() then
        print('invalid object')
        return
    end
    local door = gs:getObjects():get(args.index)

    if not removeScrapMetal(player) then
        return
    end

    local keyID = -1
    if instanceof(door, "IsoDoor") then
        keyID = door:checkKeyId()
    elseif instanceof(door, "IsoThumpable") then
        keyID = door:getKeyId()
    end

    if keyID == -1 then
        keyID = ZombRand(100000000)
    end
    door:setKeyId(keyID)

    local doubleDoorObjects = buildUtil.getDoubleDoorObjects(door)
    for i=1,#doubleDoorObjects do
        local object = doubleDoorObjects[i]
        object:setKeyId(keyID)
    end

    local garageDoorObjects = buildUtil.getGarageDoorObjects(door)
    for i=1,#garageDoorObjects do
        local object = garageDoorObjects[i]
        object:setKeyId(keyID)
    end

    local key = instanceItem("Base.Key1")
    key:setKeyId(keyID)

    player:getInventory():AddItem(key)
    sendAddItemToContainer(player:getInventory(), key)
end

local function onClientCommand(module, command, player, args)
    if module ~= 'SchilledMetalworker' then
        return
    end

    if command == "getBuildingKey" then
        Commands:getBuildingKey(player)
    elseif command == "getVehicleKey" then
        Commands:getVehicleKey(player, args.vehicleId)
    elseif command == "getDoorKey" then
        Commands:getDoorKey(player, args)
    end
end

Events.OnClientCommand.Add(onClientCommand)

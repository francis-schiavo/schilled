if isClient() then
    return
end

local Commands = {}

function Commands:getVehicleKey(player, vehicleId)
    local vehicle = getVehicleById(vehicleId)
	if vehicle then
		local item = vehicle:createVehicleKey()
		if item then
			player:getInventory():AddItem(item);
			sendAddItemToContainer(player:getInventory(), item);

			local items = player:getInventory():RemoveAll('Base.ScrapMetal', 5)
            sendRemoveItemsFromContainer(player:getInventory(), items);
		end
	end
end

function Commands:getBuildingKey(player)
    local sq = player:getCurrentSquare()
    if sq and sq:getBuilding() then
        local key = instanceItem("Base.Key1")
        key:setKeyId(sq:getBuilding():getDef():getKeyId())
        ItemPickerJava.keyNamerBuilding(key, sq)

        player:getInventory():AddItem(key)
        sendAddItemToContainer(player:getInventory(), key);

        local items = player:getInventory():RemoveAll('Base.ScrapMetal', 5)
        sendRemoveItemsFromContainer(player:getInventory(), items);
    end
end

function Commands:getDoorKey(player, args)
    local gs = getCell():getGridSquare(args.x, args.y, args.z)
    if not gs then
        print('square is nil')
        return
    end

    if args.index < 0 or args.index >= gs:getObjects():size() then
        print('invalid object')
    end
    local door = gs:getObjects():get(args.index)

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
    sendAddItemToContainer(player:getInventory(), key);
    local items = player:getInventory():RemoveAll('Base.ScrapMetal', 5)
    sendRemoveItemsFromContainer(player:getInventory(), items);
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

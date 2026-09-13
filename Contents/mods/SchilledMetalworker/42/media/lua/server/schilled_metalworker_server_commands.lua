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

local function onClientCommand(module, command, player, args)
    if module ~= 'SchilledMetalworker' then
        return
    end

    if command == "getBuildingKey" then
        Commands:getBuildingKey(player)
    elseif command == "getVehicleKey" then
        Commands:getVehicleKey(player, args.vehicleId)
    end
end

Events.OnClientCommand.Add(onClientCommand)

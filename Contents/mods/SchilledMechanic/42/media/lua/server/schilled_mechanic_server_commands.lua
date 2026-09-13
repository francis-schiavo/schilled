if isClient() then
    return
end

local Commands = {}

function Commands:repairPart(player, vehicleId, partId, targetCondition, requiredItems)
    local vehicle = getVehicleById(vehicleId)

    if vehicle then
        local part = vehicle:getPartById(partId)
        part:setCondition(targetCondition)

        for partType, partCount in pairs(requiredItems) do
            local itemsToRemove = player:getInventory():getSomeTypeRecurse(partType, partCount)
            if itemsToRemove then
                for i = 0, itemsToRemove:size() - 1 do
                    local item = itemsToRemove:get(i)
                    local container = item and item:getContainer()
                    if item and container then
                        container:DoRemoveItem(item)
                        sendRemoveItemFromContainer(container, item)
                    end
                end
            end
        end

        vehicle:updatePartStats()
        vehicle:updateBulletStats()
        vehicle:transmitPartCondition(part)
        vehicle:transmitPartItem(part)
        vehicle:transmitPartModData(part)

        player:sendObjectChange('mechanicActionDone', { success = true, vehicleId = vehicle:getId(), partId = part:getId(), itemId = -1, installing = true })
    end
end

function Commands:recycleVehicle(player, vehicleId)
    local vehicle = getVehicleById(vehicleId)
    if not vehicle then
        return
    end

    local square = vehicle:getSquare()
    local itemYield, xpYield = SchilledMechanic:GetVehicleRecycleYield(vehicle, player)

    SchilledMechanic:YieldToWorld(square, itemYield)
    SchilledMechanic:AddXp(player, xpYield)
    vehicle:permanentlyRemove()
end

local function onClientCommand(module, command, player, args)
    if module ~= 'SchilledMechanic' then
        return
    end

    if command == "repairPart" then
        Commands:repairPart(player, args.vehicleId, args.partId, args.targetCondition, args["requiredItems"])
    elseif command == "recycleVehicle" then
        Commands:recycleVehicle(player, args.vehicleId)
    end
end

Events.OnClientCommand.Add(onClientCommand)

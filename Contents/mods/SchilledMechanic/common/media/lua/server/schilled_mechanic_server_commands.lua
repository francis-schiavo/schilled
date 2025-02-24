if isClient() then
    return
end

local SchilledMechanic = {}

function SchilledMechanic:repairPart(player, vehicleId, partId, targetCondition, requiredItems)
    local vehicle = getVehicleById(vehicleId)

    if vehicle then
        local part = vehicle:getPartById(partId)
        part:setCondition(targetCondition)

        for partType, partCount in pairs(requiredItems) do
            player:sendObjectChange('removeItemType', { type = partType, count = partCount })
        end

        vehicle:updatePartStats()
        vehicle:updateBulletStats()
        vehicle:transmitPartCondition(part)
        vehicle:transmitPartItem(part)
        vehicle:transmitPartModData(part)

        player:sendObjectChange('mechanicActionDone', { success = true, vehicleId = vehicle:getId(), partId = part:getId(), itemId = -1, installing = true })
    end
end

SchilledMechanic.OnClientCommand = function(module, command, player, args)
    if module ~= 'SchilledMechanic' then
        return
    end

    if command ~= "repairPart" then
        return
    end

    SchilledMechanic:repairPart(player, args.vehicleId, args.partId, args.targetCondition, args["requiredItems"])
end

Events.OnClientCommand.Add(SchilledMechanic.OnClientCommand)

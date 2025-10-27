SchilledVehicleManager = {};

function SchilledVehicleManager:Claim(player, vehicleId)
    local SID = player:getUsername();
    if not SID then
        return
    end

    local vehicle = getVehicleById(vehicleId);
    if not vehicle then
        return
    end

    local owners = vehicle:getModData().claimedBy or {};
    owners[SID] = 255;
    vehicle:getModData().claimedBy = owners;
    vehicle:transmitModData();
end

function SchilledVehicleManager:Unclaim(player, vehicleId)
    local SID = player:getUsername();
    if not SID then
        return
    end

    local vehicle = getVehicleById(vehicleId);
    if not vehicle then
        return
    end

    local owners = vehicle:getModData().claimedBy or {};
    owners[SID] = nil;
    vehicle:getModData().claimedBy = owners;

    vehicle:transmitModData();
end

function SchilledVehicleManager:DebugClaim(_, vehicleId)
    local vehicle = getVehicleById(vehicleId);
    if not vehicle then
        return
    end

    local owners = vehicle:getModData().claimedBy or {};
    owners["dummy"] = 255;
    vehicle:getModData().claimedBy = owners;
    vehicle:transmitModData();
end

function SchilledVehicleManager:DebugUnclaim(_, vehicleId)
    local vehicle = getVehicleById(vehicleId);
    if not vehicle then
        return
    end

    vehicle:getModData().claimedBy = nil;
    vehicle:transmitModData();
end

function SchilledVehicleManager.OnClientCommand(module, command, player, args)
    if module == "SchilledVehicleAdmin" then
        local vehicleId = args.vehicleId;
        if command == "claimVehicle" then
            if args.debug then
                SchilledVehicleManager:DebugClaim(player, vehicleId);
            else
                SchilledVehicleManager:Claim(player, vehicleId);
            end
        elseif command == "unclaimVehicle" then
            if args.debug then
                SchilledVehicleManager:DebugUnclaim(player, vehicleId, args.debug);
            else
                SchilledVehicleManager:Unclaim(player, vehicleId, args.debug);
            end
        end
    end
end

Events.OnClientCommand.Add(SchilledVehicleManager.OnClientCommand);

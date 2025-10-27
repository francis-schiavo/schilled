require "Vehicles/ISUI/ISVehicleMechanics"

function string:startsWith(start)
    return self:sub(1, #start) == start
end

local originalContextMenu = ISVehicleMenu.FillMenuOutsideVehicle

function ISVehicleMenu.onClaim(player, vehicle, debug)
    if luautils.walkAdj(player, vehicle:getSquare()) then
        ISTimedActionQueue.add(SchilledClaimVehicle:new(player, vehicle, true, debug))
    end
end

function ISVehicleMenu.onUnclaim(player, vehicle, debug)
    if luautils.walkAdj(player, vehicle:getSquare()) then
        ISTimedActionQueue.add(SchilledClaimVehicle:new(player, vehicle, false, debug))
    end
end

function ISVehicleMenu.FillMenuOutsideVehicle(player, context, vehicle, test)
    local playerObj = getSpecificPlayer(player)

    local cheat = getCore():getDebug() and getDebugOptions():getBoolean("Cheat.Vehicle.MechanicsAnywhere")
    if ISVehicleMechanics.cheat or (isClient() and isAdmin()) or cheat then
        context:addOption(ContextMenuBuilder:Red() .. getText("ContextMenu_ClaimVehicle"), playerObj, ISVehicleMenu.onClaim, vehicle, true)
        context:addOption(ContextMenuBuilder:Red() .. getText("ContextMenu_UnclaimVehicle"), playerObj, ISVehicleMenu.onUnclaim, vehicle, true)
    end

    local owners = vehicle:getModData().claimedBy or {}
    local hasOwner = false
    for _, _ in pairs(owners) do
        hasOwner = true
        break
    end
    local ownedByPlayer = owners[playerObj:getUsername()] ~= nil

    if hasOwner and not ownedByPlayer then
        local claimed = context:addOption(getText("ContextMenu_VehicleClaimed"), playerObj, ISVehicleMenu.onUnclaim, vehicle)
        claimed.notAvailable = true
    elseif ownedByPlayer then
        context:addOption(getText("ContextMenu_UnclaimVehicle"), playerObj, ISVehicleMenu.onUnclaim, vehicle)
    else
        local claimOption = context:addOption(getText("ContextMenu_ClaimVehicle"), playerObj, ISVehicleMenu.onClaim, vehicle)
        if not playerObj:getInventory():haveThisKeyId(vehicle:getKeyId()) then
            claimOption.toolTip = ContextMenuBuilder:CreateTooltip("Tooltip_ClaimVehicleNoKey", ContextMenuBuilder:Red())
            claimOption.notAvailable = true
        end
    end

    originalContextMenu(player, context, vehicle, test)
end

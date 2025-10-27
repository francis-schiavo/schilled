require "TimedActions/ISBaseTimedAction"

SchilledClaimVehicle = ISBaseTimedAction:derive("SchilledClaimVehicle")

function SchilledClaimVehicle:isValid()
	return true
end

function SchilledClaimVehicle:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function SchilledClaimVehicle:update()
	self.character:faceThisObject(self.vehicle)
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function SchilledClaimVehicle:start()
	self:setActionAnim("VehicleWorkOnMid")
end

function SchilledClaimVehicle:stop()
    ISBaseTimedAction.stop(self);
end

function SchilledClaimVehicle:perform()
    if self.claim then
        sendClientCommand(self.character, 'SchilledVehicleAdmin', 'claimVehicle', { vehicleId = self.vehicle:getId(), debug = self.debug })
    else
        sendClientCommand(self.character, 'SchilledVehicleAdmin', 'unclaimVehicle', { vehicleId = self.vehicle:getId(), debug = self.debug })
    end
	ISBaseTimedAction.perform(self)
end

function SchilledClaimVehicle:new(character, vehicle, claim, debug)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.vehicle = vehicle
	o.maxTime = 1
    o.claim = claim
    o.debug = debug
	return o
end



require "TimedActions/ISBaseTimedAction"

SchilledMechanicRepairPart = ISBaseTimedAction:derive("SchilledMechanicRepairPart")

function SchilledMechanicRepairPart:isValid()
	return true
end

function SchilledMechanicRepairPart:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function SchilledMechanicRepairPart:update()
	self.character:faceThisObject(self.vehicle)
    self.character:setMetabolicTarget(Metabolics.LightWork)
end

function SchilledMechanicRepairPart:start()
	self:setActionAnim("VehicleWorkOnMid")
	self.sound = self.character:getEmitter():playSound("GeneratorConnect")
	local radius = 10 * self.character:getHammerSoundMod()
	addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), radius, radius)
end

function SchilledMechanicRepairPart:stop()
	if self.sound then
		self.character:getEmitter():stopSound(self.sound)
		self.sound = nil
	end
    ISBaseTimedAction.stop(self);
end

function SchilledMechanicRepairPart:perform()
    if self.sound then
        self.character:getEmitter():stopSound(self.sound)
        self.sound = nil
    end
	sendClientCommand(self.character, 'SchilledMechanic', 'repairPart', { vehicleId = self.vehicle:getId(), partId = self.part:getId(), targetCondition = 100, requiredItems = self.requiredItems })
	ISBaseTimedAction.perform(self)
end

function SchilledMechanicRepairPart:new(character, part, maxTime, requiredItems)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.part = part
	o.vehicle = part:getVehicle()
	o.maxTime = maxTime
	if character:isTimedActionInstant() then
        o.maxTime = 1;
    end
	
	o.requiredItems = requiredItems
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.sound = nil
	return o
end



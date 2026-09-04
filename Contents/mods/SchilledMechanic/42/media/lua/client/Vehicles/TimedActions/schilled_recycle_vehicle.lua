require "TimedActions/ISBaseTimedAction"

ISRecycleVehicle = ISBaseTimedAction:derive("ISRecycleVehicle")

local function predicateBlowTorch(item)
	return (item:hasTag(ItemTag.BLOW_TORCH) or item:getType() == "BlowTorch") and item:getCurrentUses() >= 10
end

function ISRecycleVehicle:isValid()
    if not predicateBlowTorch(self.character:getPrimaryHandItem()) then
        return false
    end
    return self.vehicle and not self.vehicle:isRemovedFromWorld();
end

function ISRecycleVehicle:update()
    self.character:faceThisObject(self.vehicle)
    self.item:setJobDelta(self:getJobDelta())
    self.item:setJobType(getText("ContextMenu_RemoveBurntVehicle"))

    if self.sound ~= 0 and not self.character:getEmitter():isPlaying(self.sound) then
        self.sound = self.character:playSound("BlowTorch")
    end

    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISRecycleVehicle:start()
    self.item = self.character:getPrimaryHandItem()
    self:setActionAnim("BlowTorch")
    self:setOverrideHandModels(self.item, nil)
    self.sound = self.character:playSound("BlowTorch")
end

function ISRecycleVehicle:stop()
    if self.item then
        self.item:setJobDelta(0)
    end
    if self.sound ~= 0 then
        self.character:getEmitter():stopSound(self.sound)
    end
    ISBaseTimedAction.stop(self)
end

function ISRecycleVehicle:perform()
    if self.sound ~= 0 then
        self.character:getEmitter():stopSound(self.sound)
    end

    -- Loot + vehicle removal must run on the server in MP.
    -- Spawning with AddWorldInventoryItem from this client perform() created
    -- ghost items that could not be picked up and vanished on reconnect.
    sendClientCommand(self.character, "SchilledMechanic", "recycleVehicle", {
        vehicleId = self.vehicle:getId(),
    })

    self.item:setJobDelta(0);
    ISBaseTimedAction.perform(self)
end

function ISRecycleVehicle:getDuration()
    if self.character:isMechanicsCheat() or self.character:isTimedActionInstant() then
        return 10
    end
    return 800 - (self.character:getPerkLevel(Perks.MetalWelding) * 20);
end

function ISRecycleVehicle:new(character, vehicle)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle = vehicle
    o.stopOnWalk = false
    o.stopOnRun = false
    o.maxTime = o:getDuration()
    return o
end

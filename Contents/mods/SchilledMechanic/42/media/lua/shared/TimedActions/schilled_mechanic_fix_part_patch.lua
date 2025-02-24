require("TimedActions/ISFixVehiclePartAction")

function ISFixVehiclePartAction:complete()
    FixingManager.fixItem(self.item, self.character, self.fixing, self.fixer);
    self.vehiclePart:setCondition(self.item:getCondition())
    self.vehiclePart:doInventoryItemStats(self.item, self.vehiclePart:getMechanicSkillInstaller())
    if self.vehiclePart:isContainer() and not self.vehiclePart:getItemContainer() and self.vehiclePart:getContainerContentType() ~= "Air" then
        self.vehiclePart:setContainerContentAmount(part:getContainerContentAmount())
    end
    self.vehiclePart:getVehicle():updatePartStats()
    self.vehiclePart:getVehicle():updateBulletStats()
    self.vehiclePart:getVehicle():transmitPartItem(self.vehiclePart)
    return true
end
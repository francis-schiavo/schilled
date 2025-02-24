require("TimedActions/ISWashYourself")
require("TimedActions/ISFixAction")

function ISWashClothing.GetSoapRemaining(soaps, character)
    -- Allow a sponge to replace soaps
    if character then
        local inventory = character:getInventory()
        local sponge = inventory:contains("Sponge")
        if sponge then
            return 100
        end
    end

    local total = 0
    for _,soap in ipairs(soaps) do
        total = total + soap:getRemainingUses()
    end
    return total
end

function ISWashYourself:new(character, sink, soapList)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.sink = sink;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    local waterUnits = math.min(ISWashYourself.GetRequiredWater(character), sink:getWaterAmount());
    o.maxTime = waterUnits * 70;
    o.soaps = soapList;
    o.forceProgressBar = true;
    if ISWashYourself.GetRequiredSoap(character) > ISWashClothing.GetSoapRemaining(soapList, character) then
        o.maxTime = o.maxTime * 1.8;
    end
    if o.character:isTimedActionInstant() then o.maxTime = 1; end
    return o;
end

function ISFixAction:perform()
    if self.item:getContainer() then
        self.item:getContainer():setDrawDirty(true);
    end
    self.item:setJobDelta(0.0);

    FixingManager.fixItem(self.item, self.character, self.fixing, self.fixer);
    if self.vehiclePart then
        local part = self.vehiclePart
        if isClient() then
            -- The server should call FixingManager.fixItem() but doesn't have all the info it needs.
            local args = { vehicle = part:getVehicle():getId(), part = part:getId(),
                           condition = self.item:getCondition(), haveBeenRepaired = self.item:getHaveBeenRepaired() }
            sendClientCommand(self.character, 'vehicle', 'fixPart', args)
        else
            part:setCondition(self.item:getCondition())
            part:doInventoryItemStats(self.item, part:getMechanicSkillInstaller())
            if part:isContainer() and not part:getItemContainer() then
                -- Changing condition might change capacity.
                -- This limits content amount to max capacity.
                part:setContainerContentAmount(part:getContainerContentAmount())
            end
            part:getVehicle():updatePartStats()
            part:getVehicle():updateBulletStats()
        end
    end

    local modData = self.item:getModData()
    if modData["neverRepaired"] then
        self.item:setHaveBeenRepaired(0)
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end
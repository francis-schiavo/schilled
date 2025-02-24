require "TimedActions/ISInventoryTransferAction"

local oldInit = ISInventoryTransferAction.new;

function ISInventoryTransferAction:new(character, item, fromContainer, toContainer, doSound)
    local o = oldInit(self, character, item, fromContainer, toContainer, doSound);
    o.doSound = doSound;
    return o;
end

function ISInventoryTransferAction:new(character, item, srcContainer, destContainer, time)
    local o = oldInit(self, character, item, srcContainer, destContainer, time);
    o.maxTime = o.maxTime * 0.5;
    if o.maxTime > 20 then
        o.maxTime = 20;
    end
    return o;
end


require "TimedActions/ISInventoryTransferAction"

local oldInit = ISInventoryTransferAction.new;

function ISInventoryTransferAction:new(character, item, srcContainer, destContainer, time)
    local o = oldInit(self, character, item, srcContainer, destContainer, time);
    o.maxTime = o.maxTime * 0.25;
    if o.maxTime > 15 then
        o.maxTime = 15;
    end
    return o;
end

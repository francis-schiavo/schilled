require("TimedActions/ISFixAction")

local originalComplete = ISFixAction.complete

function ISFixAction:complete()
    local success = originalComplete(self)
    if success then
        self.item:setHaveBeenRepaired(0);
    end
    return success
end

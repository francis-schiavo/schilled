ISInventoryPaneContextMenu.onConsolidateAll = function(drainable, consolidateList, player)
    local time = 90
    if drainable:getName() == 'Thread' then
        time = 5
    end

    if drainable:getUsedDelta() < 1 then
        local intoItem = table.remove(consolidateList, 1)
        ISTimedActionQueue.add(ISConsolidateDrainable:new(player, drainable, intoItem, time, consolidateList))
    else
        drainable = table.remove(consolidateList, 1)
        local intoItem = table.remove(consolidateList, 1)
        ISTimedActionQueue.add(ISConsolidateDrainable:new(player, drainable, intoItem, time, consolidateList))
    end
end
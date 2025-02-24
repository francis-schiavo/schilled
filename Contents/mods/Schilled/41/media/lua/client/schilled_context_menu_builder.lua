ContextMenuBuilder = {}

function ContextMenuBuilder:Red()
    return " <RGB:1,0,0>"
end

function ContextMenuBuilder:Green()
    return " <RGB:0,1,0>"
end

function ContextMenuBuilder:White()
    return " <RGB:1,1,1>"
end

function ContextMenuBuilder:CreateMenuTooltip(player, requiredItems, requiredSkills)
    local tooltip = ISToolTip:new()
    tooltip:initialise()
    tooltip:setVisible(false)
    tooltip.description = getText("Tooltip_craft_Needs") .. " : <LINE> <LINE>"
    local available = true

    for perk, requiredLevel in pairs(requiredSkills) do
        local rgb = self:Green()
        local perkName = getText("IGUI_perks_" .. perk)
        local perkLevel = player:getPerkLevel(Perks[perk])
        if perkLevel < requiredLevel then
            rgb = self:Red()
            available = false
        end
        tooltip.description = tooltip.description .. rgb .. perkName .. " " .. perkLevel .. "/" .. requiredLevel .. " <LINE>"
    end

    for requiredItem, requiredAmount in pairs(requiredItems) do
        local rgb = self:Green()
        local item = InventoryItemFactory.CreateItem(requiredItem)
        local amount = player:getInventory():getNumberOfItem(requiredItem, false, true)
        if amount < requiredAmount then
            rgb = self:Red()
            available = false
        end
        tooltip.description = tooltip.description .. rgb .. item:getDisplayName() .. " " .. amount .. "/" .. requiredAmount .. " <LINE>"
    end

    return tooltip, not available
end
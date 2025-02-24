require "SchilledMechanic"

function Recipe.OnCreate.RecycleCarSeats(items, result, player)
    local inventory = player:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleCarSeatsYield(player)
    SchilledMechanic:AddXp(player, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleElectronics(items, result, player)
    local inventory = player:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleElectronicsYield(player)
    SchilledMechanic:AddXp(player, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleMetalPipePart(items, result, player)
    local inventory = player:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleMetalPipeYield(player)
    SchilledMechanic:AddXp(player, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleBigMetalPipePart(items, result, player)
    local inventory = player:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleBigMetalPipeYield(player)
    SchilledMechanic:AddXp(player, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleMetalSheetPart(items, result, player)
    local inventory = player:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleMetalSheetYield(player)
    SchilledMechanic:AddXp(player, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleSmallMetalSheetPart(items, result, player)
    local inventory = player:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleSmallMetalSheetYield(player)
    SchilledMechanic:AddXp(player, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleArmorPart(items, result, player)
    local inventory = player:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleArmorYield(player)
    SchilledMechanic:AddXp(player, xp)
    SchilledMechanic:Yield(inventory, yield)
end

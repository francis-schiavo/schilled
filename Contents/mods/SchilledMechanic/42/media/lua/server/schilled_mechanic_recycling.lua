require "SchilledMechanic"

function Recipe.OnCreate.RecycleCarSeats(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleCarSeatsYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleElectronics(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleElectronicsYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleMetalPipePart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleMetalPipeYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleBigMetalPipePart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleBigMetalPipeYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleMetalSheetPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleMetalSheetYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleSmallMetalSheetPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleSmallMetalSheetYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function Recipe.OnCreate.RecycleArmorPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleArmorYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

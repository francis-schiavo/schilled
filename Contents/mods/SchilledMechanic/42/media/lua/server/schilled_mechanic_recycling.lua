require "SchilledMechanic"

SchilledMechanicRecipes = {}

function SchilledMechanicRecipes.RecycleCarSeats(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleCarSeatsYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanicRecipes.RecycleElectronics(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleElectronicsYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanicRecipes.RecycleMetalPipePart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleMetalPipeYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanicRecipes.RecycleBigMetalPipePart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleBigMetalPipeYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanicRecipes.RecycleMetalSheetPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleMetalSheetYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanicRecipes.RecycleSmallMetalSheetPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleSmallMetalSheetYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanicRecipes.RecycleArmorPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleArmorYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanicRecipes.RecycleWoodenPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleWoodenYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end
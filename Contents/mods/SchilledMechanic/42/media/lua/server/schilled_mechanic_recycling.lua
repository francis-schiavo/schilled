require "SchilledMechanic"

SchilledMechanic.OnCreate = {}

function SchilledMechanic.OnCreate.RecycleCarSeats(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleCarSeatsYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanic.OnCreate.RecycleElectronics(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleElectronicsYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanic.OnCreate.RecycleMetalPipePart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleMetalPipeYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanic.OnCreate.RecycleBigMetalPipePart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleBigMetalPipeYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanic.OnCreate.RecycleMetalSheetPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleMetalSheetYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanic.OnCreate.RecycleSmallMetalSheetPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleSmallMetalSheetYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

function SchilledMechanic.OnCreate.RecycleArmorPart(craftRecipeData, character)
    local inventory = character:getInventory()
    local yield, xp = SchilledMechanic:GetRecycleArmorYield(character)
    SchilledMechanic:AddXp(character, xp)
    SchilledMechanic:Yield(inventory, yield)
end

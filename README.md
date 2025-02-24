# Schilled

## How to build this project

You can clone this repository to any directory and use the `build.sh` script to build the modpack.
What it does is just copy the contents to the $WORKSHOP_DIR directory without copying any undesirable files
like the `.git` directory, `README.md` and `build.sh`.

Permission is granted to use this mod as a learning tool, but you MUST NOT re-upload it to the workshop. Not even to add translations.
If you want to add translations, please do so by creating a pull request.
If you wanna user your own private version of this mod with some changes, please do so by uploading it with visibility unlisted.

## About the modpack

Schilled is a mod tailored for the user preferences of my personal Zomboid server.

The name is a play on word combining my nickname "Schiller" and the word "skilled".

The idea behind this mod is to provide some powerful new items and recipes tied to
high level perks, to give the player a sense of progression and reward for their
efforts in leveling up their skills.

The modpack is split in several mods, each one focusing on a different aspect of the game.

## Mods

### Schilled

This is the base mod, works mainly as a library for the other mods. Must always be enabled.

**Build 42 only**:
- Soaps can be consolidated and lasts longer.
- Having a Sponge in your inventory will act as having soap and allow washing faster.

### SchilledCarpenter

Changes to the base game:

- Reduces the weight of the following items:
    - Log: from 9 to 5
    - LogStacks2: from 6 to 4
    - LogStacks3: from 9 to 7
    - LogStacks4: from 12 to 9
- When sawing a log you get 4 planks instead of 3.

**Build 41 only**:

For B41 this mod adds some recipes allowing you to change the handle of some tools. Recipes:
- Repair Wood Axe
- Repair Axe
- Repair Sledgehammer

Since B42 already provides a similar mechanic, those recipes are now removed.

### SchilledCook

Allows cooking home made glue:
- HomeMadeGlueRaw: You can mix flour, water, vinegar, salt and baking soda to create raw glue.
- HomeMadeGlue: After cooking HomeMadeGlueRaw it you get a pot of glue and then split it in glue tubes.

**Build 41 only**:
- Allows to use any type of vinegar and sugar when jarring food.
- When opening a jar of food you get the jar lid back.
- Allows consolidating soap bars (I put it in this mod as a test, and it stayed there).
- ImprovisedCan:
  - By sawing pipes you can create new empty food cans.
- ImprovisedLid:
  - By cutting plastic bags you can create new lids for the improvised cans.
- Homemade food items:
  - CannedTomatoHomeMade, CannedPotatoHomeMade and CannedCarrotsHomeMade: By using an empty
    food can, some twine or a rubber band an improvised lid and the respective vegetable
    you can create a canned food item.
  - TomatoPasteHomeMade: By using a tomato and a mortar and pestle you can create tomato paste.
  - SugarCarrot: By using a carrot and a mortar and pestle you can create sugar.
  - VinegarTomato: By using a tomato you can create vinegar.
  - RadishSpice: By using a radish and a mortar and pestle you can create radish spice.
  - HomemadeKetchup: By using tomato and vinegar you can create ketchup.

**Notes**: Since B42 introduced a lot of new plants and the ability to create jars, it didn't make sense to keep the old recipes.
Some of them will be reintroduced down the road, but for now they are disabled.

### SchilledMechanic

It adds the possibility to repair all vehicle parts in a different manner.
For parts that the base game already allows you to repair, the mod will add an alternative recipe
that will use more mats but guarantee repair to 100%.

For parts that the base game doesn't allow you to repair, the mod will add a recipe that will allow you to repair them.

This mod also allows you to recycle old parts or even entire vehicles and vehicle wrecks.
While this functionality is very similar to the "Vehicle Repair Overhaul" mod, there are some big differences:

- Recycling each part uses an algorithm that will yield a predictable amount of mats based on the part condition
  and your skills in mechanics and metalworking.
- Recycling a vehicle will yield a predictable amount of mats based on the condition of each of the parts, the same
  amount you would get if you recycled each part individually.
- It does not add any new items to the game, it uses the existing ones.
- It allows you to create more spare engine parts using scraps.
- When repairing an engine to 100% it will also set the engine quality to 100%.

### SchilledMetalworker

This mod adds some recipes allowing you to create the following items:

- ReinforcedMachete: By using a machete and a metal bar you can create a reinforced machete.
  It lasts longer and deals more damage.
- SuperMachete: By combining 3 machetes and some metal bars you can create a super machete.
  It lasts even longer and deals even more damage.
- ReinforcedToolbox: By using a regular toolbox,some metal, hinges, welding rods and a blowtorch you can create a reinforced toolbox.
  It holds more items and greatly reduces the weight of the tools inside.

**Build 41 only**:

- Propane tanks and lighters can be consolidated.
- NonCombatScissors: By using scissors and a metal bar you can create a non combat scissor.
  It is indestructible but can't be used for combat.

### SchilledPainter

- Paint buckets and plaster lasts a lot longer.

### SchilledTailor

- Thread spools can be consolidated faster.
- Ripping clothes of all kinds is really fast.
- ReinforcedFannyPack: By using a fanny pack and some leather you can create a reinforced fanny pack.
  It holds more items and greatly reduces the weight of the items inside.
- ReinforcedBackpack: By using a backpack and some leather you can create a reinforced backpack.
  It holds more items and greatly reduces the weight of the items inside.
- ReinforcedFirstAidKit: By using a first aid kit and some leather you can create a reinforced first aid kit.
  It holds more items and greatly reduces the weight of the items inside.
- ReinforcedSewingKit: By using a sewing kit and some leather you can create a reinforced sewing kit.
  It holds more items and greatly reduces the weight of the items inside.

**Build 42 only**:

- Removed the reinforced fanny pack
- You can now reinforce the 3 variants of large backpacks. (Regular, army and desert) 

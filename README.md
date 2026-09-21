# Schilled

## How to build this project

You can clone this repository to any directory and use the `build.sh` script to
build the modpack. It copies the mod into `$WORKSHOP_DIR` without copying
undesirable files like the `.git` directory, `README.md` and `build.sh`.

`WORKSHOP_DIR` is required. This tree is Build 42 (`42/` + `common/`). Set
`BUILD=42` when you run the script: it still defaults to `41`, and there is no
`41/` directory on disk.

Each mod ships a 32×32 `icon.png` and a matching 256×256 `preview.png` in its
`common/` folder (`icon=icon.png` / `poster=preview.png` in `mod.info`).

Permission is granted to use this mod as a learning tool, but you MUST NOT
re-upload it to the workshop. Not even to add translations.
If you want to add translations, please do so by creating a pull request.
If you want to use your own private version of this mod with some changes,
please do so by uploading it with visibility unlisted.

## About the modpack

Schilled is a mod tailored for the user preferences of my personal Zomboid
server.

The name is a play on word combining my nickname "Schiller" and the word
"skilled".

The idea behind this mod is to provide some powerful new items and recipes tied
to high level perks, to give the player a sense of progression and reward for
their efforts in leveling up their skills.

The modpack is split in several mods, each one focusing on a different aspect of
the game. Enable **Schilled** (the base mod) plus whichever skill modules you
want. None of the submodules declare `require=` in `mod.info`, but they call
into the base mod, so leave Schilled enabled.

This pack is Build 42 only.

Carpenter, Cook, Mechanic, Metalworker, Eletrician, Tailor, Admin and the base mod ship
English and Brazilian Portuguese translations.

## Mods

### Schilled

This is the base mod. It works mainly as a library for the other mods and must
always be enabled.

- Soap (`Soap2`) lasts longer (`UseDelta = 0.05`), weighs `0.1`, and can be
  consolidated.
- A sponge in your inventory counts as soap.
- Washing duration is overridden (faster when you have soap).
- Inventory transfers are faster (`ISInventoryTransferAction` maxTime is halved,
  then capped at 20).
- Boil-disinfect 10 bandages or ripped sheets at once (`DisinfectBandages`):
  0.5L hot water, `time = 150`. Vanilla `DisinfectBandage` (1x) is unchanged.

### SchilledCarpenter

Changes to the base game:

- Reduces the weight of the following items:
    - Log: from 9 to 5
    - LogStacks2: from 6 to 4
    - LogStacks3: from 9 to 7
    - LogStacks4: from 12 to 9
    - Plank: from 3 to 2
- Patches `SawLogs` with `Time = 120` and an additional output of 1 Plank.
- **Reinforced Baseball Bat** (`ReinforceBaseballBat`, Woodwork / Carpentry 5):
  a baseball bat or crafted bat + 2 planks/sticks + 5 nails + a hammer. Stronger
  than vanilla (min 1.2 / max 1.6) and lasts a bit longer
  (`ConditionLowerChanceOneIn = 50`). Separate from vanilla tin-can reinforce.

### SchilledCook

Allows cooking homemade glue.

- **Create homemade glue** (`CreateHomeMadeGlue`): a cooking pot or forged pot,
  baking soda, salt, flour and vinegar. No water. Awards 20 Cooking XP.
  Produces a pot of uncooked homemade glue (regular or forged, matching the pot
  you used).
- Cook the raw pot (20 minutes) to get a pot of homemade glue. The cooked pot is
  tagged as glue (`UseDelta = 0.25`).
- **Refill glue bottles** (`RefillGlueBottle`): turns a pot of homemade glue
  into 25 `Glue`.
- Raw homemade glue is drinkable and highly poisonous (`PoisonPower = 120`).
- Also allows you to slice baguettes into bread slices and yeld more slices from a loaf of bread.

### SchilledMechanic

Adds more ways to repair vehicle parts, recycle parts and wrecks, and craft
spare engine parts.

For parts the base game already lets you repair, vanilla fixings are patched
with a much higher `ConditionModifier` (10, or 15 on hoods and trunk lids) so
repairs restore far more condition. Extra fixers are added on the glove box and
car seats.

For parts the base game does not let you repair, the mod adds fixing recipes
(battery, suspension, brakes, muffler, tires, windows, lights, radio,
lightbars). KI5 M998 / DAMN parts and run-flat tires are covered in a late-load
support script.

This mod also lets you recycle old parts or entire vehicles and wrecks. While
this is similar to Vehicle Repair Overhaul, there are some big differences:

- Recycling each part uses an algorithm that yields extra mats based on your
  Mechanics / Metalworking (and related) skills. Engine scrap scales with engine
  condition.
- Recycling a vehicle from the outside-vehicle menu (Mechanics 2, Metalworking
  2, welding mask, blowtorch) drops a base pile of metal plus the yield of the
  installed parts.
- It does not add any new items to the game, it uses the existing ones.
- **Craft spare engine parts** (`CraftSpareEngineParts`): Mechanics 10. 15 scrap
  metal + 5 electronics scrap → 5 engine parts (12 Mechanics XP).
- Repairing an engine to 100% also sets engine quality to 100%.
- Heaters use a custom repair (not a vanilla fixing): 10 scrap metal + 5
  electronics scrap, Mechanics 10 and Electricity 4, restored to 100%.
- Tire inflation is faster (time scales down with Mechanics skill).
- The usual repair-count penalty is wiped after a part repair.

### SchilledMetalworker

Adds recipes for high-level metalworking gear, plus a magazine that teaches you
how to cut keys.

- **Reinforced Machete** (`ReinforceMachete`, Metalworking 5): 1 machete, 1 metal
  bar, 1 welding rods, blowtorch, welding mask. Lasts longer and deals more
  damage (min 4 / max 6, `ConditionLowerChanceOneIn = 500`).
- **Super Machete** (`MakeSuperMachete`, Metalworking 8): 3 machetes, 1 metal
  bar, 2 welding rods, blowtorch, welding mask. Lasts even longer and deals even
  more damage (min 6 / max 10, `ConditionLowerChanceOneIn = 2000`).
- **Reinforced Toolbox** (`MakeReinforcedToolbox`, Metalworking 8): 1 toolbox, 2
  sheet metal, 2 metal bars, 2 hinges, 2 welding rods, blowtorch, 2 welding masks.
  Capacity 20, weight reduction 80.
- **Keymaster Magazine** (`KeymasterMag`): found in bookstores, tool stores and
  a few other magazine/mechanic spawns. Teaches `Make_car_key` and
  `Make_door_key`. With the recipes known you can create a vehicle key (outside
  the vehicle) or a door key (inside a building). Tooltip asks for 5 scrap
  metal; the scrap is not actually consumed.
- Vanilla "Remove burnt vehicle" is stripped from the vehicle menu (use Mechanic
  recycle instead).
- Blowtorches last much longer (`UseDelta = 0.001`). Refilling from a propane
  tank is rewritten to match that use rate.

- **Paint Toolbox** / **Paint Reinforced Toolbox**: one recipe each; vanilla paint picks the color via `itemMapper` (`PaintGrey` → dark gray, `PaintBlue` → blue, `PaintOrange` → orange, `PaintRed` → vanilla red). **Make Reinforced Toolbox** is one recipe that maps each color to its reinforced variant.

### SchilledMason

- Paint cans (all colours), plaster buckets, and cement/concrete buckets last
  10× longer (`UseDelta` is 1/10 of vanilla: paint/plaster `0.01`, cement `0.025`).

### SchilledTailor

- Thread spools consolidate much faster (consolidate time 5 instead of 90).
- Ripping clothes is fast and can be batched. All rip recipes award 2 Tailoring
  XP:
    - Rip clothing / worn clothing / sheets: Time 10
    - Rip denim: Time 20
    - Rip worn denim: Time 30
- **Reinforce backpack** (`ReinforceBackPack`, Tailoring 8): empty ALICE pack,
  army ALICE pack, or desert camo ALICE pack + 5 denim strips + 5 leather strips
  + 10 thread + a sharp knife or scissors. Capacity 60, weight reduction 95.
  There is no generic reinforced backpack and no reinforced fanny pack.
- **Reinforce sewing kit** (`ReinforceSewingKit`, Tailoring 8): empty sewing kit
  + 2 denim strips + 2 leather strips + 5 thread. Capacity 7, weight reduction
  60.
- **Reinforce first aid kit** (`ReinforceFirstAidKit`, Tailoring 8): empty first
  aid kit + 2 denim strips + 2 leather strips + 5 thread. Capacity 8, weight
  reduction 60.


### SchilledBlacksmith

WIP scaffold — blacksmith features coming soon.

### SchilledEletrician

Craft vehicle lightbars at Electricity 5 from electronics scrap, scrap metal, colored bulbs, and a screwdriver: `Base.LightbarRedBlue`, `Base.LightbarRed`, `Base.LightbarBlue`, and `Base.LightbarYellow`.

### SchilledAdmin

A basic server administration mod for claiming vehicles.

- Claim a vehicle from the outside-vehicle menu if you have its key. Ownership
  is stored on the vehicle as `modData.claimedBy` (username).
- Other players cannot enter, mechanic, open doors, smash windows, unlock, or
  siphon fuel from a claimed vehicle they do not own.
- The owner can unclaim. Admins (and debug vehicle cheats) get force
  claim/unclaim options.

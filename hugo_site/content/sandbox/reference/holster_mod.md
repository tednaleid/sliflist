---
title: "Holster Mod"
draft: false
menu:
  sandbox:
    parent: "reference"
---

# `Holster` Mods

Season 15 added `Holster` Leg Mods for all weapon types that have more than one round in the chamber by default (i.e. no tube grenade launcher, rocket launcher, or sword mods).

The description says:

> Gradually reloads your stowed `<weapon_type>` over time.  Multiple copies of this perk stack to reduce the time taken to fully reload.

The various mods work similarly across weapon typoes, the only difference is the number of round loaded for each time the mod procs.

## One `Holster` Mod

If you have one Holster Mod equipped it will proc and partially load the magazine first at 4 seconds and then every 6 seconds thereafter.   

So if you have a single `Fusion Rifle Holster` mod equipped, it will reload a single shot each time the mod procs.If you empty a 6 shot fusion rifle and switch to your kinetic weapon, it will load the first round after 4 seconds, the second round after 10 seconds, and be fully loaded after 34 seconds `(4 + 6 + 6 + 6 + 6 + 6)`.

If you switch back to the fusion rifle before it is fully loaded, the timer will stop and you'll need to stow it again for 4 seconds to load the next round.

This is especially good on those weapon types that benefit from beign fully loaded (like those with the `Chain Reaction` perk).

## Two `Holster` Mods

Having 2 `Holster` mods has diminishing returns.  The mod will still wait 4 seconds after stowing before the first proc.  All subsequent procs will _also_ happen after 4 seconds.  So a 6 shot fusion rifle will load the first round after 4 seconds, the second after 8 seconds, and be fully loaded after 24 seconds `(4 + 4 + 4 + 4 + 4 + 4)`

## Rounds Loaded For Each Weapon Type On Proc

The only difference between weapon mods is the number of rounds loaded for that weapon type.  Pulse Rifles are weird in that some will load a single "burst" and some will load 2 "bursts" on each proc.  

|Weapon|Rounds Loaded On Proc|
|----|------------|
|Fusion Rifle|1 round|
|Linear Fusion Rifle|1 round|
|Heavy Grenade Launcher |1 round|
|Shotgun|1 round|
|Sniper Rifle|1 round|
|Auto Rifle|6 rounds|
|Scout Rifle|2 rounds|
|Submachine Gun|4 rounds|
|Trace Rifle|10 rounds|
|Hand cannon|2 rounds|
|Sidearm|2 rounds|
|Pulse Rifle|1-2 "bursts"|
|Bad Juju|3 rounds (1 burst)|
|Vigilance Wing|5 rounds (1 burst)|
|No Time To Explain|3 rounds (1 burst)|
|Legal Action II|3 rounds (1 burst)|
|Graviton Lance|2 rounds (1 burst)|
|Outbreak Perfected|6 rounds (2 bursts)|
|Chattering Bone|6 rounds (2 bursts)|
|The Third Axiom|6 rounds (2 bursts)|

I have not tested any 4-burst pulse rifles, none are actively dropping in the game as of Season 15.

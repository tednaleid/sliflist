---
title: "Fusion Rifles"
draft: false
menu:
  sandbox:
    parent: "weapons"
---

*2021/08/29: With the big S15 Fusion Rifle changes, much of this page needs reworking (ARGH). Left here for posterity.*

## Spicy Topics

* **Charge Time Masterworks**: Often seen as a instant dismantle, is it ever useful? When is `Charge Time` a useful Masterwork to bring up to `10`? Is there some combination of Charge Time / Impact-modifying magazines that might affect that decision?
* **High-Impact Reserves**: There are [issues with `High-Impact Reserves`](https://www.youtube.com/watch?v=PKvn1Q49EAk) with fusions when spawning in. The hypothesis is that the game is continuously checking the mag size while the bolts are firing and treats eat bolt differently. This explains why sometimes, the last few bolts when firing at `3` ammo are buffed (also, rounding).

## Rapid-Fire Frames & ?-BOLT OHKs

Rapid-Fire Frames require a **minimum of ? bolts** to connect for a OHK.

* **Base Model**: ?
* **High-Impact Reserves**: ?

|Mag|CTMW|Charge Time|Impact|Base Damage|OHK|HIR (2 In Mag)|OHK|HIR (1 in Mag)|OHK|
|-|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|Acc.|Y||||||||||
|Acc.|N||||||||||
|n/a|Y||||||||||
|n/a|N|540ms|55||||||||
|Liq.|Y||||||||||
|Liq.|N|580ms|60|36|N/A|37-38|< 4|38|< 4|

## Adaptive Frames & FIVE-BOLT OHKs

Adaptive Frames require a **minimum of five bolts** to connect for a OHK.

* **Base Model**: Oddly, sans-High-Impact Reserves, the base model is what you want. Liquid Coils only slows you down without bumping you up to the next OHK tier.
* **High-Impact Reserves**: ?

|Mag|CTMW|Charge Time|Impact|Base Damage|OHK|HIR (2 In Mag)|OHK|HIR (1 in Mag)|OHK|
|-|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|Acc.|Y|580ms|60|36|N/A|37-38|< 4|38|< 4|
|Acc.|N||||||||||
|n/a|Y|620ms|65|37|N/A|38-39|< 8|39|< 8|
|n/a|N|660ms|70|38|< 4|39|< 8|39|< 8|
|Liq.|Y||||||||||
|Liq.|N|700ms|75|38|< 4|40|ALL|40-41|ALL|

## High-Impact Frames & FOUR-BOLT OHKs

High-Impact Frames require a **minimum of four bolts** to connect for a OHK.

* **Base Model**: If you want a four-bolt OHK, use either Accelerated Coils or a Charge Time MW+10 but not both.
* **High-Impact Reserves**: If you want a four-bolt OHK up to `9` Resilience, combine `Accelerated Coils` with `High-Impact Reserves`.

|Mag|CTMW|Charge Time|Impact|Base Damage|OHK|HIR (2 In Mag)|OHK|HIR (1 in Mag)|OHK|
|-|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|Acc.|Y|780ms|85|40|N/A|?|?|?|?|
|Acc.|N|820ms|90|48|< 6|49-50|< 9|50|ALL|
|n/a|Y|820ms|90|48|< 6|48|< 6|50|ALL|
|n/a|N|860ms|95|48|< 6|50|ALL|51|ALL|
|Liq.|Y|860ms|95|48|< 6|50s,48|ALL*|51s,48|ALL*|
|Liq.|N|900ms|100|49|< 9|51|ALL|51-52|ALL|

_* - Because of the wackiness here, it's hard to say what happens but it *should* work this way. It's not super relevant because this is not a combination of perks you would take (Liq. Coils + Charge Time MW) since they cancel each other out._

---
title: "What's in a Roll?"
draft: false
menu:
  docs:
    parent: "welcome"
weight: 3
toc: true
---

With so many weapons and potential rolls, one main goal of the Sliflist is to make submitting rolls as easy as possible to reduce the barrier to populating the Sliflist. In order to do that, we first need to explain the roll format and how a roll turns into DIM wishlist entries.

## Sliflist Thesis

Over the past two years, we've noticed that many rolls fall into the same pattern:

1. The perfect (aka "god") roll, getting exactly what perks you want in every column, including the masterwork. A wishlist that only specified these wouldn't be valuable because in general there's a sub-1% chance these rolls appear.
1. The incremental "relaxing" of constraints from the perfect roll down a a baseline acceptable set of perks. Statiscally these rolls make up the majority of our values.

By presuming this pattern, we can create automation that, from a succinct specification, auto-generates variations of the perfect roll.

## Sample Roll Specification

Below is an excerpt from [The Steady Hand roll collection](https://github.com/rslifka/sliflist/blob/main/rolls/iron_banner/steady_hand.yml). It represents a single "roll" of `The Steady Hand` which we refer to as "a core collection of perks and slight variants that define this general build of the weapon". Over the remainder of this document you'll see how all the fields are used.

{{< gist rslifka 3a5fe1c01d85925a12fe549fcb8e4544 >}}

From this single specification, we auto-generate the strongest variations in order of desireability to create a set of "variants". The variants incrementally relax constraints from "the ideal" down to "just the two main perks" (`Moving Target` and `Iron Gaze` in this example).

## Deciphering the Variants

| Variant | Chance | 1 in ? |
|:-|-:|-:|
| 🔒🔒🔒🌟 Collector's Edition | 0.10% | 960 |
| 🔒🔒🔒 CE (+barrels) | 0.14% | 720 |
| 🔒🔒🔒 CE (+magazines) | 0.19% | 516 |
| 🔒🔒🔒 CE (*masterworks) | 0.42% | 240 |
| 🔒🔒 (+barrels, +magazines) | 0.26% | 387 |
| 🔒🔒 (+barrels, *masterworks) | 0.56% | 180 |
| 🔒🔒 (+magazines, *masterworks) | 0.77% | 129 |
| 🔒🔒 (+barrels, +magazines, *masterworks) | 1.03% | 96 |
| 🔒 (*barrels, *magazines, *masterworks) | 2.78% | 36 |

The name of a variant has a few components that dictates how the wishlist entries are derived.

Starting with the emojis, these are meant to be a silly faux-"rating" system, opening with the rarest 🔒🔒🔒🌟 down to the "baseline" 🔒. They have no meaning to the Sliflist; they're arbitrary text. The `+` symbol is an instruction to the Sliflist to extend the list of acceptable perks in this column as specified under `extended_perks`. The `*` symbol instructs the Sliflist to completely relax all constraints on this column, e.g. `*masterworks` = "Any masterwork is fine for this variant".

### Custom Variants

In some cases, like grenade launchers, you want to "lock" the second column (e.g. Spike Grenades or Blinding Grenades) which means you need to specify the all the variants yourself. These are `custom_variants` and require a bit more in-depth understanding of how the Sliflist works. We'll save those for another time. Eventually we may create multiple sets of "standard variants" for roll authors to choose from, because those variants also fan out in a predictable way.

## The Wishlist

Variants are then transformed into DIM wishlist entries and published on the website for usage in DIM. Let's look at the wishlist entries generated for the variant: `🔒🔒🔒🌟 Collector's Edition`.

```text
//notes:[pvp] "Locked On" 🔒🔒🔒🌟 Collector's Edition
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375892
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375893
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375896
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375897
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375898
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375899
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375901
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375902
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,1590375903
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,2942552113
dimwishlist:item=2220884262&perks=1926090094,1885400500,588594999,4152709778,384158423
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375892
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375893
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375896
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375897
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375898
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375899
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375901
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375902
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,1590375903
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,2942552113
dimwishlist:item=2220884262&perks=1926090095,1885400500,588594999,4152709778,384158423
```

This is the [DIM wishlist format](https://github.com/DestinyItemManager/DIM/blob/master/docs/COMMUNITY_CURATIONS.md), how DIM understand what rolls are desirable so it can display the 👍 or 👎 as appropriate.

You might be surprised to see so many entries for what you'd colloquially consider a single "roll". This is mostly because Destiny considers each level of Masterwork its own distinct perk. That means if you want DIM to match your roll and give you a thumbs up, you need to have a line for every perk you're after and then one of those lines for every possible masterwork level. This means a wishlist.txt might have tends of thousands of entries but only **really** what people would generally consider a hundred or so rolls.

## Submitting Rolls

Now that you know rolls work, are you interested in [submitting one](https://github.com/rslifka/sliflist/issues/new/choose)?

If not, that's cool too 👋 ❤️

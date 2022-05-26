# Healthblocks

This mod recreates the block-based health regeneration from Wolfenstein: The New Order, with plenty of cvars to configure exactly how it works.
By default, if you have not taken damage for 3 seconds, you will regenerate 1 health every 7 ticks, up to the nearest 50, capping at your starting health.
(The block size was chosen for Nightmare Logic's HUD, which has health in blocks of 50.)

## The CVars

`hblock_delay`: How long you have to go without damage to start regenerating, in tics. Larger means you need to hide for longer. Defaults to 105.

`hblock_size`: How large the health blocks are. Larger values means the breakpoints are larger. Defaults to `50`.

`hblock_tick`: How many tics should pass between each instance of healing? Larger means longer. Defaults to `7`.

`hblock_amount`: How much health should you geat with each healing tick? Larger means more healing. Defaults to `1`.

`hblock_over`: Should you be able to receive overhealing from Healthblocks? Defaults to `false`.
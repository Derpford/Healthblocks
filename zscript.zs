version "4.6.0"
class HealthBlockHandler : EventHandler {
    Array<int> timers;
    transient CVar hbtick; // how many ticks between heals
    transient CVar hbdelay; // how long after damage to not heal
    transient CVar hbsize; // the size of a health block
    transient CVar hbamount; // how much to heal each time
    transient CVar hbover; // Give health bonuses so that you can overheal?
    
    override void OnRegister() {
        timers.resize(MAXPLAYERS); // one array per player
        // negative = waiting on damage
        // positive = ticking toward heals

        // If it has been hblock_delay tics since the last source of damage:
        // Every hblock_tick tics, if our health % hblock_size is not 0, heal either hblock_amount or up to the next hblock_size increment.
        hbtick = CVar.GetCVar("hblock_tick");
        hbdelay = CVar.GetCVar("hblock_delay");
        hbsize = CVar.GetCVar("hblock_size");
        hbamount = CVar.GetCVar("hblock_amount");
        hbover = CVar.GetCVar("hblock_over");
    }

    override void WorldTick() {
        for (int i = 0; i < MAXPLAYERS; i++) {
            if (playeringame[i]) {
                timers[i] += 1;
                if (timers[i] >= hbtick.GetInt()) {
                    PlayerInfo plr = players[i];
                    int hp = plr.mo.health;
                    int block = hbsize.GetInt();
                    if (hp % block != 0) {
                        // We're not sitting on a breakpoint. Heal up!
                        int delta = block - (hp % block);
                        // console.printf("Distance to next block: "..delta);
                        int maxhp = plr.mo.SpawnHealth();
                        if (hbover.GetBool()) { maxhp = int.max; }
                        plr.mo.GiveBody(min(delta, hbamount.GetInt()),maxhp);
                    }
                    timers[i] = min(timers[i],0);
                }
            }
        }
    }

    override void WorldThingDamaged(WorldEvent e) {
        if (e.Thing is "PlayerPawn") {
            timers[e.Thing.PlayerNumber()] = hbdelay.GetInt() * -1;
            // console.printf("PNum: "..e.Thing.PlayerNumber());
        }
    }
}
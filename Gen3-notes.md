Lessons learnt from Gen 1/2:

### Power rails

I started out with various base boards that generally generated negative
power rails, because it felt like the RightThing(tm).  Then Gen2 ended
up just using a virtual ground at 4.5V anyway because anything else was
unnecessarily complex.

But that caused issues too, and when I went all old-school and decided
that even op-amps were too fancy, and I actually wanted to regress to
just entirely discrete components, even the 4.5V virtual ground was just
a distraction.

The simplest discrete boards just don't need it or want it, and even
when they do a reference voltage they don't necessarily pick the
mid-point of the supply.

So the gen3 base board is entirely passive, with no signal buffering or
any re-biasing.  So all the base board does is the stomp switch bypass,
and some very basic power supply sanity (a high-side P-MOSFET for
reverse polarity protection and some capacitors for power supply
stability).

### 1590A enclosure fit

This is a solved problem.  Gen1 was borderline and was playing with
power connectors etc, gen2 tweaked some of the positioning, but I think
gen3 is "done".

The internal inter-board connector did change in gen3, because it's now
simpler with a minimal 4-pin header (just GND / 9V / In / Out) and more
out of the way.  But that didn't affect the enclosure, just the board
pairings.

### Circuits

The lesson from Gen 1/2 has mostly been that I don't actually care about
how things sound, and what I like is the tinkering, and trying to
(still) understand the circuits.

So laying out and soldering the boards is still fun, but using op-amps
to buffer a signal has become "just do it with a transistor".

Because while op-amps are clearly simpler and better to technology to
use, they kind of miss the point of "let's understand what's going on"
by just adding that whole abstraction layer.

So the circuits have regressed to being even simpler and more pointless.

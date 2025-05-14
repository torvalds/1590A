## Random guitar pedal board designs for 1590A enclosures

### Electrical

These are probably entirely non-functional, but having done guitar pedal
board kit builds, I decided I should try to make something from scratch.

> [!WARNING]
> **Little of this is tested**
>
> I've never done analog circuits in my life.  But hey, I also
> don't play guitar, so when it doesn't work, it doesn't really
> matter.
>
> So be aware that it probably doesn't work, or if it works it
> does so mainly by luck.

> [!NOTE]
> I'm not soldering wires together like some kind of animal ---
> thus PCBs designed in KiCad.
>
> And not only don't I solder wires, I like surface-mount
> components.  And not just because some newer stuff isn't
> even available in through-hole form any more.
>
> Everything is designed to be "hand-soldered" --- although
> your definition of hand-soldering may differ from mine. The
> boards are double-sided, but surface mount components are
> only on one side, typically with the other side used only
> for connectors and the like.
>
> I do these without a stencil. It's entirely doable, since I'm
> now limiting myself to fairly simple SOIC-8 and the like.

The design is split up into a "base board" and "effects boards", because
the 1590A is pretty tight.

The base board should work with any of the effect boards, and is mainly
just about the power rails and the input and output DC decoupling and
signal buffering. And the stomp switch with true bypass etc.

The input buffering also has a trim-pot on the base board for setting
initial an boost level for the effect board input (1..11x voltage gain,
so roughly 0..+20dB).

The base board design is a traditional 9V power rail with a reference
voltage at 4.5V (except using a 2426 rail splitter rather than some kind
of traditional voltage divider hackery).  As far as the effect boards
are concerned, that reference voltage *is* ground, and they think they
have +-4.5V power rails.

The effects boards are random "Linus is testing things he doesn't know
anything about".

 - There's a traditional boost pedal with the traditional switch for
   clipping diodes. I think there's a law that you have to do an
   overdrive pedal with distortion. It also does some tone control with
   a Baxandall circuit.

   You can keep it as a clean boost, or have it clip either with the
   diodes or even just from hitting the voltage rails by boosting too
   much. With the opamps I have, hitting the voltage rails is a clean
   clip. But your choice of opamp will most definitely matter.

 - There's a "rectifier" board that is really just an op-amp based
   precision rectifier of the signal in front, with the original signal
   blended back in, and then a low-pass filter and volume knob.

   It's supposed to be an octaver fuzz kind of thing.

Some pieces of this --- not all --- have been tested.  And some pieces
have been simulated in ngspice.  Signals have been looked at with a
signal generator and a scope, and I've made random noises on an electric
guitar to check that it works that way too.

Is it *musical*? Hell knows.  The first rectifier board was horribly
broken with nasty high-frequency noise, but it actually sounded somewhat
interesting with a bass guitar and amp that filtered all that out.

This "gen2" one hopefully is better.

> [!NOTE]
> Unlike the Gen1 boards, these are two-layer boards. Yes, it's slightly
> cheaper, but perhaps more importantly it means I get boards back a day
> earlier for testing.
>
> That admittedly hasn't improved the end result noticeably yet, but one
> day. One day..

### Mechanicals

Equally importantly: does the mechanical side work and will it actually
fit in a 1590A enclosure?

Yes.  Yes it does.  Gen1 kind of did.  Gen2 definitely fits.  It's still
tight, but I've worked on it. See the ["Gen2-notes"](/Gen2-notes.md)

Unlike most enclosure builds, you also can not just drill 9.5mm holes in
the sides for the audio jacks - you need to drill the sides all the way
down so you can slide the board into the enclosure.

### Components

Connectors and potentiometers are typically from Tayda Electronics,
with most of the actual SMD components from Mouser:

 - Tayda A-6976: 1/4" thread lock panel mount mono jack CK635008

 - Tayda A-1848 etc: ALPHA 9mm PCB-mount potentiometers

 - Tayda A-4191: ALPHA 3PDT latching stomp switch.

 - Tayda A-3670 etc: 1M series mini toggle switches and the sub-mini 2M
   series for the side switch.

 - Wurth 694106301002 9V DC power jack

 - SMD resistors are all 0805, and the values generally don't matter,
   but there's a couple of voltage references, so why would you ever get
   anything other than 1% stuff as a general kit?

 - Capacitors are 1206 for the power caps, with a Murata 0704 sized cap
   for the common 0.1uF ones, and 0805 sized for the small C0G signal
   capacitors.

 - Op-Amps are SOT-23-5 (single) or SOIC-8 (double). I use OPA165x for
   these, but they should all be mostly all pin-compatible.

   Note that if you use something like a traditional TL072, you *will*
   hit the rails and get horrible distortion if you do the boost thing.
   That may be what you want, but on the whole I'd suggest something
   more modern and more rail-to-rail'ish.

 - Hammond 1590A enclosure. There are Tayda drill patterns that work.

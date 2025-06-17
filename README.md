## Random guitar pedal board designs for 1590A enclosures

### Electrical

These are not really all that useful, but having done guitar pedal board
kit builds, I decided I should try to make something from scratch.  I
don't actually play guitar, but guitar pedal kits were fun to solder,
and that then turned into "I want to actually understand what they do".

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
signal buffering.  And the stomp switch with true bypass etc.

The base board design is a traditional 9V power rail with a reference
voltage at 4.5V (except using a 2426 rail splitter rather than some kind
of traditional voltage divider hackery).

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

   It works fine, and acts like any number of traditional boost pedals.

 - There's a "rectifier" board that is really just an op-amp based
   precision rectifier of the signal in front, followed by a low-pass
   filter to get rid of most of the harsh high frequencies that the
   rectification causes at the signal "folding" point.

   The original signal is then blended back in. It's supposed to be kind
   of an octaver fuzz kind of thing, although with the filter is more of
   a random distortion effect.

   The sound is actually somewhat interesting.

 - There's a "tremolo" board with an LFO that drives a timed attenuation
   of the signal through a JFET to ground.

   The traditional analog tremolo boards that I did from kits tend to
   use a LED coupled with a LDR ("Vactrol"), and that always struck me
   as hacky. That said, having designed it with a JFET I understand why
   they used that vactrol.

   This is a pretty useless board from a sound standpoint, but my
   favorite one from a learning standpoint.

All of this has been tested and found somewhat working.  And much of it
has been simulated in KiCad using LTspice.  Signals have been
looked at with a signal generator and a scope, and I've made random
noises on an electric guitar to check that it works that way too.

Is any of it *musical*? Kind of.  The boost pedal with clipping sounds
perfectly fine.  Real musicians have said "I could see myself using
this", but it's also obviously about as non-unique as you can get.

The rectifier board sounds more unique and interesting now that the tone
control has been made to be more extreme.  It definitely adds some
"character" to the output.  I'm not sure you'd use it for music, but
it's at least interesting.

The tremolo has a somewhat odd timing interface and the modulation is
pretty abrupt.  If you're looking for something smooth, this isn't it.
But I like the board.

> [!NOTE]
> Unlike the Gen1 boards, these are two-layer boards. Yes, it's slightly
> cheaper, but perhaps more importantly it means I get boards back a day
> earlier for testing.
>
> That helped enormously with the tremolo in particular, which went from
> having a very annoying ticking sound ("It's a metronome too!") to being
> almost usable.

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

 - Wuerth 694106301002 9V DC power jack

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

 - Hammond 1590A enclosure. There are drill patterns that work here:
   ["Tayda drill patterns"](/Tayda/Enclosure-drill-holes)

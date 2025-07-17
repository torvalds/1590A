## Random guitar pedal board designs for 1590A enclosures

### Electrical

These are not at all useful, but having done guitar pedal board kit
builds, I decided I should try to make something from scratch.  I don't
actually play guitar, but guitar pedal kits were fun to solder, and that
then turned into "I want to actually understand what they do"...

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
> I do these without a stencil. It's entirely doable, and I'm
> consciously limiting myself to fairly simple footprints

The design is split up into a "base board" and "effects boards", because
the 1590A is pretty tight.

The base board should work with any of the effect boards, and is purely
about the connectors and stomp switch with true bypass.

The base board does nothing to the signal (apart from the purely
physical switching of the stomp switch), and only does some very basic
reverse polarity protection and has some capacitors for the 9V power
supply.

The effects boards are random "Linus is testing things he doesn't know
anything about".

 - There's a random "Fuzz" board that I may still play around with,
   which just does some random signal clipping with a diode. I'm keeping
   that one around just as a starting point for other potential boards.

 - There's an "Octaver" board that is just a signal rectifier. I started
   out doing those with a op-amp based precision rectification circuit,
   but now it's a dual transistor discrete circuit instead.

   The rectification is objectively worse, but it's not like it made the
   sound any better, and the circuit is much more interesting.

 - There's a plain "clean boost" thing, which should be clean until the
   boosting starts to clip. Which happens pretty quickly since it's a
   pretty aggressive 25dB boost - assuming my simulation matches
   reality, which it might not do.

All of this has been tested and found lacking.  But now my simulation is
much better, and includes some real audio samples.  That didn't make any
of the circuits sound better, but once you realize that any sane modern
guitar pedals are all digital, and that this is just to learn the basics
of transistors etc, that's all good.

### Mechanicals

These are all trivial two-layer boards.  They could be single-sided with
very little routing problem, but that would only complicate things for
no gain.

It's not like I would ever want to even try to etch boards at home any
more, because while I go for "large" components, that's still very
relative.  Etching boards is messy and doing it with the precision
needed for smd is just too painful to be worth it.  See below on
components.

So just use JLCPCB or your favorite other board house.

### Components

Connectors and potentiometers are typically from Tayda Electronics, with
most of the actual common SMD components from kits or from Mouser.

For "random" SMD capacitors and resistors, get one of the kits.  I can
personally heartily recommend the Guanruixin kits from Amazon: there are
0805 and 1206 kits of both capacitors and resistors, and I love the
packaging and labeling.  Very good for organizing at a hobbyist level.

The AideTek kits are good too, but the Guanruixin ones are really
compact for those "get all the values just in case" situations.

Then just go to Mouser or Digikey and buy cut tape for the values you
use more of.  You'll run out of the common resistors in the kits, but
they are still worth having for the less usual ones and just for the
organizing.

And things that are just a bit more specialized - like the the C0G caps
in higher capacitances - you won't find in the kits.

Also, while I'm doing discrete components, I still consider "dual
diodes" etc to be discrete.  In fact I much prefer those for things like
diodes and transistors when possible (and if you want matched pairs
obviously make those a requirement - I realize some people do the manual
matching, but that's not for me).

I've picked SOT-23-6 packages over SOT-363 or SOT-563 because I find
that my limit for enjoying the soldering is at about the 1mm pin pitch.
The 0.65mm or 0.5mm pitch stuff ends up being just annoying.

The resistors are all 0805 size, and capacitors are all over the place:
smaller capacitors in the pF or nF range are 0805, bigger ones are 1206,
and I ended up with 0.1uF C0G in 0704 because it was a common cap choice
for both signal re-biasing and for op-amp bypassing, and doing 1206 was
actually taking up noticeable amounts of board space in some cases.

Electro-mechanical:

 - Tayda A-6976: 1/4" thread lock panel mount mono jack CK635008

 - Tayda A-1848 etc: ALPHA 9mm PCB-mount potentiometers

 - Tayda A-4191: ALPHA 3PDT latching stomp switch.

 - Tayda A-3670 etc: 1M series mini toggle switches and the sub-mini 2M
   series for the side switch.

 - Wuerth 694106301002 9V DC power jack

 - Hammond 1590A enclosure. There are drill patterns that work here:
   ["Tayda drill patterns"](/Tayda/Enclosure-drill-holes)

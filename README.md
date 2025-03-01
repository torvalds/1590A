## Random guitar pedal board designs for 1590A enclosures

### Electrical

These are probably entirely non-functional, but having done guitar pedal
board kit builds, I decided I should try to make something from scratch.

> [!WARNING]
> **None of this is tested**
>
> I've never done analog circuits in my life.  But hey, I also
> don't play guitar, so when it doesn't work, it doesn't really
> matter.
>
> So be aware that it probably doesn't work, or if it works it
> does so mainly by luck.

>[NOTE!]
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
> The simpler boards you can do with a soldering iron and some
> precision. But for some of them you really do want a hot-plate,
> and very careful manual solder paste application. The LM27762
> in particular has a ground pad underneath and is a tiny 2mmx3mm
> chip that is a bit challenging.
>
> I do these without a stencil. It's entirely doable, although
> admittedly I have to throw out the occasional board because I
> messed up (the LM27762 in particular).

There are six "base boards": they all do the same thing in slightly
different ways: they do dual power rails, the input and output audio
jacks, initial buffering of the signal, and the 3PDT stomp switch.

The base boards connect to a separate "effects board" using pin headers,
which is responsible for doign anything.

The base boards are supposed to be interchangeable, and only differ in
the power rail generation:

 - A traditional LT1054 charge pump and voltage doubler, turning the
   single 9V rail into +-15V dual rails

 - A LT1945 version: +-15V using slightly more modern chips

 - A LM27762 version: +-4.2V rails because 9V is dying

 - And two USB-C-powered versions because guitar pedal power supplies
   are nasty. One LT1054, one LM27762.

and then the "effects" boards can do whatever they want, including add
extra input or output jacks.  Obviously the power rail details (in
voltage, but also available power) migth limit them.

The effects boards are random "Linus is testing things he doesn't know
anything about".

 - There's a traditional boost pedal with the traditional switch for
clipping diodes.  I think there's a law that you have to do an overdrive
pedal with distortion.

 - There's a Baxandall tone control with volume knob.

 - There's a "splitter-with-headphone-amplifier" that splits the incoming
signal and you can use the second output either for headphones or for a
second audio path.

 - And there's a "joiner" that takes two inputs and adds them together.

I honestly don't know what I'm doing, I'm learning as I go, and the
effects boards in particular are mostly to test the concepts, and the
modularity with doing other things than just signal effects (ie those
utility boards for splitting/joining).

> [!WARNING]
> There is also a VGND base board.  It takes the traditional 9V
> guitar pedal power and creates a virtual ground at 4.5V using
> a TLE2426 rail splitter.
>
> That one is different in how the effects board ground is not the
> same as the external signal ground, and that means that you have
> to be a bit careful with any externally grounded things.
>  Notably any extra audio jacks.
>
> The "joiner" board tries to do that as a test.  But the splitter
> board does not: I am intentionally driving the second jack directly
> from the BUF634A buffer chip, so it's all ground-referenced.
> And if you _only_ connect headphones and no audio cables with
> external grounds it might still work.
>
> If any of it works at all.

Some pieces of this --- not all --- have been tested in isolation.
For example, an earlier version of the headphone amplifier thing
actually did work as a headphone amplifier.

>[!NOTE]
> The boards are all 4-layer designs, because why not? With JLCPCB
> prototyping, just the shipping is typically more expensive than
> the boards themselves. And the one time I did a two-layer board,
> I had forgotten that I had stale gerbers for the inner layers,
> and zipped the stale layers up together with the new ones.
>
> It saved me a couple of bucks, and cost me my dignity and two
> days of manufacturing when a human had to look at the design and
> ask me to fix it. So I don't do two-layer boards any more.

And that's just the *electrical* problems.

### Mechanicals

Equally importantly: does the mechanical side work and will it actually
fit in a 1590A enclosure?

Barely.

The boards are 1.6mm thick, and 12mm apart (to fit the audio jacks
sandwiched in between them), and with 10mm potentiometers on top, and
roughly 1.5mm of surface-mount components and through-hole pins under
the bottom board (mainly 3DPT switch - any other pins can be flush-cut),
you end up with a stack just under 27mm.

The inside height of the 1590A is documented to be 27.4mm.  Not a lot of
wiggle room.  I'd like to find lower-profile pots, because somewhat
annoyingly there's literally 3mm of precious unused space beneath the
9mm alpha pots.  So the bodies of the pots are actually physically just
7mm high, but then the standard height is apparently 10mm off the board.

Unlike most enclosure builds, you also can not just drill 9.5mm holes in
the sides for the audio jacks - you need to drill the sides all the way
down so you can slide the board into the enclosure.

So not only do the boards probably not work electrically, it's all very
dodgy indeed from a mechanical standpoint too.  I've been told that I'm
crazy for not doing a 125B enclosure.  But 1590A is just too cute.

### Components

Connectors and potentiometers are typically from Tayda Electronics,
with most of the actual SMD components from Mouser:

 - Tayda A-6976: 1/4" thread lock panel mount mono jack CK635008

 - Tayda A-1848 etc: ALPHA PCB-mount potentiometers (9mm for multiple,
   plain 16mm for single-pot designs)

 - Tayda A-4191: ALPHA 3PDT latching stomp switch.

 - Tayda A-3670 etc: 1M series mini toggle switches

 - Wuerth 694106301002 9V DC power jack or a Molex 6-contact USB-C jack
   (don't worry: the power-only 6P ones are easy - the full 24P USB-C
   jacks are a pain)

 - SMD resistors are all 0805, and the values generally don't matter,
   but there's a couple of voltage refereces, so why would you ever get
   anything other than 1% stuff as a general kit?

 - Capacitors are typically 1206, with the occasional 0805 for small
   pF/nF caps, and generally one or two electrolytic ones at the
   incoming power supply. The signal path should be C0G/NP0, and the
   power supply side should generally be X7R and X5R, but you be you.

 - The LT1945 wants inductors. I used random 1206 components, because I
   don't know what I'm doing. My test board worked, but I'm not going to
   guarantee anything about power quality.

 - Op-Amps are SOT-23-5 (single) or SOIC-8 (double). I use OPA165x for
   these, but I think they are mostly all pin-compatible. You'd need to
   verify that if you do anything else.

 - Various voltage rail things that range from easy (LT1054 in SOIC-8)
   to painful (LM27762 in WSON-12). There's a reason I did multiple
   different versions of the base boards: they are basically variations
   based on soldering ability.

   I'm sure you could just have JLCPCB or your favorite PCB manufacturer
   just populate the boards too, but why would you? There are much better
   guitar pedals you can just buy for cheap. This is to play around with
   making hardware.

 - Hammond 1590A enclosure. You're on your own when it comes to
   drilling. I'll try to do a Tayda drill pattern one day.

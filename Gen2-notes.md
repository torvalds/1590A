Lessons learnt from Gen1:

### Power rails

I started out with various base boards that generally generated negative
power rails, because it felt like the RightThing(tm).

But it ended up being a huge distraction, and trying to support up to
+-15V was just painful.  A 30V voltage range ends up just limiting your
choice of components, ranging from simple capacitors to op-amps.

It also means that simple things like LED choice are painful: the LED
was driven by the effects board, but the effects board needed to deal
with range of voltages, so now picking the right current limiting
resistor isn't trivial either.

So having many choices was good for trial-and-error, but it needed to
go.

And I still don't love the odd 9V center-negative guitar pedal power
supply.  But while I'd prefer to just use USB-C everywhere, if anybody
else were to ever use the pedal, it's not a realistic single choice, and
having separate drill patterns for the enclosure is just not worth it.

End result: DC jack it is.  Even if it wants that polarity protection
etc due to the lack of standards in this area.

And when you combine the "let's limit the voltage range" with "I have 9V
coming in on the DC jack", that basically forces your hand.  9V it is.

And while the LM27762 ends up giving you basically that same 9V voltage
range (just +-4.5V dual rails instead of a single 9V rail) and thus
works fine from a power rail standpoint, I ended up never liking the
pain of soldering it, and it potentially had current limit issues.

It also needed a second LDO just to take the 9V down to the 5V range,
which made it a very annoying option with the DC jack even if it was
convenient with the USB-C connector.

End result: a plain single-supply 9V rail with a reference voltage at
4.5V ends up being the sane thing after all.  To-do: change the op-amp
choice to be something that is rail-to-rail in that range, rather than
the 165x that was picked at least partly due to the previous wider
voltage range.

So what started out as my least favorite base board ened up being the
one I picked in the end.


### Vertical fit

Gen1 *did* fit in the 1590A enclosure, but it was really too tight to be
a reasonable fit.

The gen1 board was designed to fit on top of the "lip" of the bottom
lid, because the SMD components were populated on the underside of the
board.  And that underside ends up having protusions due to the
through-hole components anyway, so putting the surface mount components
there was the right choice.

But the bottom lid lip is just under 4mm high, and we only need just
under 2mm of vertical space for the tallest components.  So making the
board slightly narrower so that it can sit completely inside the lid
gives us extra vertical space at the cost of really having to use
potting compound on the bottom (which was really the plan anyway, but
now it goes from 'plan' to 'pretty much a requirement').

Solution: the base board needs to be 30mm wide, not 32mm.  So now the
top of the base board will be level with the lip of the lid, instead of
resting on it.  So we effectively gain a board height (1.6mm) of
vertical space.

That should turn "it's too tight to really be reasonable" into "that
packs in quite reasonably".

### External fit

The DC jack needs to protrude about 0.8mm more to be flush with the
exterior.

On the other hand, the audio jacks need to be moved in by 2.5mm to
protrude less.  Right now they protrude 5mm from the side of the
enclosure.  They do need to have room for the washer and nut, but 5mm is
too much.

Note that moving the audio jacks inwards also means that they can no
longer slot together, so they need to be moved apart from each other on
the board.  That in turn means that the drill-pattern will change, and
I'll have to order new enclosures.

Oh well.  That was inevitable anyway due to the power decision and with
the side jacks moving due to the board moving down by the thickness of
the board.

And it helps with the next issue...

### Board space

When I started doing Gen1, I thought I had tons of space because of how
small the surface-mount components were compared to the through-hole
components.  And yes, even though I use fairly large components, that
was mostly true.

But the remaining through-hole components take a *lot* of room.  On the
base boards, it's not too bad, because the base board was bigger to
begin with, and didn't do all that much anyway.

On the effects boards, the pots in particular end up taking up a lot of
space.  The board is much smaller anyway due to the stomp switch, and
four pots is a reasonable expectation but takes up essentially half the
space of that small board.

Making the base board narrower due to the vertical fit happily doesn't
make things worse, because the effects board can remain 32mm.  However,
it does affect the board-to-board connectors.

What also affects the board-to-board connectors even more is the audio
jack movement, though.  Moving the audio jacks inwards means that the
placement of the board connectors behind the audio jacks is no longer
tenable even with just a single row of pins.

The solution:

 - Move the stomp switch down by 2mm.

   We have to change the enclosure drill pattern anyway, and that
   automatically means that the effect board can expand by the same 2mm.

 - Move the LED to the side of the stomp switch. It took up prime real
   estate on the effect board.

 - Move the board-to-board connectors, and make them a single row. The
   double row was for mechanical stability and future expansion, so that
   part is not an issue.

   The audio signal one (IN/REFGND/OUT) can be next to the stomp switch
   and share the row of holes with the LED. The LED is effectively
   driven by the base board anyway, since now the effect board doesn't
   do any utility tricks that might change the semantics of the LED.

   The power connection (now just GND, GNDREF and +9V) goes to the top
   of the board.

   Add a position for a sub-mini switch on the other side, since it fits
   and takes up no otherwise realistically useful board space.

 - Move some more functionality to the base board.

   This adds some minimal RF filtering to the base board, because the
   fuzz pedal picked up radio stations. I'm also doing output buffering,
   although what I really wanted to do was the headphone amplifier part.

   However, the single power rail makes that annoying, since the signal
   has to be biased back to the global ground at output. So I'm still
   considering options. A bigger output capacitor may be the answer.

// Simple enclosure for the USB-C power board
//
// Board dimensions:
//    80 x 30mm with 5mm corner radius
//
// DC jacks centered on front panel at X -30, -10, +10, and +30mm
// USB C receptable on back panel at +20mm
//
// board: 1.6mm thick with 2mm high components (3.4mm if choke on back)
// so let's say 5mm undercut
//
// Top of board: DC jacks 11mm high, but caps up to 12.5mm, go for
// 15mm space above: 20mm total cavity height.

$fn = 100;

// Corner locations
corners = [[-40,-15],[-40,15],[40,-15],[40,15]];

// 3mm hole board locations
holes = [[-35,+10], [+35,+10], [-20,-7.5], [+20,-7.5]];

module board_2d()
{
    minkowski() {
        square([80,30], center=true);
        circle(r=1);
    }
}

// 2mm walls around the board cutout
module exterior()
{
    minkowski() {
        linear_extrude(height=20)
            board_2d();
        sphere(r=2);
    }
}

// 9mm wide, 11mm high with 0.5mm for slop
// Translate up 10.75mm: 5mm undercut + 5.75mm for half the height
module dc_jacks()
{
    for (x = [-30:20:30])
        translate([x,-15,10.75])
            cube([9.5,15,11.5], center=true);
}

// USB-C cable cutout:
//    Plug end dimensions:   8.35mm x 2.56mm
//    Cable end dimensions: 12.35mm x 6.5mm max
// So basically cable is 2mm on each side of the plug.
//
// Centered at 5mm undercut + 1.6mm up from the board
module usbc_jack()
{
    translate([20,10,6.6])
        minkowski() {
            cube([8.35,20,2.56], center=true);
            sphere(d=3.8);
        }
}

// The capacitors in between the DC jacks can be high
// and might need a cutout because of how we support
// the DC jacks above.
module capacitors()
{
    translate([0,-4,5])
        cylinder(h=12.5,d=8);
    translate([0,-11,5])
        cylinder(h=12.5,d=8);
}

module mounting_pin(loc)
{
    translate(loc) {
        cylinder(h=3.4, d1=12, d2=8);
        translate([0,0,5])
            cylinder(h=15, d=8);
    }
}

module screw()
{
    // 0: 3 5: 2.9 10: 2.8 15:2.7
    cylinder(h=15, d1=3, d2=2.7);
    translate([0,0,-2])
        cylinder(h=7, d1=8, d2=3);
}

module corner_clips()
{
    translate([0,0,5])
    for (loc = corners)
        translate(loc)
            cylinder(h=15,r=3);
    translate([0,0,2])
        linear_extrude(height=3)
            intersection() {
                for (loc = corners)
                    translate(loc)
                        circle(2);
                board_2d();
            }
}

module cutout()
{
    // Extrude the board cutout, but not above the DC jacks.
    // We'll separately cut out the DC jacks to keep them
    // captured for easy soldering inserted in the box.
    // Also, we don't cut out the mounting pins around holes.
    difference() {
        linear_extrude(height=20)
            board_2d();
        translate([0,-15,20])
            cube([80,15,10], center=true);
	for (loc = holes)
            mounting_pin(loc);
    }
    translate([0,0,3.4])
        linear_extrude(height=1.6)
            board_2d();
    dc_jacks();
    usbc_jack();
    capacitors();

    // Add screw holes
    for (pos = holes)
        translate(pos)
            screw();
}

module box()
{
    difference() {
        exterior();
        cutout();
    }
}

// Now do it twice for the upper and lower parts, cut off at 5mm
// The box itself
difference() {
    box();
    cube([100,100,10],center=true);
}

corner_clips();

// Lid
translate([0, -45, 0]) {
    difference() {
        box();
        translate([0,0,35])
            cube([100,100,60],center=true);
    }
}

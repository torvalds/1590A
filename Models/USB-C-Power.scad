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

// 3mm hole board locations
holes = [[-35,+10], [+35,+10], [-20,-7.5], [+20,-7.5]];

module board_2d()
{
    minkowski() {
        square([80,30], center=true);
        circle(r=1);
    }
}

module lip_2d()
{
    difference() {
        minkowski() {
            square([81,31], center=true);
            circle(r=1);
        }
        board_2d();
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
            sphere(r=2);
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
        cylinder(h=3.4, d=5);
        translate([0,0,5])
            cylinder(h=15, d=5);
    }
}

module lip()
{
    translate([0,0,4])
        linear_extrude(height=4)
            lip_2d();
}

module cutout()
{
    // Extrude the board cutout, but not above the DC jacks.
    // We'll separately cut out the DC jacks to keep them
    // captured for easy soldering inserted in the box
    difference() {
        linear_extrude(height=20)
            board_2d();
        translate([0,-15,20])
            cube([80,15,10], center=true);
    }
    dc_jacks();
    usbc_jack();
    capacitors();
    lip();
}

module box()
{
    difference() {
        exterior();
        cutout();
    }
    for (pos = holes)
        mounting_pin(pos);
}

// Now do it twice for the upper and lower parts, cut off at 5mm
// The box itself
difference() {
    box();
    cube([100,100,10],center=true);
}

// Add the lip that was removed
difference() {
    lip();
    dc_jacks();
    usbc_jack();
}

// Mounting pin through hole
for (pos = holes)
    translate(pos)
        translate([0,0,3.4])
            cylinder(h=5, d=2.5);


// Lid
translate([0, -45, 0]) {
    difference() {
        box();
        translate([0,0,35])
            cube([100,100,60],center=true);
    }
}

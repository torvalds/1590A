// Hammond 1590A enclosure
// Three-pot version with stomp switch and LED
$fn = 100;

// Knob definitions
no_knob = [];
one_knob = [[0,24]];
three_knob = [[-8, 32], [8, 32], [0,16]];
four_knob = [[-8, 32], [8, 32], [-8,16], [8,16]];

// Jack definitions
normal = [[0,-18], [-40,-4]];
splitter = [[0,-18], [-40,-4], [-40,10]];
joiner = [[0,-18], [-40,-4], [0,10]];

// Switch definitions
no_switch = [];
one_switch = [[12,-34]];

// This sets up the configuration
knob_positions = one_knob;
jack_positions = splitter;
switch_positions = no_switch;

screw_positions = [[-14.25,-41.3], [-14.25,41.3], [14.25,-41.3], [14.25,41.3]];

// Do the nice rounded corners and a slight
// taper on the exterior. We'll cut the bottom
// off as part of the cutouts, so don't worry
// about the part going under the XY plane
//
// Bottom: 40.0mm wide, 94.5mm tall
// Top:    38.5mm wide, 92.6mm tall
// 28.5mm high
module exterior()
{
    minkowski() {
        linear_extrude(height = 23.5, scale=[0.9625,0.98]) {
            square([30, 84.5], center=true);
        }
        sphere(r=5);
    }
}

// Same square as the exterior, but the minkowski circle
// is 3mm vs the 5mm sphere.  So basically 2mm walls
module bottom()
{
    minkowski() {
        square([30, 84.5], center=true);
        circle(r=3);
    }
}

// Screw pillar base
module screw_pillar_2d()
{
    for (i = [-1:2:1]) {
        for (j = [-1:2:1]) {
            translate([i*14.25, j*41.3]) {
                hull() {
                    circle(d=5);
                    translate([i*2.5, 0])
                        square(5, center=true);
                    translate([0, j*2.5])
                        square(5, center=true);
                }
            }
        }
    }
}

module screw_holes()
{
    for (pos = screw_positions)
        translate(pos) {
            cylinder(h=14, d=2.9);
            cylinder(h=5, r1=4, r2=1.5);
        }
}

// The bottom extruded up, but with the
// screw pillars removed
module interior_space()
{
    difference() {
        linear_extrude(height=26.5, scale=0.98)
            bottom();
        linear_extrude(height=26.5)
            screw_pillar_2d();
    }
}

// This is the interior that gets removed
module interior()
{
    linear_extrude(height=4)
        bottom();

    interior_space();
    screw_holes();
}

module knob_cutout(pos)
{
    translate(pos)
        cylinder(h=40, d=7.7);
}

module knobs()
{
    for (pos = knob_positions)
        knob_cutout(pos);
}

module jack_cutout(pos)
{
    translate(pos) {
        rotate(90, [0,1,0]) {
            translate([-10,0])
                cylinder(h=40, d=9);
            translate([0,0,20])
                cube([20,9,40], center=true);
        }
    }
}

module audio_jacks()
{
    for (pos = jack_positions)
        jack_cutout(pos);
}

// 9.5mm wide, 14mm high
module dc_jack()
{
    translate([0,45])
        cube([9.5,30,28], center=true);
}

// Stomp switch and hole for LED
module stomp_switch()
{
    translate([0,-34])
        cylinder(h=40, d=13);
    translate([-12,-34])
        cylinder(h=40, d=6);
    for (pos = switch_positions)
        translate(pos)
            cylinder(h=40, d=6);
}

module cut()
{
    interior();
    knobs();
    audio_jacks();
    dc_jack();
    stomp_switch();

    translate([0,0,-5])
        cube([100,100,10], center=true);
}


// Main body
difference() {
    exterior();
    cut();
}

// The lid is the rounded exterior, we're just cutting off
// the top instead of the bottom and then working on that.
module lid_cut()
{
    translate([0,0,20])
        cube([50,100,40], center=true);
    translate([0,0,-2.5])
        linear_extrude(height=3)
            bottom();
}

module lid()
{
    difference() {
        exterior();
        lid_cut();
    }

    // Add corner screw pillars
    // Reinforce around the screw heads
    translate([0,0,-2.5]) {
        linear_extrude(height=5) {
            intersection() {
                screw_pillar_2d();
                bottom();
            }
        }

        for (pos = screw_positions)
            translate(pos)
                cylinder(h=5,d1=10,d2=5);
    }
}

translate([60, 0, 5]) {
    difference() {
        lid();
        translate([0,0,-5])
            screw_holes();
    }
}

// Hammond 1590A enclosure
// Three-pot version with stomp switch and LED
// No lid yet
$fn = 100;

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
    for (i = [-1:2:1])
        for (j = [-1:2:1])
            translate([i*14.25, j*41.3, 0]) {
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

module knob_cutout()
{
    cylinder(h=40, d=7.7);
}

module knobs()
{
    translate([-8, 32])
        knob_cutout();
    translate([8, 32])
        knob_cutout();
    translate([0,16])
        knob_cutout();
}

module jack_cutout()
{
    rotate(90, [0,1,0]) {
        translate([-10,0])
            cylinder(h=40, d=9);
        translate([0,0,20])
            cube([20,9,40], center=true);
    }
}


module audio_jacks()
{
    translate([0,-18])
        jack_cutout();
    translate([-40,-4])
        jack_cutout();
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
    #cut();
}

// We already have the shapes for the lid lip
module lid_lip_2d()
{
    difference() {
        bottom();
        screw_pillar_2d();
    }
}

// The lid is the rounded exterior, we're just cutting off
// the top instead of the bottom and then working on that.
module lid()
{
    difference() {
        exterior();
        translate([0,0,20])
        cube([100,100,40], center=true);
    }
    linear_extrude(height=1)
        lid_lip_2d();
}

module lid_cut()
{
    translate([0,0,-2.5]) {
        linear_extrude(height=5)
        scale([0.9,0.95])
            lid_lip_2d();
    }
    translate([0,0,-5])
        screw_holes();
}

translate([60, 0, 5]) {
    difference() {
        lid();
        #lid_cut();
    }
}

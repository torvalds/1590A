// Hammond 1590A enclosure
// Three-pot version with stomp switch and LED
// No lid yet
$fn = 150;

// Do the nice rounded corners and a slight
// taper on the exterior. We'll cut the bottom
// off as part of the cutouts, so don't worry
// about the part going under the XY plane
//
// 28.5mm wide, 92.6mm tall, 27.0mm high
module exterior()
{
    minkowski() {
        linear_extrude(height = 25, scale=0.98) {
            square([36.50, 90.60], center=true);
        }
        sphere(2);
    }
}

module 2d_interior()
{
    difference() {
        square([35, 89.1], center=true);
        for (i = [-1:2:1])
            for (j = [-1:2:1])
                translate([i*14.25, j*41.3]) {
                    circle(5);
                    translate([i*5, 0])
                        square(10, center=true);
                    translate([0, j*5])
                        square(10, center=true);
                }
    }
}

module interior()
{
    linear_extrude(height=25.4, scale=0.98) {
        2d_interior();
    }
}

module knob_cutout()
{
    cylinder(h=40, d=7);
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
            cube([20,8.5,40], center=true);
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


difference() {
    exterior();
    #cut();
}

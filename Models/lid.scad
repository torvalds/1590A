$fn=50;

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
knob_positions = three_knob;
jack_positions = normal;
switch_positions = no_switch;

screw_positions = [[-15,-42.25], [-15,42.25], [15,-42.25], [15,42.25]];

module cutouts()
{
	translate([20,-25])
		square([7,5], true);
	translate([-20,-25])
		square([7,5], true);
	translate([20,39])
		square([7,5], true);
	translate([-20,39])
		square([7,5], true);
}

module exterior()
{
	difference() {
		minkowski() {
		        square([30, 84.5], center=true);
        		circle(r=5);
		};
		cutouts();
	}
}

// Same square as the exterior, but the minkowski circle
// is 3mm vs the 5mm sphere.  So basically 2mm walls
module interior()
{
	minkowski() {
		square([30, 84.5], center=true);
		circle(r=3);
	}
}

module bottom()
{
	difference() {
		linear_extrude(height=6)
			exterior();
		translate([0,0,2])
			linear_extrude(height=5)
				interior();
	}
	translate([-10,20])
		cylinder(h=3.8, r=2);
	translate([10,20])
		cylinder(h=3.8, r=2);
	// Walls
	translate([18,20])
		linear_extrude(height=11.5)
			square([4,20],true);
	translate([-18,20])
		linear_extrude(height=11.5)
			square([4,20],true);
	translate([18,-33])
		linear_extrude(height=11.5)
			square([4,10],true);
	translate([-18,-33])
		linear_extrude(height=11.5)
			square([4,10],true);		
	translate([0,-(84.5/2 + 5 - 2)])
		linear_extrude(height=11.5)
			square([20,4],true);
}

module holes()
{
	translate([0,-34])
		cube([21,18,10], true);
	translate([12,-34,-5])
		cylinder(h=40, d=10);
	for (pos = knob_positions) {
		translate(pos)
			translate([0,-2,0])
				cube([11,13,10], true);
	}
}

module top()
{
	difference() {
		bottom();
		holes();
	}
	translate([-10,-20])
		cylinder(h=3.8, r=2);
	translate([10,-20])
		cylinder(h=3.8, r=2);
}

bottom();
translate([-10,2])
	cylinder(h=3.8, r=2);
translate([10,2])
	cylinder(h=3.8, r=2);
translate([45,0])
	top();
for (pos = screw_positions)
	translate(pos)
		cylinder(h=21, d=6);

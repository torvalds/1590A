$fn=50;

screw_positions = [[-15,-42], [-15,42], [15,-42], [15,42]];

module cutouts()
{
	translate([20,-25])
		square(5, true);
	translate([-20,-25])
		square(5, true);
	translate([20,30])
		square(5, true);
	translate([-20,30])
		square(5, true);
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
	translate([-10,10])
		cylinder(h=4.4, r=2);
	translate([10,10])
		cylinder(h=4.4, r=2);
}

module holes()
{
	translate([0,-34])
		cube([21,18,10], true);
	translate([12,-34,-5])
		cylinder(h=40, d=10);
}

module top()
{
	difference() {
		bottom();
		holes();
	}
	translate([-10,-20])
		cylinder(h=4.4, r=2);
	translate([10,-20])
		cylinder(h=4.4, r=2);
}

bottom();
translate([-10,20])
	cylinder(h=4.4, r=2);
translate([10,20])
	cylinder(h=4.4, r=2);
translate([45,0])
	top();
for (pos = screw_positions)
	translate(pos)
		cylinder(h=6, d=7);

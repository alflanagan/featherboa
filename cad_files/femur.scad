// alternate femur

include <BOSL2/std.scad>
include <BOSL2/gears.scad>
include <sg92r_gear.scad>

// height of the beam, in mm
height = 4;
// width of the beam
ywidth = 12;
// distance between center of the holes
xcenter_to_center = 40;
// depth of hole for servo gear. must be < ywidth
gear_hole_depth = 3;

end_radius = ywidth / 2;


module
gear2()
{
    scale([0.5, 0.5, 1]) {
        difference () {
            cylinder(h=height, r=8,  $fn=40);
            union() {
                // screw hole
                translate([0, 0, -1])
                    cylinder(h=height+0.2, r=1.1,  $fn=20);
                // gear_hole_depth / 2 puts gear at 0 on z plane
                translate([0, 0, gear_hole_depth / 2 + height - gear_hole_depth])
                    spur_gear(mod=0.48, teeth=20, thickness=gear_hole_depth +0.1);
            }
        }
    }
}

module
body(thickness, center_to_center, width)
{
    difference()
    {
        translate([ 0, 0, thickness / 2 ]) union()
        {
            difference()
            {
                // base rectangle
                cube([ center_to_center, width, thickness ], center = true);
                // arc cut out of side
                translate([ 0, -31, -.1 ])
                    cylinder(r = 30, h = thickness + .3, center = true, $fn=150);
            }
            // rounded ends
            for (x = [ +center_to_center / 2, -center_to_center / 2 ])
                translate([ x, 0, 0 ])
                    cylinder(r = width / 2, h = thickness, center = true, $fn=60);
        }
    }
}

module
femur(thickness = 4, center_to_center = 40, width = 12)
{
    union() {
        difference() {
            translate([ center_to_center / 2, 0, 0 ]) difference()
            {
                body(thickness, center_to_center, width);
            }
            cylinder(thickness + 0.1, 4, 4,  $fn=60);
            translate([center_to_center, 0, 0])
               cylinder(thickness + 0.1, 4, 4, $fn=60);
        }
        gear2();
        translate([center_to_center, 0, 0])
          gear2();
    }
}

union() {
  translate([0, 10, 0])
    gear();

  femur();
}
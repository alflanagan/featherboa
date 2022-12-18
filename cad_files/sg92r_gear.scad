include <BOSL2/std.scad>
include <BOSL2/gears.scad>

module
gear(height=4, gear_hole_depth=3)
{
  difference () {
    cylinder(h=height, r=4,  $fn=40);
    union() {
      // screw hole
      translate([0, 0, -1])
        cylinder(h=height+0.2, r=.8,  $fn=20);
      // gear_hole_depth / 2 puts gear at 0 on z plane
      translate([0, 0, gear_hole_depth / 2 + height - gear_hole_depth])
        spur_gear(mod=0.24, teeth=20, thickness=gear_hole_depth +0.1);
    }
  }
}

// gear();
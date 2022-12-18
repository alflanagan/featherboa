// 3dof quad
//
// coxa
include <sg92r_gear.scad>

module
coxa(servo_height = 27, servo_clearance = 7)
{
  arm_thick = 4;
  servo_width = 12;
  flange_length = 3;
  base_thick = 4;
  root_radius = 4;

  fork_width = servo_width + flange_length + servo_clearance + base_thick;
  fork_height = arm_thick * 2 + servo_height;

  servo_cog_offset = 6;

  translate([ fork_width / 2 - servo_cog_offset, 0, servo_width / 2 ]) union()
  {
    // main motor mount (attaches to hip)
    difference()
    {
      cube([ fork_width, fork_height, 12 ], center = true);
      // opening for motor (outer)
      translate([ -root_radius / 2 - base_thick / 2 - 1, 0, 0 ]) cube(
        [
          1 + servo_width + flange_length + servo_clearance - root_radius,
          servo_height,
          13
        ],
        center = true);
      // opening for motor (inner)
      translate([ -base_thick / 2, 0, 0 ]) cube(
        [
          servo_width + flange_length + servo_clearance,
          servo_height - 2 * root_radius,
          13
        ],
        center = true);
      // rounded interior corners
      translate([ 5, -9.5, 0 ])
        cylinder(r = root_radius, h = 13, center = true);
      translate([ 5, 9.5, 0 ])
        cylinder(r = root_radius, h = 13, center = true);
    }

    // second motor mount
    translate([ fork_width / 2 + 15 / 2, 0, -3 ])
    {
      difference()
      {
        cube([ 15, fork_height, 6 ], center = true);
        // opening for motor
        translate([ -1, 0, 0 ]) cube([ 12.5, 23.5, 7 ], center = true);
        // screw holes
        for (i = [ -1, 1 ]) {
          translate([ -1, i * 30 / 2, 0 ])
            cylinder(r = 0.75, h = 20, center = true);
        }
      }
    }
  }
}

difference() {
  union() {
    translate([0,15,0])
      difference() {
        coxa();
        translate([0, -12.5, 6])
          rotate([90, 0, 0])
            cylinder(h = 5, r = 4);
      }
    translate([0, -2.5, 6])
      rotate([-90, 0, 0])
        gear(height=4.05);
  }
//  translate([-10, 3, -1])
//    cube(55);
//  translate([20, -3, -1])
//    cube(30);
}
/* [Utility] */
// overlap to indicate joined objects
overlap = 0.01;

/* [Servo Board] */
//https://learn.adafruit.com/adafruit-feather/feather-specification?view=all#feather-and-wing-sizes-2861831
// servo board w/power and right-angle headers
featherwing_width = 22.8;
// length of servo controller board
featherwing_length = 50.8;
hole_to_hole_narrow = 17.7;
hole_to_hole_wide = 45.7;

/* [Holes] */
cylinder_width = 3.8; // minumum, can be larger
cylinder_height = 3.75; // length of screw I have handy
// size of hole to accept M2*5 screw
m_2_5_width = 2.2;

/* [cube] */
cube_z = 1.0;


union() {
    translate([5, 5, cube_z - overlap]) 
      difference() {
        cylinder(r = cylinder_width / 2, h = cylinder_height, $fn=60);
        cylinder(r = m_2_5_width / 2, h = cylinder_height + overlap, $fn=40);  
      }
    cube([10, 10, cube_z]);
}
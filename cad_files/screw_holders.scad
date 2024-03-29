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

/* [Boost Board] */
/* [Power Boost Holder] */
boost_length = 20;
// both connectors are same width, and centered
boost_notch_width = 8.45;
boost_notch_offset = 5.66;

boost_width = boost_notch_offset * 2 + boost_notch_width;


/* [Holes] */
cylinder_width = 3.8; // minumum, can be larger
cylinder_height = 3.75; // length of screw I have handy
// size of hole to accept M2*5 screw
m_2_5_width = 2.2;

/* [cube] */
cube_z = 1.0;

module screw_hole () {
  union() {
    difference() {
      cylinder(r = cylinder_width / 2, h = cylinder_height, $fn=60);
      cylinder(r = m_2_5_width / 2, h = cylinder_height + overlap, $fn=40);  
    }
  }
}


module four_holes (z_offset) {
  x_offset = (featherwing_length - hole_to_hole_wide) / 2;
  y_offset = (featherwing_width - hole_to_hole_narrow) / 2;
    
  translate([x_offset, y_offset, z_offset])
    screw_hole();
  translate([x_offset + hole_to_hole_wide, y_offset, z_offset])
    screw_hole();
  translate([x_offset, y_offset + hole_to_hole_narrow, z_offset])
    screw_hole();
  translate([x_offset + hole_to_hole_wide, y_offset + hole_to_hole_narrow,  z_offset])
    screw_hole();
}

module boost_holes (z_offset) {
    hole_to_hole = 15;
  x_offset = (boost_length - hole_to_hole) / 2;
  y_offset = (boost_width - hole_to_hole) / 2;

  translate([x_offset, y_offset, z_offset])
    screw_hole();
  translate([x_offset + hole_to_hole, y_offset, z_offset])
    screw_hole();
  translate([x_offset, y_offset + hole_to_hole, z_offset])
    screw_hole();
  translate([x_offset + hole_to_hole, y_offset + hole_to_hole,  z_offset])
    screw_hole();
}

//union() {
//  cube([featherwing_length, featherwing_width, cube_z]);
//  four_holes(cube_z);
//}

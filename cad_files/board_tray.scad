// tray for attaching feather boards to body assembly
// 1 unit = 1 mm

/* [Utility] */
// overlap to indicate joined objects
overlap = 0.01;

/* [Center Post] */
// center mounting hole in the backbone
center_hole_radius = 3;
// height of robot "backbone"
backbone_height = 8;

/* [Servo Board] */
// servo board w/power and right-angle headers
featherwing_width = 22.9;
// length of servo controller board
featherwing_length = 52.8;
// height of board + power post
featherwing_height = 10;

// mc board w/ through-hole leads
circuit_board_thickness = 2.6;

/* [Thickness] */
// sidewall width
sidewall_width = 0.6;
// bottom thickness -- biggest effect on mass
tray_bottom_thickness = 0.6;

/* [Power Post Cutouts] */
// size of cutout for mc board power
power_post_width = 8.2;
// location of power cutout
power_post_from_end = 8;

/* [Power Switch Box] */
// width of power switch (y-dimension)
switch_width = 12.58;
// length of power switch (x-dimension)
switch_length = 4.19;
// height to hold switch but not block
switch_height = 5.6;
switch_wires_length = 2;
switch_wires_width = 6;
// thickness of switch box walls
switch_box_thickness = 0.6;


/* General Approach -----------------------------------------------------*/
/*
 * After a lot of experimentation, I've settled on the following best practice.
 * Each part is rendered by a module at 0, 0, 0 without translation (except
 * for overlap) or centering. <del>A separate module calculates the translation to
 * the final location.</del>
 * The final translation is done by the parent module / object.
 */

/* Parts  ---------------------------------------------------------------*/

/*
 * Draws a flat rectangle from 0,0,0, sized to hold two featherwing boards
 * parallel on the longer side. Includes space for sidewalls, etc.
 */
module
tray_bottom()
{
  cube([
    featherwing_width * 2 + sidewall_width * 3,
    featherwing_length + sidewall_width * 2,
    tray_bottom_thickness
  ]);
}

/*
 * Draws a vertical cylinder of a size to extend from the base through
 * the hole in the backbone part.
 */
module
center_post()
{
  cylinder($fn = 64,
           r = center_hole_radius,
           h = backbone_height / 2);
}

/*
 * Draws a flat rectangle the length of a feather board and height
 * of featherwing_height. Seperates and stabilizes the board position.
 */
module
sidewall()
{
  cube([
    sidewall_width + overlap,
    featherwing_length + 2 * sidewall_width,
    featherwing_height
  ]);
}


/*
 * Cutout in end_lip to allow access for USB-C connector or motor controller
 * headers (which are roughly the same width)
 *
 * not yet implemented
 */
module
usb_notch() {
  cube([1, 1, 1]);
}

/*
 * Cutout in sidewall to provide access to power supplies (battery connector for
 * micro, 5 volts for motor controllers).
 */
module
power_notch()
{
  translate([-overlap, -overlap, -overlap])
    cube([
      sidewall_width + overlap * 3, // 2 just not enough, somehow
      power_post_width,
      featherwing_height + overlap * 2
    ]);
}


/*
 * A low wall that spans the two board trays.
 */
module
end_lip()
{
  cube(
    [
      featherwing_width * 2 + sidewall_width * 3,
      1,
      tray_bottom_thickness + circuit_board_thickness
    ]
  );
}

/*
 * A small box to contain a switch I happened to have on hand.
 * You'll need to at least set switch_length and switch_width to match
 * your switch, and possibly modify the cutout for the leads.
 */
module
switch_holder()
{
  difference()
  {
    union()
    {
      cube([ switch_length, switch_width, switch_box_thickness ]);
      translate([ 0, -switch_box_thickness + overlap, 0 ])
        cube([ switch_length, switch_box_thickness, switch_height ]);
      translate([ 0, switch_width - overlap, 0 ])
        cube([ switch_length, switch_box_thickness, switch_height ]);
      translate([ -switch_box_thickness + overlap, -switch_box_thickness, 0 ])
        cube([
               switch_box_thickness,
               switch_width + switch_box_thickness * 2,
               switch_height
        ]);
      translate([ switch_length - overlap, -switch_box_thickness, 0 ])
        cube([
          switch_box_thickness,
          switch_width + switch_box_thickness * 2,
          switch_height
        ]);
    } // union
    translate([
      (switch_length - switch_wires_length) / 2,
      (switch_width - switch_wires_width) / 2,
      -switch_box_thickness / 2
    ])
      cube([
        switch_wires_length,
        switch_wires_width,
        switch_box_thickness * 2
      ]);
  }; // difference
}



/* Assembly ---------------------------------------------------------------*/

module
board_tray()
{
    difference()
    {
        union()
        {
            tray_bottom();
            sidewall();
            translate([featherwing_width + sidewall_width, 0, 0])
                sidewall();
            translate([(featherwing_width + sidewall_width) * 2, 0, 0])
                sidewall();
            end_lip();
            // 0.2 either corrects for rounding error, or I missed something
            translate([0, featherwing_length + 0.2, 0])
              end_lip();
            translate([-switch_length, (featherwing_length - switch_width) / 2, 0])
              switch_holder();
          translate([
                     featherwing_width + 2 * sidewall_width,
                     featherwing_length / 2,
                     -(backbone_height / 2) + overlap
                    ])
            center_post();
        }
        // translate([
        //   featherwing_width + (sidewall_width * 2) - overlap,
        //   featherwing_length / 2 - power_post_width / 2 - power_post_from_end,
        //   featherwing_height / 2 + tray_bottom_thickness / 2
        // ])
        power_notch();
    }
}

board_tray();

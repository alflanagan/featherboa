include <screw_holders.scad>;

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
//https://learn.adafruit.com/adafruit-feather/feather-specification?view=all#feather-and-wing-sizes-2861831
// servo board w/power and right-angle headers
featherwing_width = 22.8;
// length of servo controller board
featherwing_length = 50.8;
// height of board + power post
featherwing_height = 10;
hole_to_hole_narrow = 17.7;
hole_to_hole_wide = 45.7;

// mc board (includes screw holes)
circuit_board_thickness = 6;

/* [Thickness] */
// sidewall width
sidewall_width = 0.6;
// bottom thickness -- biggest effect on mass
tray_bottom_thickness = 2;
// tray_bottom_thickness = 0.8;

// z-offset of center post and matching hole
center_post_offset = -backbone_height / 2 - tray_bottom_thickness - overlap;

/* [Power Switch Box] */
// width of power switch
switch_width = 12.58;
// length of power switch
switch_length = 4.19;
// height to hold switch but not block
switch_height = 5.6;
switch_wires_length = 2;
switch_wires_width = 6;
// thickness of switch box walls
switch_box_thickness = 0.6;

/* [Board i2c Connector] */
// distance from edge
board_i2c_to_edge = 5.1;
// width of connector
board_i2c_width = 6.35;

/* [Board Power Connector] */
board_pwr_width = 8.0;
board_pwr_to_edge = 6.8;

/* [USB Connector] */
// actual connector not this wide, but board tab is
// distance from edge to start of tab
usb_to_edge = 6.5;
// width of tab
usb_width = 10.65;

/* [Motor Controller] */
// size of cutout for mc board power
power_post_width = 7.5;
// location of power cutout
power_post_from_end = 7;
// motor connections
side_header_width = 10.5;
side_header_offset = 6.1;

/* [Power Boost Holder] */
boost_length = 21;
// both connectors are same width, and centered
boost_notch_width = 8.45;
boost_notch_offset = 6.2;

boost_width = boost_notch_offset * 2 + boost_notch_width;

/* General Approach -----------------------------------------------------*/
/*
 * After a lot of experimentation, I've settled on the following best practice.
 * Each part is rendered by a module at 0, 0, 0 without translation (except
 * for overlap) or centering. A separate module calculates the translation to 
 * the final location.
 */
 
/* Parts  ---------------------------------------------------------------*/

/*
 * Draws a flat rectangle from 0,0,0, sized to hold two featherwing boards
 * parallel on the longer side. Includes space for sidewalls, etc.
 */
module
tray_bottom()
{
    cube(
        [
            featherwing_width * 2 + sidewall_width * 3,
            featherwing_length + sidewall_width * 2,
            tray_bottom_thickness
        ]
    );
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
             h = tray_bottom_thickness + backbone_height / 2);
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

module
power_notch()
{
    cube([
            sidewall_width + overlap * 2,
            power_post_width,
            featherwing_height
        ]);
}

module
end_lip(xmul)
{
        cube([
                xmul * (featherwing_width * 2 + sidewall_width * 3),
                sidewall_width,
                tray_bottom_thickness +
                circuit_board_thickness
            ]);
}

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
            translate(
                [ -switch_box_thickness + overlap, -switch_box_thickness, 0 ])
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
        }
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
    };
}


module
boost_holder()
{
    end_height = tray_bottom_thickness + circuit_board_thickness;
    wire_gap = 2; // small space for routing wires to 5V input
    difference()
    {
        union()
        {
            cube([ boost_length, boost_width, tray_bottom_thickness ]);
            translate([ 0, -sidewall_width + overlap, 0 ])
                cube([ boost_length, sidewall_width, end_height ]);
            translate([ wire_gap, boost_width - overlap, 0 ])
                cube([ boost_length - wire_gap, sidewall_width, end_height ]);
            translate(
                [ boost_length - sidewall_width + overlap, -sidewall_width, 0 ])
                cube([
                    sidewall_width,
                    boost_width + sidewall_width * 2,
                    end_height
                ]);
            boost_holes(tray_bottom_thickness - overlap);
        }
        translate([boost_notch_offset + sidewall_width, -sidewall_width - overlap, tray_bottom_thickness])
            cube([boost_notch_width, sidewall_width + overlap * 2, featherwing_height]);
        translate([boost_notch_offset + sidewall_width, boost_width - overlap, tray_bottom_thickness])
            cube([boost_notch_width, sidewall_width + overlap * 2, featherwing_height]);
    }
}

module
board_i2c()
{
    cube([board_i2c_width, sidewall_width + 2 * overlap, featherwing_height]);
}

module
usb_connector()
{
    cube([usb_width, sidewall_width + 2 * overlap, featherwing_height]);
}

module
motor_connections()
{
    cube([side_header_width, sidewall_width + 2 * overlap, featherwing_height]);
}

module
board_power()
{
    cube([sidewall_width + 2 * overlap,
          board_pwr_width,
          featherwing_height]);
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
            end_lip(1);
            translate([0, featherwing_length + sidewall_width, 0])
                end_lip(1);
            translate([-switch_length - sidewall_width + overlap, 
                       featherwing_length * 2 / 3 - switch_width / 2,
                       0])
                switch_holder();
            translate([featherwing_width + sidewall_width, sidewall_width, 0])
              rotate([0, 0, 90])
                four_holes(tray_bottom_thickness);
            translate([(featherwing_width + sidewall_width) * 2,
                        sidewall_width,
                        0])
              rotate([0, 0, 90])
                four_holes(tray_bottom_thickness);
              translate([featherwing_width * 2 + sidewall_width * 3 - overlap,
                         8,
                         0])
                boost_holder();
                translate([(featherwing_width * 2 + sidewall_width * 3) / 2,
                            featherwing_length / 2,
                            center_post_offset])
                    center_post();
        }
        translate([board_i2c_to_edge, 
                   featherwing_length + sidewall_width - overlap,
                   tray_bottom_thickness])
            board_i2c();
        translate([usb_to_edge,
                   -overlap,
                   tray_bottom_thickness])
            usb_connector();
        translate([featherwing_width * 2 - side_header_width - side_header_offset,
                   featherwing_length + sidewall_width - overlap,
                   tray_bottom_thickness])
            motor_connections();
        translate([featherwing_width * 2 - side_header_width - side_header_offset, 
                   -overlap, 
                   tray_bottom_thickness])
            motor_connections();
        translate([-overlap, board_pwr_to_edge, tray_bottom_thickness])
            board_power();
        translate([featherwing_width * 2 + sidewall_width * 2,
                   featherwing_length - power_post_width - power_post_from_end,
                   tray_bottom_thickness])
            power_notch();
    }
}

board_tray();

// tray for attaching feather boards to body assembly
// 1 unit = 1 mm

// minor overlap to keep openscad clear on whether objects are actually separate
overlap = 0.0001;
$fn = 50;

/* Dimension global constants  ---------------------------------------- */

// center mounting hole in the backbone
center_hole_radius = 3;
backbone_height = 8;

// dimensions of featherwing servo board w/power and right-angle headers
featherwing_width = 22.9;
featherwing_length = 52.8;
// board + power post = 10 mm, walls don't need to be that high
featherwing_height = 8;
circuit_board_thickness = 2.6; // accounts for through-hole leads

sidewall_width = 1;

// height of double-stacked servo and exp32-c2 board
stacked_featherwing_height = 24;

tray_bottom_thickness = 1;

power_post_width = 7.5;
power_post_from_end = 6;

center_post_offset = -backbone_height / 2 - tray_bottom_thickness + overlap;


/* Parts  ---------------------------------------------------------------*/

module
center_post()
{
    translate([ 0, 0, center_post_offset ])
        cylinder(r = center_hole_radius,
                 h = tray_bottom_thickness + backbone_height / 2);
}
center_post();
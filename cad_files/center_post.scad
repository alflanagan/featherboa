// tray for attaching feather boards to body assembly
// 1 unit = 1 mm

// minor overlap to keep openscad clear on whether objects are actually separate
overlap = 0.0001;
$fn = 50;

/* Dimension global constants  ---------------------------------------- */

// center mounting hole in the backbone
center_hole_radius = 2.8; // works out to fit hole w/radius=3 ??
backbone_height = 8;
tray_bottom_thickness = 1;

center_post_offset = -backbone_height / 2 - tray_bottom_thickness + overlap;


/* Parts  ---------------------------------------------------------------*/

module
center_post()
{
    post_height = tray_bottom_thickness + backbone_height / 2;
    translate([ 0, 0, center_post_offset ])
        cylinder(r = center_hole_radius,
                 h = post_height);
    translate([0, 0, center_post_offset / 2])
        cylinder(r = center_hole_radius + 0.2,
                 h = post_height / 2);
}
center_post();

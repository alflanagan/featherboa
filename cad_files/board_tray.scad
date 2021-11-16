// tray for attaching feather boards to body assembly

// 1 unit = 1 mm

// minor overlap to keep openscad clear on whether objects are actually separate
overlap = 0.0001;

/* Dimension global constants  ---------------------------------------- */

// center mounting hole in the backbone
center_hole_radius = 3;
backbone_height = 8;

// dimensions of featherwing servo board w/power and right-angle headers
featherwing_width = 22.9;
featherwing_length = 50.8;
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
tray_bottom()
{
    // note center=true leaves it lying flat on X-Y plane
    // i.e. bottom remains at Z=0
    cube(
        [
            featherwing_width * 2 + sidewall_width * 3,
            featherwing_length,
            tray_bottom_thickness
        ],
        center = true);
}

module
center_post()
{
    translate([ 0, 0, center_post_offset ])
        cylinder(r = center_hole_radius,
                 h = tray_bottom_thickness + backbone_height / 2);
}

module
sidewall(xmul)
{
    translate([
        xmul * (featherwing_width + (sidewall_width * 2) - overlap),
        0,
        featherwing_height / 2 - tray_bottom_thickness / 2
    ])

        cube([ sidewall_width, featherwing_length, featherwing_height ],
             center = true);
}

module
power_notch(xmul, ymul)
{
    translate([
        xmul * (featherwing_width + (sidewall_width * 2) - overlap),
        ymul * (featherwing_length / 2 - power_post_width / 2 -
                power_post_from_end),
        featherwing_height / 2 + tray_bottom_thickness / 2
    ])
        cube(
            [
                sidewall_width * 2,
                power_post_width + overlap,
                featherwing_height +
                overlap
            ],
            center = true);
}

module
end_lip(ymul)
{
    translate([
        0,
        ymul * (featherwing_length / 2),
        circuit_board_thickness -
        tray_bottom_thickness
    ])
        cube(
            [
                featherwing_width * 2 + sidewall_width * 3,
                1,
                tray_bottom_thickness +
                circuit_board_thickness
            ],
            center = true);
}

module
board_tray()
{
    difference()
    {
        union()
        {
            tray_bottom();
            center_post();
            sidewall(1);
            sidewall(0);
            sidewall(-1);
            end_lip(1);
            end_lip(-1);
        }
        power_notch(1, 1);
        power_notch(-1, -1);
    }
}

board_tray();
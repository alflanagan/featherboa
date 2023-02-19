include <screw_holders.scad>;

// 1 unit = 1 mm-ish

// overlap to indicate joined objects
overlap = 0.01;
featherwing_height = 10;
featherwing_width = 22.8;
circuit_board_thickness = 6;
// bottom thickness -- biggest effect on mass
tray_bottom_thickness = 0.6;
sidewall_width = 0.6;

boost_length = 21;
boost_notch_width = 8.45;
boost_notch_offset = 6.2;
boost_width = boost_notch_offset * 2 + boost_notch_width;

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
boost_holder()
{
    end_height = tray_bottom_thickness + circuit_board_thickness;
    wire_gap = 4; // small space for routing wires to 5V input
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
            translate(
                [ 0, -sidewall_width, 0 ])
                cube([
                    sidewall_width,
                    boost_width + sidewall_width * 2,
                    end_height
                ]);
            scale([1, 1, 0.6])
            boost_holes(tray_bottom_thickness - overlap);
        }
        translate([boost_notch_offset + sidewall_width, -sidewall_width - overlap, tray_bottom_thickness])
            cube([boost_notch_width, sidewall_width + overlap * 2, featherwing_height]);
        translate([boost_notch_offset + sidewall_width, boost_width - overlap, tray_bottom_thickness])
            cube([boost_notch_width, sidewall_width + overlap * 2, featherwing_height]);
    }
}

boost_holder();

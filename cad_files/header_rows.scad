featherwing_width = 22.9;
lead_radius = 0.3;
// headers come in many sizes, most common is 2.54mm (0.1 in)
lead_spacing = 2.54;

module lead_hole() {
    cylinder(h=tray_bottom_thickness * 2, r = lead_radius, center=true, $fn=20);
}

module lead_rows() {
    for (i=[0:lead_spacing:lead_spacing*11])
      translate([2, -featherwing_width/2 + i, 0])
        lead_hole();
}

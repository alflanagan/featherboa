tray_bottom_thickness = 1;

// commonly leads are .64mm square or .50mm round

lead_width = 0.8;
// most common spacing is 0.1in (2.54mm)
lead_spacing = 2.54;
height = 5.0;

/* Parts  ---------------------------------------------------------------*/

module lead_cutout(x, y, z) {
    translate([x, y, z])
        // cylinder(h=tray_bottom_thickness+height, r=lead_radius, center=true, $fn=15);
        cube([lead_width, lead_width, height], center=true);
}

difference() {
    cube([16 * lead_spacing, 4, height], center=true);

    for (i=[0:1:15])
        lead_cutout(lead_spacing * (-7.5 + i), 0 , 0);
}

tray_bottom_thickness = 1;

// commonly leads are .64mm square or .50mm round
// add a bit to account for error
lead_radius = 0.4;
// most common spacing is 0.1in (2.54mm)
lead_spacing = 2.54;

/* Parts  ---------------------------------------------------------------*/

module lead_cutout(x, y, z) {
    translate([x, y, z])
        cylinder(h=tray_bottom_thickness+1, r=lead_radius, center=true, $fn=15);
}

difference() {
    cube([16 * lead_spacing, 4, 1], center=true);

    for (i=[0:1:15])
        lead_cutout(lead_spacing * (-7.5 + i), 0 , 0);
}

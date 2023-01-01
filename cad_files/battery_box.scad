/* A box to attach a battery to a robot body */

/* battery is 1200 mAh PKCELL LP503562 */
length = 64;
width = 35;
height = 5;
wall_thickness = 1.5;
overlap = 0.001;
wires_width = 12;
post_height = 4 - overlap; // 1/2 backbone height (backbone.scad)
post_radius = 3; // matches backbone

// upper tabs
tab_width = 10;
tab_length = 10;


module battery_tab(w=tab_width, h=height, t=wall_thickness) {
  linear_extrude(w)
    polygon(points=[
      [0, 0],
      [0 + h, 0],
      [0 + h, t],
      [0 + h / 3, t],
      [0 + h / 3.5, t * 1.5],
      [0, t]
    ]);
}

union() {
  difference () {
    union () {
      /* outer shell has room for battery, plus wall_thickness on each side */
      cube([width + wall_thickness*2, length + wall_thickness*2, height + wall_thickness*2]);

    translate([
        width/2 + wall_thickness,
        length/2 + wall_thickness,
        -post_height + overlap
      ])
        cylinder(h=post_height, r=post_radius, $fn=40);
    }
    /* inner cutout is simple */
    translate([wall_thickness, wall_thickness, wall_thickness])
      cube([width, length, height + wall_thickness*2]);

    /* to center the notch, the x coordinate is found by taking the total width,
       subtracting the wires_width, and dividing by 2
    */
    translate([
      (width + wall_thickness*2 - wires_width) / 2,
      -overlap,
      wall_thickness
    ])
      /* the actual notch is width of wires_width */
      cube([wires_width, wall_thickness + overlap*2, height + wall_thickness + overlap]);

    /* additional openings reduce material & enhance airflow */
    translate([5, 5, -wall_thickness/2])
      cube([width - 10, length / 2 - 10, wall_thickness*2]);

    translate([5, length/2 + 5, -wall_thickness/2])
      cube([width - 10, length / 2 - 10, wall_thickness*2]);

    /* lower the wall on one side to make battery insertion easier */
    translate([wall_thickness + overlap, 0, wall_thickness + height / 2])
      cube([width, 5, height]);
  }

  /* slanted tabs to (hopefully) hold battery */
  translate([0, (length + tab_width) / 2, height * 2])
    rotate([0, 90, -90])
      battery_tab();

  translate([width + wall_thickness * 2, (length - tab_width) / 2, height * 2])
    rotate([0, 90, 90])
      battery_tab();
  }

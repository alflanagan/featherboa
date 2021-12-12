font_size = 5;

color("lightblue")
difference()
{
    translate([ -3, -11, 0 ]) union() {
        cube([ 56, 25, 1 ]);

    }
    
    linear_extrude(height = 5,
                   center = true,
                   convexity = 0,
                   twist = 0,
                   slices = 20,
                   scale = 1.0,
                   $fn = 16) union()
    {
        translate([ 0, 7, 0 ]) text(
            "Experimental", font = "Courier New:style=Bold", size = font_size);
        text("Varmint", font = "Courier New:style=Bold", size = font_size);
        translate([ 0, -7, 0 ]) text(
            "Prototype", font = "Courier New:style=Bold", size = font_size);
    }
}



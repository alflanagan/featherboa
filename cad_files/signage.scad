font_size = 5;

stencil_font = "Boston Traffic:style=Regular";

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
            "Experimental", font = stencil_font, size = font_size);
        text("Varmint", font = stencil_font, size = font_size);
        translate([ 0, -7, 0 ]) text(
            "Prototype", font = stencil_font, size = font_size);
    }
}



// making all of these values variables, and calculating values from
// other values where possible, makes it possible to change values and
// have the board automatically adjust to changes. Try changing 'center_space'
// for instance.

height = 4;
width = 20;
end_radius = 3;
screwhole_offset = 2.5;
screwhole_radius = 1;
servo_motor_length = 23;
servo_motor_width = 12.5;

// width of motor controller headers + a little extra
center_space = 12;
length = servo_motor_length * 2 + screwhole_offset * 5 + center_space;

hip();

echo(length / 2);

module
hip()
{
    difference()
    {
        union()
        {
            // main
            translate([ -length / 2, -width / 2, 0 ])
                cube([ length, width, height ]);

            // outside end edges
            for (i = [
                     [
                         -length / 2 - end_radius - 0.5,
                         -(width / 2 - end_radius),
                         0
                     ],
                     [
                         length / 2 - end_radius + 0.5,
                         -(width / 2 - end_radius),
                         0
                     ]
                 ]) {
                translate(i)
                    cube([ end_radius * 2, width - (end_radius * 2), height ]);
            }

            // rounded corners
            for (i = [
                     [ -length / 2 - 0.5, width / 2 - end_radius, 0 ],
                     [ -length / 2 - 0.5, -(width / 2 - end_radius), 0 ],
                     [ length / 2 + 0.5, width / 2 - end_radius, 0 ],
                     [ length / 2 + 0.5, -(width / 2 - end_radius), 0 ]
                 ]) {
                translate(i) cylinder(r = end_radius, h = height, $fn = 50);
            }
        }

        // because they're cutouts, overspecify height on these

        // servo mount holes
        for (i = [
                 [ -screwhole_offset - center_space / 2, 0, -(height / 2) ],
                 [ -length / 2 - screwhole_offset / 2, 0, -(height / 2) ],
                 [ screwhole_offset + center_space / 2, 0, -(height / 2) ],
                 [ length / 2 + screwhole_offset / 2, 0, -(height / 2) ]
             ]) {
            translate(i)
                cylinder(r = screwhole_radius, h = height + 5, $fn = 20);
        }

        // servo body cutouts
        for (i = [
                 [ -servo_motor_length/2 - center_space / 2 - screwhole_offset*2, 0, height / 2 ],
                 [ servo_motor_length/2 + center_space / 2 + screwhole_offset*2, 0, height / 2 ]
             ]) {
            translate(i)
                cube([ servo_motor_length, servo_motor_width, height + 5 ],
                     center = true);
        }
    }
}

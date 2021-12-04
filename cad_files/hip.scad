include <hip_dimensions.scad>;

hip();

module
hip()
{
    difference()
    {
        union()
        {
            // main
            translate([ -length / 2, -hip_width / 2, 0 ])
                cube([ length, hip_width, hip_height ]);

            // outside end edges
            for (i = [
                     [
                         -length / 2 - hip_end_radius - 0.5,
                         -(hip_width / 2 - hip_end_radius),
                         0
                     ],
                     [
                         length / 2 - hip_end_radius + 0.5,
                         -(hip_width / 2 - hip_end_radius),
                         0
                     ]
                 ]) {
                translate(i)
                    cube([ hip_end_radius * 2, hip_width - (hip_end_radius * 2), hip_height ]);
            }

            // rounded corners
            for (i = [
                     [ -length / 2 - 0.5, hip_width / 2 - hip_end_radius, 0 ],
                     [ -length / 2 - 0.5, -(hip_width / 2 - hip_end_radius), 0 ],
                     [ length / 2 + 0.5, hip_width / 2 - hip_end_radius, 0 ],
                     [ length / 2 + 0.5, -(hip_width / 2 - hip_end_radius), 0 ]
                 ]) {
                translate(i) cylinder(r = hip_end_radius, h = hip_height, $fn = 50);
            }

        }

        // because they're cutouts, overspecify height on these

        // servo mount holes
        for (i = [
                 [ -screwhole_offset - hip_center_space / 2, 0, -(hip_height / 2) ],
                 [ -length / 2 - screwhole_offset / 2, 0, -(hip_height / 2) ],
                 [ screwhole_offset + hip_center_space / 2, 0, -(hip_height / 2) ],
                 [ length / 2 + screwhole_offset / 2, 0, -(hip_height / 2) ]
             ]) {
            translate(i)
                cylinder(r = screwhole_radius, h = hip_height + 5, $fn = 20);
        }


        // servo body cutouts
        for (i = [
                 [ -servo_motor_length/2 - hip_center_space / 2 - screwhole_offset*2, 0, hip_height / 2 ],
                 [ servo_motor_length/2 + hip_center_space / 2 + screwhole_offset*2, 0, hip_height / 2 ]
             ]) {
            translate(i)
                cube([ servo_motor_length, servo_motor_width, hip_height + 5 ],
                     center = true);
        }

        // screw holes to backbone
        for (i = [
                 [ -2.5, 0, -10 ],
                 [ 2.5, 0, -10 ]
             ]) {
            translate(i) cylinder(r = 1, h = 20, $fn = 20);
        }

    }
}

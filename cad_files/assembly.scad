use <backbone.scad>
use <coxa.scad>
use <femur.scad>
use <hip.scad>
use <hip_dimensions.scad>
use <servo.scad>
use <tibia.scad>

bb_length = 100;
bb_height = 8;
servo_width = 12;
servo_length = 23;

coxa_rot_angle = 30;
femur_angle = -40;
tibia_angle = 120;

show_full_assembly = 1;
h_pos = (bb_length - 20) / 2;

if (show_full_assembly == 1) {
  // full assembly example
  backbone();

  for (i = [ 1, -1 ]) {
    translate([ 0, i * h_pos, (bb_height / 2) ]) hip();

    for (j = [ 1, -1 ]) {
      translate([ j * 22.5, i * h_pos, 8 ]) union() {
        rotate([ 0, 0, j * -90 ]) color("blue") servo();

        translate([ j * -.5, 0, -2.5 ])
            rotate([ 90, 0, i * j * coxa_rot_angle ]) union() {
          scale([ j * 1, 1, i * -1 ]) coxa();
          translate([ j * 26.5, 6, 0 ]) rotate([ 0, 90 + i * 90, 0 ]) union() {
            color("blue") servo();
            translate([ 0, 0, 11 ]) scale([ j * i, 1, 1 ])
                rotate([ 0, 0, 180 + femur_angle ]) union() {
              femur();
              translate([ 40, 0, -11 ])
                  rotate([ 0, 0, 90 + tibia_angle ]) union() {
                color("blue") servo();
                translate([ 0, -22, -4 ]) rotate([ 0, 0, -90 ]) tibia();
              }
            }
          }
        }
      }
    }
  }
}

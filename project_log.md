## 11/27/21

1. The servo mounts on the hip piece of robot touch each other. I want some space between them for the right-angle
   headers on the motor controller featherwing. So, I rewrote hip.scad to base it on a few distance variables, and added
   a center space between the servo mounts.
2. On the other hand, it might be easier/better to mount the motor controllers underneath the body piece, which would
   make that unnecessary. However, problem with that is, where will the battery go?
3. I can stack the motor controllers with headers and fit them over the center body, but where will the feathers2 go?
   Not sure that I want to stack all 3, for one thing it makes it harder to get to the controller boards if necessary.
4. Also: need to find electrolytic capacitors at the space and add to controller boards. I _think_ I settled on about
   100 uF for the capacitance, we'll see how that works.

Later, at the space:

1. added 100 uF caps to the motor controller boards. Discovered that installing them upright interfered with stacking
   headers, so removed them and installed some laying sideways.
2. Printed a hip piece with a wider stance. Noticed I didn't have holes to match the mount holes in the backbone piece.
   I can always drill some.
3. Spent a fair amount of time attempting to make a row of holes in a printed piece which match the pins in a standard
   header. Surprisingly hard to get a match. Should use standard measurements but I'm not convinced printer is
   calibrated properly.
4. Clipped male leads on stacking header at bottom of motor controller stack, as I didn't want to put them on top of
   main board anyway.
5. Installed male headers into second motor controller, stacked on top of the first. Seems to be the most efficient use
   of space possible.
6. Need to add holder for on-off switch I found for the motor power supply, which should be manually switchable.

12/4/21

1. added (back) holes in hip.scad that mount to the backbone piece
2. switch dimensions: 11.58 mm x 4.19 mm x 5.6 mm (height). wires project from the bottom have a width of 6 mm x 2 mm (
   width depends on how wires are bent. need to add shrinkwrap tubing)

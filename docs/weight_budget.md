# Featherboa: Weight

## What is a Weight Budget?

For any mobile device, weight is an issue, for two main reasons. First, for a given set of wheels, tractors, or in our case legs, there's a maximum weight the chassis can support and still be able to move. Second, when moving, the more weight moved, the more energy it takes (see document [Energy Budget](energy_budget.md)). So the goal is to minimize the weight.

So a weight budget is the weight of all the pieces and parts, constrained by the amount the robot can reasonably carry.

Since our batteries are the second-largest source of extra weight, the weight budget puts limits on the energy budget, and vice-versa.


## Total Weight


                                |          | Weight|Per Unit |       |                                   |
Part                            | Quantity | Rated | Actual  | Total | Notes                             |
--------------------------------|----------|-------|---------|-------|-----------------------------------|
SG92R Servo Motor               |  12      | 9     | 11.65   | 139.8 | includes cable, mounting screws   |
1200 mAh LiPo battery           |  1       | 23    | 23      | 23    |                                   |
AA Battery, Duracell Alkaline   |  4       | 24    | 24.5    | 98    |                                   |
Leg mount (original)            |  2       |       | 2.5     | 5     |                                   |
Leg mount (wider)               |  2       |       | 4       | 8     |                                   |
Hip                             |  4       |       | 6.9     | 27.6  | includes horns, hot glue          |
4AA Battery Holder              |  1       |       | 11.3    | 11.3  |                                   |
Feather PCA9685 PWM controller  |  2       | 3.9   | 10.2    | 20.4  | Includes headers, 100uF capacitor |
FeatherS2 Microcontroller board |  1       |       | 6.2     | 6.2   | includes headers                  |
Upper Leg                       |  4       |       | 1.8     | 7.2   | includes motor horns, hot glue    |
Body (central bar)              |  1       |       | 0       | 0     |                                   |
Tibia (lower leg)               |  4       |       | 1.7     | 6.8   |                                   |

## Weight Limits

How much can the robot weigh? That's tricky. To stand, the robot needs to weigh less than the strength of the motors that hold the joints in a standing pose.

But we don't want our robot to just stand there, we want it to move. And that means at least one foot will be out of contact with the ground, so the remaining 3 legs have to be capable of bearing the weight.

One can get an estimate of the strength of the legs from the torque specifications of the motors, and the geometry of the parts (specifically the "ulna" and "tibia"). Or, one can directly measure the force required to cause the pose to break down and the leg to start moving.

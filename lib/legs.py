import time

from adafruit_servokit import ServoKit


class Legs:
    """
    Enum of legs
    """

    LEFT_FRONT = 1
    RIGHT_FRONT = 2
    LEFT_REAR = 3
    RIGHT_REAR = 4


class Motors:
    """
    Enum of motors
    """

    LEFT_FRONT_LOWER = 0
    LEFT_FRONT_UPPER = 1
    LEFT_FRONT_HIP = 2
    RIGHT_FRONT_LOWER = 5
    RIGHT_FRONT_UPPER = 4
    RIGHT_FRONT_HIP = 3
    # rest of these enums filled in automatically by Copilot, following the pattern
    LEFT_REAR_LOWER = 6
    LEFT_REAR_UPPER = 7
    LEFT_REAR_HIP = 9
    RIGHT_REAR_LOWER = 10
    RIGHT_REAR_UPPER = 11
    RIGHT_REAR_HIP = 12


# motors will need some calibration for not being mounted at perfect angle
# try to keep these numbers as small as possible
#
motor_angle_calibration = {
    Motors.LEFT_FRONT_LOWER: 0,
    # copilot filled in contents from here correctly. Getting scary.
    Motors.LEFT_FRONT_UPPER: 0,
    Motors.LEFT_FRONT_HIP: 0,
    Motors.RIGHT_FRONT_LOWER: 0,
    Motors.RIGHT_FRONT_UPPER: 0,
    Motors.RIGHT_FRONT_HIP: 0,
    Motors.LEFT_REAR_LOWER: 0,
    Motors.LEFT_REAR_UPPER: 0,
    Motors.LEFT_REAR_HIP: 0,
    Motors.RIGHT_REAR_LOWER: 0,
    Motors.RIGHT_REAR_UPPER: 0,
    Motors.RIGHT_REAR_HIP: 0,
}

# define a "default" standing pose
# lower motor, upper motor, hip motor
STANDING_POSE = [90, 120, 100]


class Servos:
    def __init__(self) -> None:
        # Set channels to the number of servo channels on your kit.
        # 8 for FeatherWing, 16 for Shield/HAT/Bonnet.
        self.kit = ServoKit(channels=8)

    def stand_up(self) -> None:
        self.kit.servo[LEFT_FRONT_LOWER].angle = STANDING_POSE[0]
        self.kit.servo[LEFT_FRONT_UPPER].angle = STANDING_POSE[1]
        self.kit.servo[LEFT_FRONT_HIP].angle = STANDING_POSE[2]

import time

from adafruit_servokit import ServoKit


# alas, CP doesn't suport dataclasses
class Position:
    """
    A set of motor angles to define the position of a leg.
    """

    def __init__(self, lower: int, higher: int, hip: int):
        self.lower = lower
        self.higher = higher
        self.hip = hip


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


class Leg:
    """
    Tracks which motors belong to which leg.
    """

    # unfortunately circuitpython doesn't support Enum class
    def __init__(self, lower, uppper, hip):
        self.lower = lower
        self.upper = uppper
        self.hip = hip
        self.position = None

    def current_pos(self) -> Position:
        """
        How do I determine and/or keep track of this?
        """
        return self.position

    def set_pos(self, pos: Position):
        """
        Instructs leg motors to move to the current position.
        """
        self.lower.angle = pos.lower
        self.upper.angle = pos.higher
        self.hip.angle = pos.hip
        self.position = pos


class Legs:
    """
    Enum of legs
    """

    LEFT_FRONT = Leg(
        Motors.LEFT_FRONT_LOWER, Motors.LEFT_FRONT_UPPER, Motors.LEFT_FRONT_HIP
    )
    RIGHT_FRONT = Leg(
        Motors.RIGHT_FRONT_LOWER, Motors.RIGHT_FRONT_UPPER, Motors.RIGHT_FRONT_HIP
    )
    LEFT_REAR = Leg(
        Motors.LEFT_REAR_LOWER, Motors.LEFT_REAR_UPPER, Motors.LEFT_REAR_HIP
    )
    RIGHT_REAR = Leg(
        Motors.RIGHT_REAR_LOWER, Motors.RIGHT_REAR_UPPER, Motors.RIGHT_REAR_HIP
    )


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
STANDING_POSE = Position(90, 120, 100)


class Servos:
    def __init__(self) -> None:
        # Set channels to the number of servo channels on your kit.
        # 8 for FeatherWing, 16 for Shield/HAT/Bonnet.
        self.kit = ServoKit(channels=8)

    def stand_up(self) -> None:
        self.set_attitude(Legs.LEFT_FRONT, STANDING_POSE)
        self.set_attitude(Legs.RIGHT_FRONT, STANDING_POSE)
        self.set_attitude(Legs.LEFT_REAR, STANDING_POSE)
        self.set_attitude(Legs.RIGHT_REAR, STANDING_POSE)

    def set_attitude(self, leg: Leg, position: Position):
        """
        Set the servo angles for a leg
        """
        self.kit.servo[leg.lower].angle = position.lower
        self.kit.servo[leg.upper].angle = position.upper
        self.kit.servo[leg.hip].angle = position.hip

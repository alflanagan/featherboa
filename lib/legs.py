from adafruit_servokit import ServoKit


# alas, CPy doesn't suport dataclasses
class Position:
    """
    A set of motor angles to define the position of a leg.
    """

    def __init__(self, lower: int, upper: int, hip: int):
        self.lower = lower
        self.upper = upper
        self.hip = hip


class Motor:
    """
    Enum of motors
    """
    # 6 motors per board, so we're skipping motor 0 and motor 7
    # first board
    LEFT_FRONT_LOWER = 2
    LEFT_FRONT_UPPER = 1
    LEFT_FRONT_HIP = 3
    LEFT_REAR_LOWER = 6
    LEFT_REAR_UPPER = 5
    LEFT_REAR_HIP = 4

    # second board (8 + servo number) (skip 8, 15)
    RIGHT_FRONT_LOWER = 9
    RIGHT_FRONT_UPPER = 10
    RIGHT_FRONT_HIP = 11
    RIGHT_REAR_LOWER = 12
    RIGHT_REAR_UPPER = 13
    RIGHT_REAR_HIP = 14


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
        self.lower = pos.lower
        self.upper = pos.upper
        self.hip = pos.hip
        self.position = pos


class Legs:
    """
    Enum of legs
    """

    LEFT_FRONT = Leg(
        Motor.LEFT_FRONT_LOWER, Motor.LEFT_FRONT_UPPER, Motor.LEFT_FRONT_HIP
    )
    RIGHT_FRONT = Leg(
        Motor.RIGHT_FRONT_LOWER, Motor.RIGHT_FRONT_UPPER, Motor.RIGHT_FRONT_HIP
    )
    LEFT_REAR = Leg(Motor.LEFT_REAR_LOWER, Motor.LEFT_REAR_UPPER, Motor.LEFT_REAR_HIP)
    RIGHT_REAR = Leg(
        Motor.RIGHT_REAR_LOWER, Motor.RIGHT_REAR_UPPER, Motor.RIGHT_REAR_HIP
    )


# motors will need some calibration for not being mounted at perfect angle
# try to keep these numbers as small as possible
# (if they're all 0, then I haven't calibrated yet)
motor_angle_calibration = {
    Motor.LEFT_FRONT_LOWER: 0,
    # copilot filled in contents from here correctly. Getting scary.
    Motor.LEFT_FRONT_UPPER: 0,
    Motor.LEFT_FRONT_HIP: 0,
    Motor.RIGHT_FRONT_LOWER: 0,
    Motor.RIGHT_FRONT_UPPER: 0,
    Motor.RIGHT_FRONT_HIP: 0,
    Motor.LEFT_REAR_LOWER: 0,
    Motor.LEFT_REAR_UPPER: 0,
    Motor.LEFT_REAR_HIP: 0,
    Motor.RIGHT_REAR_LOWER: 0,
    Motor.RIGHT_REAR_UPPER: 0,
    Motor.RIGHT_REAR_HIP: 0,
}


# define a "default" standing pose
STANDING_POSE = Position(90, 120, 100)


class Servo:
    def __init__(self, channels=8, address=0x40, reference_clock_speed=25000000, frequency=50) -> None:
        """
        :param int channels: The number of servo channels available. Must be 8 or 16. The FeatherWing
                         has 8 channels. The Shield, HAT, and Bonnet have 16 channels.
        :param int address: The I2C address of the PCA9685. Default address is ``0x40``.
        :param int reference_clock_speed: The frequency of the internal reference clock in Hertz.
                                      Default reference clock speed is ``25_000_000``.
        :param int frequency: The overall PWM frequency of the PCA9685 in Hertz.
                                      Default frequency is ``50``.

        """
        # Set channels to the number of servo channels on your kit.
        # 8 for FeatherWing, 16 for Shield/HAT/Bonnet.
        self.kit = ServoKit(channels=channels, address=address, reference_clock_speed=reference_clock_speed, frequency=frequency)

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

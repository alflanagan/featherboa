# FeatherS2 Helper Library
# 2021 Seon Rozenblum, Unexpected Maker
#
# Project home:
#   https://feathers2.io
#

# Import required libraries
import time

import board
from digitalio import DigitalInOut, Direction

# Helper functions


def led_blink():
    """
    Set the internal LED IO13 to its inverse state
    """
    led13.value = not led13.value


def led_set(state):
    """
    Set the internal LED IO13 to this state
    """
    led13.value = state


def enable_LDO2(state):
    """
    Set the power for the second on-board LDO to allow no current draw when not needed.
    """
    ldo2.value = state
    # A small delay to let the IO change state
    time.sleep(0.035)


# Init Blink LED
led13 = DigitalInOut(board.LED)
led13.direction = Direction.OUTPUT

# Init LDO2 Pin
ldo2 = DigitalInOut(board.LDO2)
ldo2.direction = Direction.OUTPUT

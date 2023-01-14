import gc
import os
import sys
import time
from random import randrange

import board
import digitalio
import wifi

from constants import NS_PER_SECOND
from lib.feathers2 import enable_LDO2, led_set
from lib.legs import Motor, Servo, motor_angle_calibration
from lib.networking import connect_home_network

# built-in adafruit modules for feathers2
# _bleio, adafruit_bus_device, adafruit_pixelbuf, aesio, alarm, analogio, atexit, audiobusio,
# audiocore, audiomixer, binascii, bitbangio, bitmaptools, board, busio, canio, countio, digitalio,
# displayio, dualbank, errno, fontio, framebufferio, frequencyio, getpass, i2cperipheral,
# imagecapture, ipaddress, json, keypad, math, microcontroller, msgpack, neopixel_write, nvm,
# onewireio, os, paralleldisplay, ps2io, pulseio, pwmio, qrio, rainbowio, random, re, rgbmatrix,
# rotaryio, rtc, sdcardio, sharpdisplay, socketpool, ssl, storage, struct, supervisor, synthio,
# terminalio, time, touchio, traceback, ulab, usb_cdc, usb_hid, usb_midi, vectorio, watchdog, wifi

# dir(board):
# 'A0', 'A1', 'A10', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'AMB', 'APA102_MOSI',
# 'APA102_SCK', 'D0', 'D1', 'D10', 'D11', 'D12', 'D13', 'D14', 'D15', 'D16', 'D17', 'D18',
# 'D19', 'D20', 'D21', 'D23', 'D24', 'D25', 'D4', 'D5', 'D6', 'D9', 'DAC1', 'DAC2', 'I2C',
# 'IO0', 'IO1', 'IO10', 'IO11', 'IO12', 'IO14', 'IO17', 'IO18', 'IO21', 'IO3', 'IO33', 'IO35',
# 'IO36', 'IO37', 'IO38', 'IO4', 'IO43', 'IO44', 'IO5', 'IO6', 'IO7', 'IO8', 'IO9', 'LDO2',
# 'LED', 'MISO', 'MOSI', 'RX', 'SCK', 'SCL', 'SDA', 'SPI', 'TX', 'UART', 'board_id'

# dir(feathers2)
# 'DigitalInOut', 'Direction', 'Pull', 'board', 'time', 'led_blink', 'led13', 'led_set'

# feathers2 module sets led13, OUTPUT
# feathers2.led13.direction = digitalio.Direction.OUTPUT

# using IO4 turns off LED function and behaves like ordinary pin
amber_led = digitalio.DigitalInOut(board.AMB)
amber_led.direction = digitalio.Direction.OUTPUT
# .pull is not used when direction = OUTPUT

""" did_setup = False

def setup():
    global did_setup
    if did_setup:
        return
    did_setup = True
    networking.setup()

"""

# Say hello
print("\nHello from FeatherS2!")
print("---------------------\n")


def say_hello():
    # Say hello
    print("\nHello from FeatherS2!")
    print("---------------------\n")


def show_mem():
    # Show available memory
    print("Memory Info - gc.mem_free()")
    print("---------------------------")
    print("{:,} Bytes\n".format(gc.mem_free()))

    flash = os.statvfs("/")
    flash_size = flash[0] * flash[2]
    flash_free = flash[0] * flash[3]
    # Show flash size
    print("Flash - os.statvfs('/')")
    print("---------------------------")
    print("Size: {:,} Bytes\nFree: {:,} Bytes\n".format(flash_size, flash_free))


def show_network():
    # useful, but takes a few seconds
    print("Networking")
    print("--------------")

    print(
        "AP MAC Address: " + ":".join(["%x" % byt for byt in wifi.radio.mac_address_ap])
    )

    wifi.radio.start_ap("quad_walker")
    connect_home_network()

    print("IP Address " + str(wifi.radio.ipv4_address_ap))
    print("--------------")
    # dns 192.168.1.1


class RandomBlinkLED:
    def __init__(self, max_delay):
        self.max_delay = max_delay
        self.mark = time.monotonic_ns()
        self.led_state = False

    def check(self):
        if time.monotonic_ns() > self.mark:
            led_set(self.led_state)
            self.led_state = not self.led_state
            self.mark += int(
                randrange(1_000) / 1_000.0 * self.max_delay * NS_PER_SECOND
            )

    @classmethod
    def run(cls):
        blink_led = cls(2.0)
        print("blinking LED...")
        while True:
            blink_led.check()


def testServos():
    servos = {}
    missing = []
    for i2c_channel in [0x40, 0x41]:
        try:
            servos[i2c_channel] = Servo(address=i2c_channel, channels=8)
        except ValueError:
            missing.append(hex(i2c_channel))

    if missing:
        if len(missing) > 1:
            print(f'Failed to find I2C devices on channels {", ".join(missing)}')
        else:
            print(f"Failed to find an I2C device at channel {missing[0]}")
        sys.exit()

    for num in [
        Motor.LEFT_FRONT_HIP,
        Motor.LEFT_FRONT_UPPER,
        Motor.LEFT_FRONT_LOWER,
        Motor.LEFT_REAR_HIP,
        Motor.LEFT_REAR_UPPER,
        Motor.LEFT_REAR_LOWER,
    ]:
        print("testing motor index " + str(num))
        servos[0].kit.servo[num].angle = motor_angle_calibration[num]
        # sleep(2)


def main():
    # Make sure the 2nd LDO is turned on
    enable_LDO2(True)
    # Turn on the internal blue LED
    led_set(True)
    say_hello()

    # servo0 = Servo(address=0x41, channels=8)

    # fred = esp32.freq()
    # print("CPU")
    # print("---------------------------")
    # print("Frequency {:,}".format(fred))

    uart = board.UART()
    print(f"board connected at {uart.baudrate} baud\n")
    show_mem()
    show_network()
    connect_home_network()


main()

import gc
import os
from random import randrange
from time import monotonic_ns, sleep

import board
import microcontroller
import wifi
from adafruit_esp32spi import adafruit_esp32spi_socket as socket
from adafruit_servokit import ServoKit
from digitalio import DigitalInOut

import feathers2
from lib.legs import STANDING_POSE, Legs, Motor, Position, Servo
from lib.networking import connect_home_network

# wifi: AuthMode, Radio, radio, Monitor, Network, Packet
# WiFi: connect, enabled, ip_address, neo_status, is_connected
# feathers2 board pin map:
# pins in the same row are equivalent
pin_map = [
    [board.A0, board.D14, board.DAC1, board.IO17],
    [board.A1, board.D15, board.DAC2, board.IO18],
    [board.A10, board.D5, board.IO1],
    [board.A2, board.D16, board.IO14],
    [board.A3, board.D17, board.IO12],
    [board.A4, board.D18, board.IO6],
    [board.A5, board.D19, board.IO5],
    [board.A6, board.D13, board.IO11],
    [board.A7, board.D12, board.IO10],
    [board.A8, board.D9, board.IO7],
    [board.A9, board.D6, board.IO3],
    [board.AMB, board.IO4],
    [board.APA102_MOSI],
    [board.APA102_SCK],
    [board.D0, board.IO44, board.RX],
    [board.D1, board.IO43, board.TX],
    [board.D10, board.IO8, board.SDA],
    [board.D11, board.IO9, board.SCL],
    [board.D20, board.IO33],
    [board.D21, board.IO38],
    [board.D23, board.IO37, board.MISO],
    [board.D24, board.IO35, board.MOSI],
    [board.D25, board.IO36, board.SCK],
    [board.D4, board.IO0],
    [board.IO21, board.LDO2],
    [board.LED],
]

# Make sure the 2nd LDO is turned on
feathers2.enable_LDO2(True)

# Say hello
print("\nHello from FeatherS2!")
print("---------------------\n")

# Turn on the internal blue LED
feathers2.led_set(True)

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

print("Networking")
print("--------------")

print("AP MAC Address: " + ":".join(["%x" % byt for byt in wifi.radio.mac_address_ap]))

wifi.radio.start_ap("quad_walker")
connect_home_network()

print("IP Address " + str(wifi.radio.ipv4_address_ap))
print("--------------")

# TODO: access local web API

# dns 192.168.1.1
led_state = True

Legs.LEFT_FRONT.set_pos(STANDING_POSE)
Legs.LEFT_REAR.set_pos(STANDING_POSE)
Legs.RIGHT_FRONT.set_pos(STANDING_POSE)
Legs.RIGHT_REAR.set_pos(STANDING_POSE)

NS_PER_SECOND = 1_000_000_000.0


class RandomBlinkLED:
    def __init__(self, max_delay):
        self.max_delay = max_delay
        self.mark = monotonic_ns()
        self.led_state = False

    def check(self):
        if monotonic_ns() > self.mark:
            feathers2.led_set(self.led_state)
            self.led_state = not self.led_state
            self.mark += int(
                randrange(1_000) / 1_000.0 * self.max_delay * NS_PER_SECOND
            )


blink_led = RandomBlinkLED(2.0)

while True:
    blink_led.check()

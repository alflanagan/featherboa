import gc
import os
from random import randrange
from time import monotonic_ns, sleep

import wifi

from constants import NS_PER_SECOND
from lib.feathers2 import enable_LDO2, led_set
from lib.legs import Motor, Servo
from lib.networking import connect_home_network

# wifi: AuthMode, Radio, radio, Monitor, Network, Packet
# WiFi: connect, enabled, ip_address, neo_status, is_connected


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
        self.mark = monotonic_ns()
        self.led_state = False

    def check(self):
        if monotonic_ns() > self.mark:
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


# Make sure the 2nd LDO is turned on
enable_LDO2(True)
# Turn on the internal blue LED
led_set(True)
say_hello()

servo0 = Servo(address=0x41, channels=8)

for num in [
    Motor.LEFT_FRONT_HIP,
    Motor.LEFT_FRONT_UPPER,
    Motor.LEFT_FRONT_LOWER,
    Motor.LEFT_REAR_HIP,
    Motor.LEFT_REAR_UPPER,
    Motor.LEFT_REAR_LOWER,
]:
    print("testing motor index " + str(num))
    servo0.kit.servo[num].angle = 90
    sleep(2)

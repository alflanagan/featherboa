import time, gc, os
import board
import feathers2
from lib import networking


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

flash = os.statvfs('/')
flash_size = flash[0] * flash[2]
flash_free = flash[0] * flash[3]
# Show flash size
print("Flash - os.statvfs('/')")
print("---------------------------")
print("Size: {:,} Bytes\nFree: {:,} Bytes\n".format(flash_size, flash_free))


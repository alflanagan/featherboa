# featherboa

Programmming a [FeatherS2 board](https://feathers2.io/) (ESP32-S2 chip) in Python. The actual implementation is the [CircuitPython port](https://circuitpython.org/board/unexpectedmaker_feathers2/) for the FeatherS2 board.

## What's with the name?

Feather is the name of the controller board I'm using for my robot, and a boa constrictor is, well, cousin to a python at least. (Hey, you try finding an original name on github).

## The Robot

The chip is being used to drive two Adafruit Feather [motor controllers](https://www.adafruit.com/product/2928). Each can drive 8 servos, but the robot uses 12, so they're divided into 6 servos/2 legs per board.

The robot body is based on a [Thingiverse Item](https://www.thingiverse.com/thing:50125)\*. I've included the OpenScad files in this repository, some of them have been re-written by me.

## Project Log

I am (trying to) maintain a [log](./docs/project_log.md) of the progress of this project. Hopefully if you're interested in this
project you can learn from my mistakes along the way.

---

\* Those files are covered by the Creative Commons license [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/).

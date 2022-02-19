#! /bin/sh
DESTDIR=/media/lloyd/CIRCUITPY
# unless your name is lloyd, you'll need to modify above
if [ ! -d $DESTDIR ]; then
	echo "Don't see ${DESTDIR}; you may need to change this script."
	exit 1
fi

cp ./*.py ${DESTDIR}
cp lib/*.py ${DESTDIR}/lib

# Circuitpython library modules are installed by circup (https://github.com/adafruit/circup/)
# see files board-requirements.in and board-requirements.txt

#! /bin/sh
DESTDIR=/media/lloyd/CIRCUITPY
# unless your name is lloyd, you'll need to modify above
if [ ! -d $DESTDIR ]; then
	echo "Don't see ${DESTDIR}; you may need to change this script."
	exit 1
fi
cp ./*py ${DESTDIR}
cp lib/*py  ${DESTDIR}/lib
# we don't copy third-party libraries here. I recommend you use a tool to install and update
# those. Check out VSCode 'Circuitpython' extension, or Adafruit's CircUp
# (https://github.com/adafruit/circup/)

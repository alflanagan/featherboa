#! /bin/sh
DESTDIR=/media/lloyd/CIRCUITPY
# unless your name is lloyd, you'll need to modify above
if [ ! -d $DESTDIR ]; then
	echo "Don't see ${DESTDIR}; you may need to change this script."
	exit 1
fi
cp ./*py ${DESTDIR}
cp lib/*py  ${DESTDIR}/lib

#!/bin/bash

cp .dockerignore.build .dockerignore
docker build -f Dockerfile.build -t neutrino-xrdp-dev .

if [ "$1" == "bash" ]; then
  cmd=/bin/bash
  cmd_switch="--rm -it"
else
  cmd=
  cmd_switch=""
fi

[ ! -d $(pwd)/build/xrdp ] && mkdir -p $(pwd)/build/xrdp
[ ! -d $(pwd)/build/X11rdp ] && mkdir -p $(pwd)/build/X11rdp

docker rm -f neutrino-xrdp-dev

touch usr_local.tar.gz
touch etc_xrdp.tar.gz
touch pulseaudio_module-xrdp.tar.gz 

docker run $cmd_switch --name neutrino-xrdp-dev \
   -v $(pwd)/build/xrdp:/opt/xrdp \
   -v $(pwd)/build/X11rdp:/opt/X11rdp \
   neutrino-xrdp-dev $cmd

FILE=pulseaudio_module-xrdp.tar.gz
docker cp build_xrdp:/opt/$FILE $FILE

FILE=etc_xrdp.tar.gz
docker cp build_xrdp:/opt/$FILE $FILE

FILE=usr_local.tar.gz
docker cp build_xrdp:/opt/$FILE $FILE

docker rm -f neutrino-xrdp-dev

cd build
tar -cvzf ../X11rdp.tar.gz --exclude="*/test/*" --exclude="*.a" X11rdp
cd ..



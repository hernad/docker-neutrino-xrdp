#!/bin/bash

CT=neutrino-xrdp-dev
IMG=neutrino-xrdp-dev

cp .dockerignore.build .dockerignore
docker build -f Dockerfile.build -t $IMG .

if [ "$1" == "bash" ]; then
  cmd=/bin/bash
  cmd_switch=" -it"
else
  cmd=
  cmd_switch=""
fi

[ ! -d $(pwd)/build/xrdp ] && mkdir -p $(pwd)/build/xrdp
[ ! -d $(pwd)/build/X11rdp ] && mkdir -p $(pwd)/build/X11rdp

docker rm -f $CT

touch usr_local.tar.gz
touch etc_xrdp.tar.gz
touch pulseaudio_module-xrdp.tar.gz 


docker run $cmd_switch --name $CT \
   -v $(pwd)/build/xrdp:/opt/xrdp \
   -v $(pwd)/build/X11rdp:/opt/X11rdp \
   $IMG $cmd


docker start $CT

FILE=pulseaudio_module-xrdp.tar.gz
docker cp $CT:/opt/$FILE $FILE

FILE=etc_xrdp.tar.gz
docker cp $CT:/opt/$FILE $FILE

FILE=usr_local.tar.gz
docker cp $CT:/opt/$FILE $FILE

FILE=X11rdp.tar.gz
docker cp $CT:/opt/$FILE $FILE

docker rm -f $CT



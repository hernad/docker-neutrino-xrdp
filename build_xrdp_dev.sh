#!/bin/bash

CT=neutrino-xrdp-dev
IMG=hernad/neutrino-xrdp-dev

if [ "$1" == "bash" ]; then
  cmd="/bin/bash"
  cmd_switch=" -it"
else
  cmd=""
  cmd_switch=""
fi

if [ "$1" == "--no-build" ]; then
  echo no build
  cmd="/no_build.sh"
else
  echo build
  cp .dockerignore.build .dockerignore
  docker build -f Dockerfile.build -t $IMG .
fi


[ ! -d $(pwd)/build/xrdp ] && mkdir -p $(pwd)/build/xrdp
[ ! -d $(pwd)/build/X11rdp ] && mkdir -p $(pwd)/build/X11rdp

docker rm -f $CT

docker run $cmd_switch --name $CT $IMG $cmd

#   -v $(pwd)/build/xrdp:/opt/xrdp \
#   -v $(pwd)/build/X11rdp:/opt/X11rdp \

#docker start $CT

FILE=X11rdp.tar.gz
docker cp $CT:/opt/$FILE $FILE


FILE=pulseaudio_module-xrdp.tar.gz
docker cp $CT:/opt/$FILE $FILE

FILE=etc_xrdp.tar.gz
docker cp $CT:/opt/$FILE $FILE

FILE=usr_local.tar.gz
docker cp $CT:/opt/$FILE $FILE

docker rm -f $CT

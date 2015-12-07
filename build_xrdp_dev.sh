docker build -f Dockerfile.build -t build_xrdp .

if [ "$1" == "bash" ]; then
  cmd=/bin/bash
  cmd_switch="--rm -it"
else
  cmd=
  cmd_switch=""
fi

[ ! -d $(pwd)/build/xrdp ] && mkdir -p $(pwd)/build/xrdp
[ ! -d $(pwd)/build/X11rdp ] && mkdir -p $(pwd)/build/X11rdp

docker rm -f build_xrdp

touch usr_local.tar.gz
touch etc_xrdp.tar.gz
touch pulseaudio_module-xrdp.tar.gz 

docker run $cmd_switch --name build_xrdp \
   -v $(pwd)/build/xrdp:/opt/xrdp \
   -v $(pwd)/build/X11rdp:/opt/X11rdp \
   -v $(pwd)/usr_local.tar.gz:/opt/usr_local.tar.gz \
   -v $(pwd)/etc_xrdp.tar.gz:/opt/etc_xrdp.tar.gz \
   -v $(pwd)/pulseaudio_module-xrdp.tar.gz:/opt/pulseaudio_module-xrdp.tar.gz \
   build_xrdp $cmd

cd build
tar -cvzf ../X11rdp.tar.gz --exclude="*/test/*" --exclude="*.a" X11rdp
cd ..

#sudo chown docker etc_xrdp.tar.gz
#sudo chown docker usr_local.tar.gz
#sudo chown docker pulseaudio_module-xrdp.tar.gz 


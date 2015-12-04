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
docker run $cmd_switch --name build_xrdp -v $(pwd)/build/xrdp:/opt/xrdp -v $(pwd)/build/X11rdp:/opt/X11rdp  build_xrdp $cmd

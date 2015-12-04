docker build -f Dockerfile.build -t build_xrdp .

if [ "$1" == "bash" ]; then
  cmd=/bin/bash
  cmd_switch="--rm -it"
else
  cmd=
  cmd_switch=""
fi

docker rm -f build_xrdp
docker run $cmd_switch --name build_xrdp -v $(pwd)/build:/build build_xrdp $cmd

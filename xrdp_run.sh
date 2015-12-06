#!/bin/bash

docker run \
  --rm -ti \
  -p 3389:3389 \
  -v $(pwd)/mp3:/root/mp3 \
  --name neutrino-xrdp \
  neutrino-xrdp \
  /bin/bash


#!/bin/bash

docker rm -f neutrino-xrdp

docker run \
  --rm -ti \
  -p 3389:3389 \
  -v $(pwd)/data/music:/data/music \
  -v $(pwd)/data/conf/browser:/data/conf/browser \
  --name neutrino-xrdp \
  neutrino-xrdp 


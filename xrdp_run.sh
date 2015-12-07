#!/bin/bash

docker rm -f neutrino-xrdp

docker run \
  --rm -ti \
  -p 3389:3389 \
  -v $(pwd)/mp3:/data/mp3 \
  -v $(pwd)/conf/browser:/data/conf/browser \
  --name neutrino-xrdp \
  neutrino-xrdp 


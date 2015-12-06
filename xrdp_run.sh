#!/bin/bash

docker rm --f neutrino-xrdp
docker run -p 3389:3389 \
   --rm -ti neutrino-xrdp \
  -v $(pwd)/mp3:/root/mp3 \
  --name neutrino-xrdp
  /bin/bash


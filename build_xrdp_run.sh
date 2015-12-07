#!/bin/bash

cp .dockerignore.run .dockerignore
docker build -t neutrino-xrdp -f Dockerfile.run .


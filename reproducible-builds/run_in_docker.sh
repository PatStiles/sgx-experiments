#!/bin/sh

set -e
sudo docker build -t diffoscope -f ./Dockerfile-same-distro .
sudo docker build -t diffoscope -f ./Dockerfile-diff-distro .

sudo docker run --rm -t -w /tmp diffoscope ./ubuntu20/ ./ubuntu22/
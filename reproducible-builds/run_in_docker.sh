#!/bin/sh

set -e
sudo docker build -t diffoscope -f ./Dockerfile-same-distro .
sudo docker run --read-only --tmpfs /tmp -t diffoscope --exclude-directory-metadata=yes /gramine1/ /gramine2/ > result-same-distro.diff

# sudo docker build -t diffoscope -f ./Dockerfile-diff-distro .
# sudo docker run --rm --read-only --tmpfs /tmp -t diffoscope --exclude-directory-metadata=yes /ubuntu20/ /ubuntu22/ > result-diff-distro.diff
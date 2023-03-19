#!/bin/sh

set -e
sudo docker build -t diffoscope -f ./Dockerfile-debian .
sudo docker run --rm --read-only --tmpfs /tmp -t diffoscope --exclude-directory-metadata=yes --restructured-text=- /home/gramine1.deb /home/gramine2.deb > result-deb-packages.diff
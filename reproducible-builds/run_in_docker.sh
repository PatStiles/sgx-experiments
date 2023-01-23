#!/bin/sh

set -e
sudo docker build --build-arg https_proxy=$https_proxy \
             --build-arg http_proxy=$http_proxy -t sgx_gramine -f ./Dockerfile .

sudo docker volume create --driver local --opt type=tmpfs --opt device=tmpfs --opt o=rw aesmd-socket

sudo docker run --env http_proxy --env https_proxy --device=/dev/sgx_enclave --device=/dev/sgx_provision -v /dev/log:/dev/log -v aesmd-socket:/var/run/aesmd -it sgx_gramine

#!/bin/bash

# Set the remote host and username
REMOTE_HOST="ec2-3-128-78-81.us-east-2.compute.amazonaws.com"
REMOTE_USER="ubuntu"

# Remote docker image name
DOCKER_IMAGE_NAME="gramine-diff"

# Set the path to save the tar archive on the remote machine
REMOTE_PATH="/tmp/${DOCKER_IMAGE_NAME}.tar"

# Set the path to save the tar archive on your local machine
LOCAL_PATH="/tmp/${DOCKER_IMAGE_NAME}.tar"

# Remote dockerfile
REMOTE_DOCKERFILE="./Dockerfile-remote"
LOCAL_DOCKERFILE="./Dockerfile-local"

# Remote dockerfile path
REMOTE_DOCKERFILE_PATH="/tmp/Dockerfile-remote"

# copy the dockerfile to remote host
scp ${REMOTE_DOCKERFILE} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DOCKERFILE_PATH}

# execute dockerfile and build the image
ssh ${REMOTE_USER}@${REMOTE_HOST} "sudo docker build -t ${DOCKER_IMAGE_NAME} -f ${REMOTE_DOCKERFILE_PATH} ."

# Save the docker image to a tar archive on the remote machine
ssh ${REMOTE_USER}@${REMOTE_HOST} "sudo docker save ${DOCKER_IMAGE_NAME} -o ${REMOTE_PATH}"

ssh ${REMOTE_USER}@${REMOTE_HOST} "sudo chmod 755 ${REMOTE_PATH}"

# Copy the tar archive from the remote machine to your local machine
scp ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH} ${LOCAL_PATH}

# Load the docker image from the tar archive on your local machine
sudo docker load -i ${LOCAL_PATH}

# Build gramine again on local machine
sudo docker build -t diffoscope -f ${LOCAL_DOCKERFILE} .

# Diffoscope both builds
sudo docker run --read-only --tmpfs /tmp -t diffoscope --exclude-directory-metadata=yes /gramine1/ /gramine2/ > result-diff-machine.diff

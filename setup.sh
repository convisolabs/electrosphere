#!/bin/bash

if ! docker info &>/dev/null; then
  echo "Docker is not running. Please start Docker before continuing."
  exit 1
fi

echo "Do you want to build the electrosphere docker image with nuclei? (y/n)"
read answer

if [ "$answer" == "y" ] || [ "$answer" == "Y" ]
then
    echo "Building electrosphere docker image with nuclei..."
    docker build -t electrosphere -f Dockerfile.nuclei .
elif [ "$answer" == "n" ] || [ "$answer" == "N" ]
then
    echo "Building electrosphere default docker image..."
    docker build -t electrosphere .
else
    echo "Invalid input. Please enter y/n."
fi

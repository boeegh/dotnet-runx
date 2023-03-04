#!/bin/sh
IMAGE_VERSION_MARKER="IMAGE_NO"

echo "Updating files using $IMAGE_VERSION_MARKER=$1"
sed -i "s/$IMAGE_VERSION_MARKER/$1/" Dockerfile

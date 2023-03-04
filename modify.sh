#!/bin/bash
IMAGE_VERSION_MARKER="IMAGE_NO"
IMAGE_SET_VERSION=$1

echo "Updating files using $IMAGE_VERSION_MARKER=$IMAGE_SET_VERSION"
files=("Dockerfile")
for fn in ${files[@]}; do
  echo " - $fn"

  if [[ $2 == "--dev" ]]; then
    cp -f "$fn" "$fn.bak"
  fi

  sed -i "s/$IMAGE_VERSION_MARKER/$IMAGE_SET_VERSION/" "$fn"

  if [[ $2 == "--dev" ]]; then
    docker build --progress plain --no-cache -t boeegh/dotnet-runx:dev . || echo "Docker build failed."
    mv -f "$fn.bak" "$fn"
  fi

done


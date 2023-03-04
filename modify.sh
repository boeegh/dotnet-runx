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

  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i "" "s/$IMAGE_VERSION_MARKER/$IMAGE_SET_VERSION/" "$fn" || echo "Modify failed."
  else
    sed -i "s/$IMAGE_VERSION_MARKER/$IMAGE_SET_VERSION/" "$fn"
  fi

  if [[ $2 == "--dev" ]]; then
    docker build --progress plain --no-cache -t boeegh/dotnet-runx:dev . || echo "Docker build failed."
    mv -f "$fn.bak" "$fn"
  fi

done


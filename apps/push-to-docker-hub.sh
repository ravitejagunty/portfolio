#!/bin/bash

IMAGES=("shell" "home" "about" "projects" "blogs" "contact")
USERNAME="ravitejagunty"
REPO="rg"

for image in "${IMAGES[@]}"
do
  echo "Tagging image for $image..."
  if [ "$image" == "shell" ]; then
    docker tag apps-${image}:latest $USERNAME/$REPO:$image
  else
    docker tag apps-mfe_${image}:latest $USERNAME/$REPO:$image
  fi

  echo "Pushing $USERNAME/$REPO:$image to Docker Hub..."
  docker push $USERNAME/$REPO:$image

  echo "Done with $image"
  echo "-------------------------"
done
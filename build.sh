#!/usr/bin/env bash

GOBUILD="go build"

VERSION=$(git tag -l --sort=v:refname "v*" | tail -1)
APP_NAME="gh-get-private-email"
BASE_FILENAME="${APP_NAME}_${VERSION}"

DEST_FOLDER="dist/"

# Output artifacts
WINBIN="${DEST_FOLDER}/${BASE_FILENAME}-windows-$(go env GOARCH).exe"
WINGOOPTS="-trimpath -v -x -ldflags="-extldflags='-static'""

echo ${VERSION} >>./internal/version/app-version.txt

if [ "$COMSPEC" != "" ]; then
  echo "Windows Build mode"
  CGO_ENABLED=1 ${GOBUILD} ${WINGOOPTS} ${VERSION_OPTS} -o $WINBIN
  $WINBIN
else
  make linux
  if [ $CI ] && [ "${RUUNER_OS}" == "ubuntu-24.04-arm" ]; then
    make CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ GOARCH=arm GOARM=6 linux
  fi
fi

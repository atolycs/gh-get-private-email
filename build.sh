#!/usr/bin/env bash

GOBUILD="go build"

VERSION=$(git tag -l --sort=v:refname "v*" | tail -1)
APP_NAME="gh-get-private-email"
BASE_FILENAME="${APP_NAME}_${VERSION}"

DEST_FOLDER="dist/"

# Output artifacts
WINBIN="${DEST_FOLDER}/${BASE_FILENAME}-windows-$(go env GOARCH).exe"
WINGOOPTS="-x -ldflags="-extldflags "-static" -X github.com/atolycs/gh-get-private-email/internal/version.version=${VERSION}""

if [ "$COMSPEC" != "" ]; then
  echo "Windows Build mode"
  CGO_ENABLED=1 ${GOBUILD} $WINGOOPTS -o $WINBIN
else
  make linux
  make CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ GOARCH=arm GOARM=6 linux
fi

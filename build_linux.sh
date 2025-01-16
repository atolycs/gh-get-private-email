#!/usr/bin/env bash

#echo "Building Windows execution..."
#make win64

echo "Building Linux execution..."
make linux

echo "Building Linux ARM execution..."
make CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ GOARCH=arm GOARM=6 linux

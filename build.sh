#!/usr/bin/env bash

make win64
make linux
make GOARCH=arm GOARM=6 linux

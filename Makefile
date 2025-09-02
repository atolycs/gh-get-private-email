export APP_NAME = gh-get-private-email
export VERSION := $(shell git tag -l --sort=v:refname "v*" | tail -1)
export GO      = go
export GOBUILD = $(GO) build

export CWD := $(shell pwd)

export DIST := ./dist

# gpg sign
GPGBIN  := gpg
GPGOPTS := --armor --detach-sign

# GOOS Variables
GOOSWIN     =	windows
GOOSLINUX   =	linux
# GOARM := $(shell go env GOARM)
GOARCH := $(shell go env GOARCH)

GO_OPTS := 

UNAME_OS ?= $(shell uname -s)
UNAME_ARCH ?= $(shell uname -m)

# Builded execute file
export WINBIN    = $(DIST)/$(APP_NAME)_$(VERSION)-windows-$(GOARCH).exe
export LINUXBIN  = $(DIST)/$(APP_NAME)_$(VERSION)-linux-$(GOARCH)
export DARWINBIN = $(DIST)/$(APP_NAME)_$(VERSION)-darwin-$(GOARCH)
TESTWINBIN   = $(DIST)/$(APP_NAME)_$(VERSION)-windows-$(GOARCH)-test.exe
TESTLINUXBIN = $(DIST)/$(APP_NAME)_$(VERSION)-linux-$(GOARCH)-test

export SRC	:= main.go
#GO_OPTS = -x -ldflags "-linkmode external -extldflags -static -X github.com/atolycs/gh-get-private-email/internal/version.version=$(VERSION)"
# export GO_LDFLAGS_VERSION := -X 'github.com/atolycs/gh-get-private-email/internal/version.version=$(VERSION)'
export GO_LDFLAGS := $(GO_LDFLAGS_VERSION)

export GO_OPTS := -x -ldflags "$(GO_LDFLAGS)"

UNAME_MACHINE := $(shell uname -m)
UNAME_OS := $(shell uname -s)

ifeq ($(OS), Windows_NT)
	GOOS := windows
	GOMAKEFILE := make-windows.mk
else
	ifeq ($(UNAME_OS), Linux)
		GOOS := linux
		GO_LDFLAGS := $(GO_LDFLAGS_VERSION) 
		GOMAKEFILE := make-linux.mk
	else ifeq ($(UNAME_OS), Darwin)
		GOOS := darwin
		GOMAKEFILE := make-mac.mk
	else
		GOOS := unknown
		GOMAKEFILE := make-unknow.mk
		echo "Error: OS unknown"
		exit 1
	endif
endif


ifeq ($(UNAME_MACHINE), x86_64)
	export GOARCH := amd64
else ifeq ($(UNAME_MACHINE), i686)
	export GOARCH := 386
else ifeq ($(UNAME_MACHINE), aarch64)
	export GOARCH := arm64
else ifeq ($(UNAME_OS), Darwin)
	export GOARCH := arm64
else
	export GOARCH := unknown
endif


.PHONY: env build clean

env:
	$(MAKE) -f $(GOMAKEFILE) env

build:
	$(MAKE) -f $(GOMAKEFILE) go-build

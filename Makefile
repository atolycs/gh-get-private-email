
APP_NAME = gh-get-private-email
VERSION := $(shell git tag -l --sort=v:refname "v*" | tail -1)
GO      = go
GOBUILD = $(GO) build

DIST := ./dist


# GOOS Variables
GOOSWIN     =	windows
GOOSLINUX   =	linux
GOARM := $(shell go env GOARM)
GOARCH := $(shell go env GOARCH)
CGO_ENABLED	=	1


# Builded execute file
WINBIN    = $(DIST)/$(APP_NAME)_$(VERSION)-windows-$(GOARCH).exe
LINUXBIN  = $(DIST)/$(APP_NAME)_$(VERSION)-linux-$(GOARCH)

SRC	= main.go
GO_OPTS = -x -ldflags "-X github.com/atolycs/gh-get-private-email/internal/version.version=$(VERSION)"


$(WINBIN): $(SRC)
	GOOS=$(GOOSWIN) GOARCH=$(GOARCH) CGO_ENABLED=1 $(GOBUILD) -o $@ $(GO_OPTS) $<

$(LINUXBIN): $(SRC)
	GOOS=$(GOOSLINUX) GOARCH=$(GOARCH) GOARM=$(GOARM) CGO_ENABLED=1 $(GOBUILD) -o $@ $(GO_OPTS) $<


.PHONY: win64 linux

win64: $(WINBIN)
linux: $(LINUXBIN)


all: win64 linux

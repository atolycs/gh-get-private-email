
APP_NAME = gh-get-private-email
VERSION := $(shell git tag -l --sort=v:refname "v*" | tail -1)
GO      = go
GOBUILD = $(GO) build

CWD := $(shell pwd)

DIST := ./dist

# gpg sign
GPGBIN  := gpg
GPGOPTS := --armor --detach-sign

# GOOS Variables
GOOSWIN     =	windows
GOOSLINUX   =	linux
GOARM := $(shell go env GOARM)
GOARCH := $(shell go env GOARCH)
CGO_ENABLED	=	1

# Builded execute file
WINBIN    = $(DIST)/$(APP_NAME)_$(VERSION)-windows-$(GOARCH).exe
LINUXBIN  = $(DIST)/$(APP_NAME)_$(VERSION)-linux-$(GOARCH)
TESTWINBIN   = $(DIST)/$(APP_NAME)_$(VERSION)-windows-$(GOARCH)-test.exe
TESTLINUXBIN = $(DIST)/$(APP_NAME)_$(VERSION)-linux-$(GOARCH)-test

SRC	= main.go
GO_OPTS = -x -ldflags "-linkmode external -extldflags -static -X github.com/atolycs/gh-get-private-email/internal/version.version=$(VERSION)"


$(WINBIN): $(SRC)
	GOOS=$(GOOSWIN) GOARCH=$(GOARCH) CGO_ENABLED=1 $(GOBUILD) -o $@ $(GO_OPTS) $<

$(LINUXBIN): $(SRC)
	GOOS=$(GOOSLINUX) GOARCH=$(GOARCH) GOARM=$(GOARM) CGO_ENABLED=1 $(GOBUILD) -o $@ $(GO_OPTS) $<

$(TESTWINBIN): $(SRC)
	GOOS=$(GOOSWIN) GOARCH=$(GOARCH) CGO_ENABLED=1 $(GOBUILD) -o $@ $(GO_OPTS) $<

$(TESTLINUXBIN): $(SRC)
	GOOS=$(GOOSLINUX) GOARCH=$(GOARCH) GOARM=$(GOARM) CGO_ENABLED=1 $(GOBUILD) -o $@ $(GO_OPTS) $<
	ln -sf $(shell realpath $@) $(CWD)/$(APP_NAME)

.PHONY: win64 linux test-linux test-win clean sign

win64: $(WINBIN)
linux: $(LINUXBIN)

test-win: $(TESTWINBIN)
test-linux: $(TESTLINUXBIN)

dist/%.sig: $(WINBIN) $(LINUXBIN)
	$(foreach path, $^, $(GPGBIN) $(GPGOPTS) -o $(path).sig $(path);)

sign: dist/*.sig

clean:
	rm -f $(DIST)/*

all: win64 linux


APP_NAME = gh-get-private-email
VERSION := $(shell git tag -l --sort=v:refname "v*" | tail -1)
GO 			= go
GOBUILD = $(GO) build

DIST := ./dist

SRC	= main.go
GO_OPTS = -x -ldflags "-X github.com/atolycs/gh-get-private-email/internal/version.version=$(VERSION)"

$(APP_NAME).exe: $(SRC)
	CGO_ENABLED=1 GOOS=windows GOARCH=amd64 $(GOBUILD) -o $(DIST)/$(APP_NAME)_$(VERSION)-windows-amd64.exe $(GO_OPTS) $<

$(APP_NAME): $(SRC)
	CGO_ENABLED=1 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(DIST)/$(APP_NAME)_$(VERSION)-linux-amd64 $(GO_OPTS) $<

$(APP_NAME)-debug: $(SRC)
	CGO_ENABLED=1 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(APP_NAME) $(GO_OPTS) $<

.PHONY: all win64 linux debug-linux lint

win64: $(APP_NAME).exe
linux: $(APP_NAME)
lint: 
	$(GO)fmt -d -w .

debug-linux: $(APP_NAME)-debug

all: win64 linux



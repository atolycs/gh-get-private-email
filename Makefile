

APP_NAME = gh-get-private-email
VERSION = 0.0.1
GO 			= go
GOBUILD = $(GO) build

SRC	= main.go
GO_OPTS = -o ./dist/$(@) -x -ldflags "-X github.com/atolycs/gh-get-private-email/internal/version.version=v$(VERSION)"

$(APP_NAME).exe: $(SRC)
	CGO_ENABLED=1 GOOS=windows GOARCH=amd64 $(GOBUILD) $(GO_OPTS) $<

$(APP_NAME): $(SRC)
	CGO_ENABLED=1 GOOS=linux GOARCH=amd64 $(GOBUILD) $(GO_OPTS) $<


.PHONY: all win64 linux

win64: $(APP_NAME).exe
linux: $(APP_NAME)

all: win64 linux



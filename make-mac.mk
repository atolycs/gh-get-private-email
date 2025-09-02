go-build: internal/version/app-version.txt $(DARWINBIN)

%/app-version.txt:
	echo $(VERSION) >> $@

$(DARWINBIN): $(SRC)
	CGO_ENABLED=$(CGO) $(GOBUILD) $(GO_OPTS) -o $@

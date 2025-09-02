go-build: internal/version/app-version.txt $(WINBIN)

%/app-version.txt:
	echo $(VERSION) >> $@

$(WINBIN): $(SRC)
	CGO_ENABLED=$(CGO) $(GOBUILD) $(GO_OPTS) -o $@

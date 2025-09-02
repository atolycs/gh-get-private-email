go-build: internal/version/app-version.txt $(LINUXBIN)

%/app-version.txt:
	echo $(VERSION) >> $@

$(LINUXBIN): $(SRC)
	CGO_ENABLED=$(CGO) $(GOBUILD) $(GO_OPTS) -o $@

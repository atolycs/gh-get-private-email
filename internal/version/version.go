package version

import (
	"fmt"
  _ "embed"
)

//go:embed version.txt
var version string

func CallVersion() {
	fmt.Printf("get-private-email ver: %s\n", version)
}

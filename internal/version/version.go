package version

import (
	"fmt"
  _ "embed"
)

//go:embed app-version.txt
var version []byte

func CallVersion() {
	fmt.Printf("get-private-email ver: %s\n", version)
}

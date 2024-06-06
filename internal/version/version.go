package version

import (
	"fmt"
)

var version string

func CallVersion() {
	fmt.Printf("get-private-email ver: %s\n", version)
}

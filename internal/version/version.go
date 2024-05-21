package version

import (
  "fmt"
)

var version string

func CallVersion() {
  fmt.Printf("ver: %s\n", version)
}

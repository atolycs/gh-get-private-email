package util

import "strings"

func ToLines(output string) []string {
	lines := strings.TrimSuffix(output, "\n")
	return strings.Split(lines, "\n")
}

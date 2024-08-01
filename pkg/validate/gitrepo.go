package validate

import (
	"github.com/atolycs/gh-get-private-email/internal/git"
	"github.com/atolycs/gh-get-private-email/pkg/util"
)

func IsRepository() ([]string, error) {
	stdOut, _, err := git.Exec("rev-parse", "--is-inside-work-tree")
	if err != nil {
		return nil, err
	}
	return util.ToLines(stdOut.String()), nil
}

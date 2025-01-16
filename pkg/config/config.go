package config

import (
	"github.com/atolycs/gh-get-private-email/internal/git"
)

func Useremailset(c string) {
	git.Exec("config", "--local", "user.email", c)
	return
}

func Usernameset(c string) {
	git.Exec("config", "--local", "user.name", c)
	return
}

func Getconfig(c string) {
	git.Exec("config", "--local", "--get", c)
	return
}

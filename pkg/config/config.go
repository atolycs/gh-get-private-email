package config

import (
  "github.com/atolycs/gh-get-private-email/internal/git"
)


func Userset(c string) {
  git.Exec("config", "--local", "user.email", c)
  return
}

func Getconfig (c string) {
  git.Exec("config", "--local", "--get", c)
  return
}

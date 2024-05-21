package main

import (
	"fmt"
  "strconv"

	"github.com/cli/go-gh/v2/pkg/api"
  "github.com/atolycs/gh-get-private-email/pkg/config"
  "github.com/atolycs/gh-get-private-email/internal/version"
)

func main() {
  // fmt.Println("hi world, this is the gh-get-private-email extension!")
  version.CallVersion()
	
  client, err := api.DefaultRESTClient()
	if err != nil {
		fmt.Println(err)
		return
	}
	response := struct {Login string; Id int; }{}
	err = client.Get("user", &response)
	if err != nil {
		fmt.Println(err)
		return
	}

  account_id := strconv.Itoa(response.Id)
  account_name := response.Login

  email_templates := "@users.noreply.github.com"

  commit_address := account_id + "+" + account_name + email_templates

  fmt.Printf("%s\n", commit_address)

  fmt.Println("Setting commit address...")

  config.Userset(commit_address)

  fmt.Println("Setup complete")
	// fmt.Printf("running as %s\n", response.Login)
}

// For more examples of using go-gh, see:
// https://github.com/cli/go-gh/blob/trunk/example_gh_test.go

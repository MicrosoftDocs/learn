Let's talk about what we'll be creating. As mentioned previously, we'll create two projects: one for the program's core logic and another one to expose logic through a Web API. Imagine that you're now part of a team that's building an online bank system.

## Define the features and requirements

The online bank we're about to build is a proof of concept, which will determine how feasible it is to build the bank program. In this first iteration, the interaction with the core package will be through a CLI program. We won't have a user interface or persist data into a database. To see the account statement from a customer, we'll simply expose an endpoint.

The online bank system will:

- Enable customers to create an account.
- Enable customers to withdraw money.
- Enable customers to transfer money to another account.
- Provide an account statement with customer data and a final balance.
- Expose a Web API through an endpoint to print an account statement.

We'll build this together, so don't worry too much about the details for now.

## Create the initial project files

Let's create the initial set of files that we'll need for the program. We'll create a Go package for all the bank core logic and a `main` program to initialize the system with a few customers and actions like deposits and transfers. Additionally, this `main` program will start a Web API server to expose an endpoint for the account statement.

Let's create the following file structure in your `$GOPATH` directory:

```output
$GOPATH/
  src/
    bankcore/
      go.mod
      bank.go
    bankapi/
      go.mod
      main.go
```

Then, to make sure we can focus only on writing code in the proper files, let's start writing a `Hello World!` program that will confirm that we can call the `bankcore` package from the `bankapi` main program.

Copy and paste the following code snippet in `src/bankcore/bank.go`:

```go
package bank

func Hello() string {
    return "Hey! I'm working!"
}
```

We'll use Go modules. In `src/bankcore/go.mod`, add the following content to give this package a proper name so that we can reference it later:

```go
module github.com/msft/bank

go 1.14
```

Then add the following code to call the `bankcore` package in `src/bankapi/main.go`:

```go
package main

import (
    "fmt"

    "github.com/msft/bank"
)

func main() {
    fmt.Println(bank.Hello())
}
```

In `src/bankapi/go.mod`, we need to reference the `bankcore` package files locally, like this:

```go
module bankapi

go 1.14

require (
    github.com/msft/bank v0.0.1
)

replace github.com/msft/bank => ../bankcore
```

To make sure everything is working, go to the terminal in the `$GOPATH/src/bankapi/` directory and run the following command:

```sh
go run main.go
```

You should see the following output:

```output
Hey! I'm working!
```

This output confirms that your project files are set up exactly as they should be. Next, we'll start writing the code to implement the initial set of features for our online bank system.

Before we jump into writing our program, let's talk testing and create our first test. Package testing provides support for automated testing of Go packages.

Testing is important to ensure that code works as expected. Generally, there should be at least one test for each function in a package to confirm the functionality. A good practice to follow when coding is to use the Test Driven Development (TDD) approach. With this approach, we'll write our tests first, make sure they fail since the code they test doesn't yet exist, and then we'll write the code that satisfies that test.

## Create the test file

First, we need to create the Go file to put all of our tests for the `bankcore` package. To create a test file, the file's name has to finish with `_test.go`. You can put whatever you want before, but the pattern is to use the name of the file you're testing. Additionally, every test you want to write has to be a function that starts with `Test`, and then you usually write a descriptive name for the test you're writing like `TestDeposit`.

Head over to the `$GOPATH/src/bankcore/` location and create a file called `bank_test.go` with the following content:

```go
package bank

import "testing"

func TestAccount(t *testing.T) {

}
```

Open a terminal, and make sure at the `$GOPATH/src/bankcore/` location, then use the following command to run the tests in verbose mode:

```sh
go test -v
```

And Go will look for all the `*_test.go` files to run the tests, so you should see the following output:

```output
=== RUN   TestAccount
--- PASS: TestAccount (0.00s)
PASS
ok      github.com/msft/bank    0.391s
```

## Write a failing test

Using TDD, before writing any code, let's first write a failing test for it. Modify the `TestAccount` function with the following code:

```go
package bank

import "testing"

func TestAccount(t *testing.T) {
    account := Account{
        Customer: Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number:  1001,
        Balance: 0,
    }

    if account.Name == "" {
        t.Error("can't create an Account object")
    }
}
```

We introduce a struct for account and customer that we haven't yet implemented. And we're using the `t.Error()` function to say that the test will fail if something doesn't happen the way it supposes to happen.

Also, notice that the test has the logic to create an account object (that doesn't exist yet), but we're designing at this moment how we'd like to interact with our package. **You'll notice that we'll provide you with the code for the tests as we don't want to explain line by line, but your mental model should be that you start little by little and do as many iterations as you need.** In our case, we're going to do only one iteration, which is writing the test, make sure it fails, and write the code that satisfies that test. When coding on your own, you should start simple and add complexity as you progress.

When you run the `go test -v` command, you should see a failing test in the output:

```output
# github.com/msft/bank [github.com/msft/bank.test]
./bank_test.go:6:13: undefined: Account
FAIL    github.com/msft/bank [build failed]
```

Let's leave it here for now; we'll complete this test and create new tests as we write the logic for our online bank system.

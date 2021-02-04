Now that we have the base project running along with our tests file let's start writing the code that implements the previous section's features and requirements. We'll come back to a few topics we've discussed, like errors, structs, and methods.

Open the `$GOPATH/src/bankcore/bank.go` file, remove the `Hello()` function and let's start writing the core logic of our online bank system.

## Create structs for customers and accounts

Let's begin by creating a `Customer` struct where we'll have the name, address, and phone from a person who wants to become a bank customer. Also, we need a struct for the `Account` data and because a customer can have more than one account, let's embed the customer information into the account object. Basically, let's create what we defined in the `TestAccount` test.

The structs we need could look like the following:

```go
package bank

// Customer ...
type Customer struct {
    Name    string
    Address string
    Phone   string
}

// Account ...
type Account struct {
    Customer
    Number  int32
    Balance float64
}
```

When you run the `go test -v` command in your terminal now, you should see that the test is passing:

```output
=== RUN   TestAccount
--- PASS: TestAccount (0.00s)
PASS
ok      github.com/msft/bank    0.094s
```

This is passing because we have implemented the structs for *Customer* and *Account*. Now that we have the structs let's write the methods we use to add the features we need in the initial version of our bank, like deposit, withdraw, and transfer money.

## Implement the deposit method

We need to start with a method to allow adding money to our account, but before we do that, let's create the `TestDeposit` function in the `bank_test.go` file, like this:

```go
func TestDeposit(t *testing.T) {
    account := Account{
        Customer: Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number:  1001,
        Balance: 0,
    }

    account.Deposit(10)

    if account.Balance != 10 {
        t.Error("balance is not being updated after a deposit")
    }
}
```

When you run `go test -v`, you should see a failing test in the output:

```output
# github.com/msft/bank [github.com/msft/bank.test]
./bank_test.go:32:9: account.Deposit undefined (type Account has no field or method Deposit)
FAIL    github.com/msft/bank [build failed]
```

To satisfy the previous test, let's create a `Deposit` method to our `Account` struct that returns an error if the amount received is equal or lower to zero. Otherwise, simply add the amount received to the balance of the account.

Use the following code for the `Deposit` method:

```go
// Deposit ...
func (a *Account) Deposit(amount float64) error {
    if amount <= 0 {
        return errors.New("the amount to deposit should be greater than zero")
    }

    a.Balance += amount
    return nil
}
```

When you run `go test -v`, you should see that the test is passing:

```output
=== RUN   TestAccount
--- PASS: TestAccount (0.00s)
=== RUN   TestDeposit
--- PASS: TestDeposit (0.00s)
PASS
ok      github.com/msft/bank    0.193s
```

You could also write a test that confirms that you get an error when you try to deposit a negative amount, like this:

```go
func TestDepositInvalid(t *testing.T) {
    account := Account{
        Customer: Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number:  1001,
        Balance: 0,
    }

    if err := account.Deposit(-10); err == nil {
        t.Error("only positive numbers should be allowed to deposit")
    }
}
```

When you run the `go test -v` command, you should see that the test is passing:

```output
=== RUN   TestAccount
--- PASS: TestAccount (0.00s)
=== RUN   TestDeposit
--- PASS: TestDeposit (0.00s)
=== RUN   TestDepositInvalid
--- PASS: TestDepositInvalid (0.00s)
PASS
ok      github.com/msft/bank    0.197s
```

> [!NOTE]
> From here on, we'll write one test case for each method, but you should write as many tests as you feel comfortable with to your programs covering both expected and unexpected scenarios. For example, in this case, the error handling logic is tested.

## Implement the withdraw method

Before we write the withdraw functionality, let's write the test for it:

```go
func TestWithdraw(t *testing.T) {
    account := Account{
        Customer: Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number:  1001,
        Balance: 0,
    }

    account.Deposit(10)
    account.Withdraw(10)

    if account.Balance != 0 {
        t.Error("balance is not being updated after withdraw")
    }
}
```

When you run the `go test -v` command, you should see a failing test in the output:

```output
# github.com/msft/bank [github.com/msft/bank.test]
./bank_test.go:67:9: account.Withdraw undefined (type Account has no field or method Withdraw)
FAIL    github.com/msft/bank [build failed]
```

Let's implement the logic for the `Withdraw` method where we'll reduce the balance of the account by the amount we receive as a parameter. Like we did before, we need to validate the number we receive is greater than zero and that the balance in the account is enough.

Use the following code for the `Withdraw` method:

```go
// Withdraw ...
func (a *Account) Withdraw(amount float64) error {
    if amount <= 0 {
        return errors.New("the amount to withdraw should be greater than zero")
    }

    if a.Balance < amount {
        return errors.New("the amount to withdraw should be greater than the account's balance")
    }

    a.Balance -= amount
    return nil
}
```

When you run the `go test -v` command, you should see that the test is passing:

```output
=== RUN   TestAccount
--- PASS: TestAccount (0.00s)
=== RUN   TestDeposit
--- PASS: TestDeposit (0.00s)
=== RUN   TestDepositInvalid
--- PASS: TestDepositInvalid (0.00s)
=== RUN   TestWithdraw
--- PASS: TestWithdraw (0.00s)
PASS
ok      github.com/msft/bank    0.250s
```

## Implement the statement method

Let's write a simple method to print out the statement that includes the account name, number, and its balance. But first, let's create the `TestStatement` function, like this:

```go
func TestStatement(t *testing.T) {
    account := Account{
        Customer: Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number:  1001,
        Balance: 0,
    }

    account.Deposit(100)
    statement := account.Statement()
    if statement != "1001 - John - 100" {
        t.Error("statement doesn't have the proper format")
    }
}
```

When you run `go test -v`, you should see a failing test in the output:

```output
# github.com/msft/bank [github.com/msft/bank.test]
./bank_test.go:86:22: account.Statement undefined (type Account has no field or method Statement)
FAIL    github.com/msft/bank [build failed]
```

So let's write the `Statement` method which as you can see, it should return a simple string (you'll have to overwrite this method later as a challenge). Use the following code:

```go
// Statement ...
func (a *Account) Statement() string {
    return fmt.Sprintf("%v - %v - %v", a.Number, a.Name, a.Balance)
}
```

When you run `go test -v`, you should see that the test is passing:

```output
=== RUN   TestAccount
--- PASS: TestAccount (0.00s)
=== RUN   TestDeposit
--- PASS: TestDeposit (0.00s)
=== RUN   TestDepositInvalid
--- PASS: TestDepositInvalid (0.00s)
=== RUN   TestWithdraw
--- PASS: TestWithdraw (0.00s)
=== RUN   TestStatement
--- PASS: TestStatement (0.00s)
PASS
ok      github.com/msft/bank    0.328s
```

Let's move on to the next section to write the web API to expose the `Statement` method.

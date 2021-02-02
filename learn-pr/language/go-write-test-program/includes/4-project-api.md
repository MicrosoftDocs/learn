Now that we've built the online bank's core logic let's build a Web API to test it from a browser (or even the command line). For now, we'll not use a database to persist data, so we'll have to create a global variable to store all the accounts in memory. Additionally, we'll skip the testing part to avoid keeping this guide too long, but ideally you'll follow the same approach we followed when building the core package to write tests before code.

## Accounts in memory

As we said previously, we're not going to use a database to persist data. Instead, we'll use a memory map for the accounts we'll create when the program starts. Additionally, we'll use a map to access the account information using the account number.

Head over to the `$GOPATH/src/bankapi/main.go` file and add the following code to create the global `accounts` variable and initialize it with an account (something similar to what we did when creating the tests previously):

```go
package main

import (
    "github.com/msft/bank"
)

var accounts = map[float64]*bank.Account{}

func main() {
    accounts[1001] = &bank.Account{
        Customer: bank.Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number: 1001,
    }
}
```

Run the application with `go run main.go` to make sure you don't have any errors. For now, the program does nothing else, so let's add the logic to launch a Web API.

## Expose the statement method

Creating a Web API in Go is very easy, as you've seen before in a previous module. So, we'll continue using the `net/http` package and use the `HandleFunc` and `ListenAndServe` functions to expose endpoints and launch the server. The `HandleFunc` function requires a name for the URL path you'd like to expose and the name of a function with the logic for that endpoint.

Let's start by exposing the functionality to print out the statement for an account. You need to copy and paste the following function in `main.go`:

```go
func statement(w http.ResponseWriter, req *http.Request) {
    numberqs := req.URL.Query().Get("number")

    if numberqs == "" {
        fmt.Fprintf(w, "Account number is missing!")
        return
    }

    if number, err := strconv.ParseFloat(numberqs, 64); err != nil {
        fmt.Fprintf(w, "Invalid account number!")
    } else {
        account, ok := accounts[number]
        if !ok {
            fmt.Fprintf(w, "Account with number %v can't be found!", number)
        } else {
            fmt.Fprintf(w, account.Statement())
        }
    }
}
```

The first highlight from the `statement` function is that it's receiving the object to write a response back to the browser (`w http.ResponseWriter`) and the request object to access the information from the HTTP request (`req *http.Request`). Then, notice that we're using the `req.URL.Query().Get()` function to read a parameter from the query string. This will be the account number that we'll send through the HTTP call and then access the account map to get its information using that value. But because we're getting data from the user, we should include some validations to avoid a crash. Only when we know we have a valid account number, we make the call to the `Statement()` method and print out the string it returns to the browser (`fmt.Fprintf(w, account.Statement())`).

Now, you should modify your `main()` function so it looks like this:

```go
func main() {
    accounts[1001] = &bank.Account{
        Customer: bank.Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number: 1001,
    }

    http.HandleFunc("/statement", statement)
    log.Fatal(http.ListenAndServe("localhost:8000", nil))
}
```

When you run the program (`go run main.go`), if you don't see any error nor output, it means that it's working correctly. Now open a web browser the URL `http://localhost:8000/statement?number=1001` or run the following command:

```sh
curl http://localhost:8000/statement\?number=1001
```

You should see the following output:

```output
1001 - John - 0
```

## Expose the deposit method

Let's continue using the same approach to expose the deposit method. In this case, we'd like to add money to the account we have in memory. So every time we call the `Deposit()` method, the balance should increase.

Add a `deposit()` function in the main program that gets the account number from the query string, validates that the account exist in the `accounts` map, validates that the amount to deposit is a valid number, and then calls the `Deposit()` method, like this:

```go
func deposit(w http.ResponseWriter, req *http.Request) {
    numberqs := req.URL.Query().Get("number")
    amountqs := req.URL.Query().Get("amount")

    if numberqs == "" {
        fmt.Fprintf(w, "Account number is missing!")
        return
    }

    if number, err := strconv.ParseFloat(numberqs, 64); err != nil {
        fmt.Fprintf(w, "Invalid account number!")
    } else if amount, err := strconv.ParseFloat(amountqs, 64); err != nil {
        fmt.Fprintf(w, "Invalid amount number!")
    } else {
        account, ok := accounts[number]
        if !ok {
            fmt.Fprintf(w, "Account with number %v can't be found!", number)
        } else {
            err := account.Deposit(amount)
            if err != nil {
                fmt.Fprintf(w, "%v", err)
            } else {
                fmt.Fprintf(w, account.Statement())
            }
        }
    }
}
```

Notice that this function follows a similar approach to get and validate the data it receives from the user. We're also declaring and using variables directly in the `if` statement. Finally, after we add some funds to the account, we print out the statement to see the new account balance.

Now, you should expose a `/deposit` endpoint that calls the `deposit` function, like this `http.HandleFunc("/deposit", deposit)`. Modify your `main()` function to look like this:

```go
func main() {
    accounts[1001] = &bank.Account{
        Customer: bank.Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number: 1001,
    }

    http.HandleFunc("/statement", statement)
    http.HandleFunc("/deposit", deposit)
    log.Fatal(http.ListenAndServe("localhost:8000", nil))
}
```

When you run the program (`go run main.go`), if you don't see any error nor output, it means that it's working correctly. Now open a web browser the URL `http://localhost:8000/deposit?number=1001&amount=100` or run the following command:

```sh
curl http://localhost:8000/deposit\?number=1001&amount=100
```

You should see the following output:

```output
1001 - John - 100
```

If you make the same call several times, the account balance will continue to increase. Give it a try to confirm that the `accounts` map in memory is updated at runtime. Of course, if you stop the program, all the deposits you did get lost, but that's expected in this initial version.

## Expose the withdraw method

Finally, let's expose the method to withdraw money from an account. Again, let's first create the `withdraw` function in the main program that will validate the account number information, withdraw, and print out any error you receive from the core package. Add the following function to your main program:

```go
func withdraw(w http.ResponseWriter, req *http.Request) {
    numberqs := req.URL.Query().Get("number")
    amountqs := req.URL.Query().Get("amount")

    if numberqs == "" {
        fmt.Fprintf(w, "Account number is missing!")
        return
    }

    if number, err := strconv.ParseFloat(numberqs, 64); err != nil {
        fmt.Fprintf(w, "Invalid account number!")
    } else if amount, err := strconv.ParseFloat(amountqs, 64); err != nil {
        fmt.Fprintf(w, "Invalid amount number!")
    } else {
        account, ok := accounts[number]
        if !ok {
            fmt.Fprintf(w, "Account with number %v can't be found!", number)
        } else {
            err := account.Withdraw(amount)
            if err != nil {
                fmt.Fprintf(w, "%v", err)
            } else {
                fmt.Fprintf(w, account.Statement())
            }
        }
    }
}
```

And now add the `/withdraw` endpoint in the `main()` function to expose the logic you have in the `withdraw()` function. Modify the `main()` function to look like this:

```go
func main() {
    accounts[1001] = &bank.Account{
        Customer: bank.Customer{
            Name:    "John",
            Address: "Los Angeles, California",
            Phone:   "(555) 314 8947",
        },
        Number: 1001,
    }

    http.HandleFunc("/statement", statement)
    http.HandleFunc("/deposit", deposit)
    http.HandleFunc("/withdraw", withdraw)
    log.Fatal(http.ListenAndServe("localhost:8000", nil))
}
```

When you run the program (`go run main.go`), if you don't see any error nor output, it means that it's working correctly. Now open a web browser the URL `http://localhost:8000/withdraw?number=1001&amount=100` or run the following command:

```sh
curl http://localhost:8000/withdraw\?number=1001&amount=100
```

You should see the following output:

```output
the amount to withdraw should be greater than the account's balance
```

Notice that the error we're getting comes from the core package. When the program starts, the account balance is zero. Therefore, you can't withdraw any amount of money. Call the `/deposit` endpoint a few times to add funds, and call the `/withdraw` endpoint again to confirm that's working, like this:

```sh
curl http://localhost:8000/deposit\?number=1001&amount=100
curl http://localhost:8000/deposit\?number=1001&amount=100
curl http://localhost:8000/deposit\?number=1001&amount=100
curl http://localhost:8000/withdraw\?number=1001&amount=100
```

You should see the following output:

```output
1001 - John - 200
```

And that's it! You've created a Web API to expose functionality from a package you've built from scratch. Head over to the next section to continue practicing. This time you'll be presented with a challenge you will write your own solution for.

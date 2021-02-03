Here you can find one solution for the previous challenge.

## Store package

Here's the code for the store package:

```go
package store

import (
    "errors"
    "fmt"
)

type Account struct {
    FirstName string
    LastName  string
}

type Employee struct {
    Account
    Credits float64
}

func (a *Account) ChangeName(newname string) {
    a.FirstName = newname
}

func (e Employee) String() string {
    return fmt.Sprintf("Name: %s %s\nCredits: %.2f\n", e.FirstName, e.LastName, e.Credits)
}

func CreateEmployee(firstName, lastName string, credits float64) (*Employee, error) {
    return &Employee{Account{firstName, lastName}, credits}, nil
}

func (e *Employee) AddCredits(amount float64) (float64, error) {
    if amount > 0.0 {
        e.Credits += amount
        return e.Credits, nil
    }
    return 0.0, errors.New("Invalid credit amount.")
}

func (e *Employee) RemoveCredits(amount float64) (float64, error) {
    if amount > 0.0 {
        if amount <= e.Credits {
            e.Credits -= amount
            return e.Credits, nil
        }
        return 0.0, errors.New("You can't remove more credits that what the account has.")
    }
    return 0.0, errors.New("You can't remove negative numbers.")
}

func (e *Employee) CheckCredits() float64 {
    return e.Credits
}
```

And here's the code for the main program to test all the functionality:

```go
package main

import (
    "fmt"
    "store"
)

func main() {
    bruce, _ := store.CreateEmployee("Bruce", "Lee", 500)
    fmt.Println(bruce.CheckCredits())
    credits, err := bruce.AddCredits(250)
    if err != nil {
        fmt.Println("Error:", err)
    } else {
        fmt.Println("New Credits Balance = ", credits)
    }

    _, err = bruce.RemoveCredits(2500)
    if err != nil {
        fmt.Println("Can't withdraw or overdrawn!", err)
    }

    bruce.ChangeName("Mark")

    fmt.Println(bruce)
}
```

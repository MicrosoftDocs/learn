While you're writing your programs, you need to consider the various ways your programs can fail, and you need to manage failures. Your users don't need to see a long and confusing stack trace error. It's better if they see meaningful information about what went wrong. As you've seen, Go has built-in functions like `panic` and `recover` to manage exceptions, or unexpected behavior, in your programs. But errors are known failures that your programs should be built to handle.

Go's approach to error handling is simply a control-flow mechanism where only an `if` and a `return` statement are needed. For example, when you're calling a function to get information from an `employee` object, you might want to know if the employee exists. Go's opinionated way for handling such an expected error would look like this:

```go
employee, err := getInformation(1000)
if err != nil {
    // Something is wrong. Do something.
}
```

Notice how the `getInformation` function returns the `employee` struct and also an error as a second value. The error could be `nil`. If the error is `nil`, that means success. If it's not `nil`, that means failure. A non-`nil` error comes with an error message that you can either print or, preferably, log. This is how you handle errors in Go. We'll cover a few other strategies in the next section.

You'll probably notice that error handling in Go demands that you pay more attention to how you report and handle an error. That's exactly the point. Let's look at some other examples to help you better understand Go's approach to error handling.

We'll use the code snippet that we used for structs to practice various error handling strategies:

```go
package main

import (
    "fmt"
    "os"
)

type Employee struct {
    ID        int
    FirstName string
    LastName  string
    Address   string
}

func main() {
    employee, err := getInformation(1001)
    if err != nil {
        // Something is wrong. Do something.
    } else {
        fmt.Print(employee)
    }
}

func getInformation(id int) (*Employee, error) {
    employee, err := apiCallEmployee(1000)
    return employee, err
}

func apiCallEmployee(id int) (*Employee, error) {
    employee := Employee{LastName: "Doe", FirstName: "John"}
    return &employee, nil
}
```

From here on, we'll focus on modifying the `getInformation`, `apiCallEmployee`, and `main` functions to show how to handle errors.

## Error handling strategies

When a function returns an error, it's usually going to be the last return value. It's the caller's responsibility to check if an error exists and handle it, as you saw in the previous section. So a common strategy is to continue using that pattern to propagate the error in a subroutine. For example, a subroutine (like `getInformation` in the previous example) could return the error to the caller without doing anything else, like this:

```go
func getInformation(id int) (*Employee, error) {
    employee, err := apiCallEmployee(1000)
    if err != nil {
        return nil, err // Simply return the error to the caller.
    }
    return employee, nil
}
```

You might also want to include more information before propagating the error. For that purpose, you could use the `fmt.Errorf()` function, which is similar to what we've seen before, but it returns an error. For example, you could add more context to the error and still return the original error, like this:

```go
func getInformation(id int) (*Employee, error) {
    employee, err := apiCallEmployee(1000)
    if err != nil {
        return nil, fmt.Errorf("Got an error when getting the employee information: %v", err)
    }
    return employee, nil
}
```

Another strategy is to run retry logic when errors are transient. For example, you could use a retry policy to call a function three times and wait for two seconds, like this:

```go
func getInformation(id int) (*Employee, error) {
    for tries := 0; tries < 3; tries++ {
        employee, err := apiCallEmployee(1000)
        if err == nil {
            return employee, nil
        }

        fmt.Println("Server is not responding, retrying ...")
        time.Sleep(time.Second * 2)
    }

    return nil, fmt.Errorf("server has failed to respond to get the employee information")
}
```

Finally, instead of printing errors to the console, you could log errors and hide any implementation details from end users. We'll cover logging in the next module. For now, let's look at how you can create and use custom errors.

## Create reusable errors

Sometimes the number of error messages increases and you want to maintain order. Or you might want to create a library for common error messages that you want to reuse. In Go, you can use the `errors.New()` function to create errors and reuse them in several parts, like this:

```go
var ErrNotFound = errors.New("Employee not found!")

func getInformation(id int) (*Employee, error) {
    if id != 1001 {
        return nil, ErrNotFound
    }

    employee := Employee{LastName: "Doe", FirstName: "John"}
    return &employee, nil
}
```

The code for the `getInformation` function looks better, and if you need to change the error message, you do it in only one place. Also, notice that the convention is to include the `Err` prefix for error variables.

Finally, when you have an error variable, you could be more specific when you're handling an error in a caller function. The `errors.Is()` function allows you to compare the type of error you're getting, like this:

```go
employee, err := getInformation(1000)
if errors.Is(err, ErrNotFound) {
    fmt.Printf("NOT FOUND: %v\n", err)
} else {
    fmt.Print(employee)
}
```

## Recommended practices for error handling

When you're handling errors in Go, here are some recommended practices to keep in mind:

- Always check for errors, even if you don't expect them. Then handle them properly to avoid exposing unnecessary information to end users.
- Include a prefix in an error message so you know the origin of the error. For example, you could include the name of the package and function.
- Create reusable error variables as much as you can.
- Understand the difference between using returning errors and panicking. Panic when there's nothing else you can do. For example, if a dependency isn't ready, it doesn't make sense for the program to work (unless you want to run a default behavior).
- Log errors with as many details as possible (we'll cover how in the next section) and print out errors that an end user can understand.

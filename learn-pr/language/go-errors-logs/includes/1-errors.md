While you're writing your programs, you need to consider the different ways your programs can fail and manage it. Your users don't need to see a long and confusing stack trace error. It's better if they see meaningful information about what went wrong. As we've seen before, Go has built-in functions like `panic` and `recover` to manage exceptions, or unexpected behavior, in your programs. But errors are known failures that your programs should be built to expect.

Go's approach for error handling is simply a control-flow mechanism where only an `if` and `return` statement is needed. For instance, when you're calling a function to get information from an employee, you might want to know if the employee exists or not. Go's opinionated way for handling such expected error would be like this:

```go
employee, err := getInformation(1000)
if err != nil {
    // Something is wrong, do something
}
```

Notice how the `getInformation` function is returning the employee struct and returns an error as a second value (the error) that could be `nil`. An error could be `nil`, which implies **success**, and could be `non-nil`, which means **failure**. A non-nil error comes with an error message that you could either print or log (preferably). This is how you handle errors in Go, and we'll cover a few other strategies in the next section.

Undoubtedly, you'll notice that error handling in Go demands to pay more attention to how you report and handle an error, but that's precisely the point. So, let's see other examples to better understand Go's approach to error handling.

Let's use the following code snippet we used for structs to practice the different error handling strategies:

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
        // Something is wrong, do something
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

When a function returns an error, usually, it's going to be the last return value, and it's the caller's responsibility to check if an error exists and handle it–as you've seen in the previous section. Therefore, a common strategy is to continue using that pattern to propagate the error in a subroutine. For instance, a subroutine (like the `getInformation` from the previous example) could return the error to the caller without doing anything else, like this:

```go
func getInformation(id int) (*Employee, error) {
    employee, err := apiCallEmployee(1000)
    if err != nil {
        return nil, err // simply return the error to the caller
    }
    return employee, nil
}
```

You might also want to include more information before propagating the error, and for that, you could use the `fmt.Errorf()` function, which is similar to what we've seen before, but it returns an error. For instance, you could add more context to the error and still return the original error, like this:

```go
func getInformation(id int) (*Employee, error) {
    employee, err := apiCallEmployee(1000)
    if err != nil {
        return nil, fmt.Errorf("Got an error when getting the employee information: %v", err)
    }
    return employee, nil
}
```

Another strategy is to perform a retry logic when errors are transient. For instance, you could have a simple retry policy to call a function three times and wait for two seconds, like this:

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

Lastly, instead of printing to the console the errors, we could log errors and hide any implementation details to the end user. We'll cover logging in the next module. For now, let's see how you can create and use custom errors.

## Creating reusable errors

There are times where the number of error messages increases, and you'd like to maintain order. Or you simply want to create a library for common error messages that you'd like to reuse. In Go, you can make use of the `errors.New()` function to create errors and reuse them in several parts, like this:

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

The code from the `getInformation` function looks better, and if you need to change the error message, you do it in one place only. Also, notice that the convention is to include the `Err` prefix for error variables.

Lastly, when you have an error variable, you could be more specific when you're handling an error in a caller function. The `errors.Is()` function allows you to compare the type of error you're getting, like this:

```go
employee, err := getInformation(1000)
if errors.Is(err, ErrNotFound) {
    fmt.Printf("NOT FOUND: %v\n", err)
} else {
    fmt.Print(employee)
}
```

## Best practices for error handling

When you're handling errors in Go, the following is a list of recommended practices you should keep in mind:

- Always check for errors even if you don't expect them. Then, handle them properly to avoid exposing unnecessary information to the end user.
- Include a prefix in the error message to know where the error is originating from. For instance, the name of the package and function.
- Create reusable error variables as much as possible.
- Understand the difference between using returning errors and panicking. Panic when there's nothing else you could do. For instance, if any dependency is not ready, it doesn't make sense for the program to work (unless you want to have a default behavior).
- Log errors with as many details as possible (we'll cover how in the next section) and print out errors that an end user can understand.

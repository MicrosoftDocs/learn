To close this module, we're going to cover less common control flows in Go: `defer`, `panic`, and `recover`. As we've said since the beginning, Go is idiomatic in several aspects, and these three functions are the proof of that. There are several use cases for each of these functions, but we'll only cover the most important ones while we explain them.

Let's get started with the first function.

## Defer function

A `defer` statement in Go defers the execution of a function (including any parameters) when the function that contains the defer statement finishes. In other words, you'd typically defer functions when you don't want to forget about things like closing a file or run a cleanup process. You can defer as many functions as you want, but they will be executed in the reverse order in which they were deferred.

Let's see how this works with an example; use the following code:

```go
package main

import "fmt"

func main() {
    for i := 1; i <= 4; i++ {
        defer fmt.Println("deferred", -i)
        fmt.Println("regular", i)
    }
}
```

When you run the above code, the output is the following one:

```output
regular 1
regular 2
regular 3
regular 4
deferred -4
deferred -3
deferred -2
deferred -1
```

From the previous example, notice how every time the `fmt.Println("deferred", -i)` was deferred, the value for `i` was stored, and its execution was added to a queue. When the `main()` function finished printing the "regular" values, all the deferred calls were executed. That's why you see the output in reverse order (last-in-first-out).

A typical application for the `defer` function is to close a file when you're done using it, like this:

```go
package main

import (
    "io"
    "os"
)

func main() {
    f, err := os.Create("notes.txt")
    if err != nil {
        return
    }
    defer f.Close()

    if _, err = io.WriteString(f, "Learning Go!"); err != nil {
        return
    }

    f.Sync()
}
```

Right after you create or open a file, you defer the `f.Close()` function to avoid forgetting to close the file after writing something into it.

## Panic function

When there are runtime errors, a Go program panics. You can force a program to panic, but this could also happen due to other runtime errors like out-of-bounds array access or nil pointer dereferences. The built-in `panic()` function stops the normal flow of control, and all the deferred function calls are executed typically. The process continues up the stack until all functions have returned. The program then crashes with a log message, including any error message and a stack trace to help diagnose the problem's root cause.

When you call the `panic()` function, you can add any value as an argument. Usually, you send the error message of why you're panicking.

For instance, let's combine the `panic` and `defer` functions to see how the control flow is interrupted, but continue running any "clean up" processes. Use the following code snippet:

```go
package main

import "fmt"

func main() {
    g(0)
    fmt.Println("Program finished successfully!")
}

func g(i int) {
    if i > 3 {
        fmt.Println("Panicking!")
        panic("Panic in g() (major)")
    }
    defer fmt.Println("Defer in g()", i)
    fmt.Println("Printing in g()", i)
    g(i + 1)
}
```

When you run the above code, the output looks like this:

```output
Printing in g() 0
Printing in g() 1
Printing in g() 2
Printing in g() 3
Panicking!
Defer in g() 3
Defer in g() 2
Defer in g() 1
Defer in g() 0
panic: Panic in g() (major)

goroutine 1 [running]:
main.g(0x4)
        /Users/johndoe/go/src/helloworld/main.go:13 +0x22e
main.g(0x3)
        /Users/johndoe/go/src/helloworld/main.go:17 +0x17a
main.g(0x2)
        /Users/johndoe/go/src/helloworld/main.go:17 +0x17a
main.g(0x1)
        /Users/johndoe/go/src/helloworld/main.go:17 +0x17a
main.g(0x0)
        /Users/johndoe/go/src/helloworld/main.go:17 +0x17a
main.main()
        /Users/johndoe/go/src/helloworld/main.go:6 +0x2a
exit status 2
```

First, everything runs normally, and the program prints the value that the function `g()` receives. When this value is equal to 3, it panics, and you see the `Panicking!` message. At this point, the control flow is interrupted, and all the deferred functions start to print the `Defer in g()` message. As a final step, the program crashes, and you see the full stack trace. Therefore, you don't see the `Program finished successfully!` message.

A call to `panic()` is usually executed when grave errors are not expected. If you want to avoid a program crash, you could use the `recover()` function, which we'll explore in the next section.

## Recover function

There are times where you'd like to avoid the program to crash and report the error internally. Or, perhaps you simply want to clean up the mess before letting the program crash. For instance, you might want to close any connection to a resource to avoid more problems. Go provides the built-in function `recover()` to regain control after panic has occurred. However, you can only use this function in a deferred function. If you call the `recover()` function, it returns `nil` and has no other effect in normal execution.

Let's modify our previous code to add a call to the `recover()` function, like this:

```go
package main

import "fmt"

func main() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("Recovered in main", r)
        }
    }()
    g(0)
    fmt.Println("Program finished successfully!")
}

func g(i int) {
    if i > 3 {
        fmt.Println("Panicking!")
        panic("Panic in g() (major)")
    }
    defer fmt.Println("Defer in g()", i)
    fmt.Println("Printing in g()", i)
    g(i + 1)
}
```

Run the program, and the output should look like this:

```output
Printing in g() 0
Printing in g() 1
Printing in g() 2
Printing in g() 3
Panicking!
Defer in g() 3
Defer in g() 2
Defer in g() 1
Defer in g() 0
Recovered in main Panic in g() (major)
```

Do you see the difference from the previous version? Well, the main difference is that you no longer see the stack trace error. In the `main()` function we're deferring an anonymous function where we call the `recover()` function. If the call to `recover()` doesn't return a `nil` it's because the program is panicking. Therefore, we can do something here to clean up the mess, but we're simply printing out something in our case.

The combination of `panic` and `recover` is the idiomatic way of Go to handle exceptions. You have the `try/catch` block in other programming languages, but Go prefers to follow the approach we've covered in this section. If you want to read more about this topic, check out the [proposal to have a built-in `try` function](https://go.googlesource.com/proposal/+/master/design/32437-try-builtin.md).

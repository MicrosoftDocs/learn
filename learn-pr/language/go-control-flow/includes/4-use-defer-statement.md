Now consider some less-common control flows in Go: `defer`, `panic`, and `recover`. As you've already seen, Go is idiomatic in several ways, and these three control flows are ones that are unique to Go.

Each of these functions has several use cases. You'll explore the most important use cases here. Let's get started with the first function.

## Defer function

In Go, a `defer` statement postpones the running of a function (including any parameters) until the function that contains the `defer` statement finishes. Generally, you defer a function when you want to avoid forgetting about tasks like closing a file or running a cleanup process. 

You can defer as many functions as you want. The defer statements run in reverse order, from last to first.

Check out how this pattern works by running the follow example code:

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

Here's the code output:

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

In this example, notice that every time `fmt.Println("deferred", -i)` was deferred, the value for `i` was stored, and its run task was added to a queue. After the `main()` function finished printing the `regular` values, all the deferred calls ran. That's why you see the output in reverse order (last in, first out).

A typical use case for the `defer` function is to close a file when you finish using it. Here's an example:

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

After you create or open a file, you defer the `f.Close()` function to avoid forgetting to close the file after you write something into it.

## Panic function

Runtime errors make a Go program panic. You can force a program to panic, but a panic can also result from runtime errors like out-of-bounds array access and nil pointer dereferences. 

The built-in `panic()` function stops the normal flow of control. All the deferred function calls run normally. The process continues up the stack until all functions return. The program then crashes with a log message. The message includes any error and a stack trace to help you diagnose the problem's root cause.

When you call the `panic()` function, you can add any value as an argument. Usually, you send an error message about why you're panicking.

For instance, combine the `panic` and `defer` functions to see how the control flow is interrupted. But continue running any cleanup processes. Use the following code snippet:

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

When you run the code, the output looks like this:

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

Here's what happens when the code runs: 

1. Everything runs normally. The program prints the value that the function `g()` receives. 

1. When `i` is greater than 3, the program panics. You see the `Panicking!` message. At this point, the control flow is interrupted, and all the deferred functions start to print the `Defer in g()` message. 

1. The program crashes, and you see the full stack trace. You don't see the `Program finished successfully!` message.

A call to `panic()` usually runs when grave errors aren't expected. To avoid a program crash, you can use the `recover()` function. You'll learn about this function in the next section.

## Recover function

Sometimes you might want to avoid a program crash and instead report the error internally. Or perhaps you want to clean up the mess before letting the program crash. For instance, you might want to close any connection to a resource to avoid more problems. 

Go provides the built-in function `recover()` to allow you to regain control after a panic. You can use this function only in a deferred function. If you call the `recover()` function, it returns `nil` and has no other effect in normal running.

Try modifying the previous code to add a call to the `recover()` function, like this:

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

When you run the program, the output should look like this:

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

Do you see the difference from the previous version? The main difference is that you no longer see the stack trace error. 

In the `main()` function, you defer an anonymous function where you call the `recover()` function. A call to `recover()` fails to return `nil` when the program is panicking. You can do something here to clean up the mess, but in this case you're simply printing something.

The combination of `panic` and `recover` is the idiomatic way that Go handles exceptions. Other programming languages use the `try/catch` block. Go prefers the approach you explored here. 

For more information, check out the [proposal to add a built-in `try` function in Go](https://go.googlesource.com/proposal/+/master/design/32437-try-builtin.md?azure-portal=true).

Now let's look at some control flows that are unique to Go: `defer`, `panic`, and `recover`. Each of these functions has several use cases. We'll explore the most important use cases here.

## Defer function

In Go, a `defer` statement postpones the running of a function (including any parameters) until the function that contains the `defer` statement finishes. Generally, you defer a function when you want to avoid forgetting about tasks like closing a file or running a cleanup process.

You can defer as many functions as you want. The `defer` statements run in reverse order, from last to first.

Check out how this pattern works by running the following example code:

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

In this example, notice that every time `fmt.Println("deferred", -i)` was deferred, the value for `i` was stored, and the function call was added to a queue. After the `main()` function finished printing the `regular` values, all the deferred calls ran. Notice the output from the deferred calls is in reverse order (last in, first out), as they're popped off of the queue.

A typical use case for the `defer` function is to close a file after you finish using it. Here's an example:

```go
package main

import (
    "io"
    "os"
    "fmt"
)

func main() {
    newfile, error := os.Create("learnGo.txt")
    if error != nil {
        fmt.Println("Error: Could not create file.")
        return
    }
    defer newfile.Close()

    if _, error = io.WriteString(newfile, "Learning Go!"); error != nil {
	    fmt.Println("Error: Could not write to file.")
        return
    }

    newfile.Sync()
}
```

After you create or open a file, you defer the `.Close()` function to avoid forgetting to close the file after you're done.


## Panic function

Runtime errors make a Go program panic, such as attempting to access an array by using an out-of-bounds index or dereferencing a nil pointer. You can also force a program to panic.

The built-in `panic()` function stops the normal flow of control in a Go program. When you use a `panic` call, any deferred function calls run normally. The process continues up the stack until all functions return. The program then crashes with a log message. The message includes any error information and a stack trace to help you diagnose the problem's root cause.

When you call the `panic()` function, you can add any value as an argument. Usually, you send an error message about why you're panicking.

For instance, the following code combines the `panic` and `defer` functions. Try running this code to see how the control flow is interrupted. Notice that the clean-up processes still run.

```go
package main

import "fmt"

func highlow(high int, low int) {
    if high < low {
        fmt.Println("Panic!")
        panic("highlow() low greater than high")
    }
    defer fmt.Println("Deferred: highlow(", high, ",", low, ")")
    fmt.Println("Call: highlow(", high, ",", low, ")")

    highlow(high, low + 1)
}

func main() {
    highlow(2, 0)
    fmt.Println("Program finished successfully!")
}
```

Here's the output:

```output
Call: highlow( 2 , 0 )
Call: highlow( 2 , 1 )
Call: highlow( 2 , 2 )
Panic!
Deferred: highlow( 2 , 2 )
Deferred: highlow( 2 , 1 )
Deferred: highlow( 2 , 0 )
panic: highlow() low greater than high

goroutine 1 [running]:
main.highlow(0x2, 0x3)
	/tmp/sandbox/prog.go:13 +0x34c
main.highlow(0x2, 0x2)
	/tmp/sandbox/prog.go:18 +0x298
main.highlow(0x2, 0x1)
	/tmp/sandbox/prog.go:18 +0x298
main.highlow(0x2, 0x0)
	/tmp/sandbox/prog.go:18 +0x298
main.main()
	/tmp/sandbox/prog.go:6 +0x37

Program exited: status 2.
```

Here's what happens when the code runs: 

1. Everything runs normally. The program prints the high and low values passed into the `highlow()` function. 

1. When the value of `low` is greater than the value of `high`, the program panics. You see the `Panic!` message. At this point, the control flow is interrupted, and all the deferred functions start to print the `Deferred...` message. 

1. The program crashes, and you see the full stack trace. You don't see the `Program finished successfully!` message.

A call to the `panic()` function usually runs when grave errors aren't expected. To avoid a program crash, you can use another function named `recover()`.


## Recover function

Sometimes you might want to avoid a program crash and instead report the error internally. Or perhaps you want to clean up the mess before letting the program crash. For instance, you might want to close any connection to a resource to avoid more problems.

Go provides the built-in `recover()` function to allow you to regain control after a panic. You only call `recover` in a function where you're also calling `defer`. If you call the `recover()` function, it returns `nil` and has no other effect in normal running.

Try modifying the `main` function in the previous code to add a call to the `recover()` function, like this:

```go
func main() {
    defer func() {
	handler := recover()
        if handler != nil {
            fmt.Println("main(): recover", handler)
        }
    }()

    highlow(2, 0)
    fmt.Println("Program finished successfully!")
}
```

When you run the program, the output should look like this:

```output
Call: highlow( 2 , 0 )
Call: highlow( 2 , 1 )
Call: highlow( 2 , 2 )
Panic!
Deferred: highlow( 2 , 2 )
Deferred: highlow( 2 , 1 )
Deferred: highlow( 2 , 0 )
main(): recover from panic highlow() low greater than high

Program exited.
```

Do you see the difference from the previous version? The main difference is that you no longer see the stack trace error. 

In the `main()` function, you defer an anonymous function where you call the `recover()` function. A call to `recover()` fails to return `nil` when the program is panicking. You can do something here to clean up the mess, but in this example, you simply print something.

The combination of the `panic` and `recover` functions is the idiomatic way that Go handles exceptions. Other programming languages use the `try/catch` block. Go prefers the approach you explored here. 

For more information, check out the [proposal to add a built-in `try` function in Go](https://go.googlesource.com/proposal/+/master/design/32437-try-builtin.md?azure-portal=true).

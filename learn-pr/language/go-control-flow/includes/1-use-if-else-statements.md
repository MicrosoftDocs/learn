The most basic control flow in any programming language is the `if/else` statement. In Go, `if/else` statements are straightforward. But you need to understand a few differences before you start feeling comfortable writing Go programs.

Let's take a look at the Go syntax for `if` statements.

## Syntax for if statements

Unlike other programming languages, in Go, you *don't need parentheses in conditions*. The `else` clause is optional. But braces are still required. Moreover, Go doesn't offer support for [ternary `if` statements](http://en.wikipedia.org/wiki/%3F:?azure-portal=true) to reduce lines, so you need to write the full `if` statement every time.

Here's a basic example of an `if` statement:

```go
package main

import "fmt"

func main() {
    x := 27
    if x%2 == 0 {
        fmt.Println(x, "is even")
    }
}
```

In Visual Studio Code, if your Go syntax includes parentheses in conditions, the parentheses are automatically removed when you save your program.

## Compound if statements

Go supports compound `if` statements. You can nest statements by using the `else if` statement. Here's an example:

```go
package main

import "fmt"

func givemeanumber() int {
    return -1
}

func main() {
    if num := givemeanumber(); num < 0 {
        fmt.Println(num, "is negative")
    } else if num < 10 {
        fmt.Println(num, "has only one digit")
    } else {
        fmt.Println(num, "has multiple digits")
    }
}
```

In this code, notice that the `num` variable stores the value returned from the `givemeanumber()` function, and the variable *is available in all `if` branches*. However, if you try to print the value of the `num` variable outside the `if` block, you'll get an error like this:

```go
package main

import "fmt"

func somenumber() int {
    return -7
}
func main() {
    if num := somenumber(); num < 0 {
        fmt.Println(num, "is negative")
    } else if num < 10 {
        fmt.Println(num, "has 1 digit")
    } else {
        fmt.Println(num, "has multiple digits")
    }

    fmt.Println(num)
}
```

When you run the program, the error output looks like this:

```output
# command-line-arguments
./main.go:17:14: undefined: num
```

In Go, declaring variables within `if` blocks is idiomatic, meaning that it is a way to program effectively using a convention that is common in Go.

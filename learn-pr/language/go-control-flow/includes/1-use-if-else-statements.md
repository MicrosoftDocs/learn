The most basic control flow in any programming language is the `if/else` statement. In Go, these statements are pretty straightforward. However, there are a few nuances that you need to know before you start getting to feel comfortable writing Go programs.

Let's see how the syntax in Go looks like for `if` statements.

## If statement syntax

Unlike other programming languages, in Go, you **don't need parentheses in conditions**, and the `else` clause is optional. However, braces are still required. Moreover, Go doesn't offer support for [ternary if statements](http://en.wikipedia.org/wiki/%3F:) to reduce lines, so you need to write the full `if` statement every time.

A basic example of an `if` statement looks like this

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

When you're using VS Code, if you forget that in Go, you omit the parentheses in conditions; when you save your program VS Code removes them automatically.

## Compound If statements

When you need to write more complex `if` statements, Go has support to compound `if` statements. You can nest statements using the `else if` statement, like this:

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

Notice how in the above code, the `num` variable stores the value returned from the `givemeanumber()` function **is available in all `if` branches**. However, if you try to print the value of the `num` variable outside of the `if` block, you'll get an error like this:

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

Declaring variables within `if` blocks are very idiomatic in Go.

Another common control flow is a loop. Go uses only one looping construct, and that's a `for` loop. But you can represent loops in more than one way. In this part, you'll learn about the loop patterns that Go supports.

## Basic for loop syntax 

Like `if` statements and `switch` statements, `for` loop expressions don't require parentheses. But braces are required.

Semicolons (`;`) separate the three components of `for` loops:

- An initial statement that's executed before the first iteration (optional).
- A condition expression that's evaluated before every iteration. The loop stops when this condition is `false`.
- A poststatement that's executed at the end of every iteration (optional).

As you can see, the `for` loop in Go is similar to the `for` loop in programming languages like C, Java, and C#.

In its simplest form, a `for` loop in Go looks like this:

```go
func main() {
    sum := 0
    for i := 1; i <= 100; i++ {
        sum += i
    }
    fmt.Println("sum of 1..100 is", sum)
}
```

Let's see how else you can write loops in Go.

## Empty prestatements and poststatements

In some programming languages, you use the `while` keyword to write loop patterns where only the condition expression is required. Go has no `while` keyword. But you can use a `for` loop instead. This provision makes prestatements and poststatements optional.

Use the following code snippet to confirm that you can use the `for` loop without using prestatements and poststatements.

```go
package main

import (
    "fmt"
    "math/rand"
    "time"
)

func main() {
    var num int64
    rand.Seed(time.Now().Unix())
    for num != 5 {
        num = rand.Int63n(15)
        fmt.Println(num)
    }
}
```

As long as the `num` variable holds a value different than `5`, the program prints a random number.

## Infinite loops and break statements

Another loop pattern you can write in Go is the infinite loop. In this case, you don't write a condition expression or a prestatement or poststatement. Instead, you write your way out of the loop. Otherwise, the logic will never exit. To make the logic exit a loop, use the `break` keyword.

To write a proper infinite loop, follow the `for` keyword with braces, like this:

```go
package main

import (
    "fmt"
    "math/rand"
    "time"
)

func main() {
    var num int32
    sec := time.Now().Unix()
    rand.Seed(sec)

    for {
        fmt.Print("Writting inside the loop...")
        if num = rand.Int31n(10); num == 5 {
            fmt.Println("finish!")
            break
        }
        fmt.Println(num)
    }
}
```

Every time you run this code, you get a different output.

## Continue statements

In Go, you can use the `continue` keyword to skip the current iteration of a loop. You can use this keyword, for example, to run a validation before the loop continues. Or use it when you're writing an infinite loop and need to wait for a resource to become available.

This example uses the `continue` keyword:

```go
package main

import "fmt"

func main() {
    sum := 0
    for num := 1; num <= 100; num++ {
        if num%5 == 0 {
            continue
        }
        sum += num
    }
    fmt.Println("The sum of 1 to 100, but excluding numbers divisible by 5, is", sum)
}
```

This example has a for loop that iterates from 1 to 100, adding the current number to the sum in each iteration. Every number divisible by 5 is skipped in the current iteration of the loop, and not added to the sum.

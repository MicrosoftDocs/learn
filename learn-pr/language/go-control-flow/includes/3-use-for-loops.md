Another common control flow is a loop. Go uses only one looping construct, and that's a `for` loop. But you have more than one way to represent loops. In this part, you'll learn that even though Go has only one keyword for loops, Go supports multiple loop patterns.

## `For` loop basic syntax

Similar to the `if` and `switch` statements, in `for` loops statements, you don't need to use parenthesis for the expressions, but the braces are required.

There are three components in the `for` loop that are separated by semicolons (`;`):

- An initial statement that is executed before the first iteration (optional)
- A condition expression that is evaluated before every iteration (the loop stops when this is `false`)
- A post statement that is executed at the end of every iteration (optional)

As you can see, the above is very similar to a `for` loop in other programming languages like C, Java, or C#.

So, at its simplest form, a for loop in Go looks like this:

```go
func main() {
    sum := 0
    for i := 1; i <= 100; i++ {
        sum += i
    }
    fmt.Println("sum of 1..100 is", sum)
}
```

Let's see what else we can do to write loops in Go.

## Empty prestatements and poststatements (`while` loops)

In some programming languages, you use the `while` keyword to write loop patterns where only the condition expression is required. Go has no `while` keyword, but you can use a `for` loop instead. This provision makes the prestatments and poststatements optional.

Use the following code snippet to confirm that you can use the `for` loop without prestatments and poststatements.

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

## Infinite loop and `break` statements

Another loop pattern you can write in Go is the infinite loop. In this case, you don't write a condition expression or a prestatement or poststatement. Instead, you write your way out of the loop; otherwise, the logic will never exit. To make the logic exit a loop, you use the `break` keyword.

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

## Continue statement

Lastly, in Go, you also have the `continue` keyword available to skip the current iteration for the loop. You might find useful this keyword when you need to run a validation before continuing with the loop. Perhaps you're writing an infinite loop, and you're waiting for a resource to become available.

Here's a simple example of using the `continue` keyword:

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

The above excludes simply excludes numbers divisible by 5.

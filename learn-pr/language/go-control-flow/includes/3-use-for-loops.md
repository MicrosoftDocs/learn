Another common control flow is a loop. In Go, there's only one looping construct, and that is a `for` loop. However, this doesn't mean that you only have one way of representing loops. In this section, you'll learn that even though Go has only one keyword for loops, Go supports different loop patterns.

## For loop basic syntax

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

## Empty pre and post statements (while loops)

In other programming languages, you have the `while` keyword available to write different loop patterns where only the condition expression is required. In Go, there is no `while` keyword, but a `for` loop can be used instead. This is why the pre and post statements are optional, as you learned in the previous section.

Use the following code snippet to confirm that you can use the `for` loop without pre and post statements:

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

As long as the `num` variable holds a value different than 5, the program will print out a random number.

## Infinite loop and break statements

Another loop pattern that is possible to write in Go are infinite loops. In this case, you don't write a condition expression, nor a pre or post statement. Therefore, you need to write a way out of the loop; otherwise, the program will never exit. To exit a loop, you use the `break` keyword.

So, to write a proper infinite loop, you simply write the `for` keyword followed immediately by braces, like this:

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

Every time you run the above code, you get a different output.

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

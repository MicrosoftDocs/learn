Like other programming languages, Go supports `switch` statements. You use `switch` statements to avoid chaining multiple `if` statements. By using `switch` statements, you avoid the difficulty of maintaining and reading code that includes many `if` statements. These statements also make complicated conditions easier to construct. Take a look at `switch` statements in the following sections.

## Basic switch syntax

Like the `if` statement, the `switch` condition doesn't require parentheses. In its simplest form, a `switch` statement looks like this:

```go
package main

import (
    "fmt"
    "math/rand"
    "time"
)

func main() {
    sec := time.Now().Unix()
    rand.Seed(sec)
    i := rand.Int31n(10)

    switch i {
    case 0:
        fmt.Print("zero...")
    case 1:
        fmt.Print("one...")
    case 2:
        fmt.Print("two...")
    }

    fmt.Println("ok")
}
```

If you run the preceding code several times, you'll see a different output every time. (But if you run the code in the Go Playground, you'll get the same result every time. That's one of the service's limitations.)

Go compares each case of the `switch` statement until it finds a match for the condition. But notice that the previous code doesn't cover all possible cases of `num` variable values. If `num` ends up being `5`, the program output is `ok`.

You can also be more specific about the default use case and include it like this:

```go
switch i {
case 0:
    fmt.Print("zero...")
case 1:
    fmt.Print("one...")
case 2:
    fmt.Print("two...")
default:
    fmt.Print("no match...")
}
```

Notice that for the `default` case, you don't write a validating expression. The value of the `i` variable is validated against the `case` statements, and the `default` case handles any unvalidated values.

## Use multiple expressions

Occasionally, more than one expression matches only one `case` statement. In Go, if you want a `case` statement to include more than one expression, separate the expressions by using commas (`,`). This technique allows you to avoid duplicate code.

The following code sample shows how to include multiple expressions.

```go
package main

import "fmt"

func location(city string) (string, string) {
    var region string
    var continent string
    switch city {
    case "Delhi", "Hyderabad", "Mumbai", "Chennai", "Kochi":
        region, continent = "India", "Asia"
    case "Lafayette", "Louisville", "Boulder":
        region, continent = "Colorado", "USA"
    case "Irvine", "Los Angeles", "San Diego":
        region, continent = "California", "USA"
    default:
        region, continent = "Unknown", "Unknown"
    }
    return region, continent
}
func main() {
    region, continent := location("Irvine")
    fmt.Printf("John works in %s, %s\n", region, continent)
}
```

Notice that the values you include in the expressions for the `case` statement correspond to the data type of the variable that the `switch` statement validates. If you include an integer value as a new `case` statement, the program won't compile.

## Invoke a function

A `switch` can also invoke a function. From that function, you can write `case` statements for possible return values. For example, the following code calls the `time.Now()` function. The output that it prints depends on the current weekday.

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    switch time.Now().Weekday().String() {
    case "Monday", "Tuesday", "Wednesday", "Thursday", "Friday":
        fmt.Println("It's time to learn some Go.")
    default:
        fmt.Println("It's the weekend, time to rest!")
    }

    fmt.Println(time.Now().Weekday().String())
}
```

When you call a function from a `switch` statement, you can modify its logic without changing the expression because you always validate what the function returns.

Also, you can call a function from a `case` statement. Use this technique, for instance, to match a particular pattern by using a regular expression. Here's an example:

```go
package main

import "fmt"

import "regexp"

func main() {
    var email = regexp.MustCompile(`^[^@]+@[^@.]+\.[^@.]+`)
    var phone = regexp.MustCompile(`^[(]?[0-9][0-9][0-9][). \-]*[0-9][0-9][0-9][.\-]?[0-9][0-9][0-9][0-9]`)

    contact := "foo@bar.com"

    switch {
    case email.MatchString(contact):
        fmt.Println(contact, "is an email")
    case phone.MatchString(contact):
        fmt.Println(contact, "is a phone number")
    default:
        fmt.Println(contact, "is not recognized")
    }
}
```

Notice that the `switch` block has no validating expression. Let's talk about that concept in the next section.

## Omit a condition

In Go, you can omit a condition in a `switch` statement like you do in an `if` statement. This pattern is like comparing a `true` value as if you were forcing the `switch` statement to run all the time.

Here's an example of how to write a `switch` statement without a condition:

```go
package main

import (
    "fmt"
    "math/rand"
    "time"
)

func main() {
    rand.Seed(time.Now().Unix())
    r := rand.Float64()
    switch {
    case r > 0.1:
        fmt.Println("Common case, 90% of the time")
    default:
        fmt.Println("10% of the time")
    }
}
```

The program always runs this type of `switch` statement because the condition is always true. A conditional `switch` block can be easier to maintain than a long chain of `if` and `else if` statements.


## Make the logic fall through to the next case

In some programming languages, you write a `break` keyword at the end of every `case` statement. But in Go, when the logic falls into one case, it exits the `switch` block unless you explicitly stop it. To make the logic fall through to the next immediate case, use the `fallthrough` keyword.

To understand this pattern better, look at the following code sample.

```go
package main

import (
    "fmt"
)

func main() {
    switch num := 15; {
    case num < 50:
        fmt.Printf("%d is less than 50\n", num)
        fallthrough
    case num > 100:
        fmt.Printf("%d is greater than 100\n", num)
        fallthrough
    case num < 200:
        fmt.Printf("%d is less than 200", num)
    }
}
```

Run the code and analyze the output:

```output
15 is less than 50
15 is greater than 100
15 is less than 200
```

Do you see anything wrong?

Notice that because `num` is 15 (less than 50), it matches the first case. But `num` isn't greater than 100. And because the first `case` statement has a `fallthrough` keyword, the logic goes to the next `case` statement immediately without validating the case. So you have to be careful when you use the `fallthrough` keyword. You might not want the behavior that this code creates.

Like other programming languages, Go also has support for `switch` statements. When you need to have several `if` statements chained, a better approach is to use `switch` statements. Not only you'll avoid having too many `if` statements that could make your code harder to read and maintain, but you can also have complicated conditions. We'll give them a look in the below sections.

## Basic switch syntax

Like the `if` statement, you don't need parenthesis for the `switch` condition. At its simplest form, a `switch` statement looks like this:

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

Run the code above several times, and you'll see a different output every time (If you run it in the Go Playground, you'll get the same result every time, and that's one of the service's limitations).

Go executes each case of the `switch` statement until it finds a match for the condition. However, notice that the previous code doesn't cover all possible cases of the `num` variable's values. For instance, if `num` ends up being `5`, the program's output will simply be `ok`. Alternatively, you can be more specific about the default use case and include it like this:

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

Notice that for the `default` case, you don't write an expression to validate. Instead, you simply include the `i` variable because you'll validate its value in the different `case` statements.

## Switch with multiple expressions

There will be cases where more than one expression could match only one `case` statement. In Go, if you want to have more than one expression in the same `case` statement, you can separate them with commas (`,`). This allows you to avoid duplicate code.

Below is a code sample of how you can have multiple expressions:

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

Notice that the values you include in the expressions for the `case` statement correspond to the data type of the variable the `switch` statement is validating. If you try to include an integer value as a new `case` statement, the program won't compile.

## Switch invoking a function

A `switch` can also invoke a function, and you can write `case` statements for possible return values from that function. For instance, the below code makes a call to the `time.Now()` function and prints out something depending on the current weekday:

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
        fmt.Println("It's weekend, time to rest!")
    }

    fmt.Println(time.Now().Weekday().String())
}
```

When you're calling a function from a `switch` statement, you can modify its logic without having to change the expression as you'll always validate what the function returns.

Also, you can call a function from a `case` statement. For instance, when you want to match a particular pattern by using a regular expression, like this:

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

Notice that the above `switch` block doesn't have an expression to validate. Let's talk about that in the next section.

## Omitting condition

In Go, conditions in a `switch` statement can be omitted altogether, simulating an `if` statement. This pattern is as if you would be comparing a `true` value as if you were forcing the `switch` statement to be executed all the time.

See the below code for a simple example of how to write a `switch` statement without a condition:

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

Notice that this pattern might be a cleaner way to write long if-then-else chains.

## Switch fallthrough

Unlike other programming languages where you need to write a `break` keyword at the end of every `case` statement, in Go, once the logic falls into one case, it will exit the `switch` block unless you explicitly say so. To fall through to the next immediate case, you need to use the `fallthrough` keyword.

To understand this pattern better, let's use the following code sample:

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

Run the above code, and analyze the output:

```output
15 is less than 50
15 is greater than 100
15 is less than 200
```

Do you see anything wrong?

Notice that because `num` is 15, it matches the first case because it's lower than 50. However, num it's not higher than 100, but because there was a `fallthrough` from the first `case` statement, it goes to the next immediately without validating if it's a valid case or not. So you have to be careful when you use fall through; you might not want to have the above behavior.

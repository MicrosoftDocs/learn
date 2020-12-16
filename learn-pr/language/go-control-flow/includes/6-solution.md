Here you can find one solution for the previous challenges

## Write a FizzBuzz program

The solution to this challenge could be something like this:

```go
package main

import (
    "fmt"
    "strconv"
)

func fizzbuzz(num int) string {
    switch {
    case num%15 == 0:
        return "FizzBuzz"
    case num%3 == 0:
        return "Fizz"
    case num%5 == 0:
        return "Buzz"
    }
    return strconv.Itoa(num)
}

func main() {
    for num := 1; num <= 100; num++ {
        fmt.Println(fizzbuzz(num))
    }
}
```

Notice that for the `FizzBuzz` case, we're multiplying 3 by 5 (as that will be divisible by 3 and 5), but you can also include an `AND` condition to check if the number is divisible by 3 and 5.

## Guess the square root

The solution to this challenge could be something like this:

```go
package main

import "fmt"

func sqrt(num float64) float64 {
    currguess := 1.0
    prevguess := 0.0

    for count := 1; count <= 10; count++ {
        prevguess = currguess
        currguess = prevguess - (prevguess*prevguess-num)/(2*prevguess)
        if currguess == prevguess {
            break
        }
        fmt.Println("A guess for square root is ", currguess)
    }
    return currguess
}

func main() {
    var num float64 = 25
    fmt.Println("Square root is:", sqrt(num))
}
```

Notice that we've included an `if` statement within the loop to stop it if the previous and current numbers are the same. You might need more than 10 calculations for high numbers, so it will be interesting to change the code to use instead of an infinite loop to run a calculation until the previous and current guess are the same. However, you might have a decimal precision problem, so you'll need to use round numbers.

## Ask a number, panic if negative

The solution to this challenge could be something like this:

```go
package main

import (
    "fmt"
)

func main() {
    val := 0

    for {
        fmt.Print("Enter number: ")
        fmt.Scanf("%d", &val)

        switch {
        case val < 0:
            panic("You entered a negative number!")
        case val == 0:
            fmt.Println("0 is neither negative nor positive")
        default:
            fmt.Println("You entered:", val)
        }
    }
}
```

Notice that the idea was to practice an infinite loop and a `switch` statement.

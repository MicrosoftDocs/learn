Here you can find a solution for each of the previous challenges.

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

For the `FizzBuzz` case, you multiply 3 by 5 because the results are divisible by 3 and 5. You can also include an `AND` condition to check whether a number is divisible by 3 and 5.

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

This solution includes an `if` statement within the loop. This statement stops the logic if the previous and current numbers are the same. You might need more than 10 calculations for high numbers. So it would be interesting to change the code to use an infinite loop to run a calculation until the previous and current guess are the same. To avoid a decimal precision problem, you'll need to use round numbers.

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

Remember, the idea is to practice an infinite loop and a `switch` statement.

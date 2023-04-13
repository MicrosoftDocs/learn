Let's look at possible solutions for each of the exercises.

## Write a FizzBuzz program

A solution for the exercise to use the `switch` statement could be something like this:

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

## Find the primes

A solution to the exercise to find the prime numbers less than 20 could be something like this:

```go
package main

import "fmt"

func findprimes(number int) bool {	
	for i := 2; i < number; i++ {
        if number % i == 0 {
			return false
        }
    }

	if number > 1 {
		return true
	} else {
	    return false
	}	
}

func main() {
    fmt.Println("Prime numbers less than 20:")
	
    for number := 1; number <= 20; number++ {
        if findprimes(number) {
            fmt.Printf("%v ", number)
        }
    }
}
```

In the `main` function, we loop from 1 to 20, and call the `findprimes` function to check the current number. In the `findprimes` function, we start the `for` loop at 2, and repeat until the counter is more than the `number` value. If the `number` is evenly divisible by the counter, the `number` isn't prime. If we complete the loop without exiting, the number is either 1, or it's prime.

Here's the output:

```output
Prime numbers less than 20:
2 3 5 7 11 13 17 19 
```

## Ask a number, panic if negative

The solution to the exercise to try a `panic` call could be something like this:

```go
package main

import "fmt"

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

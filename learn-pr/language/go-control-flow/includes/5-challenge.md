Practice what you've learned in this module by completing some coding exercises. These exercises aren't complicated, and you'll find solutions in the next unit. 

Try to solve the exercises on your own first. Then compare your results with the solutions. You can always review the module if you don't remember an important detail.

## Write a FizzBuzz program

First, write a program that prints numbers 1 through 100, with the following changes:

- Print `Fizz` if the number is divisible by 3.
- Print `Buzz` if the number is divisible by 5.
- Print `FizzBuzz` if the number is divisible by both 3 and 5.
- Print the number if none of the previous cases match.

Try to use the `switch` statement.

## Find the primes

Write a program to find all prime numbers less than 20. A prime number is any number greater than 1 that can be evenly divided only by itself and 1. To be "evenly divided" means, there's no remainder after the division operation. Like most programming languages, Go provides a way to check if a division operation produces a remainder. We can use the modulus `%` (percent sign) operator.

In this exercise, you'll update a function named `findprimes` to check if a number is prime. The function has one integer argument and returns a boolean. The function tests if the input number is a prime by checking for a remainder. If the number is a prime, the function returns true. 

Use the following code snippet as a starting point and replace all instances of `??` with the correct syntax:

```go
package main

import "fmt"

func findprimes(number int) bool {
	for i := 2; i ?? number; i ?? {
        if number ?? i == ?? {
			return false
        }
    }

	if number ?? {
		return true
	} else {
	    return false
	}
}

func main() {
    fmt.Println("Prime numbers less than 20:")

    for number := ??; number ?? 20; number++ {
        if ?? {
            fmt.Printf("%v ", number)
        }
    }
}
```

This program checks numbers 1 through 20, and prints the number if it's prime. Modify the example as described.

- In the `main` function, loop through all the numbers to check. Exit the loop after you check the last number.
- Call the `findprimes` function to check the number. If the function returns true, print the prime.
- In the `findprimes` loop, start from 2 and repeat until the counter is more than or equal to the `number` value.
- Check if the `number` is evenly divisible by the current counter value. If it is, exit the loop.
- When the `number` is prime, return true; otherwise, return false.
- Hint: Be sure to correctly handle the case where the input number is 1.

## Ask a number, panic if negative

Write a program that asks a user for a number. Use the following code snippet as a starting point:

```go
package main

import "fmt"

func main() {
    val := 0
    fmt.Print("Enter number: ")
    fmt.Scanf("%d", &val)
    fmt.Println("You entered:", val)
}
```

This program asks for a number and prints it. Modify the example code to:

- Ask continually for an integer number. The exit condition for the loop should be a user entry that's a negative number.
- Crash the program when the user enters a negative number. Then print the stack trace error.
- When the number is 0, print `0 is neither negative nor positive`. Keep asking for a number.
- When the number is positive, print `You entered: X` (where `X` is the entered number). Keep asking for a number.

For now, ignore the possibility that the user might enter something different than an integer number.

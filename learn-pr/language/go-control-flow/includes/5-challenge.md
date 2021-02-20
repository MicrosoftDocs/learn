Practice what you've learned in this module by completing some coding challenges. These challenges aren't complicated, and you'll find solutions in the next unit. 

Try to solve the challenges on your own first. Then compare your results with the solutions. You can always review the module if you don't remember an important detail.

## Write a FizzBuzz program

First, write a program that prints numbers 1 through 100, with the following changes:

- Print `Fizz` if the number is divisible by 3.
- Print `Buzz` if the number is divisible by 5.
- Print `FizzBuzz` if the number is divisible by both 3 and 5.
- Print the number if none of the previous cases match.

Try to use the `switch` statement.

## Guess the square root

Write a program to guess the square root of a number. Use this formula: 

`sroot = sroot − (sroot − x) / (2 * sroot)` 

This formula is for [Newton's method](https://en.wikipedia.org/wiki/Newton%27s_method?azure-portal=true).

The more you run this formula, the closer you'll get to the square root of a number. Initialize the `sroot` variable to `1`, regardless of the number for which you want to find the square root. *Repeat the calculation up to 10 times*, and print each guess.

You might need *fewer* than 10 calculations. You can stop the loop when you get the same result from a previous run. The higher the number is, the more calculations you need to run. For simplicity, you'll stick with a maximum of 10 repetitions.

For instance, if the input number is `25`, the output should look like this:

```output
A guess for square root is  13
A guess for square root is  7.461538461538462
A guess for square root is  5.406026962727994
A guess for square root is  5.015247601944898
A guess for square root is  5.000023178253949
A guess for square root is  5.000000000053723
A guess for square root is  5
Square root is: 5
```

## Ask a number, panic if negative

Write a program that asks a user for a number. Use the following code snippet as a starting point:

```go
package main

import (
    "fmt"
)

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

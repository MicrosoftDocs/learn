To put into practice everything you've learned in this module, we have some coding challenges that will help you practice what you've learned. These are not complicated challenges, and we'll give you our solution to each of the challenges. Try to solve them on your own first, and then compare your solution with ours. You can always go back to review the content in case you don't remember something specific.

## Write a FizzBuzz program

Write a program that prints the numbers from 1 to 100 and prints out the following:

- `Fizz` if the number is divisible by 3
- `Buzz` if the number is divisible by 5
- `FizzBuzz` if the number is divisible by both 3 and 5
- The number if none of the previous cases match

Try to make use of the `switch` statement.

## Guess the square root

Write a program to guess the square root of a number; you could use the formula `sroot = sroot − (sroot − x) / (2 * sroot)` (this is the formula for the [Newton's method](https://en.wikipedia.org/wiki/Newton%27s_method)).

The more you run the above formula, the close you'll get to find out what the square root value of a number is. You need to initialize the `sroot` variable to 1, regardless of the number you want to find the square root. **Repeat the calculation 10 times**, and print each guess.

Additionally, you might need **less than 10 calculations**, so stop the loop when you get the same result from a previous run. The higher the number is, the more calculations you need to run, but let's leave to only 10.

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

Write a program that asks for a number from a user. To do so, you can use the following code snippet as a starting point:

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

The above program simply asks for a number and prints it out.

Modify the previous code to do the following:

- Ask continuously for an integer number. The exit condition for the loop should be when a negative number is entered.
- Crash the program when the user enters a negative number and prints out the stack trace error.
- When the number is 0, print the `0 is neither negative nor positive` message, and keep asking for a number.
- When the number is positive, print out `You entered: X` (where `X` is the number entered), and keep asking for a number.

For now, ignore the fact that the user might enter something different than an integer number.

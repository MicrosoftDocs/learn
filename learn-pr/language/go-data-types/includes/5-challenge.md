To put into practice everything you've learned in this module, we have some coding challenges that will help you practice what you've learned. These are not complicated challenges, and we'll give you our solution to each of the challenges. Try to solve them on your own first, and then compare your solution with ours. You can always go back to review the content in case you don't remember something specific.

## Fibonacci sequence

A typical programming exercise is to write a program to calculate the Fibonacci sequence from a number. Write a function that returns a slice with all the numbers in a Fibonacci sequence that result from doing the calculation from a number users input greater than 2. Let's assume that numbers lower than `2` will result in an error and return a nil slice.

Remember, the Fibonacci sequence is a list of numbers where each number is the sum of the previous Fibonacci numbers. For instance, the sequence numbers for `6` is `1,1,2,3,5,8`, for `7` is `1,1,2,3,5,8,13`, for `8` is `1,1,2,3,5,8,13,21`, and so on and so forth.

## Roman numerals translator

Write a program that translates a Roman numeral like `MCLX` to `1,160`. Use a map to load the basic Roman numerals that you'll use to translate a string character into a number. For instance, `M` will be a key in the map, and its value will be `1000`. Use the following string character map list:

* `M` => 1000
* `D` => 500
* `C` => 100
* `L` => 50
* `X` => 10
* `V` => 5
* `I` => 1

In case the user input comes with a different letter from the above list, print an error.

Remember, there will be cases where a smaller number precedes a larger number, so you can't merely sum the numbers. For instance, the number `MCM` should print `1,900`.

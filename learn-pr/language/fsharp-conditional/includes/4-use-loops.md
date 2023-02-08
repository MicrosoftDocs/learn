You've come to a point in your program where you need to carry out a group of statements more than one time. You may be working with a list type structure that you need to iterate over. Or, you have a general need to repeat an operation until a certain condition is met. In theses scenarios, you can use loops.

## Loops

A loop iterates over a range of values. For each value, the code does something, like printing results on a screen or using the value in an operation. F# has three types of loops you can use:

- **`for...in`**: The `for...in` construct assumes that you have an enumerable collection you can iterate over. It iterates over each value in a collection.
- **`for...to`**: The `for...to` loop starts and ends where this loop iterates. It iterates until it reaches the value of a loop variable.
- **`while...do`**: The `while...do` loop isn't centered on an enumerable collection like the first two constructs. Instead, it loops until a condition is met.

### Use a for...in loop for every value in a collection

The `for...in` construct operates on an enumerable collection. It implements `System.Collections.IEnumerable` and includes lists, sequences, arrays, and other types. Here's the syntax for a `for...in` loop:

```fsharp
for <pattern> in <enumerable-expression> do
  <body-expression>
```

It's important to understand some keywords:

- **Pattern**: The pattern can be the current item or a tuple. An example is iterating over a sequence. The following code is an example of when the pattern is the current value `i`. The `for` iterates over the `list` list, and then it prints each value in the collection:

   ```fsharp
   let list = [1; 2; 3; 4; 5]
   for i in list do
     printf "%d " i
   ```

- **Enumerable-expression**: The enumerable expression is what you are iterating through. It might be a list or a sequence.
- **Body-expression**: The body expression is where you carry out the task you mean to do, like printing or performing a calculation.

### Use a for...to loop until a looping variable occurs

The `for...to` construct is slightly different from a `for...in` loop. The `for...to` loop variable constitutes a boundary of where to stop iterating. Here's what the syntax looks like:

```fsharp
for <identifier = start> [ to | downto ] <finish> do
    <body-expression>
```

It's important to understand the syntax components:

- **`identifier = start`**: This syntax is an assignment. You typically decide what variable you want to track as part of the iteration and what value it should start on.
- **`[to | downto]`**: You can choose between two different keywords. `to` means the loop iterates to that number. If you use `downto`, the value of your identifier decreases until it reaches that number.

Here's an example of using a `for...to` loop:

```fsharp
for i = 1 to 10 do
  printfn "%i " i  // prints 1 2 3 4 5 6 7 8 9 10
```

This loop prints all values between 1 and 10, including 10. Let's also look at an example that uses the `for...downto` construct. This construct works similar to `for...to`, but in reverse. The following code shows how you can print the values from 10 down to 1, including 1:

```fsharp
for i = 10 downto 1 do
  printfn "%i" i  // prints 10 9 8 7 6 5 4 3 2 1
```

### Use a while...do loop until a condition is met

The `while...do` construct is different from the `for...in` and `for...to` constructs. `while...do` doesn't iterate on a collection. Instead, use a `while...do` loop if you have logic that needs to loop until a condition is met. An example is accepting command-line arguments until a user enters **quit**.

This code shows the syntax of a `while...do` construct:

```fsharp
while <test-expression> do
  <body-expression>
```

A guessing game is an example of using a `while...do` construct:

```fsharp
open System

let mutable quit = false
let no = 11
while not quit do
   printf "Guess a number: "
   let guess = Console.ReadLine() 
   let guessNo = int guess
   if guessNo = no then
      quit <- true
      printfn "You guessed correctly %i is the secret number" no
   else
      printfn "%i is incorrect" guessNo
```

The code carries out a set of statements until the variable `quit` has the value `true`. By setting the value for `quit` to `true`, when a user guesses correctly, the loop ends.

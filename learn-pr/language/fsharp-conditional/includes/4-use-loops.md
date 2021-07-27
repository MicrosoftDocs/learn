You've come to a point in your program where you need to carry out a group of statements more than one time. The reason for that is that you are either dealing with a list type structure, or you have a general need to repeat something until a certain condition is met. To deal with this situation, you can use loops.

## Loops

The idea of a loop is to iterate over a range of values and for each value do something like outputting it to a screen or have the value interact in some operation. F# has three different loops you could be using:

- **for...to**. This construct assumes you have an enumerable collection that you can iterate over. It will iterate over each value in said collection.
- **for...in**. The `for...in` loop has the notion of start and ending where this loop iterates until it reaches the value of a loop variable.
- **while...do**. The `while...do` is not centered around an enumerable collection, like two first constructs, but loops until a condition is met.

### `for...in`, looping through every value in a collection

This construct needs to operate on something that's an enumerable collection and thereby implements `System.Collections.IEnumerable`, that includes, lists, sequences, arrays and more. The syntax for the loop looks like the following:

```fsharp
for <pattern> in <enumerable-expression> do
  <body-expression>
```

There's some keywords here that needs explaining:

- **Pattern**, the pattern can be the current item, or a tuple, for example,  of iterating over a sequence. Here's an example where the pattern is the current value, `i`. The `for` iterates over the list `list` and ends up printing each value in the collection:

   ```fsharp
   let list = [1; 2; 3; 4; 5]
   for i in list do
     printf "%d " i
   ```

- **Enumerable-expression**, the enumerable expression is what you are iterating through, like a list or  sequence and so on.
- **Body-expression**, this part is where you carry out the task you mean to do, like printing or performing a calculation and so on.

### `for...to`, loop until a looping variable

This construct is slightly different from the first loop. The difference lies in there being a loop variable that constitutes a boundary, where to stop iterating. Here's what the syntax looks like:

```fsharp
for <identifier = start> [ to | downto ] <finish> do
    <body-expression>
```

Let's go over the different parts:

- `identifier = start`. This syntax is an assignment, here you typically decide what variable you want to track as part of the iteration and what value it should start on.
- `[to | downto]`. You can choose between two different keywords. If you choose `to` to that means the loop will iterate to that number. If you on the other hand choose `downto` the value of your identifier will decrease until it hits that number.

Here's an example using the `for...to` loop:

```fsharp
for i = 1 to 10 do
  printfn "%i " i  // prints 1, 2 3 4 5 6 7 8 9 10
```

The above loop will print all values between 1 and 10, including 10. Let's have a look at an example using the `downto` construct as well. This construct is much `to` but in reverse. The following code shown how you can print from numbers 10 to 1:

```fsharp
for i = 10 downto 1 do
  printfn "%i" i  // prints 10, 9 8 7 6 5 4 3 2 1
```

### `while...do`, loop until a condition is met

The `while...do` construct is different in the sense that it doesn't center around a collection to iterate over. Instead, if you have logic that you need to implement like accepting command-line args until a user types the string "quit" this construct is well suited for it.

The syntax of the `while...do` looks like so:

```fsharp
while <test-expression> do
  <body-expression>
```

An example of using a `while...do` can, for example,  be this guessing game:

```fsharp
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

In this code, you are carrying out a set of statements until the variable `quit` has the value `true`. By setting it true, when a user guesses correctly, the loop quits.

Programs often have blocks of code that need to be repeated in place. We can use loop expressions to tell the program how to do the repetitions. To print all entries in a phonebook, we can use a loop expression to tell the program how to print starting from the first entry all the way through to the last entry.

Rust offers three loop expressions to make a program repeat a block of code:

- `loop`: Repeat, unless a manual stop occurs.
- `while`: Repeat while a condition remains true.
- `for`: Repeat for all values in a collection.

We'll take a look at each of these loop expressions in this unit.


## Just keep looping

The `loop` expression creates an infinite loop. This keyword lets us repeat the actions in the expression body continuously. The actions repeat until we take some direct action to make the loop stop.

The following example prints the text "We loop forever!" and it doesn't stop by itself. The `println!` action keeps repeating.

```rust
loop {
    println!("We loop forever!");
}
```

When you use a `loop` expression, the only way to stop the loop is if you as the programmer intervene directly. You can add specific code to make the loop stop, or enter a keyboard instruction like Ctrl+C to halt program execution.

The most common way to stop a `loop` expression is by using the `break` keyword to set a break point:

```rust
loop {
    // Keep printing, printing, printing...
    println!("We loop forever!");
    // On the other hand, maybe we should stop!
    break;                            
}
```

When the program encounters the `break` keyword, it stops executing the actions in the body of the `loop` expression and continues to the next code statement.

The `break` keyword reveals a special feature of the `loop` expression. By using the `break` keyword, you can both stop repeating the actions in the expression body and also return a value at the break point.

The following example shows how we can use the `break` keyword in a `loop` expression to also return a value:

```rust
let mut counter = 1;
// stop_loop is set when loop stops
let stop_loop = loop {
    counter *= 2;
    if counter > 100 {
        // Stop loop, return counter value
        break counter;
    }
};
// Loop should break when counter = 128
println!("Break the loop at counter = {}.", stop_loop);
```

Here's the output:

```rust
Break the loop at counter = 128.
```

The body of our `loop` expression does these successive actions:

1. Declare the `stop_loop` variable.
1. Instruct the program to bind the variable value to the result from the `loop` expression.
1. Start the loop. Execute the actions in the body of the `loop` expression:<br>
    **Loop body**
    1. Increment the `counter` value to be twice the current value.
    1. Check the `counter` value.
    1. If the `counter` value is more than 100:
       > Break from the loop and return the `counter` value.
    1. If the `counter` value is not more than 100:
       > Repeat the actions in the loop body.
1. Set the `stop_loop` value to the `counter` value, which is the result of the `loop` expression.

The `loop` expression body can have more than one break point. When the expression has multiple break points, every break point must return a value of the same type. All values must be of type integer, or String, or bool, and so on. When a break point doesn't explicitly return a value, the program interprets the expression result as an empty tuple, `()`.


## Loop a while

The `while` loop uses a conditional expression. The loop repeats as long as the conditional expression remains true. This keyword lets us execute the actions in the expression body until the conditional expression is false. 

A `while` loop begins by evaluating a boolean conditional expression. If the conditional expression evaluates to `true`, the actions in the body are executed. After the actions are completed, control returns to the conditional expression. When the conditional expression evaluates to `false`, the `while` expression stops.

The following example prints the text "We loop a while...". Each repetition of the loop tests the condition "is count less than 5." While the condition remains true, the actions in the expression body are executed. After the condition is no longer true, the `while` loop stops and the program continues to the next code statement.

```rust
while counter < 5 {
    println!("We loop a while...");
    counter = counter + 1;
}
```


## Loop for these values

The `for` loop uses an iterator to process a collection of items. The loop repeats the actions in the expression body for each item in the collection. This type of loop repetition is called *iterating*. When all iterations are complete, the loop stops.

In Rust, we can iterate over any collection type, such as an array, vector, or hash map. Rust uses an *iterator* to move through each item in the collection from first to last.

The `for` loop uses a temporary variable as the iterator. The variable is implicitly declared at the start of the loop expression, and the current value is set with each iteration. 

In the following code, the collection is the `big_birds` array and the iterator is named `bird`.

```rust
let big_birds = ["ostrich", "peacock", "stork"];
for bird in big_birds
```

We access the items in the collection by using the `iter()` method. The `for` expression binds the current value of the iterator to the result of the `iter()` method. In the expression body, we can work with the iterator value.

```rust
let big_birds = ["ostrich", "peacock", "stork"];
for bird in big_birds.iter() {
    println!("The {} is a big bird.", bird);
}
```

Here's the output:

```output
The ostrich is a big bird.
The peacock is a big bird.
The stork is a big bird.
```

Another easy way to create an iterator is to use the range notation `a..b`. The iterator starts at the `a` value and continues through to `b` in steps of one, but it doesn't use the value `b`.

```rust
for number in 0..5 {
    println!("{}", number * 2);
}
```

This code iterates through the numbers 0, 1, 2, 3, and 4. It binds the value to the `number` variable for each loop iteration.

Here's the output:

```output
0
2
4
6
8
```

You can run this code and explore loops in this [Rust Playground][RustPlay-loops].


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.


<!-- Links -->

[RustPlay-loops]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=7d11ab60ce11aa2082f2df2b0d8267ef?azure-portal=true

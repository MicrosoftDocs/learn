Functions are the primary way code is executed within Rust. You’ve already seen one of the most
important functions in the language: the `main` function, which is the entry point of many programs.

Function definitions in Rust start with `fn` and have a set of parentheses after the function
name. The curly brackets tell the compiler where the function body begins and ends.

```rust
fn main() {
    println!("Hello, world!");
    another_function();
}

fn another_function() {
    println!("Hello from another function!");
}
```

A function can be called by entering its name followed by a set of parentheses, passing any
arguments as necessary. In the example above, the `another_function` function required no arguments,
so we haven't passed any.

Note that we defined `another_function` after the `main` function in the source code; we could have
defined it before as well. Rust doesn’t care where you define your functions, only that they’re
defined somewhere.

Lets try declaring a function that accepts parameters and returns a value.

## Passing parameters to functions

In the following example, we are going to declare a function that checks if a given number is
divisible by another and returns a `boolean` to confirm that.

```rust
fn is_divisible_by(dividend: u32, divisor: u32) -> bool {
    // If the divisor is zero, we want to return early with a `false` value
    if divisor == 0 {
    return false;
    }
    dividend % divisor == 0
}
```

Lets take a look in this function signature:

- `fn`: the function declaration keyword in Rust.
- `is_divisible_by`: the function name.
- `(dividend: u32, divisor: u32)`: this function's parameter list, and it states that two unsigned
    32-bit integers are expected as input values.
- `-> bool`: the arrow points to the type of the value this function will always return.

So, the `is_divisible_by` function accepts two integers as inputs and will output a boolean value.

Now lets look closer to this function's body:

```rust
if divisor == 0 {
    return false;
}
```

All this part of the function is trying to do is preventing a classic programming error, the
division by zero error.

We still haven't covered *conditional expressions* yet, but this snippet is really simple. The `if`
keyword checks if the value held by the `divisor` variable is zero and, if it is, the code inside
the folowing block is executed. If it is, the function will return the boolean value `false`, using
the keyword `return` followed by the value to be returned.

The last line in our functin's body is actually just an expression without the `return` keyword:

```rust
dividend % divisor == 0
```

In Rust, the last expression inside a code block (`{ ... }`) is always returned, so we don't really
need to use the `return` keyword in here.

This expression uses the remainder operator (`%`) to get the remainder of the division between the
two terms and compare it to zero. The resulting type after applying the equality operator (`==`) is
the `bool` type, either `true` or `false`.

## Calling a function

Lets see our function in action.

```rust
fn is_divisible_by(dividend: u32, divisor: u32) -> bool {
    if divisor == 0 {
    return false;
    }
    dividend % divisor == 0
}

fn main() {
    assert_eq!(is_divisible_by(2, 3), false);
    assert_eq!(is_divisible_by(5, 1), true);
    assert_eq!(is_divisible_by(24, 6), true);
}
```

You can interact with the example above in this [Rust Playground Link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=554726b787ed0426bf288756e938c028?azure-portal=true).

It looks like it is working just fine! But what happens if we change the return type of our
function?

We can learn a lot of how Rust works when we try to break things on purpose, so lets try to break
our function contract and declare that it should return a `char` instead of a `bool` type, without
modifying the function's body:

```rust
fn is_divisible_by(dividend: u32, divisor: u32) -> char {
//                                                 ^^^^
```

We get some compiler errors explaining that we have "mismatched types" in our function definition:

```output
    error[E0308]: mismatched types
     --> src/main.rs:3:16
      |
    1 | fn is_divisible_by(dividend: u32, divisor: u32) -> char {
      |                                                    ---- expected `char` because of return type
    2 |     if divisor == 0 {
    3 |         return false;
      |                ^^^^^ expected `char`, found `bool`

    error[E0308]: mismatched types
     --> src/main.rs:5:5
      |
    1 | fn is_divisible_by(dividend: u32, divisor: u32) -> char {
      |                                                    ---- expected `char` because of return type
    ...
    5 |     dividend % divisor == 0
      |     ^^^^^^^^^^^^^^^^^^^^^^^ expected `char`, found `bool`
```

This error tells us that the expected type (`char`) did not match the received type (`bool`).

Indeed, each of the two return points inside our function received complaints from the compiler,
telling us that it expected a `char` to be returned, but it found a `bool` instead.

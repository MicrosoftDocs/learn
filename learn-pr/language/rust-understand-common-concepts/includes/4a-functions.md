Functions are the primary way code is executed within Rust. You've already seen one of the most important functions in the language, the `main` function. In this unit, we'll cover more of the details about how to define and use functions.


## Function basics

Let's review some function basics that we talked about earlier.

Function definitions in Rust start with the `fn` keyword. After the function name, we specify the function's input arguments as a comma-separated list of data types inside parentheses. The curly brackets tell the compiler where the function body begins and ends.

```rust
fn main() {
    println!("Hello, world!");
    goodbye();
}

fn goodbye() {
    println!("Goodbye!");
}
```

We call a function by using its name along with its input arguments in parentheses. If a function doesn't have any input arguments, we leave the parentheses empty. In our example, both the `main` and `goodbye` functions have no input arguments.

You might have noticed that we defined the `goodbye` function after the `main` function. We could have defined the `goodbye` function before we defined `main`. Rust doesn't care where in the file you define your functions, as long as they're defined somewhere in the file.


## Function input arguments

When a function has input arguments, we name each argument and specify the data type at the start of the function declaration. Because arguments are named like variables, we can access the arguments in the function body.

Let's declare a function to check if a number is divisible by another number (no remainder). 

```rust
fn is_divisible_by(dividend: u32, divisor: u32) {
    // If the divisor is zero, stop execution
    if divisor == 0 {
        println!("\nError! Division by zero is not allowed.");
    } else if dividend % divisor > 0 {
        println!("\n{} % {} has a remainder of {}.", dividend, divisor, (dividend % divisor));
    } else {
        println!("\n{} % {} has no remainder.", dividend, divisor);
    }
}

fn main() {
    is_divisible_by(12, 4);
    is_divisible_by(13, 5);
    is_divisible_by(14, 0);
}
```

We'll test our function by calling it from the `main` function with three different sets of argument values, and then check the output:

```output
12 % 4 has no remainder.

13 % 5 has a remainder of 3.

Error! Division by zero is not allowed.
```

You can experiment with this example code in this [Rust Playground][RustPlay-args].


## Function return values

When a function returns a value, we add the syntax `-> <type>` after the list of function arguments and before the opening curly bracket for the function body. The arrow syntax `->` indicates that the function returns a value. The `<type>` portion lets the complier know the type of the value returned.

The following code shows a function that returns a boolean value:

```rust
fn is_input_zero(input: u8) -> bool {
```

In Rust, the value of the last expression inside a code block (`{ ... }`) is always returned. You can use the `return` keyword explicitly, as needed. 

The following code calls the function to check if a value equals zero. If it does, the function returns `true`; otherwise, it returns `false`.

```rust
fn is_zero(input: u8) -> bool {
    if input == 0 {
        return true;
    }
    false
}

fn main() {
    if is_zero(0) {
        println!("The value is zero.");
    }
}
```

The return functionality can be used at any point in the function to halt execution and send a value back to the caller. When you explicitly use the `return` keyword, you end the statement with a semicolon. When you create and send back a return value without using the `return` keyword, don't end the statement with a semicolon.

Let's update our division example so the function returns a boolean value to show if the dividend is divisible. Notice how we use the arrow `-> <type>` and `return` keyword syntax in this code.


```rust
fn is_divisible_by(dividend: u32, divisor: u32) -> bool {
    if divisor == 0 {
        println!("\nError! Division by zero is not allowed.");
        // To prevent division by zero, halt execution and return to the caller
        return false;
    } else if dividend % divisor > 0 {
        println!("\n{} % {} has a remainder of {}.", dividend, divisor, (dividend % divisor));
    } else {
        println!("\n{} % {} has no remainder.", dividend, divisor);
    }

    // Create the boolean value and return it to the function caller
    dividend % divisor == 0
}
```

Try running this example in the [Rust Playground][RustPlay-return]. 


## Function signature

The first part of the declaration for a function is called the *function signature*. 

The signature for the `is_divisible_by` function in our example has these characteristics:

- `fn`: The function declaration keyword in Rust.
- `is_divisible_by`: The function name.
- `(dividend: u32, divisor: u32)`: The function's argument or *parameter* list. This list states that two unsigned 32-bit integers are expected as input values.
- `-> bool`: The arrow points to the type of value this function will always return.

The `is_divisible_by` function accepts two integers as inputs and outputs a boolean value.


## Function body

Now let's look closer at the primary expression in our function body:

```rust
// If the divisor is zero, stop execution - division by zero causes a runtime error
if divisor == 0 {
    println!("\nError! Division by zero is not allowed.");
    // To prevent division by zero, halt execution and return to the caller
    return false;
} else if dividend % divisor > 0 {
     println!("\n{} % {} has a remainder of {}.", dividend, divisor, (dividend % divisor));
} else {
    println!("\n{} % {} has no remainder.", dividend, divisor);
}
```

First, we try to prevent a classic programming error: division by zero. If there's an attempt to divide by zero, we stop execution of the function, print an error message, and return false. Because we explicitly use the `return` keyword here, we end the statement with a semicolon.

Next, we check for a remainder from the division calculation. If a remainder is found, the value is displayed.

Finally, we handle cases that weren't processed in the previous statements.

If execution continues to the end of the function body, the value of the last expression is returned.

```rust
dividend % divisor == 0
```

The expression `dividend % divisor == 0` uses the remainder operator (`%`) to get the remainder of the division between the two numbers and then compares it to zero. The resulting type after applying the equality operator (`==`) is the `bool` type, which is either `true` or `false`. The return value is created implicitly without using the `return` keyword, so we don't end the statement with a semicolon.


## Explore the example code

You can interact with the example code in this [Rust Playground][RustPlay-return].

We can learn a lot about how Rust works when we try to break things on purpose. Here are a few experiments to try:

- What happens if you add a semicolon after the last statement in the `is_divisible_by` function? 
- Can you change the return type of the `is_divisible_by` function and also process the result?
- If you forget to handle the case where the user tries to divide by zero, when do you see the error?

Let's try to break our function contract by declaring the function return type as a `char` instead of a `bool`, but not modify the function body.

```rust
fn is_divisible_by(dividend: u32, divisor: u32) -> char {
//                                                 ^^^^
```

We get some compiler errors explaining that we have "mismatched types" in our function definition.

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

This error tells us that the expected type `char` didn't match the received type `bool`.

Each of the two return points inside our function received complaints from the compiler, telling us that it expected a `char` to be returned but found a `bool` instead.


<!-- Links -->
[RustPlay-args]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=cb0e7f2f992840acba2b52692f624a24?azure-portal=true
[RustPlay-return]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=01d5fe69a51a32961844ec03b2e32774?azure-portal=true

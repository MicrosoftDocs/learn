In this unit, we review how a simple Rust program is structured.

## Functions in Rust

A function is a block of code that does a specific task. We separate the code in our program into blocks based on task. This separation makes the code easier to understand and maintain. After we define a function for a task, we can call the function when we need to do that task.

Every Rust program must have **one** function named `main`. The code in the `main` function is always the first code run in a Rust program. We can call other functions from within the `main` function, or from within other functions. 

```rust
fn main() {
    println!("Hello, world!");
}
```

To declare a function in Rust, we use the `fn` keyword. After the function name, we tell the compiler how many parameters or *arguments* the function expects as input. The arguments are listed inside the parentheses `()`. The *function body* is the code that does the task of the function and is defined inside curly brackets `{}`. It's a best practice to format the code so the opening curly bracket for the function body appears right after the argument list in parentheses.

## Code indentation

In the function body, most code statements end with a semicolon `;`. Rust processes these statements one after the other in order. When a code statement doesn't end with a semicolon, Rust knows the next line of code must be executed before the starting statement can be complete.

To help see the execution relationships in the code, we use indentation. This format shows how the code is organized and reveals the flow of steps to complete the function task. A starting code statement is indented four spaces from the left margin. When the code doesn't end in a semicolon, the next line of code to execute is indented four more spaces.

Here's an example:

```rust
fn main() { // The function declaration is not indented

    // First step in function body
        // Substep: execute before First step can be complete

    // Second step in function body
        // Substep A: execute before Second step can be complete
        // Substep B: execute before Second step can be complete
            // Sub-substep 1: execute before Substep B can be complete

    // Third step in function body, and so on...
}
```

## The todo! macro

When you work on exercises in the Rust modules, you'll notice the sample code often uses the `todo!` macro. A macro in Rust is a like a function that takes a variable number of input arguments. The `todo!` macro is used to identify unfinished code in the Rust program. The macro is helpful for prototyping, or when you want to indicate behavior that isn't complete.

Here's an example of how we use the `todo!` macro in the exercises:

```rust
fn main() {
    // Display the message "Hello, world!"
    todo!("Display the message by using the println!() macro");
}
```

When you compile code that uses the `todo!` macro, the compiler can return a panic message where it expects to find completed functionality:

```output
   Compiling playground v0.0.1 (/playground)
    Finished dev [unoptimized + debuginfo] target(s) in 1.50s
     Running `target/debug/playground`
thread 'main' panicked at 'not yet implemented: Display the message by using the println!() macro', src/main.rs:3:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```

## The println! macro

Our `main` function does one task. It calls the `println!` macro that's predefined in Rust. The `println!` macro expects one or more input arguments, which it displays to the screen or *standard output*. In our example, we pass one input argument to the macro, the text string "Hello, world!"

```rust
fn main() {
    // Our main function does one task: show a message
    // println! displays the input "Hello, world!" to the screen
    println!("Hello, world!");
}
```

## Value substitution for {} arguments

In the Rust Learn module lessons, we often call the `println!` macro with a list of arguments that includes text strings with instances of curly brackets `{}` and other values. The `println!` macro replaces each instance of curly brackets `{}` inside a text string with the value of the next argument in the list. 

Here's an example:

```rust
fn main() {
    // Call println! with three arguments: a string, a value, a value
    println!("The first letter of the English alphabet is {} and the last letter is {}.", 'A', 'Z');
}
```

We call the `println!` macro with three arguments: a string, a value, and another value. The macro processes the arguments in order. Each instance of curly brackets `{}` inside the text string is replaced with the value of the next argument in the list.

The output is:

```output
The first letter of the English alphabet is A and the last letter is Z.
```

### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.

<!-- Links -->

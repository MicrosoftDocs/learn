Functions are the primary way code is executed within Rust. You've already seen one of the most important functions in the language, the `main` function. In this unit, we'll cover more of the details about how to define functions.


## Define a function

Function definitions in Rust start with the `fn` keyword. After the function name, we specify the function's input arguments as a comma-separated list of data types inside parentheses. The curly brackets tell the compiler where the function body begins and ends.

```rust
fn main() {
    println!("Hello, world!");
    goodbye();
}

fn goodbye() {
    println!("Goodbye.");
}
```

We call a function by using its name along with its input arguments in parentheses. If a function doesn't have any input arguments, we leave the parentheses empty. In our example, both the `main` and `goodbye` functions have no input arguments.

You might have noticed that we defined the `goodbye` function after the `main` function. We could have defined the `goodbye` function before we defined `main`. Rust doesn't care where in the file you define your functions, as long as they're defined somewhere in the file.


## Pass input arguments

When a function has input arguments, we name each argument and specify the data type at the start of the function declaration. Because arguments are named like variables, we can access the arguments in the function body.

Let's modify our goodbye function to take a pointer to some string data as an input argument.

```rust
fn goodbye(message: &str) {
    println!("\n{}", message);
}

fn main() {
    let formal = "Formal: Good bye.";
    let casual = "Casual: See you later!";
    goodbye(formal);
    goodbye(casual);
}
```

We'll test our function by calling it from the `main` function with two different argument values, and then check the output:

```output
Formal: Good bye.
Casual: See you later!
```


## Return a value

When a function returns a value, we add the syntax `-> <type>` after the list of function arguments and before the opening curly bracket for the function body. The arrow syntax `->` indicates that the function returns a value. The `<type>` portion lets the complier know the type of the value returned.

Let's modify our goodbye function to take a pointer to return a boolean value:

```rust
fn goodbye(message: &str) -> bool {
    println!("\n{}", message);
    return true
}
```

The return functionality can be used at any point in the function to halt execution and send a value back to the caller. When you explicitly use the `return` keyword, you end the statement with a semicolon. When you create and send back a return value without using the `return` keyword, don't end the statement with a semicolon.


## Review the signature

The first part of the declaration for a function is called the *function signature*. 

The signature for the `goodbye` function in our example has these characteristics:

- `fn`: The function declaration keyword in Rust.
- `goodbye`: The function name.
- `(message: &str)`: The function's argument or *parameter* list. One pointer to string data is expected as the input value.
- `-> bool`: The arrow points to the type of value this function will always return.

The `goodbye` function accepts one string pointer as input and outputs a boolean value.

You can interact with the example code in this [Rust Playground][RustPlay-func].


<!-- Links -->
[RustPlay-func]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=370b04cadc1f78cf8fee0f09653399a1?azure-portal=true

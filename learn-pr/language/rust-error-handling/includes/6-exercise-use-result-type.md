In this exercise, you'll add error handling to a program that reads files from a computer. In the sample program, the `read_file_contents` function receives a `PathBuf` struct as its single input and returns a `Result<String, io::Error>`. 

The function does the following tasks:

1. Creates a mutable empty `String` variable.
1. Accesses a file at a specified path.
1. Reads the file contents into the `String` variable with the `read_to_string` method.
1. Returns the modified `String` variable.

Here are some details about the code:

- The program uses some structs and a trait. The first three lines of code bring these data types into scope.
- Some of the `match` arms introduce variables like `file_handle` and `io_error`. Because their scope is limited to the `match` expression, they aren't declared in code that precedes `match`.
- The `open` method returns a `Result<File, Error>` enum. When no errors occur, it returns a file handle wrapped in an `Ok` variant.
- The `read_to_string` method appends the file contents to the passed `string` parameter, not to a return value.
- The program uses a `match` expression to assign a value to a variable. Within that assignment statement, you can also use `match` arms to return from the function early.


## Open the sample program

To work on the sample code for this exercise, you have two options:

- Copy the following code and edit it in your local development environment. 
- Open the code in this prepared [Rust Playground][RustPlay-exercise].

### Edit in local development environment

To run this code on your local computer, write the code in a *src/main.rs* file. The file must be at the root of a Cargo project. For questions about how to set up a new Cargo project, review the [first module in this learning path][Rust-cargo].

### Work in the Rust Playground

To complete the exercise in the Rust Playground, you can read your own code as a file named *src/main.rs*. This file is on its own virtual path.

```rust
use std::fs::File;
use std::io::{Error, Read};
use std::path::PathBuf;

fn read_file_contents(path: PathBuf) -> Result<String, Error> {
    let mut string = String::new();

    // Access a file at a specified path
    // ---------------------------------
    // TODO #1:
    // - Pass variable to `file` variable on success, or
    // - Return from function early if there's an error
    let mut file: File = match File::open(path) {
        Ok(file_handle) => todo!("Pass variable to `file` variable on success"),
        Err(io_error) => todo!("Return from function early if there's an error")
    };

    // Read file contents into `String` variable with `read_to_string`
    // ---------------------------------
    // Success path is already filled in
    // TODO #2: Return from function early if there's an error
    match file.read_to_string(&mut string) {
        Ok(_) => (),
        Err(io_error) => todo!("Return from function early if there's an error")
    };

    // TODO #3: Return `string` variable as expected by function signature
    todo!("Return `string` variable")
}

fn main() {
    if read_file_contents(PathBuf::from("src/main.rs")).is_ok() {
        println!("The program found the main file.");
    }
    if read_file_contents(PathBuf::from("non-existent-file.txt")).is_err() {
        println!("The program reported an error for the file that doesn't exist.");
    }
}
```


## Handle success and failure scenarios

Your first task is to add code to handle the success and failure scenarios.

> [!NOTE]
> In the sample code, look for the `TODO` comments and the `todo!` macro. The comments explain the task to complete. This macro indicates code that needs to be finished or updated.

Update the following code to handle the success and failure scenarios inside a `match` expression.

```rust
    // Access a file at a specified path
    // ---------------------------------
    // TODO #1:
    // - Pass variable to `file` variable on success, or
    // - Return from function early if there's an error
    let mut file: File = match File::open(path) {
        Ok(file_handle) => todo!("Pass variable to `file` variable on success"),
        Err(io_error) => todo!("Return from function early if there's an error")
    };
```

As you complete the task, address these programming goals:

- The `Ok(value)` case must provide the inner `value`.
- The `Err(error_value)` value must be returned early from the `read_file_contents` function.


## Handle error scenarios

Your next task is to add error handling. Update the following code to support the `Err` case.

```rust
    // Read file contents into `String` variable with `read_to_string`
    // ---------------------------------
    // Success path is already filled in
    // TODO #2: Return from function early if there's an error
    match file.read_to_string(&mut string) {
        Ok(_) => (),
        Err(io_error) => todo!("Return from function early if there's an error")
    };
```

As you work on this task, address the following programming goals:

- The `Ok(value)` case must provide the inner `value`.
- The `Err(error_value)` value must be returned early from the `read_file_contents` function.


## Return a String

Your final task is to revise the code to return the modified `String` variable inside an `Ok` variant. The implementation should express that the return value is the expected successful output of the function.

```rust
fn read_file_contents(path: PathBuf) -> Result<String, Error> {
    ...
    // TODO #3: Return `string` variable as expected by function signature
    todo!("Return `string` variable")
}
```


## Build the program

After you complete the tasks, build and run your program. You should see the following output:

```output
The program found the main file.
The program reported an error for the file that doesn't exist.
```

## Solution

You can compare your code with the prepared solution in this [Rust Playground][RustPlay-answer].

<!-- Links -->

[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=c76ec6ab0bca6572dda78ded96d90faa?azure-portal=true
[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=218fec0300bf94b1aeb8178d9db62050?azure-portal=true
[Rust-cargo]: /training/modules/rust-set-up-environment/5-hello-world?azure-portal=true

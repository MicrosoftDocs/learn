This challenge involves handling errors that result in reading files from a computer.

If you plan to run this code in your local computer, make sure your code is written in a file called `src/main.rs`, at the root of some Cargo project. Review the first module of this learning path if you have any questions about how to setup a new Cargo project.

If you plan on completing this exercise in the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=6cb6629db5c1460f070ba672ff2d5c41?azure-portal=true),
rest assured. The Playground allows you to read your own code as a file named `src/main.rs` located
at their own virtual path.

In this exercise you are going to fill in the `???` marks inside the `read_file_contents` to make
it compile and run without panics.

This is what you need to know before trying this challenge:

- `read_file_contents` is a function that receives a `PathBuf` struct as its single input and returns a `Result<String, io::Error>`. All it does is:

1. Creates a new, mutable and empty `String`.
2. Tries to access a file at a given path.
3. Tries to read the contents from that file into the `String` we just created using the `read_to_string` method.
4. Returns the modified `String`

## Exercise steps

- `TODO #1` expects you to handle both the success and failure scenarios inside a `match` expression.
  The `Ok(value)` case must provide that inner `value`, while the `Err(error_value)` must be
  returned early from the `read_file_contents` function.
- `TODO #2` expects you to handle the `Err` case exactly as the `TODO #1` assignment.
- `TODO #3` expects you to return the modified `String` inside an `Ok` variant, expressing that it
  is the expected successful output of that function.

```rust
use std::fs::File;
use std::io::{Error as IoError, Read};
use std::path::PathBuf;

fn read_file_contents(path: PathBuf) -> Result<String, IoError> {
    let mut string = String::new();

    // TODO #1: Handle this match expression.
    // --------------------------------------
    // Pass the variable to the `file` variable on success, or
    // Return from the function earely if it is an error.
    let mut file: File = match File::open(path) {
        Ok(file_handle) => ???,
        Err(io_error) => ???,
    };

    // TODO #2: Handle this error.
    // ---------------------------
    // The success path is already filled for you.
    // Return from the function earely if it is an error.
    match file.read_to_string(&mut string) {
        Ok(_) => (),
        Err(io_error) => ???,
    };

    // TODO #3: return the `string` variable as expected by this function signature.
    ???
}

fn main() {
    assert!(read_file_contents(PathBuf::from("src/main.rs")).is_ok());
    assert!(read_file_contents(PathBuf::from("non-existent-file.txt")).is_err());
}
```

You can find the solution to this exercise in this
[Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=8a554893ab63112e5e8f7fa1bacfb9b5?azure-portal=true).

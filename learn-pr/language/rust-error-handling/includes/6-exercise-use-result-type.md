This challenge involves handling errors that result in reading files from a computer.

If you plan to run this code on your local computer, make sure that it's written in the file called *src/main.rs*, at the root of a Cargo project. If you have any questions about how to set up a new Cargo project, review the first module in this learning path.

If you plan to complete this exercise on the [Rust playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=6cb6629db5c1460f070ba672ff2d5c41?azure-portal=true), understand that, by using the playground, you can read your own code as a file named *src/main.rs*, which is on its own virtual path.

In this exercise, you'll replace the question marks (`???`) inside `read_file_contents` to make
it compile and run without panics.

Before you try this challenge, here's something you need to know:

`read_file_contents` is a function that receives a `PathBuf` struct as its single input and returns a `Result<String, io::Error>`. The function does the following, in order:

1. Creates a new mutable and empty `String`.
1. Tries to access a file at a specified path.
1. Tries to read the contents from that file into the `String` you just created by using the `read_to_string` method.
1. Returns the modified `String.`

## Exercise steps

To complete this exercise, follow the instructions in each of the three Rust inline "TODO" comments:

1. **TODO #1**: Expects you to handle both the success and failure scenarios inside a `match` expression.

   The `Ok(value)` case must provide that inner `value`, and the `Err(error_value)` must be returned early from the `read_file_contents` function.

1. **TODO #2**: Expects you to handle the `Err` case exactly as you've done in the TODO #1 exercise.

1. **TODO #3**: Expects you to return the modified `String` inside an `Ok` variant, which expresses that it's the expected successful output of that function.

```rust
use std::fs::File;
use std::io::{Error as IoError, Read};
use std::path::PathBuf;

fn read_file_contents(path: PathBuf) -> Result<String, IoError> {
    let mut string = String::new();

    // TODO #1: Handle this match expression.
    // --------------------------------------
    // Pass the variable to the `file` variable on success, or
    // Return from the function early if it is an error.
    let mut file: File = match File::open(path) {
        Ok(file_handle) => ???,
        Err(io_error) => ???,
    };

    // TODO #2: Handle this error.
    // ---------------------------
    // The success path is already filled in for you.
    // Return from the function early if it is an error.
    match file.read_to_string(&mut string) {
        Ok(_) => (),
        Err(io_error) => ???,
    };

    // TODO #3: Return the `string` variable as expected by this function signature.
    ???
}

fn main() {
    assert!(read_file_contents(PathBuf::from("src/main.rs")).is_ok());
    assert!(read_file_contents(PathBuf::from("non-existent-file.txt")).is_err());
}
```

Get a [solution to this exercise](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=8a554893ab63112e5e8f7fa1bacfb9b5?azure-portal=true).

Now that you've installed Rust, let's write your first Rust program. You'll print the message "Hello, world!" to the console.

## Create a new directory to organize your code

Start by creating a directory for storing all the code in this learning path
(`rust-learning-path`), and then creating a new sub-directory to keep the source code for this exercise.

For Linux, macOS, and PowerShell on Windows, enter this:

    $ mkdir ~/rust-learning-path
    $ cd ~/rust-learning-path
    $ mkdir hello_world
    $ cd hello_world

For the Windows command prompt, enter this:

    > mkdir "%USERPROFILE%\rust-learning-path"
    > cd /d "%USERPROFILE%\rust-learning-path"
    > mkdir hello_world
    > cd hello_world

## Write your first Rust program

Next, create a new file named `main.rs` and use your editor to write the following code into it:

```rust
fn main() {
	println!("Hello, world!");
}
```

## Compile and run your program

Now that you have your source code ready, you need to compile your program into an executable file. Back in your terminal window, enter the following commands to compile and run the file:

If you're on Linux or macOS:

    $ rustc main.rs
    $ ./main
    Hello, world!

On Windows, enter the command `.\main.exe`, instead of `./main`:

    > rustc main.rs
    > .\main.exe
    Hello, world!

You should see `Hello, world!` printed out in the terminal.

Congratulations, you've written your first Rust program!

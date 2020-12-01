Now that you've installed Rust, let's write your first Rust program that prints the message "Hello, world!" to the console.

## Creating a new directory to organize our code

We'll start by creating a directory for storing all the code in this learning path
(`rust-learning-path`) and then creating a new sub-directory to keep the source code for this exercise.

For Linux, macOS, and PowerShell on Windows, enter this:

    $ mkdir ~/rust-learning-path
    $ cd ~/rust-learning-path
    $ mkdir hello_world
    $ cd hello_world

For Windows Command Prompt, enter this:

    > mkdir "%USERPROFILE%\rust-learning-path"
    > cd /d "%USERPROFILE%\rust-learning-path"
    > mkdir hello_world
    > cd hello_world

## Writing our first Rust program

Next, create a new file named `main.rs` and use your editor to write the following code into it:

```rust
fn main() {
	println!("Hello, world!");
}
```

## Compiling and running our program

Now that we have our source code ready, we need to compile our program into an executable file. Back in your terminal window, enter  the following commands to compile and run the file:

If you are on Linux or macOS:

    $ rustc main.rs
    $ ./main
    Hello, world!

On Windows, enter the command .\main.exe instead of ./main:

    > rustc main.rs
    > .\main.exe
    Hello, world!

You should see the string `Hello, world!` be displayed in the terminal.

Congratulations! You've written your first Rust program!

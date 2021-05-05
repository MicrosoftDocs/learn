Now that you've installed Rust, let's write your first Rust program. You'll print the message "Hello, world!" to the console.

## Create a new directory to organize your code

Start by creating a directory for storing all the code in this learning path
(`rust-learning-path`), and then creating a new subdirectory to keep the source code for this exercise.

For Linux, macOS, and PowerShell on Windows, run the following commands:

```console
mkdir ~/rust-learning-path
cd ~/rust-learning-path
mkdir hello_world
cd hello_world

```

For the Windows command prompt, run the following commands:

```console
mkdir "%USERPROFILE%\rust-learning-path"
cd /d "%USERPROFILE%\rust-learning-path"
mkdir hello_world
cd hello_world

```

## Write your first Rust program

Next, create a new file named `main.rs` and use your editor to write the following code into it:

```rust
fn main() {
	println!("Hello, world!");
}
```

## Compile and run your program

Your source code is ready. Now it's time to compile your program into an executable file. Return to your terminal window and enter the following commands to compile and run the file.

If you're on Linux or macOS, run the following commands:

```console
rustc main.rs
./main

```

On Windows, run the following commands:

```console
rustc main.rs
.\main.exe

```

You should see the following output:

```output
Hello, world!
```

Congratulations, you've written your first Rust program!

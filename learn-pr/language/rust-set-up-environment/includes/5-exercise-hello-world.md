With Rust installed, you're ready to start coding. Let's write a program that prints "Hello, world!" to the console.

## Create a new directory to organize your code

Start by creating a directory for storing all the code in this learning path
(`rust-learning-path`), and then creating a new subdirectory to keep the source code for this exercise.

::: zone pivot="windows"

For the Windows command prompt, run the following commands:

```console
mkdir "%USERPROFILE%\rust-learning-path"
cd /d "%USERPROFILE%\rust-learning-path"
mkdir hello-world
cd hello-world

```
::: zone-end

::: zone pivot="linux,macos"

For Linux, macOS, and PowerShell on Windows, run the following commands:

```console
mkdir ~/rust-learning-path
cd ~/rust-learning-path
mkdir hello-world
cd hello-world

```

::: zone-end


## Write your first Rust program

Next, create a new file named `main.rs` and use your editor to write the following code into it:

```rust
fn main() {
	println!("Hello, world!");
}
```

## Compile and run your program

Your source code is ready. Now it's time to compile your program into an executable file. Return to your terminal window and enter the following commands to compile and run the file.

::: zone pivot="windows"

On Windows, run the following commands:

```console
rustc main.rs
.\main.exe

```

::: zone-end

::: zone pivot="linux,macos"

If you're on Linux or macOS, run the following commands:

```console
rustc main.rs
./main

```
::: zone-end

You should see the following output:

```output
Hello, world!
```

## Create a project with Cargo 

Now let's use Cargo to write and run the same program.

> [!NOTE]
> The commands in the following sections work on all platforms.

To start, we use Cargo to make a new project.

Make sure your terminal is at your `rust-learning-path` directory, and run the following command:

```console
cargo new hello-cargo
```

This command generates a new directory named *hello-cargo* with a *src* subdirectory and adds two files:

> hello-cargo/ <br>
> &nbsp;&nbsp;&nbsp;&nbsp; Cargo.toml <br>
> &nbsp;&nbsp;&nbsp;&nbsp; src/ <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; main.rs 

- The *Cargo.toml* file is the manifest file for Rust. It's where you keep metadata for your project and also any dependencies.
- The *main.rs* file in the *src* subdirectory is where you write your application code.

Notice that the `cargo new` command generated a boilerplate "Hello, world!" project for you.

## Build and run your program with Cargo

To execute the boilerplate program, move into the new directory *hello-cargo*, and then use the `cargo run` command.

Run the following commands in your terminal:

```console
cd hello-cargo
cargo run

```

You should see the following output in your terminal:

```output
  Compiling hello-cargo v0.1.0 (/tmp/.OFUp/hello-cargo)
    Finished dev [unoptimized + debuginfo] target(s) in 1.59s
      Running `target/debug/hello-cargo`

Hello, world!
```

Cargo has built and executed your executable.

Congratulations, you've written your first Rust program and learned how to initialize your first Rust project with Cargo!

Here's how to write your program by using Cargo.

## Create a new project

To start, use Cargo to make a new project.

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
- The *main.rs* file in the *src* subdirectory is where you'll write your application code.

Notice that the `cargo new` command generated a boilerplate "Hello, world!" project for you.

## Build and run your program with Cargo

To execute the boilerplate program, we'll move into the new directory *hello-cargo*, and then use the `cargo run` command.

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

Congratulations, you've learned how to initialize your first Rust project with Cargo!

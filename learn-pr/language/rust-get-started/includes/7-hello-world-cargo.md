Here's how to write your program by using Cargo.

## Create a new project

To start, use Cargo to make a new project.

Make sure your terminal is at your `rust-learning-path` directory, and run the following command:

`cargo new hello-cargo`

This generates a new directory called `hello-cargo`, with the following files:

    hello-cargo
    |- Cargo.toml
    |- src
      |- main.rs

`Cargo.toml` is the manifest file for Rust. It's where you keep metadata for your project, as well as dependencies.

`src/main.rs` is where you'll write your application code.

You can see that `cargo new` generated a boilerplate "Hello, world!" project for us.

## Build and run your program with Cargo

To run this program, move into the new directory `hello-cargo`, and run this in your
terminal:

    $ cd hello-cargo
    $ cargo run

You should see this in your terminal:

       Compiling hello-cargo v0.1.0 (/tmp/.OFUp/hello-cargo)
        Finished dev [unoptimized + debuginfo] target(s) in 1.59s
         Running `target/debug/hello-cargo`
    Hello, world!

Cargo has built and executed your executable. Congratulations, you've just learned how to initialize your first Rust project with Cargo!

Lets write our Hello World program using Cargo this time.

## Create a new project

To start, we'll use Cargo to make a new project for us.

Make sure you terminal is at our `rust-learning-path` directory and run the following command:

`cargo new hello-cargo`

This will generate a new directory called `hello-cargo` with the following files:

    hello-cargo
    |- Cargo.toml
    |- src
      |- main.rs

`Cargo.toml` is the manifest file for Rust. It's where you keep metadata for your project, as well as dependencies.

`src/main.rs` is where we'll write our application code.

You can see that `cargo new` generated a boilerplate "Hello, world!" project for us!

## Building and running our program with Cargo

We can run this program by moving into the new directory `helo-cargo` and running this in our
terminal:

    $ cd hello-cargo
    $ cargo run

You should see this in your terminal:

       Compiling hello-cargo v0.1.0 (/tmp/.OFUp/hello-cargo)
        Finished dev [unoptimized + debuginfo] target(s) in 1.59s
         Running `target/debug/hello-cargo`
    Hello, world!

Congratulations! You've just learned how to initialize your first Rust project with Cargo!

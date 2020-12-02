Just compiling with `rustc` is fine for simple programs, but as your project grows, you’ll want to manage all the options and make it easy to share your code.

The good news is when you install `rustup` you'll also get the latest stable version of the Rust build tool and package manager, also known as Cargo.

Cargo does lots of things for you:

- create new project templates with `cargo new`
- build your project with `cargo build`
- run your project with `cargo run`
- test your project with `cargo test`
- build documentation for your project with `cargo doc`
- publish a library to crates.io with `cargo publish`

In the next unit we will rewrite our "Hello, world!" program using Cargo.

While the `rustc` compiler is fine for simple programs, almost no projects use the Rust compiler directly. Instead they use Rust's build tool and dependency manager, Cargo.

The good news is that when you install `rustup`, you'll also get the latest stable version of Cargo.

Cargo does lots of things for you, including:

- Creating new project templates with `cargo new`.
- Building your project with `cargo build`.
- Building and running your project with `cargo run`.
- Testing your project with `cargo test`.
- Checking your project type checks with `cargo check`.
- Building documentation for your project with `cargo doc`.
- Publishing a library to crates.io with `cargo publish`.

In the next unit, you'll rewrite your "Hello, world!" program by using Cargo.

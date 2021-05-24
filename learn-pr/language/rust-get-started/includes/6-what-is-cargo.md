While the `rustc` compiler is fine for simple programs, almost no projects use the Rust compiler directly. Instead they use Rust's build tool and dependency manager, Cargo.

The good news is that when you install `rustup`, you'll also get the latest stable version of Cargo.

Cargo does lots of things for you, including:

- Create new project templates with the `cargo new` command.
- Build a project with the `cargo build` command.
- Build and run a project with the `cargo run` command.
- Test a project with the `cargo test` command.
- Check project types with the `cargo check` command.
- Build documentation for a project with the `cargo doc` command.
- Publish a library to crates.io with the `cargo publish` command.

In the next unit, you'll rewrite your "Hello, world!" program by using Cargo.

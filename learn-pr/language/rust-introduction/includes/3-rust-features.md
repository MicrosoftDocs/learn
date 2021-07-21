In this unit, we'll review some unique features of Rust.

## Manage and organize Rust code

Rust offers a collection of features to manage and organize your code. These features are referred to as the "Rust module system." The system is composed of packages, modules, crates, and paths. 

### Paths

In Rust, you can use paths to name items in your code. For example, a path can be a data definition like a vector, a code function, or even a *module*.

### Modules
 
Modules help you organize your program by letting you manage the scope of the individual code items. You can group items that are related or used together into the same module.

The module feature also helps you control the privacy of your paths. You can specify the parts of your code that are accessible publicly versus parts that are private. This feature lets you hide the implementation details.

### Crates

Crates consist of a hierarchy of modules. The code in a crate is compiled together to create a binary executable or a library. In Rust, only crates are compiled as a reusable unit. 

### Packages

A package can have one or more binary-type crates. A package can also have one library-type crate, but it's not required. You can use packages to build, test, and share crates with the **Cargo** feature (described later in this unit). You can extract portions of a package into separate crates, which are then used as external dependencies. 

### The "use" keyword

The `use` keyword lets you use compiled code from a crate or other library in your program. With the `use` keyword, the code in a crate or library is "brought into scope" for use in your program.


## Use Rust libraries

There are tens of thousands of libraries available for use in your Rust program. You can access the compiled code in these libraries with the `use` keyword and add the functionality to your program. Here are some of the libraries you'll use for the exercises in this lesson:
 
- [crate std](https://doc.rust-lang.org/std/) - Rust standard library
- [crates.io](https://crates.io/) - Rust I/O library

For more Rust libraries, see the [Lib.rs catalog of programs and libraries for Rust](https://lib.rs/).


## Build projects with Cargo

The `rustc` compiler is commonly used to compile simple Rust programs, but most projects use a Rust build tool and dependency manager called **Cargo**.

Cargo does lots of things for you, including:

- Create new project templates with the `cargo new` command.
- Build a project with the `cargo build` command.
- Build and run a project with the `cargo run` command.
- Test a project with the `cargo test` command.
- Check project types with the `cargo check` command.
- Build documentation for a project with the `cargo doc` command.
- Publish a library to crates.io with the `cargo publish` command.


## Try recipes in the Rust cookbook

The Rust Cookbook contains *recipes* for code that follows recommended practices for common programming tasks. By following the recipes, you can learn how to work with commonly used crates in Rust. The recipes cover a wide-range of topics, including processing text and numbers, working with databases, applying common algorithms, and debugging programs. You can read the Rust Cookbook on the [Rust website](https://rust-lang-nursery.github.io/rust-cookbook/).


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check answers**.

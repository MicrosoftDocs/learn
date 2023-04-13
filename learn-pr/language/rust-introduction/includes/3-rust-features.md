To figure out if a programming language is suitable for your project, you need to know the features and the limitations. Then you can compare the possible languages and choose the one that will work best.

In this unit, we'll review some of the features and limitations of Rust:

- The Rust module system: modules, crates, and paths
- Rust standard libraries and third-party crates
- The Rust Cargo tool and dependency manager
- When to use Rust

## Manage code with the Rust module system

Rust offers a collection of features to help you manage and organize your code. These features are referred to as the **Rust module system**. The system is composed of *crates*, *modules*, and *paths*, and tools to work with those items.

- **Crates**: A Rust crate is a compilation unit. It's the smallest piece of code the Rust compiler can run. The code in a crate is compiled together to create a binary executable or a library. In Rust, only crates are compiled as reusable units. A crate contains a hierarchy of Rust modules with an implicit, unnamed top-level module.

- **Modules**: Rust modules help you organize your program by letting you manage the scope of the individual code items inside a crate. Related code items or items that are used together can be grouped into the same module. Recursive code definitions can span other modules.

- **Paths**: In Rust, you can use paths to name items in your code. For example, a path can be a data definition like a vector, a code function, or even a module. The module feature also helps you control the privacy of your paths. You can specify the parts of your code that are accessible publicly versus parts that are private. This feature lets you hide the implementation details.

## Use Rust crates and libraries

The Rust Standard Library `std` contains reusable code for fundamental definitions and operations in Rust programs. This library has definitions for core data types like `String` and `Vec<T>`, operations for Rust primitives, code for commonly used macro functions, support for input and output actions, and many other areas of functionality.

There are tens of thousands of libraries and third-party crates available to use in Rust programs most of which can be accessed through Rust's third-party crate repository [crates.io](https://crates.io). You'll learn later how to access these crates from your project, but for now here are some crates used in the programming exercises:

- [std](https://doc.rust-lang.org/std/) - The Rust standard library. In the Rust exercises, you'll notice the following modules:
  - std::collections - Definitions for collection types, such as `HashMap`.
  - std::env - Functions for working with your environment.
  - std::fmt - Functionality to control output format.
  - std::fs - Functions for working with the file system.
  - std::io - Definitions and functionality for working with input/output.
  - std::path - Definitions and functions that support working with file system path data.
- [structopt](https://crates.io/crates/structopt) - A third-party crate for easily parsing command-line arguments.
- [chrono](https://crates.io/crates/chrono) - A third-party crate to handle date and time data.
- [regex](https://crates.io/crates/regex) - A third-party crate to work with regular expressions. 
- [serde](https://crates.io/crates/serde) - A third-party crate of serialization and deserialization operations for Rust data structures.

By default, the `std` library is available to all Rust crates. To access the reusable code in a crate or library, we implement the `use` keyword. With the `use` keyword, the code in the crate or library is "brought into scope" so you can access the definitions and functions in your program. The standard library is accessed in `use` statements with the path `std`, as in `use std::fmt`. Other crates or libraries are accessed with their name, such as `use regex::Regex`.

## Create and manage projects with Cargo

While it's possible to use the Rust compiler (`rustc`) directly to build crates, most projects use the Rust build tool and dependency manager called **Cargo**.

Cargo does lots of things for you, including:

- Create new project templates with the `cargo new` command.
- Build a project with the `cargo build` command.
- Build and run a project with the `cargo run` command.
- Test a project with the `cargo test` command.
- Check project types with the `cargo check` command.
- Build documentation for a project with the `cargo doc` command.
- Publish a library to `crates.io` with the `cargo publish` command.
- Add dependent crates to a project by adding the crate name to the Cargo.toml file.

## When to use Rust

The Rust language has many strengths to consider when choosing the best language for your project:

- Rust allows for control over the performance and resource consumption of programs and libraries written in the language on par with C and C++, while still being memory safe by default. This level of control eliminates entire classes of common bugs.
- Rust has rich abstraction features that allow developers to encode many of the invariants of their program into code. the code is then checked by the compiler instead of relying on convention or documentation. This feature can often lead to the feeling of "if it compiles, it works."
- Rust has built-in tools for building, testing, documenting, and sharing code as well as a rich ecosystem of third-party tools and libraries. These tools can make some tasks that are difficult in some languages, such as building dependencies, easy and productive in Rust.


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.

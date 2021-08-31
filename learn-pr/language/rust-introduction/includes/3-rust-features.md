To figure out if a programming language is suitable for your project, you need to know the features and the limitations. Then you can compare the possible languages and choose the one that will work best.

In this unit, we'll review some of the features and limitations of Rust:

- The Rust module system: packages, modules, crates, and paths
- Rust standard libraries and third-party crates
- The Rust Cargo tool and dependency manager
- The Rust playground
- Limitations of Rust


## Manage code with the Rust module system

Rust offers a collection of features to help you manage and organize your code. These features are referred to as the "Rust module system." The system is composed of packages, modules, crates, and paths, and tools to work with those items. 

- **Crates**: A Rust crate is a compilation unit. It's the smallest piece of code the Rust compiler can run. The code in a crate is compiled together to create a binary executable or a library. In Rust, only crates are compiled as reusable units. A crate contains a hierarchy of Rust modules with an implicit, unnamed top-level module. 

- **Modules**: Rust modules help you organize your program by letting you manage the scope of the individual code items inside a crate. Related code items or items that are used together can be grouped into the same module. Recursive code definitions can span other modules.

- **Packages**: A Rust package contains functionality from one or more *binary* crates. A package can also have one *library* crate, but it's not required. The package includes instructions for how to build the crates. This information is kept in the Cargo.toml file. You can extract portions of a package into separate crates to use as external dependencies. 

- **Paths**: In Rust, you can use paths to name items in your code. For example, a path can be a data definition like a vector, a code function, or even a module. The module feature also helps you control the privacy of your paths. You can specify the parts of your code that are accessible publicly versus parts that are private. This feature lets you hide the implementation details.


## Use Rust crates and libraries

The Rust Standard Library `std` contains reusable code for fundamental definitions and operations in Rust programs. This library has definitions for core data types like `String` and Vec<T>`, operations for Rust primitives, code for commonly used macro functions, support for input and output actions, and many other areas of functionality. 

There are tens of thousands of libraries and third-party crates available to use in Rust programs. Here are some crates implemented in the Rust programming exercises:

- [std](https://doc.rust-lang.org/std/) - The Rust standard library. In the Rust exercises, you'll notice the following crates:
   - std::collections - Definitions for collection types, such as hashmap.
   - std::env - Functions for working with your environment.
   - std::fmt - Functionality to control output format.
   - std::fs - Functions for working with the file system.
   - std::io - Definitions and functionality for working with input/output.
   - std::path - Definitions and functions that support working with the path and data, such as buffers.
- [crates.io](https://crates.io/) - The Rust I/O library. The crates.io website is a central place where you can find and download packages.
- [structopt](https://crates.io/crates/structopt) - A third-party crate that provides an easy way to define a basic struct.
- [chrono](https://docs.rs/chrono/0.4.19/chrono/index.html) - A third-party crate of chronology functions to handle date and time data.
- [regex](https://docs.rs/regex/1.5.4/regex/) - A third-party crate of functions to work with regular expressions. 
- [serde](https://serde.rs/) - A third-party crate of serialization operations for Rust data structures.

For more Rust libraries, see the [Lib.rs catalog of programs and libraries for Rust](https://lib.rs/).

By default, the `std` library is available to all Rust crates. To access the reusable code in a crate or library, we implement the `use` keyword. This keyword lets you use the compiled code from a crate or library in your program. With the `use` keyword, the code in the crate or library is "brought into scope" so you can access the definitions and functions in your program. The standard library is accessed in `use` statements with the path `std`, as in `use std::fmt`. Other crates or libraries are accessed with their name, such as `use regex`. The supplemental keywords `self` and `super` are used with the `use` keyword to control the scope of the operation.


## Create and manage projects with Cargo

Basic Rust programs are often compiled by using the `rustc` compiler. Most other projects use a Rust build tool and dependency manager called **Cargo**.

Cargo does lots of things for you, including:

- Create new project templates with the `cargo new` command.
- Build a project with the `cargo build` command.
- Build and run a project with the `cargo run` command.
- Test a project with the `cargo test` command.
- Check project types with the `cargo check` command.
- Build documentation for a project with the `cargo doc` command.
- Publish a library to crates.io with the `cargo publish` command.
- Add dependent crates to a project by adding the crate name to the Cargo.toml file.


## Develop programs in the Rust playground

Sometimes you just want to try a bit of Rust code or check syntax for a definition in a Rust library. You might also be looking for a way to quickly share some code with others. The Rust language offers support for these tasks in the Rust playground.

The playground is an IDE for Rust development that's available on the internet at `https://play.rust-lang.org/`. Anyone can access the playground. You can write your code, and then compile and run your code in the same environment. The following screenshot shows the playground environment. At the far right on the toolbar, the **Configure** menu has options to set your preferences for the environment.

:::image type="content" source="../media/rust-playground-main.png" alt-text="Screenshot of the Rust playground that shows a basic program.":::

In the playground, you can access methods and functions in the Rust `std` standard library. The top 100 most-downloaded crates in the crates.io library are also available along with their dependencies.

There are some limitations in the playground that protect the site from being used in a malicious manner. The restrictions help to ensure the site remains available for all users.

- **Network**: When you compile or run code in the playground, a network connection isn't available.
- **Memory**: The playground limits the available memory to compile code and run a built program.
- **Execution time**: The playground sets a maximum amount of time to compile code and run a built program.
- **Disk**: The amount of available disk space to compile code and run a built program is limited.

You can read more about the features of the Rust playground on the [Rust website](https://play.rust-lang.org/help?azure-portal=true).


## Understand Rust limitations

The Rust language has some limitations to consider when choosing the best language for your project:

- Developing code with Rust isn't as fast as using a scripting language like Ruby or Python. The unique features of Rust involve a level of complexity that can take more time to grasp and implement.
- The Rust language requires explicit declarations for types and definitions for actions. The requirements are more rigorous than C++, and can involve significant more time and effort to implement.
- The Rust compiler is known to be slower than other popular languages like C++ and C. The built programs also tend to be larger and less efficient.
- Rust is a newer language. The libraries and third-party code aren't as mature as common functionality for other popular languages.
- Rust is known to leak memory, and compiled code can't rely on standard garbage collection.


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check answers**.

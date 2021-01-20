Before we start, it is important to explain the concepts behind code organization in Rust programs:

- A **package**:
  - Is one or more **crates** that provide a set of functionality.
  - Contains a `Cargo.toml` file that describes how to build those **crates**.
- A **crate**:
  - Is a compilation unit, which is the smallest amount of code that the Rust compiler can operate on.
  - Once compiled, produces either an executable or a library.
  - Contains an implicit, un-named top-level **module**.
- A **module**:
  - Is a *(possibly nested)* unit of code organization inside a **crate**.
  - Can have recursive definitions that span additional modules.

## Package

Whenever we run the command `$ cargo new <project-name>`, Cargo creates a package for us:

    $ cargo new my-project
         Created binary (application) `my-project` package

Here, we have a package that only contains `src/main.rs`, meaning it only contains a binary crate named `my-project`:

    my-project
    ├── src
    │  └── main.rs
    └── Cargo.toml

A package can have multiple binary crates by placing files in the `src/bin` directory: each file will be a separate binary crate.

If a package contains `src/main.rs` and `src/lib.rs`, it has two crates: a library and a binary, both with the same name as the package.

## Crates

Rust's compilation model centers on artifacts called **crates**, that can be compiled into a binary or into a library.

Every project that you create with the `cargo new` command is a crate, itself. All third party rust code that you can use as dependencies in your
project are also, each, a single crate.

## Library crates

We've already covered how to create a binary program, and creating a library is just as easy. To create a library, pass the `--lib` command line parameter to the `cargo new` command:

    $ cargo new --lib my-library
         Created library `my-library` package

You can see that, instead of a `src/main.rs` file, you now get a =src/lib.rs' file.

    my-library
    ├── src
    │  └── lib.rs
    └── Cargo.toml

When you tell Cargo to compile this crate, you'll get a library file called `libmy_library.rlib` that can be published and linked to other projects.

## Modules

Rust provides a powerful module system that can be used to hierarchically split code into logical units and that ease readability and reuse.

A module is a collection of items:

- Constants
- Type aliases
- Functions
- Structs
- Enums
- Traits
- `impl` blocks
- Other modules

Modules also control the *privacy* of items, which is whether an item can be used by outside code (*public*) or is an internal implementation detail and not available for outside use (*private*).

An example of a module:

```rust
mod math {
    type Complex = (f64, f64);
    pub fn sin(f: f64) -> f64 { /* ... */ }
    pub fn cos(f: f64) -> f64 { /* ... */ }
    pub fn tan(f: f64) -> f64 { /* ... */ }
}

println!("{}", math::cos(45.0));
```

If a source file has `mod` declarations in it, then the contents of the module files would be inserted in places where `mod` declarations in the source file are found, before running the compiler over it. In other words, modules do not get compiled individually, only crates get compiled.

You might've noticed the `pub` keyword at the beginning of the function definitions in the `math` module.

To control whether items can be used across modules, the Rust compiler perform checks to see whether they should be allowed or not. By default, everything in Rust is private and can only be accessed by the current module and its descendants. In contrast, when an item is declared as `pub`, it can be thought of as being accessible to the outside world. For example:

```rust
// Declare a private struct
struct Foo;

// Declare a public struct with a private field
pub struct Bar {
    field: i32,
}

// Declare a public enum with two public variants
pub enum State {
    PubliclyAccessibleVariant,
    PubliclyAccessibleVariant2,
}
```

Rust's privacy rules are surprisingly powerful for creating module hierarchies exposing public APIs while hiding internal implementation details.

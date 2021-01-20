You might have noticed that our custom types are a little difficult to use in practice. This simple `Point` struct cannot be compared to other `Point` instances or displayed in the terminal. Because of this, we might want to use the **derive** attribute to allow new items to automatically be generated for the struct.

## Downside of generic types

Take a look at the following code example:

```rust
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let p1 = Point { x: 1, y: 2 };
    let p2 = Point { x: 4, y: -3 };

    if p1 == p2 { // can't compare two Point values!
        println!("equal!");
    } else {
        println!("not equal!");
    }

    println!("{}", p1); // can't print using the '{}' format specifier!
    println!("{:?}", p1); //  can't print using the '{:?}' format specifier!

}
```

The preceding code will fail for three reasons. See the output below:

```output
    error[E0277]: `Point` doesn't implement `std::fmt::Display`
      --> src/main.rs:10:20
       |
    10 |     println!("{}", p1);
       |                    ^^ `Point` cannot be formatted with the default formatter
       |
       = help: the trait `std::fmt::Display` is not implemented for `Point`
       = note: in format strings you may be able to use `{:?}` (or {:#?} for pretty-print) instead
       = note: required by `std::fmt::Display::fmt`
       = note: this error originates in a macro (in Nightly builds, run with -Z macro-backtrace for more info)

    error[E0277]: `Point` doesn't implement `Debug`
      --> src/main.rs:11:22
       |
    11 |     println!("{:?}", p1);
       |                      ^^ `Point` cannot be formatted using `{:?}`
       |
       = help: the trait `Debug` is not implemented for `Point`
       = note: add `#[derive(Debug)]` or manually implement `Debug`
       = note: required by `std::fmt::Debug::fmt`
       = note: this error originates in a macro (in Nightly builds, run with -Z macro-backtrace for more info)

    error[E0369]: binary operation `==` cannot be applied to type `Point`
      --> src/main.rs:13:11
       |
    13 |     if p1 == p2 {
       |        -- ^^ -- Point
       |        |
       |        Point
       |
       = note: an implementation of `std::cmp::PartialEq` might be missing for `Point`

    error: aborting due to 3 previous errors#+end_example
```

This code fails to compile because our `Point` type does not implement the following traits:

- The `Debug` trait, that allows a type to be formatted using the `{:?}` format specifier, used in a programmer-facing, debugging context.
- The `Display` trait, that allows a type to be formatted using the `{}` format specifier, is
similar to `Debug`, but Display is better suited for user-facing output.
- The `PartialEq` trait, that allows implementors to be compared for equality.

## Using derive

Luckily, the `Debug` and `PartialEq` traits can be automatically implemented for us by the Rust compiler using the `#[derive(Trait)]` attribute, provided that each of its fields implements the trait:

```rust
#[derive(Debug, PartialEq)]
struct Point {
    x: i32,
    y: i32,
}
```

Our code will still fail to compile because Rust's standard library does not provide automatic
implementation for the `Display` trait, since it is meant for end users, but if we comment out that line our code would now produce this output:

```output
    Point { x: 1, y: 2 }
    not equal!
```

Nevertheless, we can implement the `Display` trait for our type by ourselves:

```rust
use std::fmt;

impl fmt::Display for Point {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
    write!(f, "({}, {})", self.x, self.y)
    }
}
```

and our code will then compile just fine:

```output
    (1, 2)
    Point { x: 1, y: 2 }
    not equal!
```

Check out the code of this example at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=83e972b28e9d02bd93540f9e292ad20b&azure-portal=true).

In this exercise, you'll transform a `Container` struct that only accepts positive integers of the `u32` type into a generic container that can hold values of any given type.

Don't edit any content inside the `main` function. This exercise is complete when the code compiles.

```rust
struct Container {
    value: u32,
}

impl Container {
    pub fn new(value: u32) -> Self {
    Container { value }
    }
}

fn main() {
    assert_eq!(Container::new(42).value, 42);
    assert_eq!(Container::new(3.14).value, 3.14);
    assert_eq!(Container::new("Foo").value, "Foo");
    assert_eq!(Container::new(String::from("Bar")).value, String::from("Bar"));
    assert_eq!(Container::new(true).value, true);
    assert_eq!(Container::new(-12).value, -12);
    assert_eq!(Container::new(Some("text")).value, Some("text"));
}
```

You can also view this exercise at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=deb167131f297b09ddd1df639e1b3be9&azure-portal=true).

To find a solution for this exercise, check out this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=b944b719262d7a86ba4dc801a78a2c71&azure-portal=true).

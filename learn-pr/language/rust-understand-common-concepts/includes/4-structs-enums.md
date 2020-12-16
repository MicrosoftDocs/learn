A Struct is a type that is composed of other types. Like tuples, the pieces of a struct can be
different types but you can name each piece of data so it’s clear what the values mean.

Structs in Rust come in three flavors: Structs with named fields, tuple structs, and unit structs.

```rust
// A struct with named fields
struct Person {
    name: String,
    age: u8,
    likes_oranges: bool
}

// A tuple struct
struct Point2D(u32, u32);

// A unit struct
struct Unit;
```

- **Regular structs** are the most commonly used. Each field defined within them has a name and a type,
  and once defined can be accessed using `example_struct.field` syntax.
- **Tuple structs** are similar to regular structs, but its fields have no names. For accessing
  individual variables, the same syntax is used as with regular tuples, namely `foo.0`, `foo.1`, etc,
  starting at zero.
- **Unit structs** are most commonly used as marker. They are useful when you need to implement a trait
  on something, but don't need to store any data inside it.

## Instantiating Structs

To use a struct after we’ve defined it, we create an instance of that struct by specifying concrete
values for each of the fields.

```rust
fn main() {
    // Instantiate a regular struct, with named fields. Order does not matter.
    let person = Person {
        name: String::from("Adam"),
        likes_oranges: true,
        age: 25
    };

    // Instantiate a tuple struct by passing the values in the same order as defined.
    let origin = Point2D(0, 0)

    // Instantiate a unit struct.
    let unit = Unit;
}
```

You can interact with the example above in this [Rust Playground Link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=1ee492e41152dd39f7190cfceebc6897?azure-portal=true).

## Enums

Enums are types that can be any one of several variants.

What Rust calls enums are more commonly known as [Algebraic Data Types](https://en.wikipedia.org/wiki/Algebraic_data_type?azure-portal=true)
if you're coming from a functional programming background. The important detail is that each enum
variant can have data to go along with it.

The `enum` keyword allows the creation of a type which may be one of a few different variants. Any
variant which is valid as a struct is also valid as an enum.

In the example below we define an enum to classify a web event. Each variant is independent and
store different amounts and types of values.

```rust
enum WebEvent {
    // An enum may either be unit-like,
    PageLoad,
    PageUnload,
    // An enum can include characters and strings
    KeyPress(char),
    Paste(String),
    // or include tuple structs
    Click { x: i64, y: i64 },
}
```

This enum has four variants with different types:

- `PageLoad` and `PageUnload` have no data associated with it at all.
- `Keypress` includes a single character in it.
- `Paste` includes a single String.
- `Click` includes an anonymous struct inside it.

Defining an enum with variants such as the one above is similar to defining different kinds of
struct definitions, except the enum doesn’t use the `struct` keyword and all the variants are
grouped together under the same `WebEvent` type.

If we chose to define separate structs for each variant, we could hold the same data that the
preceding enum variants held, but this would imply in each struct having its own type, and we
couldn’t as easily define a function to take any of these kinds of web events as we could with the
`WebEvent` enum, which is a single type.

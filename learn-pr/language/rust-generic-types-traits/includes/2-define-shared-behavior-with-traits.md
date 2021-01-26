A trait is a common interface that a group of types can implement. The Rust standard library has a lot of useful traits, such as:

- `io::Read` for values that can read bytes from a source.
- `io::Write` for values that can write out bytes.
- `Debug` for values that can be printed in the console using the "{:?}" format specifier.
- `Clone` for values that can be explicitly duplicated in memory.
- `ToString` for values that can be converted to a `String`.
- `Default` for types that have a sensible default value, like zero for numbers, empty for vectors, “” for `String`, etc.
- `Iterator` for types that can produce a sequence of values.

Each trait definition is a collection of methods defined for an unknown type, usually representing a capability or behavior that it's implementors can do.

To represent the concept of "having a 2-dimensional area", we can define the following trait:

```rust
trait Area {
    fn area(&self) -> f64;
}
```

Here, we declare a trait using the `trait` keyword and then the trait’s name, which is `Area` in this case.

Inside the curly brackets, we declare the method signatures that describe the behaviors of the types that implement this trait, which in this case is the function signature `fn area(&self) -> f64`. The compiler will then check that each type implementing this trait must provide its own custom behavior for the body of the method.

Now, lets create some new types that will implement our `Area` trait:

```rust
struct Circle {
    radius: f64,
}

struct Rectangle {
    width: f64,
    height: f64,
}

impl Area for Circle {
    fn area(&self) -> f64 {
    use std::f64::consts::PI;
    PI * self.radius.powf(2.0)
    }
}

impl Area for Rectangle {
    fn area(&self) -> f64 {
    self.width * self.height
    }
}
```

To implement a trait for a type, we use the keywords `impl Trait for Type`, where `Trait` is the name of the trait being implemented and `Type` is the name of the implementor struct or the enum.

Within the `impl` block, we put the method signatures that the trait definition has required, filling the method body with the specific behavior that we want the methods of the trait to have for the particular type.

When a type implements a given trait it is promising to uphold its contract. After implementing the trait, we can call the methods on instances of `Circle` and `Rectangle` in the same way we call regular methods, like this:

```rust
let circle = Circle { radius: 5.0 };
let rectangle = Rectangle {
    width: 10.0,
    height: 20.0,
};

println!("Circle area: {}", circle.area());
println!("Rectangle area: {}", rectangle.area());
```

You can interact with this code at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=62d721bd992978bf8c822154b65c013f&azure-portal=true).

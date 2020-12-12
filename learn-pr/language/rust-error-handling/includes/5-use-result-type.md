Rust provides the `Result<T, E>` enum for returning and propagating errors. By convention, the
`Ok(T)` variant represents a success and contains a value, while the variant `Err(E)` represents an
error and contains an error value.

It is prominently used for I/O operations, such as parsing strings into other types, attempts at acquiring network connections, file access and data validation.

It is defined as:

```rust
enum Result<T, E> {
    Ok(T):  // A value T was obtained.
    Err(E): // An error of type E was encountered, instead.
}
```

In contrast to the `Option` type, that describes the possibility of *absence*, the `Result` type is
best suited whenever *failures* are expected.

The `Result` type also has the `unwrap` and `expect` methods, that will return the value inside the
`Ok` variant, if it is the case, or cause the program to panic if the variant is a `Err`.. Use
pattern matching

Let's see `Result` in action. In the example below there is an implementation for a `safe_division`
function, that returns a `Result` value with an `Ok` variant carrying the result of a successful
division or an `Err` variant carrying an atomic struct `DivisionByZeroError`, signaling a
unsuccessfull division.

```rust
#[derive(Debug)]
struct DivisionByZeroError;

fn safe_division(dividend: f64, divisor: f64) -> Result<f64, DivisionByZeroError> {
    if divisor == 0.0 {
        Err(DivisionByZeroError)
    } else {
        Ok(dividend / divisor)
    }
}

fn main() {
    println!("{:?}", safe_division(9.0, 3.0));
    println!("{:?}", safe_division(4.0, 0.0));
    println!("{:?}", safe_division(0.0, 2.0));
}
```

You can check this program in the
[Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=4aca69ce1eb3e647997a38b6c92ace04?azure-portal=true).

The output of this program will be:

```output
    Ok(3.0)
    Err(DivisionByZeroError)
    Ok(0.0)
```

The `#[derive(Debug)]` part above the `DivisionByZeroError` struct is a macro that tells the Rust
compiler to make our type printable for debugging purposes. We will cover this in depth when we
reach the Traits module.

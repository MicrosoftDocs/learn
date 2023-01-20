Panicking is the simplest error handling mechanism in Rust.

You can use the `panic!` macro to *panic* the current thread. The macro prints an error message, frees resources, and then exits the program.

This example shows how to call the `panic!` macro:

```rust
fn main() {
    panic!("Farewell!");
}
```

This program would exit with status code *101* and print the following message:

```output
thread 'main' panicked at 'Farewell!', src/main.rs:2:5
```

The last part of the preceding panic message shows the location of the panic. It occurred in the *src/main.rs* file, on the fifth character of the second line.

In general terms, you should use `panic!` when a program reaches an unrecoverable state. A state where there's absolutely no way to recover from the error.

Rust panics on some operations such as a division by zero or an attempt to access an index that isn't present in an array, a vector, or a hash map, as shown in the following code:

```rust
let v = vec![0, 1, 2, 3];
println!("{}", v[6]); // this will cause a panic!
```

In the next unit, you learn how to handle such errors without causing your program to panic.

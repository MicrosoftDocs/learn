Panicking is the simplest error handling mechanism in Rust.

You can use the `panic!` macro to panic the current thread. It prints an error message, unwind and clean up the stack and exits the program.

Let’s try calling the `panic!` macro in a simple program:

```rust
fn main() {
    panic!("Farewell!");
}
```

This program would exit with status code `101` and print the following message:

```output
thread 'main' panicked at 'Farewell!', src/main.rs:2:5
```

The panic message reveals to us the place in our source code where the panic occurred: `src/main.rs:2:5` indicates that it’s the second line, fifth character of our `src/main.rs` file.

In general terms, `panic!` should be used when a program reaches an unrecoverable state.

Rust can also emit a panic on some operations, such as a division by zero or when you try to access an index which isn't in a Array, Vector or Hashmap:

```rust
let v = vec![0, 1, 2, 3];
println!("{}", v[6]); // this will cause a panic!
```

In the next unit we are going to learn how to handle such kind of errors without causing our program to panic.

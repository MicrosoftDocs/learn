In Rust, memory is managed through an ownership system, which is a set of rules checked at compile time. None of the ownership features slow down your program while it's running.

To understand ownership, let's first take a look at Rust's *scoping rules* and *move semantics*.

## Scoping rules

In Rust, variables are valid only within a certain *scope* that's denoted by curly brackets `{}`.

Let's say we have a `mascot` variable that's a string literal, defined within a scope:

```rust
// `mascot` is not valid here, because it's not yet declared.
{
    let mascot = "ferris";   // `mascot` is valid from this point forward.
    // do stuff with `mascot`.
}
// this scope is now over, so `mascot` is no longer valid.
```

The variable is valid from the point at which it's declared until the end of that scope. Whenever an object goes out of scope, its resources are freed from memory.

If we try to use `mascot` beyond its scope, we'll get an error like this:

```rust
{
    let mascot = "ferris";
}
println!("{}", mascot);
```

```output
    error[E0425]: cannot find value `mascot` in this scope
     --> src/main.rs:5:20
      |
    5 |     println!("{}", mascot);
      |                    ^^^^^^ not found in this scope
```

You can run this example online in the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=1fc552675319bd4a6954339519513f6e&azure-portal=true).

## Move semantics

The same scoping rules happen inside `function` bodies. The function's parameters enter the scope, but only the returned value lives after the function exists. All the input parameters and local variables are released from memory.

In the following example, a string is sent to a function that doesn't return it:

```rust
fn process(input: String) { }

fn caller() {
    let s = String::from("Hello, world!");
    process(s); // Transfers ownership of `s` to `process`
    process(s); // Error! ownership already transferred.
}
```

The compiler complains about the value `greeting` being *moved*.

```output
    error[E0382]: use of moved value: `s`
     --> src/main.rs:6:13
      |
    4 |     let s = String::from("Hello, world!");
      |         - move occurs because `s` has type `String`, which does not implement the `Copy` trait
    5 |     process(s); // Transfers ownership of `s` to `process`
      |             - value moved here
    6 |     process(s); // Error! ownership already transferred.
      |             ^ value used here after move
```

As you can see in the preceding snippet, the first call to `process` transfers ownership of the variable `s`. The compiler tracks ownership, so the second call to `process` results in an error. After resources are moved, the previous owner can no longer be used.

*Moving* a value is a way to transfer ownership of its underlying resources. For example, moving a string would transfer the string's buffer instead of copying it.

This pattern has a profound impact on the way Rust code is written. It's central to the promise of memory safety that Rust proposes.

In other programming languages, the `String` value of the `greeting` variable can be implicitly copied before being passed to our function. But in Rust, that happens only for types that implement the `Copy` trait. You might have noticed that in the (rather informative) compiler error message.

In Rust, ownership transfer (that is, moving) is the default behavior.

Most inexperienced programmers try to work around this error by cloning the values passed to the function. A call to `.clone` will duplicate the memory and produce a new value, which prevents the move.

```rust
fn process(s: String) {}

fn main() {
    let s = String::from("Hello, world!");
    process(s.clone()); // Passing another value, cloned from `s`.
    process(s);
}
```

This approach is simpler but often results in unnecessary allocations. We can avoid unnecessary allocations if we use *references*, the topic of our next unit.

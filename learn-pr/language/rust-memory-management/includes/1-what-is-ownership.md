In Rust, memory is managed through an ownership system, which is a set of rules checked at compile time. None of the ownership features slow down your program while it’s running.

To understand ownership, we must first take a look at Rust's *scoping rules* and *move semantics*.

## Scoping Rules

In Rust, variables are only valid within a certain *scope*, denoted by curly brackets `{}`.

Let’s say we have a `mascot` variable that is a string literal, defined within a scope:

```rust
// `mascot` is not valid here, it’s not yet declared.
{
    let mascot = "ferris";   // `mascot` is valid from this point forward.
    // do stuff with `mascot`.
}
// this scope is now over, `mascot` is no longer valid.
```

It is valid from the point at which it’s declared until the end of that scope. Whenever an object
goes out of scope its resources are freed from memory.

If we try to use `mascot` beyond its scope, we will get an error like this:

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

You can run this example online at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=1fc552675319bd4a6954339519513f6e&azure-portal=true).

## Move Semantics

The same scoping rules happens inside `function` bodies. The function's parameters enters the scope but only the returned value lives after the function exists. All the input parameters and local variables are released from memory.

Consider the following example, in which we have a String being sent to a function that doesn't return it:

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

As you can see in the snippet above, the first call to `process` transfers ownership of the variable `s`. The compiler tracks ownership, so the second call to `process` results in an error, because after moving resources, the previous owner can no longer be used.

*Moving* a value is a way to transfer **ownership** of its underlying resources. For example, moving a string would transfer the string’s buffer rather than copying it.

This pattern has a profound impact on the way Rust code is written, as it is central to the promise of memory safety that Rust proposes.

In other programming languages, the `String` value held by the `greeting` variable could be implicitly copied before being passed to our function, but in Rust that only happens for types that implements the `Copy` trait, as you might have noticed in the (rather informative) compiler error message.

In Rust, ownership transfer *(also known as moving)* is the default behavior.

Most inexperienced programmers try to work around this error by cloning the values passed to the function. A call to `.clone` will duplicate the memory and produce a new value, preventing the move to occur.

```rust
fn process(s: String) {}

fn main() {
    let s = String::from("Hello, world!");
    process(s.clone()); // Passing another value, cloned from `s`.
    process(s);
}
```

This approach is simpler, but often results in unnecessary allocations, which could be avoided if we used *references*, the topic of our next unit.

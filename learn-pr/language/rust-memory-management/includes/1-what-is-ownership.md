Rust includes an ownership system to manage memory. At compile time, the ownership system checks a set of rules 
to ensure that the ownership features allow your program to run without slowing down.

To understand ownership, let's first take a look at Rust's *scoping rules* and *move semantics*.

## Scoping rules

In Rust, like most other programming languages, variables are valid only within a certain *scope*. In Rust, scopes are often denoted by using curly brackets `{}`. Common scopes include function bodies and `if`, `else`, and `match` branches.

> [!NOTE]
> In Rust, "variables" are often called "bindings". This is because "variables" in Rust aren't very variable - they don't change that often since they're unchangeable by default. Instead, we often think about names being "bound" to data, hence the name "binding". In this module, we'll use the terms "variable" and "binding" interchangeably.

Let's say we have a `mascot` variable that's a string, defined within a scope:

```rust
// `mascot` is not valid and cannot be used here, because it's not yet declared.
{
    let mascot = String::from("ferris");   // `mascot` is valid from this point forward.
    // do stuff with `mascot`.
}
// this scope is now over, so `mascot` is no longer valid and cannot be used.
```

If we try to use `mascot` beyond its scope, we'll get an error like this example:

```rust
{
    let mascot = String::from("ferris");
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

You can run this example online in the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=5734858af1e100f6ca2ef73be02e89ab&azure-portal=true).

The variable is valid from the point at which it's declared until the end of that scope.

## Ownership and dropping

Rust adds a twist to the idea of scopes. Whenever an object goes out of scope, it's "dropped." Dropping a variable releases any resources that are tied to it. For variables of files, the file ends up being closed. For variables that have allocated memory associated with them, the memory is freed.

In Rust, bindings that have things "associated" with them that they'll free when the binding is dropped are said to "own" those things.

In the previous example, the `mascot` variable owns the String data associated with it. The `String` itself owns the heap-allocated memory that holds the characters of that string. At the end of the scope, `mascot` is "dropped", the `String` it owns is dropped, and finally the memory that `String` owns is freed.

```rust
{
    let mascot = String::from("ferris");
    // mascot dropped here. The string data memory will be freed here.
}
```

## Move semantics

Sometimes, though, we don't want the things associated with a variable to be dropped at the end of scope. Instead, we want to transfer ownership of an item from one binding to another.

The simplest example is when declaring a new binding:

```rust
{
    let mascot = String::from("ferris");
    // transfer ownership of mascot to the variable ferris.
    let ferris = mascot;
    // ferris dropped here. The string data memory will be freed here.
}
```

A key thing to understand is that once ownership is transferred, the old variable is no longer valid. In our previous example, after we transfer ownership of the `String` from `mascot` to `ferris`, we can no longer use the `mascot` variable.

In Rust, "transferring ownership" is known as "moving". In other words, the ownership of the `String` value has been *moved* from `mascot` to `ferris`.

If we try to use `mascot` after the `String` has been moved from `mascot` to `ferris`, the compiler won't compile our code:

```rust
{
    let mascot = String::from("ferris");
    let ferris = mascot;
    println!("{}", mascot) // We'll try to use mascot after we've moved ownership of the string data from mascot to ferris.
}
```

```output
error[E0382]: borrow of moved value: `mascot`
 --> src/main.rs:4:20
  |
2 |     let mascot = String::from("ferris");
  |         ------ move occurs because `mascot` has type `String`, which does not implement the `Copy` trait
3 |     let ferris = mascot;
  |                  ------ value moved here
4 |     println!("{}", mascot);
  |                    ^^^^^^ value borrowed here after move
```

This result is known as a "use after move" compile error.

> [!Important]
> In Rust, only one thing can ever *own* a piece of data at a time.

## Ownership in functions

Let's take a look at an example of a string being passed to a function as an argument. Passing something as an argument to a function *moves* that thing into the function.

```rust
fn process(input: String) {}

fn caller() {
    let s = String::from("Hello, world!");
    process(s); // Ownership of the string in `s` moved into `process`
    process(s); // Error! ownership already moved.
}
```

The compiler complains that the value `s` was *moved*.

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

This pattern has a profound effect on the way Rust code is written. It's central to the promise of memory safety that Rust proposes.

In other programming languages, the `String` value of the `s` variable can be implicitly copied before being passed to our function. But in Rust, this action doesn't happen.

In Rust, ownership transfer (that is, moving) is the default behavior.

## Copying instead of moving

In the previous example, you might have noticed the mention of the `Copy` trait in the (rather informative) compiler error messages. We haven't talked about traits yet, but a value that implements the `Copy` trait, isn't moved but is copied.

Let's take a look at a value that implements the `Copy` trait: `u32`. The following code mirrors our broken code, but it compiles without issue.

```rust
fn process(input: u32) {}

fn caller() {
    let n = 1u32;
    process(n); // Ownership of the number in `n` copied into `process`
    process(n); // `n` can be used again because it wasn't moved, it was copied.
}
```

Simple types like numbers are *copy* types. They implement the `Copy` trait, which means they're copied rather than moved. The same action occurs for most simple types. Copying numbers is inexpensive, so it makes sense for these values to be copied. Copying strings or vectors or other complex types can be expensive, so they don't implement the `Copy` trait and are instead moved.

## Copying types that don't implement `Copy`

One way to work around the errors we saw in the previous example is by *explicitly* copying types before they're moved: known as cloning in Rust. A call to `.clone` will duplicate the memory and produce a new value. The new value is moved meaning the old value can still be used.

```rust
fn process(s: String) {}

fn main() {
    let s = String::from("Hello, world!");
    process(s.clone()); // Passing another value, cloned from `s`.
    process(s); // s was never moved and so it can still be used.
}
```

This approach can be useful, but it can make your code slower as every call to `clone` makes a full copy of the data. This method often includes memory allocations or other expensive operations. We can avoid these costs if we "borrow" values by using *references*. We'll learn how to use references in the next unit.

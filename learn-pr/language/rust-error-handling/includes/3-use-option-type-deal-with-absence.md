Rust standard library provides the `Option<T>` enum to be used when the absence of a value is a possibility. It is widely used in Rust code because it encodes the very common scenario in which a value could be something or it could be nothing.

It manifests itself as one of two "options":

```rust
enum Option<T> {
    None,     // No element was found
    Some(T),  // An element of type T was found
}
```

The `<T>` part in the `Option<T>` enum declaration states that the type `T` is generic, and will be
associated with the `Some` variant of the `Option` enum.

In the previous unit, we mentioned that a trying to access a Vector's non-existing index would cause
our program to `panic`, but we could avoid that by using the `Vec::get` method, that returns us an
`Option` type instead of panicking. If the value exists at the given index, it is wrapped in the
`Option::Some(value)` variant. If the index is out of bounds, it would return a `Option::None` value
instead.

Let's give it a try. You can run the code below either locally or via this
[Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=14dcb7b524b0448c946b85ef9b28908c?azure-portal=true).

```rust
let fruits = vec!["banana", "apple", "coconut", "orange", "strawberry"];

// pick the first item:
let first = fruits.get(0);
println!("{:?}", first);

// pick the third item:
let third = fruits.get(2);
println!("{:?}", third);

// pick the 99th item, which is non-existent:
let non_existent = fruits.get(99);
println!("{:?}", non_existent);
```

The output will be:

```output
Some("banana")
Some("coconut")
None
```

The printed messages tells us that the first two attempts at accessing existing indexes in our `fruits` array resulted in `Some("banana")` and `Some("coconut")`, but our attempt of fetching the 99th element returned a `None` value *(which isn't associated with any data)* instead of panicking.

In practice, we must decide how our program behaves depending on what variant of a enum it gets. But how can we access the data inside a `Some(data)` variant?

## Pattern Matching

Rust has an extremely powerful control flow operator called `match` that allows you to compare a value against a series of patterns and then execute code based on which pattern matches.

```rust
let fruits = vec!["banana", "apple", "coconut", "orange", "strawberry"];
for &index in [0, 2, 99].iter() {
    match fruits.get(index) {
    Option::Some(fruit_name) => println!("It's a delicious {}!", fruit_name),
    Option::None => println!("There is no fruit! :("),
    }
}
```

You can try running this example in the
[Rust Playground](https://play.rust-lang.org/?version=nightly&mode=debug&edition=2018&gist=bf5526cc6a1b8d02f90b790e5ae2844d?azure-portal=true).

The output will be:

```output
    It's a delicious banana!
    It's a delicious coconut!
    There is no fruit! :(
```

In the code above, we iterate through the same indexes from our previous example (0, 2 and 99) and use each one to retrieve a value from the `fruits` vector using the `fruits.get(*index)` expression.

Since our `fruits` vector contains `&str` elements, we know that the result of this expression is of type `Option<&str>`. We then use a `match` expression against the `Option` value and define a course of action for each of its variants. Rust refers to those branches as "match arms", and each arm can handle one possible outcome for the matched value.

We can even refine our `match` expression even further to also act differently depending on the values inside a `Some` variant . Suppose we wan't to stress the fact that coconuts are awesome:

```rust
let fruits = vec!["banana", "apple", "coconut", "orange", "strawberry"];
for &index in [0, 2, 99].iter() {
    match fruits.get(index) {
    Some(&"coconut") => println!("Coconuts are awesome!!!"),
    Some(fruit_name) => println!("It's a delicious {}!", fruit_name),
    None => println!("There is no fruit! :("),
    }
}
```

You can try running this example in the
[Rust Playground](https://play.rust-lang.org/?version=nightly&mode=debug&edition=2018&gist=bf5526cc6a1b8d02f90b790e5ae2844d?azure-portal=true).

The output will be:

```output
    It's a delicious banana!
    Coconuts are awesome!!!
    There is no fruit! :(
```

Notice that when the string value is `"coconut"` the first arm will be matched and then used to
determine the flow of execution.

Whenever you use the `match` expression, keep the following rules in mind:

1. match arms are evaluated top-to-bottom, so specific cases must be defined earlier than generic cases, or they will never be matched and evaluated!
2. match arms must cover every possible value of the input type could possibly have. You'll get a compiler error if you try to match against a non-exhaustive pattern list.

## The `if let` expression

Rust offers a convenient way to test if a a value conforms with a single pattern.

Consider the example below that matches on an `Option<u8>` value but only wants to execute code if the value is **7**.

```rust
let some_number: Option<u8> = Some(7);
match some_number {
    Some(7) => println!("That's my lucky number!"),
    _ => (),
}
```

We want to do something with the `Some(7)` match but ignore other `Some<u8>` values or the `None` variant. The underscore `_` wildcard pattern can be added after all other patterns to match "anything else", and it is used to satisfy the compiler demands for exhausting match arms.

We could write this in a shorter way using `if let`. The following code behaves the same as the previous one:

```rust
if let Some(7) = some_u8_value {
    println!("That's my lucky number!");
}
```

A `if let` expression takes a pattern and an expression separated by an equal sign. If the pattern matches, the `if` block is executed. The nice thing about `if let` expressions is that you don't need all the boilerplate code of a `match` expression for when you're interested in a single pattern
to match against.

## Using `unwrap` and `expect`

You can try to access the inner value of an `Option` type directly using the `unrwap` method, but be careful as this method will panic if the variant is a `None`.

For instance:

```rust
let gift = Some("candy");
assert_eq!(gift.unwrap(), "candy");

let empty_gift: Option<&str> = None;
assert_eq!(empty_gift.unwrap(), "candy"); // This will panic!
```

In the case above, the code would panic with the following output:

```output
    thread 'main' panicked at 'called `Option::unwrap()` on a `None` value', src/main.rs:6:27
```

Because this function may panic, its use is generally discouraged. Instead, prefer to use pattern matching and handle the `None` case explicitly, or call similar non-panicking methods, such as `unwrap_or`, which returns a default value if the variant is `None` or the inner value if the variant is `Some(value)` :

```rust
assert_eq!(Some("dog").unwrap_or("cat"), "dog");
assert_eq!(None.unwrap_or("cat"), "cat");
```

The `expect` method does the same as `unrwap` but provides a custom panic message provided by its
second argument.

```rust
let a = Some("value");
assert_eq!(a.expect("fruits are healthy"), "value");

let b: Option<&str> = None;
b.expect("fruits are healthy"); // panics with `fruits are healthy`
```

The output will show:

```output
    thread 'main' panicked at 'fruits are healthy', src/main.rs:6:7
```

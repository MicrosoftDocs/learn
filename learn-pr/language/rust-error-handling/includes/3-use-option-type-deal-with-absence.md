The Rust standard library provides an `Option<T>` enum to be used when the absence of a value is a possibility. `Option<T>` is widely used in Rust code. It's useful for working with values that might exist or that might be empty.

In many other languages absence of a value would be modeled using `null` or `nil`, but Rust doesn't use `null` outside of code that interoperates with other languages. Rust is explicit about when a value is optional. While in many languages, a function that takes a `String` might actually take either a `String` or `null`, in Rust, that same function can only take an actual `String`. If you want to model an optional string in Rust, you need to explicitly wrap it in an `Option` type: `Option<String>`. 

`Option<T>` manifests itself as one of two variants:

```rust
enum Option<T> {
    None,     // The value doesn't exist
    Some(T),  // The value exists
}
```

The `<T>` part of the `Option<T>` enum declaration states that the type `T` is generic and will be associated with the `Some` variant of the `Option` enum.

As discussed in previous sections, `None` and `Some` aren't types but are variants of the `Option<T>` type, meaning, among other things, that functions can't take `Some` or `None` as arguments but only `Option<T>`.

In the preceding unit, we mentioned that trying to access a vector's non-existent index would cause the program to `panic`, but you could avoid that by using the `Vec::get` method, which returns an `Option` type instead of panicking. If the value exists at a specified index, it's wrapped in the `Option::Some(value)` variant. If the index is out of bounds, it would return an `Option::None` value instead.

Let's give it a try. You can run the following code locally or on the [Rust playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=14dcb7b524b0448c946b85ef9b28908c?azure-portal=true).

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

The output shows:

```output
Some("banana")
Some("coconut")
None
```

The printed message says that the first two attempts at accessing the existing indexes in the `fruits` array resulted in `Some("banana")` and `Some("coconut")`, but the attempt to fetch the 99th element returned a `None` value (which isn't associated with any data) instead of panicking.

In practice, you must decide how your program behaves depending on what enum variant it gets. But how can we access the data inside a `Some(data)` variant?

## Pattern matching

There's a powerful operator in Rust that's called `match`. You can use it to control the flow of your program by providing patterns. When `match` finds a matching pattern, it runs code that you supply with that pattern.

```rust
let fruits = vec!["banana", "apple", "coconut", "orange", "strawberry"];
for &index in [0, 2, 99].iter() {
    match fruits.get(index) {
        Some(fruit_name) => println!("It's a delicious {}!", fruit_name),
        None => println!("There is no fruit! :("),
    }
}
```

You can try running this example on the [Rust playground](https://play.rust-lang.org/?version=nightly&mode=debug&edition=2018&gist=6572d38d80d19d44afba3a45834bfdd6?azure-portal=true).

The output shows:

```output
It's a delicious banana!
It's a delicious coconut!
There is no fruit! :(
```

In the preceding code, we iterate through the same indexes from our previous example (0, 2, and 99) and then use each one to retrieve a value from the `fruits` vector by using the *fruits.get(index)* expression.

Because  the `fruits` vector contains `&str` elements, we know that the result of this expression is of type `Option<&str>`. You then use a *match* expression against the `Option` value and define a course of action for each of its variants. Rust refers to those branches as *match arms*, and each arm can handle one possible outcome for the matched value.

The first arm introduces a new variable, `fruit_name`. This variable matches any value inside a `Some` value. The scope of `fruit_name` is limited to the *match* expression, so it doesn't make sense to declare `fruit_name` before introducing it in `match`.

You can refine your *match* expression even further to act differently, depending on the values inside a `Some` variant. For example, you could stress the fact that coconuts are awesome by running the following code:

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

> [!NOTE]
> The first pattern in the match is `Some(&"coconut")` (note the `&` before the string literal). This is because `fruits.get(index)` returns an `Option<&&str>` or an option of a reference to a string slice.
> Removing `&` in the pattern would mean we are trying to match against an `Option<&str>` (an optional string slice *not* an optional reference to a string slice). We haven't covered references so this 
> might not make full sense right now. For now, just remember the `&` is making sure the types line up properly.


You can try running this example on the [Rust playground](https://play.rust-lang.org/?version=nightly&mode=debug&edition=2018&gist=060f6d3ffa5186f8287f56d1e24cca1e?azure-portal=true).

The output shows:

```output
It's a delicious banana!
Coconuts are awesome!!!
There is no fruit! :(
```

When the string value is `"coconut"`, the first arm is matched and then used to determine the flow of execution.

Whenever you use the *match* expression, keep the following rules in mind:

* `match` arms are evaluated from top to bottom. Specific cases must be defined earlier than generic cases or they'll never be matched and evaluated.
* `match` arms must cover every possible value that the input type could have. You'll get a compiler error if you try to match against a non-exhaustive pattern list.

## The *if let* expression

Rust offers a convenient way to test whether a value conforms with a single pattern.

In the following example, the input to `match` is an `Option<u8>` value. The `match` expression should only run code if that input value is *7*.

```rust
let a_number: Option<u8> = Some(7);
match a_number {
    Some(7) => println!("That's my lucky number!"),
    _ => {},
}
```

In this case, we'd like to ignore the `None` variant and all `Some<u8>` values that don't match `Some(7)`. Wildcard patterns are useful for this type of situation. You can add the `_` (underscore) wildcard pattern after all other patterns to match *anything else*, and it's used to satisfy the compiler demands for exhausting match arms.

To condense this code, you can use an *if let* expression:

```rust
let a_number: Option<u8> = Some(7);
if let Some(7) = a_number {
    println!("That's my lucky number!");
}
```

An *if let* operator compares a pattern with an expression. If the expression matches the pattern, the *if* block is executed. The nice thing about *if let* expressions is that you don't need all the boilerplate code of a *match* expression when you're interested in a single pattern to match against.

## Use `unwrap` and `expect`

You can try to access the inner value of an `Option` type directly by using the `unwrap` method. Be careful, though, because this method will panic if the variant is a `None`.

For instance:

```rust
let gift = Some("candy");
assert_eq!(gift.unwrap(), "candy");

let empty_gift: Option<&str> = None;
assert_eq!(empty_gift.unwrap(), "candy"); // This will panic!
```

In this case, the code would panic with the following output:

```output
    thread 'main' panicked at 'called `Option::unwrap()` on a `None` value', src/main.rs:6:27
```

The `expect` method does the same as `unwrap`, but it provides a custom panic message that's provided by its second argument:

```rust
let a = Some("value");
assert_eq!(a.expect("fruits are healthy"), "value");

let b: Option<&str> = None;
b.expect("fruits are healthy"); // panics with `fruits are healthy`
```

The output shows:

```output
    thread 'main' panicked at 'fruits are healthy', src/main.rs:6:7
```

Because these functions might panic, we don't recommend using them. Instead, consider either of the following approaches:
* Use pattern matching and handle the `None` case explicitly.
* Call similar non-panicking methods, such as `unwrap_or`, which returns a default value if the variant is `None` or the inner value if the variant is `Some(value)`.

```rust
assert_eq!(Some("dog").unwrap_or("cat"), "dog");
assert_eq!(None.unwrap_or("cat"), "cat");
```

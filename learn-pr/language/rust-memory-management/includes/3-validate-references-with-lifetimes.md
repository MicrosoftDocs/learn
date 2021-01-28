Lifetimes are Rust's answer to the question of memory safety. They allow Rust to ensure memory safety without the performance costs of garbage collection.

The main goal of lifetimes is to prevent dangling references, which cause a program to reference data other than the data it's intended to reference.

Consider the following snippet, which tries to use a reference whose value has gone out of scope:

```rust
fn main() {
    let x;
    {
        let y = 42;
        x = &y;
    }
    println!("x: {}", x);
}
```

The preceding code fails to compile with the following error message:

```output
    error[E0597]: `y` does not live long enough
     --> src/main.rs:6:17
      |
    6 |             x = &y;
      |                 ^^ borrowed value does not live long enough
    7 |         }
      |         - `y` dropped here while still borrowed
    8 |         println!("x: {}", x);
      |                           - borrow later used here
```

This error occurs because a value was dropped while it was still borrowed. In this case, `y` is dropped at the end of the inner scope, but `x` borrows it until the `println` call. Because `x` is still valid for the outer scope *(because its scope is larger)*, we say that it "lives longer."

Here's the same code snippet with drawings around each variable lifetime. We gave each lifetime a name:

- `'a` is the lifetime annotation for our value `x`.
- `'b` is the lifetime annotation for our value `y`.

```rust
fn main() {
    let x;                // ---------+-- 'a
    {                     //          |
        let y = 42;       // -+-- 'b  |
        x = &y;           //  |       |
    }                     // -+       |
    println!("x: {}", x); //          |
}
```

Here we can see that the inner `'b` lifetime block is shorter than the outer `'a` block.

At compile time, the borrow checker compares the two lifetimes and sees that `x` has a lifetime of `'a` but that it refers to a value with a lifetime of `'b`. The program fails to compile
because the subject of the reference *(`y` at lifetime `'b`)* doesn't live as long as the reference *(`x` at lifetime `'a`)*.

## Annotating lifetimes in functions

Just as with types, lifetimes are implicit and inferred by the Rust compiler most of the time.

When multiple lifetimes are possible, we must annotate them to help the compiler understand which lifetime it will consider to ensure that the references used at runtime will be valid.

For example, consider a function that takes two strings as its input parameters and returns the longest of them:

```rust
fn main() {
    let magic1 = String::from("abracadabra!");
    let magic2 = String::from("shazam!");

    let result = longest_word(magic1, magic2);
    println!("The longest magic word is {}", result);
}

fn longest_word(x: &str, y: &str) -> &str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

The preceding code fails to compile with an informative error message:

```output
    error[E0106]: missing lifetime specifier
     --> src/main.rs:9:38
      |
    9 | fn longest_word(x: &str, y: &str) -> &str {
      |                    ----     ----     ^ expected named lifetime parameter
      |
      = help: this function's return type contains a borrowed value, but the signature does not say whether it is borrowed from `x` or `y`
    help: consider introducing a named lifetime parameter
      |
    9 | fn longest_word<'a>(x: &'a str, y: &'a str) -> &'a str {
      |                ^^^^    ^^^^^^^     ^^^^^^^     ^^^
```

The help text says Rust can't tell whether the reference that's being returned refers to `x` or `y`. Neither can we. So the return type needs to be annotated with a generic lifetime parameter.

The lifetimes might be different each time the function is called. We don't know the concrete lifetimes of the references that will be passed to our `longest_word` function, and we can't determine if the reference that will be returned will always be a valid one.

The borrow checker can't determine this either, because it doesn't know how the lifetimes of the input parameters relate to the lifetime of the return value. This is why we need to annotate the lifetimes manually.

Luckily, the compiler gave us a hint on how to fix this error. We can add generic lifetime parameters to our function signature. These parameters define the relationship between the references so the borrow checker can perform its analysis:

```rust
fn longest_word<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

You can try this code at the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=39c0e9eab0903d6b16f97e712709426a&azure-portal=true).

Generic lifetime parameters are annotated inside angle brackets between the function name and the parameter list. Because the constraint that we want to express in this signature is *that all the references in the parameters and the return value must have the same lifetime*, we use the same lifetime name `'a` and then add it to each reference in the function signature.

There's nothing special about the name `'a` in this case. It would be just as fine to use any other word, such as `'response` or `'program`. The important thing to keep in mind is that all parameters and the returned value will live at least as long as the lifetime associated with each of them.

Let's experiment with this sample code and change some values and lifetimes of the references passed in to the `longest_word` function to see how it behaves. The compiler would also reject the following snippet, but can you guess why?

```rust
fn main() {
    let magic1 = String::from("abracadabra!");
    let result;
    {
        let magic2 = String::from("shazam!");
        result = longest_word(magic1, magic2);
    }
    println!("The longest magic word is {}", result);
}

fn longest_word<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

You'll find this snippet at the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=8624616d4aede430f4c74d168dcfba01&azure-portal=true).

If you guessed that this code is broken, you're right. This time, we see the following error:

```output
    error[E0597]: `magic2` does not live long enough
     --> src/main.rs:6:40
      |
    6 |         result = longest_word(&magic1, &magic2);
      |                                        ^^^^^^^ borrowed value does not live long enough
    7 |     }
      |     - `magic2` dropped here while still borrowed
    8 |     println!("The longest magic word is {}", result);
      |                                              ------ borrow later used here
```

This error shows that the compiler expected the lifetime of `magic2` to be the same as the lifetime of the returned value and of the `x` input argument. Rust knows this because we annotated the lifetimes of the function parameters and return value by using the same lifetime name: `'a`.

If we were to inspect the code, as humans, we would see that `magic1` is longer than `magic2`. We would see that the result contains a reference to `magic1`, which will live long enough to be valid. However, Rust can't run that code at compile time. It will consider both references `&magic1` and `&magic2` to be possible return values and will emit the error we saw earlier.

We've told Rust that the lifetime of the reference that the `longest_word` function returns is the same as the smaller of the lifetimes of the references passed in. So, the borrow checker disallows the earlier code as possibly having an invalid reference.

## Annotating lifetimes in types

Whenever a struct or enum holds a reference in one of its fields, we must annotate that type definition with the lifetime of each reference that it carries along with it.

For example, consider the following example code. We have a `text` string *(which owns its contents)* and a `Highlight` tuple struct. The struct has one field, `part`, that holds a string slice. The slice is a borrowed value from another part of our program.

```rust
#[derive(Debug)]
struct Highlight<'document>(&'document str);

fn main() {
    let text = String::from("The quick brown fox jumps over the lazy dog.");
    let fox = Highlight(&text[4..19]);
    let dog = Highlight(&text[35..43]);
    println!("{:?}", fox);
    println!("{:?}", dog);
}
```

The preceding code is available at the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=e992388f5a562abf9301a3bd6c6bdc0d&azure-portal=true).

We declare the name of the generic lifetime parameter inside angle brackets after the name of the struct, so we can use the lifetime parameter in the body of the struct definition. This annotation
means that an instance of `Highlight` can't outlive the reference that it holds in its `part` field. 

In the preceding code, we annotated our struct with a lifetime called `'document`. This annotation is a reminder that the
`Highlight` struct can't outlive the source of the `&str` that it borrows, a supposed document.

The `main` function here creates two instances of the `Highlight` struct. Each instance holds a reference to a segment of the `String` value owned by the variable `text`:

- `fox` references the segment between the 4th and 19th characters of the `text` string.
- `dog` references the segment between the 35th and 43rd characters of the `text` string.

In addition, `text` doesn't go out of scope until after `Highlight` goes out of scope. So the reference in the `Highlight` instance is valid.

The code would print this message on the console:

```output
    Highlight("quick brown fox")
    Highlight("lazy dog")
```

As an experiment, try to move the value held by `text` out of the scope and see what kinds of complaints the borrow checker issues:

```rust
#[derive(Debug)]
struct Highlight<'document>(&'document str);

fn erase(_: String) { }

fn main() {
    let text = String::from("The quick brown fox jumps over the lazy dog.");
    let fox = Highlight(&text[4..19]);
    let dog = Highlight(&text[35..43]);

    erase(text);

    println!("{:?}", fox);
    println!("{:?}", dog);
}
```

You can find this failing code snippet at the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=d858080a07ef5e0bc460dc382734e7a3&azure-portal=true).

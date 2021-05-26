Rust is a statically typed language. The compiler must know exactly the data types for each variable in your code.

The compiler can usually infer the type for a value, and you don't need to explicitly tell the type in your code. When many types are possible, you must inform the compiler the specific type by using *type annotations*.

Suppose we write a program to convert a string into a number with a `.parse()` method:

```rust
let number: u32 = "42".parse().expect("Not a number!");
```

We tell the compiler we want the `number` variable to be a 32-bit number by annotating the type *u32* after the variable name.

You can experiment by removing the type annotation and observe the resulting compiler error:

```rust
let number = "42".parse().expect("Not a number!");
```

The  compiler error:

```output
    error[E0282]: type annotations needed
     --> src/main.rs:2:9
      |
    2 |     let number = "42".parse().expect("Not a number!");
      |         ^^^^^^ consider giving `number` a type
```

You can interact with the preceding code in this [Rust Playground][RustPlay-compile].


## Rust built-in data types

Rust comes with some built-in data types to express numbers, text, and truthiness. We'll cover each of these types in the following subtopics.

## Numbers

Integers in Rust are identified by bit size and the *signed* property. A signed integer can be a positive or negative number. An unsigned integer can be only a positive number.

| Length  | Signed  | Unsigned |&nbsp;|&nbsp;|
|---------|---------|----------|------|------|
| 8-bit   | `i8`    | `u8`     |&nbsp;|&nbsp;|
| 16-bit  | `i16`   | `u16`    |&nbsp;|&nbsp;|
| 32-bit  | `i32`   | `u32`    |&nbsp;|&nbsp;|
| 64-bit  | `i64`   | `u64`    |&nbsp;|&nbsp;|
| 128-bit | `i128`  | `u128`   |&nbsp;|&nbsp;|
| *architecture-dependant*     | `isize` | `usize`  |&nbsp;|&nbsp;|

The `isize` and `usize` types depend on the kind of computer your program is running on. The 64-bit type is used on a 64-bit architecture, and the 32-bit type on a 32-bit architecture. If you don't specify the type for an integer, and the system can't infer the type, it assigns the `i32` type (a 32-bit signed integer) by default.

Rust's floating-point types are `f32` and `f64`, which are 32 bits and 64 bits in size, respectively.

The default type is `f64`. On modern CPUs, the `f64` type is roughly the same speed as the `f32` type, but it has more precision.

```rust
let x = 2.0;      // f64, default type
let y: f32 = 3.0; // f32, via type annotation
```

All Rust's primitive number types support mathematical operations such as addition, subtraction, multiplication, and division

```rust
fn main() {
    // Addition
    println!("1 + 2 = {}", 1u32 + 2);

    // Subtraction
    println!("1 - 2 = {}", 1i32 - 2);
    // ^ Try changing `1i32` to `1u32` to see why the type is important

    // Integer Division
    println!("9 / 2 = {}", 9u32 / 2);

    // Float Division
    println!("9 / 2 = {}", 9.0 / 2.0);

    // Multiplication
    println!("3 * 6 = {}", 3 * 6)
}
```

> [!NOTE]
> We use suffixes on the literal numbers to inform Rust about the data type. `1u32` indicates the number 1 as an unsigned 32-bit integer, and so on. 
> If we don't provide type annotations, Rust tries to infer the type from context. When the context is ambiguous, it assigns the `i32` type (a 32-bit signed integer) by default.

You can try running this example in the [Rust Playground][RustPlay-numbers].


## Booleans

Booleans in Rust are represented by the type `bool` and have two possible values: `true` or `false`. Boolean values are used widely in conditionals like `if` and `else` expressions. A boolean value is often returned by a comparison check.

```rust
fn main() {
    let is_bigger = 1 > 4;
    println!("{}", is_bigger);  // prints "false"
}
```

## Character and strings

Rust has two string types and one character type. All of them are valid UTF-8 representations.

The `char` type is the most primitive type among them and is specified with single quotation marks:

```rust
let c = 'z';
let z = 'ℤ';
let heart_eyed_cat = '😻';
```

> [!NOTE]
> Some languages treat their `char` types as 8-bit unsigned integers, which is the equivalent of the Rust `u8` type.
> The `char` type in Rust contains unicode code points, but they don't use utf-8 encoding. A `char` in Rust is a 21-bit integer that's padded to be 32 bits wide. The `char` contains the plain code point value directly.

The `str` type, also known as a *string slice*, is a view into string data. Most of the time, we refer to those types in referenced form by using the form `&str`. We'll cover references in the following modules. For now, you can think of `&str` as a pointer to an immutable string data. String literals are all of type `&str`.

Although string literals are convenient to use in introductory Rust examples, they aren't suitable for every situation in which we might want to use text. That's because not every string can be known at compile time. An example is when a user interacts with a program and sends text via a terminal.

For these situations, Rust has a second string type, `String`. This type is allocated on the heap. When you use this type, the length of the string (number of characters) doesn't need to be known before the code is compiled. 

> [!NOTE]
> If you're coming from a garbage collected language, you might be wondering why Rust has two string types (spoiler alert: it actually has more!). As it turns out, strings are extremely complex 
> data types. Most languages use their garbage collectors to gloss over this complexity, but Rust, being a system's language, exposes some of the inherent complexity of strings to you.
> With this added complexity comes a very fine grained amount of control over how memory is used in your program. 

We won't get a full idea of the difference between `String` and `&str` until we learn about Rust's ownership and borrowing system. Until then, you can think of `String` data as string data that can change as your program runs, while `&str` are immutable views into string data that don't change as your program runs.

You can create a `String` from a string literal by using the `from` function, like so:

```rust
fn main() {
    // Create a String from a string literal
    let mut hello = String::from("Hello, ");  

    // Push a character into our String
    hello.push('w');
    
    // Push a string literal into our String       
    hello.push_str("orld!");
             
    println!("{}", hello)
}
```

You can try running this example in the [Rust Playground][RustPlay-chars].


## Tuples

A tuple is a grouping of values of different types collected into one compound. They have fixed length, meaning that after they're declared, they can't grow or shrink in size. The type of a tuple is defined by the sequence of each member's type.

Here's a tuple of length 3:

```rust
("hello", 5i32, 'c');
```

This tuple has the type signature `(&'static str, i32, char)`, where:

- `&'static str` is the type of the first element.
- `i32` is the type of the second element.
- `char` is the type of the third element.

Tuples elements can be accessed by position, which is known as *tuple indexing*. It looks like this:

```rust
fn main() {
    let tuple = ("hello", 5, 'c');

    assert_eq!(tuple.0, "hello");
    assert_eq!(tuple.1, 5);
    assert_eq!(tuple.2, 'c');

    println!("{}", tuple.0);  // prints "hello"
}
```

The `assert_eq!` macro verifies that two expressions are equal to each other.

Tuples are useful when you want to combine different types into a single value. For instance, functions can use tuples to return multiple values because tuples can hold any number of values.


<!-- Links -->
[RustPlay-compile]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=7b8d18e97567f9603a0f8efea0369034?azure-portal=true
[RustPlay-numbers]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=d683842bd8cedd949ed3c56b27f6f0eb?azure-portal=true
[RustPlay-chars]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=8b2abd147dc31d217d380db74dec01b0?azure-portal=true

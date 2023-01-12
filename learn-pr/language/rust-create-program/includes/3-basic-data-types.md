Rust is a statically typed language. The compiler must know the exact data type for all variables in your code for your program to compile and run. The compiler can usually infer the data type for a variable based on the bound value. You don't always need to explicitly tell the type in your code. When many types are possible, you must inform the compiler the specific type by using *type annotations*.

In the following example, we tell the compiler to create the `number` variable as a 32-bit integer. We specify the data type `u32` after the variable name. Notice the use of the colon `:` after the variable name.

```rust
let number: u32 = 14;
println!("The number is {}.", number);
```

If we enclose the variable value in double quotation marks, the compiler interprets the value as text rather than a number. The inferred data type of the value doesn't match the `u32` data type specified for the variable, so the compiler issues an error:

```rust
let number: u32 = "14";
```

The  compiler error:

```output
   Compiling playground v0.0.1 (/playground)
error[E0308]: mismatched types
 --> src/main.rs:2:23
  |
2 |     let number: u32 = "14";
  |                 ---   ^^^^ expected `u32`, found `&str`
  |                 |
  |                 expected due to this

error: aborting due to previous error
```

You can interact with the preceding code in this [Rust Playground][RustPlay-compile].

## Built-in data types

Rust comes with some built-in primitive data types to express numbers, text, and truth. Several of these types are referred to as *scalar* because they represent a single value:

- Integer numbers
- Floating point numbers
- Booleans
- Characters

Rust also offers more complex data types to work with data series, such as string and tuple values.

## Numbers: Integers and floating point values

Integers in Rust are identified by bit size and the *signed* property. A **signed** integer can be a positive or negative number. An **unsigned** integer can be only a positive number.

| Length  | Signed  | Unsigned |&nbsp;|&nbsp;|
|---------|---------|----------|------|------|
| 8-bit   | `i8`    | `u8`     |&nbsp;|&nbsp;|
| 16-bit  | `i16`   | `u16`    |&nbsp;|&nbsp;|
| 32-bit  | `i32`   | `u32`    |&nbsp;|&nbsp;|
| 64-bit  | `i64`   | `u64`    |&nbsp;|&nbsp;|
| 128-bit | `i128`  | `u128`   |&nbsp;|&nbsp;|
| *architecture-dependent*     | `isize` | `usize`  |&nbsp;|&nbsp;|

The `isize` and `usize` types depend on the kind of computer your program is running on. The 64-bit type is used on a 64-bit architecture, and the 32-bit type on a 32-bit architecture. If you don't specify the type for an integer, and the system can't infer the type, it assigns the `i32` type (a 32-bit signed integer) by default.

Rust has two floating-point data types for decimal values: `f32` (32 bits) and `f64` (64 bits). The default floating-point type is `f64`. On modern CPUs, the `f64` type is roughly the same speed as the `f32` type, but it has greater precision.

```rust
let number_64 = 4.0;      // compiler infers the value to use the default type f64
let number_32: f32 = 5.0; // type f32 specified via annotation
```

All of the primitive number types in Rust support mathematical operations like addition, subtraction, multiplication, and division.

```rust
// Addition, Subtraction, and Multiplication
println!("1 + 2 = {} and 8 - 5 = {} and 15 * 3 = {}", 1u32 + 2, 8i32 - 5, 15 * 3);

// Integer and Floating point division
println!("9 / 2 = {} but 9.0 / 2.0 = {}", 9u32 / 2, 9.0 / 2.0);
```

> [!NOTE]
> When we call the `println` macro, we add the data type suffix to each literal number to inform Rust about the data type. The syntax `1u32` tells the compiler the value is the number 1 and to interpret the value as an unsigned 32-bit integer.
>
> If we don't provide type annotations, Rust tries to infer the type from the context. When the context is ambiguous, it assigns the `i32` type (a 32-bit signed integer) by default.

You can try running this example in the [Rust Playground][RustPlay-numbers].

## Booleans: True or false

The boolean type in Rust is used to store truth. The `bool` type has two possible values: `true` or `false`. Boolean values are used widely in conditional expressions. If a `bool` statement or value is true, then do this action; otherwise (the statement or value is false), do a different action. A boolean value is often returned by a comparison check.

In the following example, we use the greater than `>` operator to test two values. The operator returns a boolean value that shows the result of the test.

```rust
// Declare variable to store result of "greater than" test, Is 1 > 4? -- false
let is_bigger = 1 > 4;
println!("Is 1 > 4? {}", is_bigger);  
```

## Text: Characters and strings

Rust supports text values with two basic string types and one character type. A character is a single item, while a string is a series of characters. All text types are valid UTF-8 representations.

### Characters

The `char` type is the most primitive of the text types. The value is specified by enclosing the item in single quotation marks:

```rust
let uppercase_s = 'S';
let lowercase_f = 'f';
let smiley_face = '😃';
```

> [!NOTE]
> Some languages treat their `char` types as 8-bit unsigned integers, which is the equivalent of the Rust `u8` type. The `char` type in Rust contains unicode code points, but they don't use UTF-8 encoding. A `char` in Rust is a 21-bit integer that's padded to be 32 bits wide. The `char` contains the plain code point value directly. You can learn more about the `char` type in Rust in the [Rust documentation](https://doc.rust-lang.org/std/primitive.char.html).

### Strings

The `str` type, also known as a *string slice* is a **view** into string data. Most of the time, we refer to these types by using reference-style syntax that precedes the type with the ampersand `&str`. We'll cover references in the following modules. For now, you can think of `&str` as a pointer to immutable string data. String literals are all of type `&str`.

Although string literals are convenient to use in introductory Rust examples, they aren't suitable for every situation where we might want to use text. Not every string can be known at compile time. An example is when a user interacts with a program during runtime and sends text via a terminal.

For these scenarios, Rust has a second string type named `String`. This type is allocated on the heap. When you use the `String` type, the length of the string (number of characters) doesn't need to be known before the code is compiled.

> [!NOTE]
> If you're familiar with a garbage-collected language, you might be wondering why Rust has two string types.<sup>**1**</sup> Strings are extremely complex data types. Most languages use their garbage collectors to gloss over this complexity. Rust as a system's language exposes some of the inherent complexity of strings. With the added complexity comes a very fine-grained amount of control over how memory is used in your program.
>
> <sup>**1**</sup> _Actually, Rust has more than two string types. In this module, we cover only the `String` and `&str` types. You can learn more about the string types offered in the [Rust documentation][Rust-string].

We won't get a full idea of the difference between `String` and `&str` until we learn about Rust's ownership and borrowing system. Until then, you can think of `String` type data as text data that can change as your program runs. The `&str` references are immutable views into the text data that don't change as your program runs.

### Text example

The following example shows how to use the `char` and `&str` data types in Rust.

- Two character variables are declared with the `: char` annotation syntax. The values are specified by using single quotation marks.
- A third character variable is declared and bound to a single image. For this variable, we let the compiler infer the data type.
- Two string variables are declared and bound to their respective values. The strings are enclosed in double quotation marks.
- One of the string variables is declared with the `: &str` annotation syntax to specify the data type. The data type for the other variable is left unspecified. The compiler will infer the data type for this variable based on the context.

Notice that the `string_1` variable includes an empty space at the end of the series of characters.

```rust
// Specify the data type "char"
let character_1: char = 'S';
let character_2: char = 'f';
   
// Compiler interprets a single item in quotations as the "char" data type
let smiley_face = '😃';

// Compiler interprets a series of items in quotations as a "str" data type and creates a "&str" reference
let string_1 = "miley ";

// Specify the data type "str" with the reference syntax "&str"
let string_2: &str = "ace";

println!("{} is a {}{}{}{}.", smiley_face, character_1, string_1, character_2, string_2);
```

Here's the output for our example:

``` output
😃 is a Smiley face.
```

What happens if we don't specify the ampersand `&` before `str` in this example? To find out, try running this example in the [Rust Playground][RustPlay-text].


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.

<!-- Links -->

[Rust-string]: https://doc.rust-lang.org/book/ch08-02-strings.html?azure-portal=true
[RustPlay-compile]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=d1635823974d9456858611266a32ffa6?azure-portal=true
[RustPlay-numbers]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=d683842bd8cedd949ed3c56b27f6f0eb?azure-portal=true
[RustPlay-text]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=dafd8dfd9159b2c6db51fdf02d5cb096?azure-portal=true

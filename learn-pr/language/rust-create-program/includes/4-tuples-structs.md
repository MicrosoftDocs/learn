In this unit, we'll explore two data types that are useful for working with data collections or compound data: tuples and structs.

## Tuples 

A tuple is a grouping of values of different types collected into one compound value. The individual values in a tuple are called *elements*. The values are specified as a comma-separated list enclosed in parentheses `(<value>, <value>, ...)`.

A tuple has a fixed length, which is equal to its number of elements. After a tuple is declared, it can't grow or shrink in size. Elements can't be added or removed. The data type of a tuple is defined by the sequence of the data types of the elements.

## Define a tuple

Here's an example of a tuple with three elements:

```rust
// Tuple of length 3
let tuple_e = ('E', 5i32, true);
```

The following table shows the index, value and data type for each element in the tuple:

Element | Value | Data type
---|---|---
0 | E | `char`
1 | 5 | `i32`
2 | true | `bool`

The type signature for this tuple is defined by the sequence of the types for the three elements: `(char, i32, bool)`.

## Access elements in a tuple

The elements in a tuple can be accessed by index position starting from zero. This process is referred to as *tuple indexing*. To access an element in a tuple, we use the syntax `<tuple>.<index>`.

The following example shows how to access the elements in the tuple by using indexing:

```rust
// Declare a tuple of three elements
let tuple_e = ('E', 5i32, true);

// Use tuple indexing and show the values of the elements in the tuple
println!("Is '{}' the {}th letter of the alphabet? {}", tuple_e.0, tuple_e.1, tuple_e.2);
```

The example shows the following output:

```output
Is 'E' the 5th letter of the alphabet? true
```

You can explore this example in the [Rust Playground][RustPlay-tuple].

Tuples are useful when you want to combine different types into a single value. Functions can use tuples to return multiple values because tuples can hold any number of values.

## Structs

A struct is a type that's composed of other types. The elements in a struct are called *fields*. Like tuples, the fields in a struct can have different data types. A significant benefit of the struct type is that you can name each field so it's clear what the value means.

To work with structs in a Rust program, first you define the struct by name and specify the data type for each field. Then, you create an *instance* of the struct with another name. When you declare the instance, you provide the specific values for the fields.

Rust supports three struct types: classic structs, tuple structs, and unit structs. These struct types support different ways to group and work with the data.

- **Classic [C structs][Wikipedia-C]** are the most commonly used. Each field in the struct has a name and a data type. After a classic struct is defined, the fields in the struct can be accessed by using the syntax `<struct>.<field>`.
- **Tuple structs** are similar to classic structs, but the fields don't have names. To access the fields in a tuple struct, we use the same syntax as we do for indexing a tuple: `<tuple>.<index>`. As with tuples, the index values in the tuple struct start at zero.
- **Unit structs** are most commonly used as markers. We'll learn more about why unit structs are useful when we learn about Rust's *traits* feature.

The following code shows example definitions for the three varieties of struct types:

```rust
// Classic struct with named fields
struct Student { name: String, level: u8, remote: bool }

// Tuple struct with data types only
struct Grades(char, char, char, char, f32);

// Unit struct
struct Unit;
```

## Define a struct

To define a struct, enter the `struct` keyword followed by a name for the struct. Choose a name for the struct type that describes the significant characteristic of the grouped data. Unlike the naming convention that we've used so far, the name of a struct type is capitalized.

Struct types are often defined outside of the `main` function and other functions in the Rust program. For this reason, the start of the struct definition isn't indented from the left margin. Only the inside portion of the definition is indented to show how the data is organized.

### Classic struct

Like a function, the body of a classic struct is defined inside curly brackets `{}`. Each field in the classic struct is given a name that's unique within the struct. The type for each field is specified with the syntax `: <type>`. The fields in the classic struct are specified as a comma-separated list `<field>, <field>, ...`. A classic struct definition **doesn't** end with a semicolon.

```rust
// Classic struct with named fields
struct Student { name: String, level: u8, remote: bool }
```

A benefit of the classic struct definition is you can access the value for a struct field by name. To access the field value, we use the syntax `<struct>.<field>`.

### Tuple struct

Like a tuple, the body of a tuple struct is defined inside parentheses `()`. The parentheses immediately follow the struct name. There's no space between the struct name and the opening parentheses.

Unlike a tuple, the tuple struct definition contains only the data type for each field. The data types in the tuple struct are specified as a comma-separated list `<type>, <type>, ...`.

```rust
// Tuple struct with data types only
struct Grades(char, char, char, char, f32);
```

## Instantiate a struct

After you define a struct type, you use the struct by creating an instance of the type and specifying values for each field. When you set the field values, you don't need to specify the fields in the same order as they're defined.

The following example uses the definitions that we created for the Student and Grades struct types.

```rust
// Instantiate classic struct, specify fields in random order, or in specified order
let user_1 = Student { name: String::from("Constance Sharma"), remote: true, level: 2 };
let user_2 = Student { name: String::from("Dyson Tan"), level: 5, remote: false };

// Instantiate tuple structs, pass values in same order as types defined
let mark_1 = Grades('A', 'A', 'B', 'A', 3.75);
let mark_2 = Grades('B', 'A', 'A', 'C', 3.25);

println!("{}, level {}. Remote: {}. Grades: {}, {}, {}, {}. Average: {}", 
         user_1.name, user_1.level, user_1.remote, mark_1.0, mark_1.1, mark_1.2, mark_1.3, mark_1.4);
println!("{}, level {}. Remote: {}. Grades: {}, {}, {}, {}. Average: {}", 
         user_2.name, user_2.level, user_2.remote, mark_2.0, mark_2.1, mark_2.2, mark_2.3, mark_2.4);
```

## Convert a string literal to a String type

String data that's stored inside another data structure, such as a struct or vector, must be converted from a string literal reference (`&str`) to a `String` type. To do the conversion, we use the standard `String::from(&str)` method. Notice how we use this method in this example:

```rust
// Classic struct with named fields
struct Student { name: String, level: u8, remote: bool }
...
let user_2 = Student { name: String::from("Dyson Tan"), level: 5, remote: false };
```

If we don't convert the type before we assign the value, the compiler issues an error:

```output
error[E0308]: mismatched types
  --> src/main.rs:24:15
   |
24 |         name: "Dyson Tan",
   |               ^^^^^^^^^^^
   |               |
   |               expected struct `String`, found `&str`
   |               help: try using a conversion method: `"Dyson Tan".to_string()`

error: aborting due to previous error
```

The compiler suggests that we can use the `.to_string()` function to make the conversion. In our examples, we use the `String::from(&str)` method.

You can interact with the example code in this [Rust Playground][RustPlay-structs].

### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.

<!-- Links -->

[RustPlay-tuple]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=f0c1c833543c9f58af5e49efb77a9fdd?azure-portal=true
[RustPlay-structs]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=1a09be796adc0020c4f868a92b4084f4?azure-portal=true
[Wikipedia-C]: https://wikipedia.org/wiki/Struct_(C_programming_language)

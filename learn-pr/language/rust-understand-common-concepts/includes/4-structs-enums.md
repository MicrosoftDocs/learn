A struct is a type that's composed of other types. The elements in a struct are called *fields*. Like tuples, the fields in a struct can have different data types. A significant benefit of the struct type is that you can name each field so it's clear what the value means. 

To work with structs in a Rust program, first you define the struct by name and specify the data type for each field. Then, you create an *instance* of the struct with another name. When you declare the instance, you provide the specific values for the fields.


## Choose the struct type

Rust supports three struct types: classic structs, tuple structs, and unit structs. These struct types support different ways to group and work with the data.

- **Classic [C structs][Wikipedia-C]** are the most commonly used. Each field in the struct has a name and a data type. After a classic struct is defined, the fields in the struct can be accessed by using the syntax `<struct>.<field>`.
- **Tuple structs** are similar to classic structs, but the fields don't have names. To access the fields in a tuple struct, we use the same syntax as we do for indexing a tuple: `<tuple>.<index>`. As with tuples, the index values in the tuple struct start at zero.
- **Unit structs** are most commonly used as markers. We'll learn more about why unit structs are useful when we learn about Rust's *traits* feature.

The following code shows example definitions for the three varieties of struct types:

```rust
// Classic struct with named fields
struct Student {
    name: String,
    level: u8,
    pass: bool
}

// Tuple struct with data types only
struct Grades(char, char, char, char, f32);

// Unit struct
struct Unit;
```


## Define a struct

To define a struct, we enter the keyword `struct` followed by the struct name. Choose a name for the struct type that describes the significant characteristic of the grouped data. Unlike the naming convention that we've used so far, the name of a struct type is capitalized.

Struct types are often defined outside of the `main` function and other functions in the Rust program. For this reason, the start of the struct definition isn't indented from the left margin. Only the inside portion of the definition is indented to show how the data is organized.


### Classic struct

Like a function, the body of a classic struct is defined inside curly brackets `{}`. Each field in the classic struct is given a name that's unique within the struct. The type for each field is specified with the syntax `: <type>`. The fields in the classic struct are specified as a comma-separated list `<field>, <field>, ...`. A classic struct definition **doesn't** end with a semicolon.

```rust
// Classic struct with named fields
struct Student {
    name: String,
    level: u8,
    pass: bool
}
```

A benefit of the classic struct definition is you can access the value for a struct field by name. To access the field value, we use the syntax `<struct>.<field>`.


### Tuple struct

Like a tuple, the body of a tuple struct is defined inside parentheses `()`. The parentheses immediately follows the struct name. There's no space between the struct name and the opening parentheses.

Unlike a tuple, the tuple struct definition contains only the data type for each field. The data types in the tuple struct are specified as a comma-separated list `<type>, <type>, ...`. 

```rust
// Tuple struct with data types only
struct Grades(char, char, char, char, f32);
```


## Instantiate a struct

After you define a struct type, you use the struct by creating an instance of the type and specifying values for each field. When you set the field values, you don't need to specify the fields in the same order as they're defined.

The following example uses the definitions that we created for the Student and Grades struct types.

```rust
fn main() {
    // Instantiate a classic struct, specify the fields in random order
    let student_1 = Student {
        name: String::from("Constance Sharma"),
        remote: true,
        level: 2
    };

    // Instantiate a tuple struct, pass the values in the same order as the types are defined
    let grades_1 = Grades('A', 'A', 'B', 'A', 3.75);

    // Instantiate another classic struct, specify the field values in order
    let student_2 = Student {
        name: String::from("Dyson Tan"),
        level: 5,
        remote: false
    };

    // Instantiate another tuple struct, pass the values in the same order as defined
    let grades_2 = Grades('B', 'A', 'A', 'C', 3.25);

    // Show the student information
    println!("{}, level {}. Remote: {}. Grades: {}, {}, {}, {}. Average: {}", 
             student_1.name, student_1.level, student_1.remote, grades_1.0, grades_1.1, grades_1.2, grades_1.3, grades_1.4);

    println!("{}, level {}. Remote: {}. Grades: {}, {}, {}, {}. Average: {}", 
             student_2.name, student_2.level, student_2.remote, grades_2.0, grades_2.1, grades_2.2, grades_2.3, grades_2.4);
}
```

You can interact with this example code in this [Rust Playground][RustPlay-structs].

To learn more about working with structs in Rust, see the [Rust documentation][Rust-struct].


## Enums

Enums are types that can be any one of several variants. What Rust calls enums are more commonly known as [algebraic data types][Wikipedia-algebraic]. The important detail is that each enum variant can have data to go along with it.


## Define an enum

We use the `enum` keyword to create an enum type, which can have any combination of the enum variants. Like structs, enum variants can have named fields, fields without names, or no fields at all. Like struct types, enum types are also capitalized.

In the following example, we define an enum to classify a web event. Each variant in the enum is independent and stores different amounts and types of values.

```rust
enum WebEvent {
    // An enum variant can be like a unit struct without fields or data types
    WELoad,

    // An enum variant can be like a tuple struct with data types but no named fields
    WEKeys(String, char),

    // An enum variant can be like a classic struct with named fields and their data types
    WEClick { x: i64, y: i64 }
}
```

The enum in our example has three variants of different types:

- `WELoad` has no associated data type or data.
- `WEKeys` has two fields with data types `String` and `char`.
- `WEMClick` contains an anonymous struct with named fields `x` and `y`, and their data types (`i64`).

We define an enum with variants similar to how we define different kinds of struct types. All the variants are grouped together in the same `WebEvent` enum type. Each variant in the enum **isn't** its own type. Any function that uses a variant of the `WebEvent` enum must accept all the variants in the enum. We can't have a function that accepts only the `KeyPress` variant, but not the other variants.


## Define an enum with structs

A way to work around enum variant requirements is to define a separate struct for each variant in the enum. Then, each variant in the enum uses the corresponding struct. The struct holds the same data that was held by the corresponding enum variant. This style of definition allows us to refer to each logical variant on its own.

The following code shows how to use this alternate definition style. The structs are defined to hold the data. The variants in the enum are defined to refer to the structs.

```rust
// Define a tuple struct
struct KeyPress(String, char);

// Define a classic struct
struct MouseClick { 
    x: i64, 
    y: i64 
}

// Redefine the enum variants to use the data from the new structs
// Update the page Load variant to have the boolean type
enum WebEvent {
    WELoad(bool),
    WEClick(MouseClick),
    WEKeys(KeyPress)
}
```

To learn more about working with enums in Rust, see the [Rust documentation][Rust-enum].


## Instantiate an enum

Now let's add code to create instances of our enum variants. For each variant, we use the `let` keyword to make the assignment. To access the specific variant in the enum definition, we use the syntax `<enum>::<variant>` with double colons `::`.


### Simple variant: WELoad(bool)

The first variant in the `WebEvent` enum has a single boolean value, `WELoad(bool)`. We instantiate this variant in a manner similar to how we worked with booleans in the previous unit:

```rust
   let we_load = WebEvent::WELoad(true);
```


### Struct variant: WEClick(MouseClick)

The second variant contains a classic struct `WEClick(MouseClick)`. The struct has two named fields `x` and `y`, and both fields have the `i64` data type. To create this variant, first we instantiate the struct. Then we pass the struct as an argument in the call to instantiate the variant.

```rust
    // Instantiate a MouseClick struct and bind the coordinate values
    let click = MouseClick {
        x: 100,
        y: 250
    };

    // Set the WEClick variant to use the data in the click struct
    let we_click = WebEvent::WEClick(click);
```


### Tuple variant: WEKeys(KeyPress)

The last variant contains a tuple `WEKeys(KeyPress)`. The tuple has two fields that use the `String` and `char` data types. To create this variant, first we instantiate the tuple. Then we pass the tuple as an argument in the call to instantiate the variant.

```rust
    // Instantiate a KeyPress tuple and bind the key values
    let keys = KeyPress(String::from("Ctrl+"), 'N');
    
    // Set the WEKeys variant to use the data in the keys tuple
    let we_key = WebEvent::WEKeys(keys);
```

Notice that we use new syntax in this piece of code, `String::from("<value>")`. This syntax creates a value of type `String` by calling the Rust `from` method. The method expects an input argument of data enclosed in double quotation marks.


### Enums example

Here's our final code to instantiate the enum variants:

```rust
fn main() {
    // Instantiate a MouseClick struct and bind the coordinate values
    let click = MouseClick {
        x: 100,
        y: 250
    };
    
    // Print the MouseClick coordinate values
    println!("Mouse click location: {}, {}", click.x, click.y);
    
    // Instantiate a KeyPress tuple and bind the key values
    let keys = KeyPress(String::from("Ctrl+"), 'N');
    
    // Print the KeyPress values
    println!("\nKeys pressed: {}{}", keys.0, keys.1);
    
    // Instantiate the WebEvent enum variants
    // Set the boolean page Load value to true
    let we_load = WebEvent::WELoad(true);
    // Set the WEClick variant to use the data in the click struct
    let we_click = WebEvent::WEClick(click);
    // Set the WEKeys variant to use the data in the keys tuple
    let we_key = WebEvent::WEKeys(keys);
    
    // Print the values in the WebEvent enum variants
    // Use the {:#?} syntax to display the enum structure and data in a readable form
    println!("\nWebEvent enum structure: \n\n {:#?} \n\n {:#?} \n\n {:#?}", we_load, we_click, we_key);
}

```

Try to interact with this example code in the [Rust Playground][RustPlay-enums].


### Debug statements

In the Rust Playground, look for the following code statement. This statement is used in several places in the code.

```rust
// Set the Debug flag so we can check the data in the output
#[derive(Debug)]
```

The `#[derive(Debug)]` syntax lets us see certain values during the code execution that aren't otherwise viewable in standard output. To view debug data with the `println!` macro, we use the syntax `{:#?}` to format the data in a readable manner. 


<!-- Links -->
[Rust-enum]: https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html?azure-portal=true
[Rust-struct]: https://doc.rust-lang.org/book/ch05-01-defining-structs.html?azure-portal=true
[RustPlay-enums]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=f81139b1fc896ac6f3e5840f2661dd2f?azure-portal=true
[RustPlay-structs]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=1a09be796adc0020c4f868a92b4084f4?azure-portal=true
[Wikipedia-algebraic]: https://wikipedia.org/wiki/Algebraic_data_type?azure-portal=true
[Wikipedia-C]: https://wikipedia.org/wiki/Struct_(C_programming_language)

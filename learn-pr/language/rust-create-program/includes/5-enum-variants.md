Enums are types that can be any one of several variants. What Rust calls enums are more commonly known as [algebraic data types][Wikipedia-algebraic]. The important detail is that each enum variant can have data to go along with it.

We use the `enum` keyword to create an enum type, which can have any combination of the enum variants. Like structs, enum variants can have named fields, but they can also have fields without names, or no fields at all. Like struct types, enum types are also capitalized.

## Define an enum

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

We define an enum with variants similar to how we define different kinds of struct types. All the variants are grouped together in the same `WebEvent` enum type. Each variant in the enum **isn't** its own type. Any function that uses a variant of the `WebEvent` enum must accept all the variants in the enum. We can't have a function that accepts only the `WEClick` variant, but not the other variants.

## Define an enum with structs

A way to work around enum variant requirements is to define a separate struct for each variant in the enum. Then, each variant in the enum uses the corresponding struct. The struct holds the same data that was held by the corresponding enum variant. This style of definition allows us to refer to each logical variant on its own.

The following code shows how to use this alternate definition style. The structs are defined to hold the data. The variants in the enum are defined to refer to the structs.

```rust
// Define a tuple struct
struct KeyPress(String, char);

// Define a classic struct
struct MouseClick { x: i64, y: i64 }

// Redefine the enum variants to use the data from the new structs
// Update the page Load variant to have the boolean type
enum WebEvent { WELoad(bool), WEClick(MouseClick), WEKeys(KeyPress) }
```

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
let click = MouseClick { x: 100, y: 250 };

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

Notice that we use the `String::from("<value>")` syntax in this piece of code. This syntax creates a value of type `String` by calling the Rust `from` method. The method expects an input argument of data enclosed in double quotation marks.

### Enums example

Here's the final code to instantiate the enum variants:

```rust
// Define a tuple struct
#[derive(Debug)]
struct KeyPress(String, char);

// Define a classic struct
#[derive(Debug)]
struct MouseClick { x: i64, y: i64 }

// Define the WebEvent enum variants to use the data from the structs
// and a boolean type for the page Load variant
#[derive(Debug)]
enum WebEvent { WELoad(bool), WEClick(MouseClick), WEKeys(KeyPress) }

fn main() {
    // Instantiate a MouseClick struct and bind the coordinate values
    let click = MouseClick { x: 100, y: 250 };
    println!("Mouse click location: {}, {}", click.x, click.y);
        
    // Instantiate a KeyPress tuple and bind the key values
    let keys = KeyPress(String::from("Ctrl+"), 'N');
    println!("\nKeys pressed: {}{}", keys.0, keys.1);
        
    // Instantiate WebEvent enum variants
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

In the previous example, look for the following code statement. This statement is used in several places in the code.

```rust
// Set the Debug flag so we can check the data in the output
#[derive(Debug)]
```

The `#[derive(Debug)]` syntax lets us see certain values during the code execution that aren't otherwise viewable in standard output. To view debug data with the `println!` macro, we use the syntax `{:#?}` to format the data in a readable manner.

### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.

<!-- Links -->

[RustPlay-enums]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=f81139b1fc896ac6f3e5840f2661dd2f?azure-portal=true
[Wikipedia-algebraic]: https://wikipedia.org/wiki/Algebraic_data_type?azure-portal=true

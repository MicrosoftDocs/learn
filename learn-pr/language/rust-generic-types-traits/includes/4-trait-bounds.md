Traits let us define functions that accept many different types, because when a type implements a trait it can be treated abstractly as that trait.

We can declare function arguments to be an anonymous type parameter where the callee must provide a type that has the bounds declared by the anonymous type parameter.

Lets imagine that we are writing a web application and would like to have a interface for
serializing values to the JSON format. We could write a trait like this:

```rust
trait AsJson {
    fn as_json(&self) -> String;
}
```

And then we could write a function that accepts any type that implements the `AsJson` trait. They
are written as `impl` followed by a set of trait bounds.

```rust
fn send_data_as_json(value: &impl AsJson) {
    println!("Sending JSON data to server...");
    println!("-> {}", value.as_json());
    println!("Done!\n");
}
```

Instead of a concrete type for the `item` parameter, we specify the `impl` keyword and the trait
name. This parameter accepts any type that implements the specified trait. Note that since the
function doesn't know anything about the concrete type it will receive, it can only use the methods available by the trait bounds of the anonymous type parameter.

Another way to write the same function, but with a litte different syntax, that explicitly tells that T is a generic type that must implement the `AsJson` trait:

```rust
fn send_data_as_json<T: AsJson>(value: &T) { ... }
```

We can then declare our types and implement the `AsJson` trait for them:

```rust
struct Person {
    name: String,
    age: u8,
    favorite_fruit: String,
}

struct Dog {
    name: String,
    color: String,
    likes_petting: bool,
}

impl AsJson for Person {
    fn as_json(&self) -> String {
	format!(
	    r#"{{ "type": "person", "name": "{}", "age": {}, "favoriteFruit": "{}" }}"#,
	    self.name, self.age, self.favorite_fruit
	)
    }
}

impl AsJson for Dog {
    fn as_json(&self) -> String {
	format!(
	    r#"{{ "type": "dog", "name": "{}", "color": "{}", "likesPetting": {} }}"#,
	    self.name, self.color, self.likes_petting
	)
    }
}
```

Now that both `Person` and `Dog` implements the `AsJson` trait, we can use them as input parameters
for our `send_data_as_json` function.

```rust
fn main() {
    let laura = Person {
	name: String::from("Laura"),
	age: 31,
	favorite_fruit: String::from("apples"),
    };

    let fido = Dog {
	name: String::from("Fido"),
	color: String::from("Black"),
	likes_petting: true,
    };

    send_data_as_json(&laura);
    send_data_as_json(&fido);
}
```

But what happens when we pass a type that doesn't implement the expected trait to the function? Lets create a new struct and see what happens:

```rust
struct Cat {
    name: String,
    sharp_claws: bool,
}

let kitty = Cat {
    name: String::from("Kitty"),
    sharp_claws: false,
};

send_data_as_json(&kitty);
```

The compiler raises the following error:

```output
    error[E0277]: the trait bound `Cat: AsJson` is not satisfied
      --> src/main.rs:70:23
       |
    5  | fn send_data_as_json(value: &impl AsJson) {
       |                                   ------ required by this bound in `send_data_as_json`
    ...
    70 |     send_data_as_json(&kitty);
       |                       ^^^^^^ the trait `AsJson` is not implemented for `Cat`
```

This happened because we tried to use a type which doesn't implement the `AsJson` trait in a place which expected that trait: the `send_data_as_json` function.

To view the code used in this unit, visit this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=eb322a632e8eca7f39056fcc6c966163&azure-portal=true).

As an optional challenge, you can try to implement the `AsJson` trait for the `Cat` type.

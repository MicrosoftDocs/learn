In this exercise, you are going to finish implementing a function that receives a `Person` struct and returns a `String` with its full name. Keep in mind that some of those people doesn't have a middle name, but, if they do, it must be included in the return value.

You must edit only the `build_full_name` function. Note that the part that handles the first and the last name have already been implemented for you.

```rust
struct Person {
    first: String,
    middle: Option<String>,
    last: String,
}

fn build_full_name(person: &Person) -> String {
    let mut full_name = String::new();
    full_name.push_str(&person.first);
    full_name.push_str(" ");

    // TODO: Implement the part of this function that handles the person's middle name

    full_name.push_str(&person.last);
    full_name
}

fn main() {
    let john = Person {
    first: String::from("James"),
    middle: Some(String::from("Oliver")),
    last: String::from("Smith"),
    };
    assert_eq!(build_full_name(&john), "James Oliver Smith");

    let alice = Person {
        first: String::from("Alice"),
        middle: None,
        last: String::from("Stevens"),
    };
    assert_eq!(build_full_name(&alice), "Alice Stevens");

    let bob = Person {
        first: String::from("Robert"),
        middle: Some(String::from("Murdock")),
        last: String::from("Jones"),
    };
    assert_eq!(build_full_name(&bob), "Robert Murdock Jones");
}
```

Run the code above and check if all the `assert_eq!` expressions passes without panicking. You can also edit this at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=bfc7568619b261d18e272bf09bad48c0?azure-portal=true).

The solution to this exercise can be found [here](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=bfc7568619b261d18e272bf09bad48c0?azure-portal=true).

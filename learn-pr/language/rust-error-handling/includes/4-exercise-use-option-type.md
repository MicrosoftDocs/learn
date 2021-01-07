In this exercise, you'll finish implementing a function that receives a `Person` struct and returns a `String` that contains its full name. 

Keep in mind that some people don't have a middle name but, if they do, it must be included in the return value.

You must edit only the `build_full_name` function. Note that the part that handles the first and last names has already been implemented for you.

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

    // TODO: Implement the part of this function that handles the person's middle name.

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

Run the preceding code and check to ensure that all the `assert_eq!` expressions pass without panicking. You can also edit the code on the [Rust playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=bfc7568619b261d18e272bf09bad48c0?azure-portal=true).

Get a [solution to this exercise](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=bfc7568619b261d18e272bf09bad48c0?azure-portal=true).

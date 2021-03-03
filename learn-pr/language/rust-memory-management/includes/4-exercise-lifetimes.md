In this exercise, you'll reimplement the `copy_and_return` function so that it returns a reference to the value inserted in the vector. Leave the `main` function as it is. You'll know your task is complete when the code run and all the assertions pass.

```rust
// TODO: modify only this function.
fn copy_and_return(vector: &mut Vec<String>, value: &str) {
    vector.push(String::from(value));
}

fn main() {
    let name1 = "Joe";
    let name2 = "Chris";
    let name3 = "Anne";

    let mut names = Vec::new();

    assert_eq!("Joe", copy_and_return(&mut names, &name1));
    assert_eq!("Chris", copy_and_return(&mut names, &name2));
    assert_eq!("Anne", copy_and_return(&mut names, &name3));

    assert_eq!(
        names,
        vec!["Joe".to_string(), "Chris".to_string(), "Anne".to_string()]
    )
}
```

You can find the preceding code at the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=5fe3c3fa78b91d05c7dd5e6956ac3044&azure-portal=true).

You can also find the solution to this exercise at the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=a687fa389ffc14dedd80c0320e7ae8c9&azure-portal=true).

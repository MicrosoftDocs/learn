In this unit, your challenge is to fix the missing parts of each exercise's code to make them compile.

You can use your local development environment or use the Rust Playground to edit the code.

## Exercise

In this exercise, modify the code for the two functions. Use the index notation to access the required elements of the `numbers` tuple and the `letters` array.

Remember that tuples and arrays have different indexing notation.

You can put the expression for each required element where you see the placeholder `todo!` macro.

```rust
fn indexing_tuple() {
    let numbers = (1, 2, 3);
    let second = todo!("Replace with the tuple indexing syntax");

    assert_eq!(
        2, second,
        "This is not the 2nd number in the tuple: {}",
        second
    )
}

fn indexing_array() {
    let characters = ['a', 'b', 'c', 'd', 'e'];
    let letter_d = todo!("Replace with the array indexing syntax");

    assert_eq!(
        'd', letter_d,
        "This is not the character for the letter d: {}",
        letter_d
    )
}
```

You can run this code in your local computer, or use this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=f3dceec336bea3f171c88e54023238e4?azure-portal=true).

The solution to this exercise is in this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=1ae47e11d8fe08e78d66edf7c888d6d5?azure-portal=true).

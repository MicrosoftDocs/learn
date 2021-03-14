In this unit, your challenge is to fix the missing parts of each exercise's code to make them compile.

You can use your local development environment or use the Rust Playground to edit the code.

## Exercise

In this exercise, modify the code for the two functions. Use the index notation to access the required elements of the `numbers` tuple and the `letters` array.

Remember that tuples and arrays have different indexing notation.

You can put the expression for each required element where you see the placeholder *???* so that the assertion passes.

```rust
fn indexing_tuple() {
    let numbers = (1, 2, 3);
    // Replace below ??? with the tuple indexing syntax.
    let second = ???;

    assert_eq!(
    2, second,
    "This is not the 2nd number in the tuple: {}",
    second
    )
}

fn indexing_array() {
    let characters = ['a', 'b', 'c', 'd', 'e'];
    // Replace below ??? with the array indexing syntax.
    let letter_d = ???;

    assert_eq!(
    'd', letter_d,
    "This is not the character for the letter d: {}",
    letter_d
    )
}
```

You can run this code in your local computer, or use this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=2feac2d3023de64774d9633f396bf24f?azure-portal=true).

The solution to this exercise is in this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=7932c6a7a48377dbe3278b83ecc982ba?azure-portal=true).

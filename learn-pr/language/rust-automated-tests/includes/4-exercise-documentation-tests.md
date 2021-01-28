In this exercise, you'll create documentation tests in the code snippet below for the functions `div` and `sub`.

For the `div` function, write the following doctests:

  1. assert that `10` divided by `2` equals `5`
  2. assert that `6` divided by `3` equals `2`
  3. assert that `10` divided by `0` panics

For the `sub` function, write the following doctests:

  1. assert that `9` subtracted by `2` equals `7`
  2. assert that `6` subtracted by `9` equals `-3`

```rust
/// This function divides two numbers.
///
/// # Example #1: 10 / 2 == 5
///
/// ```
/// let result = doctests_exercise::div(...);  // TODO: finish this test!
/// assert_eq!(result, 2);
/// ```
///
/// # Example #2: 6 / 2 = 3
///
/// ```
/// TODO: Write this doctest!
/// ```
///
/// # Panics
///
/// The function panics if the second argument is zero.
///
/// ```rust,should_panic
/// // panics on division by zero
/// TODO: Write this doctest!
/// ```
pub fn div(a: i32, b: i32) -> i32 {
    if b == 0 {
        panic!("Divide-by-zero error");
    }
    a / b
}

/// This function subtracts two numbers.
///
/// # Example #1: 9 - 2 == 7
///
/// ```
/// TODO: Write this doctest!
/// ```
///
/// # Example #2: 6 - 9 == -3
///
/// ```
/// TODO: Write this doctest!
/// ```
pub fn sub(a: i32, b: i32) -> i32 {
    a - b
}
```

Remember to create the project in your computer first, as documentation tests are only available for library crates. You can run the following commands in your terminal to accomplish this objective:

```sh
$ cargo new --lib doctests_exercise
$ cd doctests_exercise
```

Keep in mind that the name of the crate must prefix the name of the function, as it is already filled in for the first assignment of this exercise.

To find a complete version of this exercise, visit this [Rust Playground
link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=e53758e499766ca348ee8d52724d583b&azure-portal=true).

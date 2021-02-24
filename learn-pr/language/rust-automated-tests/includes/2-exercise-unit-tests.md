In this exercise, you'll write two test functions for the `is_even` function. You'll know the exercise is complete after the code compiles and both tests pass. You should edit only the body of the two test functions.

```rust
pub fn is_even(num: i32) -> bool {
    num % 2 == 0
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn is_true_when_even() {
        assert!();
    }

    #[test]
    fn is_false_when_odd() {
        assert!();
    }
}
```

You can also view this exercise at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=2af390896e18dda3bb70c0a3de4c4aa1&azure-portal=true).

To find the solution for this exercise, check out this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=1832ce3596a0f9e9104f5752199fbbe7&azure-portal=true).

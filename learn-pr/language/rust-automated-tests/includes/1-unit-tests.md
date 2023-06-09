Unit tests in Rust are simple functions marked with the `#[test]` attribute that verify that the non-test code is functioning in the expected manner. These functions are only compiled when testing code.

Test functions run the code that you want to test. Then they check the results, often by using the `assert!` or `assert_eq!` macros.

In the following code example, we define a simple `add` function and another `add_works` function marked with the `#[test]` attribute.

```rust
fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[test]
fn add_works() {
    assert_eq!(add(1, 2), 3);
    assert_eq!(add(10, 12), 22);
    assert_eq!(add(5, -2), 3);
}
```

When we execute the command `$ cargo test`, our output would look like the following example:

```output
running 1 test
test add_works ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

## Test failures

Let's try to include a failing test, just to see how `cargo tests` behaves.

```rust
#[test]
fn add_fails() {
    assert_eq!(add(2, 2), 7);
}
```

If we run the tests again by using the `$ cargo test` command, the output should show that our `add_works` test passed. It should also show that `add_fails` failed and should include information about the failed call to `assert_eq`.

```output
running 2 tests
test add_works ... ok
test add_fails ... FAILED

failures:

---- add_fails stdout ----
thread 'add_fails' panicked at 'assertion failed: `(left == right)`
  left: `4`,
 right: `7`', src/main.rs:14:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace


failures:
    add_fails

test result: FAILED. 1 passed; 1 failed; 0 ignored; 0 measured; 0 filtered out
```

## Expected failures

In many scenarios, it's important to test if a condition will cause a `panic!`.

The `should_panic` attribute makes it possible to check for a `panic!`. If we add this attribute to our test function, the test passes when the code in the function panics. The test fails when the code doesn't panic.

Now, our `add_fails` test function can capture an expected panic and treat it as a passing test.

```rust
#[test]
#[should_panic]
fn add_fails() {
    assert_eq!(add(2, 2), 7);
}
```

And our tests results will be:

```output
running 2 tests
test add_works ... ok
test add_fails ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

## Ignore tests

A function annotated with the `[test]` attribute can also be annotated with the `[ignore]`
attribute. This attribute causes that test function to be skipped during tests.

The `[ignore]` attribute may optionally be written with a reason why the test is ignored.

```rust
#[test]
#[ignore = "not yet reviewed by the Q.A. team"]
fn add_negatives() {
    assert_eq!(add(-2, -2), -4)
}
```

Ignored test functions will still be type checked and compiled but won't be executed in our tests.

```output
running 3 tests
test add_negatives ... ignored
test add_works ... ok
test add_fails ... ok

test result: ok. 2 passed; 0 failed; 1 ignored; 0 measured; 0 filtered out
```

## The test module

Most unit tests go into a submodule with the `#[cfg(test)]` attribute.

```rust
fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[cfg(test)]
mod add_function_tests {
    use super::*;

    #[test]
    fn add_works() {
        assert_eq!(add(1, 2), 3);
        assert_eq!(add(10, 12), 22);
        assert_eq!(add(5, -2), 3);
    }

    #[test]
    #[should_panic]
    fn add_fails() {
        assert_eq!(add(2, 2), 7);
    }

    #[test]
    #[ignore]
    fn add_negatives() {
        assert_eq!(add(-2, -2), -4)
    }
}
```

The `cfg` attribute controls conditional compilation and will only compile the thing it's attached to if the predicate is `true`. The `test` compilation flag is issued automatically by Cargo whenever we execute the command `$ cargo test`, so it will always be true when we run our tests.

The `use super::*;` declaration is necessary for the code inside the `add_function_tests` module to access the `add` in the outer module.

You can find the code used in this unit at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=f74afccf321c642e7ebea8633a3f4b32&azure-portal=true).

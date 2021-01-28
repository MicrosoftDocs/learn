In this exercise, you'll be requested to implement an iterator that returns equal items in a sequence grouped in vectors, such as:

- **Input:** `[ 1, 1, 2, 1, 3, 3 ]`
- **Output:** `[ [1, 1], [2], [1], [3, 3] ]`

Your goal is to finish writing the implementation of the `Iterator` trait for the `Group` struct, which will be responsible for keeping the data state in its `inner` field between iterations.

The generic type `T` will need to be an implementor of the trait `PartialEq` since you'll need to compare values to perform this assignment. But don't worry about that, because that part is already solved for you at the `impl<T: PartialEq>` segment.

```rust
struct Groups<T> {
    inner: Vec<T>,
}

impl<T> Groups<T> {
    fn new(inner: Vec<T>) -> Self {
	Groups { inner }
    }
}

impl<T: PartialEq> Iterator for Groups<T> {
    type Item = Vec<T>;

    // TODO: Write the rest of this implementation.
}

fn main() {
    let data = vec![4, 1, 1, 2, 1, 3, 3, -2, -2, -2, 5, 5];
    // groups:     |->|---->|->|->|--->|----------->|--->|
    assert_eq!(
	Groups::new(data).into_iter().collect::<Vec<Vec<_>>>(),
	vec![
	    vec![4],
	    vec![1, 1],
	    vec![2],
	    vec![1],
	    vec![3, 3],
	    vec![-2, -2, -2],
	    vec![5, 5],
	]
    );

    let data2 = vec![1, 2, 2, 1, 1, 2, 2, 3, 4, 4, 3];
    // groups:      |->|---->|---->|----|->|----->|->|
    assert_eq!(
	Groups::new(data2).into_iter().collect::<Vec<Vec<_>>>(),
	vec![
	    vec![1],
	    vec![2, 2],
	    vec![1, 1],
	    vec![2, 2],
	    vec![3],
	    vec![4, 4],
	    vec![3],
	]
    )
}
```

You can also view this exercise at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=74f513d95c9eab321ec4b71bee7058ca&azure-portal=true).

To find a solution for this exercise, check out this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=ea40ee2c11b8fd3937e4a5a7362abea6&azure-portal=true).

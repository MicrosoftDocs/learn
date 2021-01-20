# Using iterators

We have already covered how we can iterate over collection types using the loop, but this time we will do a more in-depth review on how Rust handles the concept of iteration itself.

In Rust, all iterators implement a trait named `Iterator` that is defined in the standard library and is used to implement iterators over collections such as ranges, arrays, vectors and hashmaps.

The core of that trait looks like this:

```rust
trait Iterator {
    type Item;
    fn next(&mut self) -> Option<Self::Item>;
}
```

An `iterator` has a method, `next`, which when called, returns an `Option<Item>`. `next` will return `Some(Item)` as long as there are elements, and once they've all been exhausted, will return `None` to indicate that iteration is finished.

Notice this definition uses some new syntax: `type Item` and `Self::Item`, which are defining an
associated type with this trait. This means that every implementation of the `Iterator` traits also requires the definition of the associated `Item` type, wich is used as the return type of the `next` method. In other words, the `Item` type will be the type returned from the iterator inside the `for` loop block.

## Implementing our own iterator

Creating an iterator of your own involves two steps:

1. Creating a struct to hold the iterator's state, and then
2. Implementing Iterator for that struct.

Let's make an iterator named `Counter` which counts from 1 to an arbitrary number, defined when the `Counter` struct is created.

First, we create the struct that will hold our iterator state. We also implement a `new` method to control how it should be initiated.

```rust
#[derive(Debug)]
struct Counter {
    length: usize,
    count: usize,
}

impl Counter {
    fn new(length: usize) -> Counter {
	Counter {
	    count: 0,
	    length,
	}
    }
}
```

Then, we implement the `Iterator` trait for our `Counter` struct. We will be counting with usize, so we declare that our associated `Item` type should be of that type.

`next()` is the only required method that we should define, and inside its body we increment our
count by 1 at every call *(this is why we started at zero)*, and then we check to see if we've
finished counting or not. We use the `Some(value)` variant of the `Option` type to express that
iteration is still yielding results and the `None` variant to express that iteration should stop.

```rust
impl Iterator for Counter {
    type Item = usize;

    fn next(&mut self) -> Option<Self::Item> {
    self.count += 1;
    if self.count <= self.length {
        Some(self.count)
    } else {
        None
    }
    }
}
```

We can check that our `Counter` works by explicitly calling its `next` function.

```rust
fn main() {
    let mut counter = Counter::new(6);
    println!("Counter just created: {:#?}", counter);

    assert_eq!(counter.next(), Some(1));
    assert_eq!(counter.next(), Some(2));
    assert_eq!(counter.next(), Some(3));
    assert_eq!(counter.next(), Some(4));
    assert_eq!(counter.next(), Some(5));
    assert_eq!(counter.next(), Some(6));
    assert_eq!(counter.next(), None);
    assert_eq!(counter.next(), None);  // further calls to `next` will return `None`
    assert_eq!(counter.next(), None);

    println!("Counter exhausted: {:#?}", counter);
}

```

But calling `next` this way gets repetitive. Rust allows us to use `for` loops in types that
implement the `Iterator` trait, so lets do that:

```rust
fn main() {
    for number in Counter::new(10) {
    println!("{}", number);
    }
}
```

The snippet above will then print the following in the console:

```output
    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
```

`Iterator`'s full definition includes a number of other methods as well, but they are default
methods, built on top of `next`, and so you get them for free:

```rust
let sum_until_10: usize = Counter::new(10).sum();
assert_eq!(sum_until_10, 55);

let powers_of_2: Vec<usize> = Counter::new(8).map(|n| 2usize.pow(n as u32)).collect();
assert_eq!(powers_of_2, vec![2, 4, 8, 16, 32, 64, 128, 256]);
```

You can check the complete code example of this unit at this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=36fb2b6f5acdb60f78c7fe3efda5f278).

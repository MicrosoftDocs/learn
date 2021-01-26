If you take a closer look at the previous compiler error, you'll see a hint about changing our reference to be **mutable** by changing our type parameter from `&String` to `&mut String`. We also need to declare our original value as mutable:

```rust
fn main() {
    let mut greeting = String::from("hello");
    change(&mut greeting);
}

fn change(text: &mut String) {
    text.push_str(", world");
}
```

## Borrowing and mutable references

Mutable data can be borrowed using `&mut T`. This is called a *mutable reference* or
*mutable borrow* and gives read/write access to the borrower. In contrast, `&T` borrows the data via an *immutable reference*, and the borrower can read the data but not modify it.

You may have either one or the other of these two kinds of borrows, but not both at the same time:

- one or more references (`&T`) to a resource.
- exactly one mutable reference (`&mut T`)

The following code would then fail to compile:

```rust
fn main() {
    let mut value = String::from("hello");

    let ref1 = &mut value;
    let ref2 = &mut value;

    println!("{}, {}", ref1, ref2);
}

```

```output
    error[E0499]: cannot borrow `value` as mutable more than once at a time
     --> src/main.rs:5:16
      |
    4 |     let ref1 = &mut value;
      |                ---------- first mutable borrow occurs here
    5 |     let ref2 = &mut value;
      |                ^^^^^^^^^^ second mutable borrow occurs here
    6 |
    7 |     println!("{}, {}", ref1, ref2);
      |                        ---- first borrow later used here
```

We can even try to mix *immutable references* with *mutable references* but the compiler will still complain:

```rust
fn main() {
    let mut value = String::from("hello");

    let ref1 = &value;
    let ref2 = &mut value;

    println!("{}, {}", ref1, ref2);
}
```

```output
    error[E0502]: cannot borrow `value` as mutable because it is also borrowed as immutable
     --> src/main.rs:5:16
      |
    4 |     let ref1 = &value;
      |                ------ immutable borrow occurs here
    5 |     let ref2 = &mut value;
      |                ^^^^^^^^^^ mutable borrow occurs here
    6 |
    7 |     println!("{}, {}", ref1, ref2);
      |                        ---- immutable borrow later used here
```

The main idea when dealing with references is that Rust developers are always choosing between aliasing and mutation, but never both. This might seem harsh at first, but this aspect of the borrow checker prevents Rust code from ever having a race condition.

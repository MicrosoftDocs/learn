In the previous module, we learned about how values have owners. We transfer ownership of a value by moving ownership from one variable to another. Ownership can't be transferred for types that implement the `Copy` trait, such as for simple values like numbers.

We can also **explicitly** copy values by using the *cloning* process. We call the `clone` method and get new values that are copied, which leaves the original values unmoved and free to still use.

Wouldn't it be nice to be able to allow functions and other variables to use certain data without fully owning it?

This type of functionality is available by using *references*. References allow us to "borrow" values without taking ownership of them.

```rust
let greeting = String::from("hello");
let greeting_reference = &greeting; // We borrow `greeting` but the string data is still owned by `greeting`
println!("Greeting: {}", greeting); // We can still use `greeting`
```

In the previous code, `greeting` was borrowed by using the reference symbol (`&`). The variable `greeting_reference` was of type string reference (`&String`). Since we only borrowed `greeting` and didn't move ownership, `greeting` could still be used after we created `greeting_reference`.

## References in functions

This example isn't too interesting since we're not actually using `greeting_reference` for anything. Let's take a look at how we use references in functions.

```rust
fn print_greeting(message: &String) {
  println!("Greeting: {}", message);
}

fn main() {
  let greeting = String::from("Hello");
  print_greeting(&greeting); // `print_greeting` takes a `&String` not an owned `String` so we borrow `greeting` with `&`
  print_greeting(&greeting); // Since `greeting` didn't move into `print_greeting` we can use it again
}
```

Borrowing allows us to use a value without taking full ownership. However, as we'll see, borrowing a value means we can't do everything we can do with a fully owned value.

## Mutate borrowed values

What happens if we try to mutate a value we borrowed?

```rust
fn change(message: &String) {
  message.push_str("!"); // We try to add a "!" to the end of our message
}

fn main() {
  let greeting = String::from("Hello");
  change(&greeting); 
}
```

This code won't compile. Instead we get the following compiler error:

```output
error[E0596]: cannot borrow `*message` as mutable, as it is behind a `&` reference
 --> src/main.rs:2:3
  |
1 | fn change(message: &String) {
  |                    ------- help: consider changing this to be a mutable reference: `&mut String`
2 |   message.push_str("!"); // We try to add a "!" to the end of our message
  |   ^^^^^^^ `message` is a `&` reference, so the data it refers to cannot be borrowed as mutable
```

If you take a closer look at the compiler error, you'll see a hint about changing our reference to be *mutable* by changing the type parameter from `&String` to `&mut String`. We also need to declare our original value as mutable:

```rust
fn main() {
    let mut greeting = String::from("hello");
    change(&mut greeting);
}

fn change(text: &mut String) {
    text.push_str(", world");
}
```

With `&` borrows, known as "immutable borrows," we can read the data but we can't change it. With `&mut` borrows, known as "mutable borrows," we can both read and change the data.

## Borrowing and mutable references

Now we get to the real core of Rust's memory management story. Immutable and mutable references differ in one other way that has radical effects on how we build our Rust programs. When we borrow a value of any type `T`, the following rules apply:

Your code must implement *either* of the following definitions, but **not both at the same time**:

- One or more immutable references (`&T`)
- Exactly one mutable reference (`&mut T`)

The following code doesn't have the allowed definitions, so the compilation fails:

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

We can even try to mix immutable references with mutable references, but the compiler will still complain:

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

This restriction may seem harsh at first, but this aspect of borrowing prevents Rust code from a whole host of issues, including never having data races.

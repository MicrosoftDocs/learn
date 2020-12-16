Values can be bound to variables using the `let` keyword.

```rust
fn main() {
  let a_number = 10;
  let a_boolean = true;

  println!("the number is {}.", a_number);
  println!("the boolean is {}.", a_boolean);
}
```

`println` is a macro that takes a string as a first argument and one extra argument for each `{}`
inside that string and replaces them for the argument's display value.

> [!NOTE]
> We won't cover Rust macros in this module, but you can think of the `println` macro as a function
with a variable number of arguments, for now

The example above would print:

> the number is 10.

> the boolean is true.

## Mutability

In Rust, variable bindings are immutable by default. When a variable is immutable, once a value is
bound to a name, you can’t change that value.

For instance, if we try to change the value of our number from the previous example, we would receive an
error message from the compiler.

```rust
fn main() {
  let a_number = 10; // error: cannot assign twice to immutable variable `a_number`
  println!("the number is {}.", a_number);
  a_number = 15;
  println!("and now the number is {}.", a_number);
}
```

You can see this error message for yourself in the [Rust Playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=723a1c9bd36161c3cfc056f572ed9c11?azure-portal=true).
Just click the "Run" button to execute the code.

In order to mutate a value we must first use the `mut` keyword to make a variable binding mutable
instead.

```rust
fn main() {
  let mut a_number = 10; // notice the `mut` keyword
  println!("the number is {}.", a_number);
  a_number = 15;
  println!("and now the number is {}.", a_number);
}
```

This code will compile without errors, since the variable `a_number` is now allowed to be mutated.

## Shadowing

You can also declare a new variable with the same name as a previous variable, creating a new
binding. In Rust this operation is called "shadowing" since the new variable shadows the previous
variable, in the sense that the old variable still exists, but you can't refer to it in this scope
anymore.

Note that the variable `number` from the example above does not need to be mutable. In fact, no
mutation occurs since every operation creates a new variable while shadowing the previous one.

```rust
fn main() {
    let number = 5;          // the first binding is created using the name "number"
    let number = number + 5; // a different binding shadows the name "number"
    let number = number * 2; // again, a new binding is created
    println!("The number is: {}", number);
}
```

Can you guess the output?
[Visit the Rust Playground to run this example](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=ddc9fa490b0602526e10b564fa93890a?azure-portal=true).

Values can be bound to variables by using the `let` keyword.

```rust
fn main() {
    let a_number = 10;
    let a_boolean = true;

    println!("The number is {}.", a_number);
    println!("The boolean is {}.", a_boolean);
}
```

The `println` macro takes a string as a first argument and one extra argument for each `{}` inside that string and replaces them for the argument's display value. 


> [!NOTE]
> We add the exclamation mark `!` when we call `println!` to let Rust know that we're using this function as a macro and not a normal method. We won't cover Rust macros in detail this module. For now, you can think of the `println!` macro as a function with a variable number of arguments. 


Our example prints the following output:

```output
The number is 10.
The boolean is true.
```

## Mutability

In Rust, variable bindings are immutable by default. When a variable is immutable, after a value is
bound to a name, you can't change that value.

For instance, if we tried to change the value of our number from the previous example, we would receive an
error message from the compiler.

```rust
fn main() {
    let a_number = 10;
    println!("The number is {}.", a_number);
    
    a_number = 15;
    // Error: cannot assign twice to immutable variable `a_number`
    println!("Now the number is {}.", a_number);
}
```

You can see this error message for yourself in the [Rust Playground][RustPlay-errmsg]. Select the **Run** button to run the code.

To mutate a value, we must first use the `mut` keyword to make a variable binding mutable instead.

```rust
fn main() {
    // The `mut` keyword lets the variable be changed
    let mut a_number = 10; 
    println!("The number is {}.", a_number);

    a_number = 15;
    println!("Now the number is {}.", a_number);
}
```

This code compiles without errors because the variable `a_number` can now be mutated.

## Shadowing

You can also declare a new variable with the same name as a previous variable, which creates a new binding. In Rust, this operation is called "shadowing" because the new variable shadows the previous variable. The old variable still exists, but you can't refer to it in this scope anymore.

The variable `number` from the preceding example doesn't need to be mutable. No mutation occurs because every operation creates a new variable while shadowing the previous one.

```rust
fn main() {
    // The first binding is created with the name "number"
    let number = 5;

    // A different binding shadows the name "number" 
    let number = number + 5; 

    // Again, another new binding is created
    let number = number * 2; 
    println!("The number is {}.", number);
}
```

Can you guess the output? Visit the [Rust Playground to run this example][RustPlay-shadow].


<!-- Links -->
[RustPlay-errmsg]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=e993f03ddbaa2831a27accda66c332c1?azure-portal=true
[RustPlay-shadow]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=e6f06e06abb37c9ee15e25de0d510f5a?azure-portal=true

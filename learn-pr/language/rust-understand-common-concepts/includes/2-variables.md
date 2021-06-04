Developers write computer programs to work with data. Data is gathered, analyzed, stored, processed, shared, and reported. To do these tasks, we need a way to work with the data and pass it to the functions in our program. We use a programming construct called *variables* to work with data.

## Variables

In Rust, a variable is declared with the keyword `let`. Each variable has a unique name. When a variable is declared, it can be bound to a value, or the value can be bound later in the program. The following code declares a variable named `a_number`. 

```rust
    let a_number;
```

The `a_number` variable isn't yet bound to a value. We can modify this statement to bind a value to the variable:

```rust
    let a_number = 10;
```

> [!Note]
> **Keywords**
> &nbsp;
> As with other programming languages, certain *keywords* like `fn` and `let` are reserved for use only by Rust. Keywords can't be used as names of functions or variables. For more information about keywords, see the [Rust appendix][Rust-keywords]. 


Let's look at another example. The following code declares two variables. The first variable is declared and bound to a number value. The second variable is declared, but it's not bound to a value. Later in the program, the value for the second variable is bound to a word. The code calls the `println!` macro to display the variable values.

```rust
fn main() {
    // Declare a variable
    let a_number;
    
    // Declare a second variable and bind the value
    let a_word = "Ten";
    
    // Bind a value to the first variable
    a_number = 10;

    println!("The number is {}.", a_number);
    println!("The word is {}.", a_word);
}
```

Our example prints the following output:

```output
The number is 10.
The word is Ten.
```

If we call the `println!` macro and try to show the value of the `a_number` variable before it's bound, the compiler returns an error.
You can see this error message for yourself in the [Rust Playground][RustPlay-variables]. Select the **Run** button to run the code.


## Immutable versus mutable

In Rust, variable bindings are immutable by default. When a variable is immutable, after a value is bound to a name, you can't change that value.

For instance, if we try to change the value of the `a_number` variable from the previous example, we receive an error message from the compiler.

```rust
    // Change the value of an immutable variable
    a_number = 15;
```

You can see this error message for yourself in the [Rust Playground][RustPlay-variables]. 

To mutate a value, we must first use the `mut` keyword to make a variable binding mutable.

```rust
fn main() {
    // The `mut` keyword lets the variable be changed
    let mut a_number = 10; 

    println!("The number is {}.", a_number);

    // Change the value of an immutable variable
    a_number = 15;

    println!("Now the number is {}.", a_number);
}
```

This example prints the following output:

```output
The number is 10.
Now the number is 15.
```

This code compiles without errors because the variable `a_number` can now be mutated.


## Variable shadowing

You can declare a new variable that uses the same name of an existing variable. The new declaration creates a new binding. In Rust, this operation is called "shadowing" because the new variable shadows the previous variable. The old variable still exists, but you can't refer to it in this scope anymore.

The following code demonstrates the use of shadowing. We declare a variable named `shadow_num`. We don't define the variable as mutable because each `let` operation creates a new variable named `number` while shadowing the previous variable binding.

```rust
fn main() {
    // Declare the first variable binding with the name "shadow_num"
    let shadow_num = 5;

    // Declare a second variable binding
    // This binding shadows the existing variable named "shadow_num" 
    let shadow_num = shadow_num + 5; 

    // Declare a third variable binding
    // This binding shadows the second binding of the variable named "shadow_num"
    let shadow_num = shadow_num * 2; 

    println!("The number is {}.", shadow_num);
}
```

Can you guess the output? Visit the [Rust Playground to run this example][RustPlay-shadow].


<!-- Links -->
[Rust-keywords]: https://doc.rust-lang.org/book/appendix-01-keywords.html?azure-portal=true
[RustPlay-shadow]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=e6f06e06abb37c9ee15e25de0d510f5a?azure-portal=true
[RustPlay-variables]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=ece8cff9611f109439db2645d75e98d6?azure-portal=true

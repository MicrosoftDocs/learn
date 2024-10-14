Developers write computer programs to work with data. Data is gathered, analyzed, stored, processed, shared, and reported. We use *variables* to store our data in a named reference that we can refer to later in our code.

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
> As with other programming languages, certain *keywords* like `fn` and `let` are reserved for use only by Rust. Keywords can't be used as names of functions or variables.

Let's look at another example. The following code declares two variables. The first variable is declared but not bound to a value. The second variable is declared and bound to a value. Later in the program, the first variable is bound to a value. The code calls the `println!` macro to display the variable values.

```rust
// Declare a variable
let a_number;
    
// Declare a second variable and bind the value
let a_word = "Ten";
    
// Bind a value to the first variable
a_number = 10;

println!("The number is {}.", a_number);
println!("The word is {}.", a_word);
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

You can try this change yourself and see the error message in the [Rust Playground][RustPlay-variables]. 

To mutate a value, we must first use the `mut` keyword to make a variable binding mutable.

```rust
// The `mut` keyword lets the variable be changed
let mut a_number = 10; 
println!("The number is {}.", a_number);

// Change the value of an immutable variable
a_number = 15;
println!("Now the number is {}.", a_number);
```

This example prints the following output:

```output
The number is 10.
Now the number is 15.
```

This code compiles without errors because the variable `a_number` can now be mutated.

## Variable shadowing

You can declare a new variable that uses the name of an existing variable. The new declaration creates a new binding. In Rust, this operation is called "shadowing" because the new variable shadows the previous variable. The old variable still exists, but you can't refer to it in this scope anymore.

The following code demonstrates the use of shadowing. We declare a variable named `shadow_num`. We don't define the variable as mutable because each `let` operation creates a new variable named `shadow_num` while shadowing the previous variable binding.

```rust
// Declare first variable binding with name "shadow_num"
let shadow_num = 5;

// Declare second variable binding, shadows existing variable "shadow_num" 
let shadow_num = shadow_num + 5; 

// Declare third variable binding, shadows second binding of variable "shadow_num"
let shadow_num = shadow_num * 2; 

println!("The number is {}.", shadow_num);
```

Can you guess the output? Visit the [Rust Playground][RustPlay-shadow] to run this example.


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.


<!-- Links -->

[RustPlay-shadow]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=ece8cff9611f109439db2645d75e98d6?azure-portal=true
[RustPlay-variables]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=7619f3a57e95b1c161d410641f9e88fb?azure-portal=true

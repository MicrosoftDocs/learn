An essential part of programming involves making decisions based on the data. In this unit, we learn how to control program actions by testing for conditions.

We can create *conditional branches* in our code by using the `if` and `else` keywords. Many programming languages offer this functionality and use similar syntax.

The `if` and `else` keywords are used with expressions to test values and do actions based on the test result. All conditional expressions result to a boolean: true or false.

## Define an if/else condition

Here's an example that tests if two numbers are the same, and prints a message based on the test result:

```rust
if 1 == 2 {
    println!("True, the numbers are equal."); // 
} else {
    println!("False, the numbers are not equal.");
}
```

In this example, the condition of `if` is the expression `1 == 2`, which evaluates into a boolean type with the value false.

Unlike most other languages, `if` blocks in Rust can also act as expressions. All execution blocks in the condition branches must return the same type for the code to compile.

```rust
let formal = true;
let greeting = if formal { // if used here as an expression
    "Good day to you."     // return a String
} else {
    "Hey!"                 // return a String
};
println!("{}", greeting)   // prints "Good day to you."
```

In this example, we assign a value to the `greeting` variable based on the result of the `if formal` expression. When the expression `if formal` is true, the `greeting` value is set to the string "Good day to you." When the expression is false, the `greeting` value is set to the string "Hey!". Because we initialized the `formal` variable to true, we know the result of the expression `if formal` is also true.

## Combine multiple test conditions

You can combine `if` and `else` together to form an `else if` expression. Multiple `else if` conditions can be used after the starting `if` condition, and before a closing `else` condition, which is optional.

If a condition expression evaluates to `true`, the corresponding action block is executed. Any following `else if` or `else` blocks are skipped. If a condition expression evaluates to `false`, the corresponding action block is skipped. Any following `else if` condition is evaluated. If all `if` and `else if` conditions evaluate to `false`, then any `else` block is executed.

In this example, we check if a number is within an allowable range. We want to do some specific processing when the number is less than zero, equal to zero, or greater than 512. We declare the boolean variable `out_of_range`, but we don't set the variable value until the program enters the conditional test expression.

```rust
let num = 500; // num variable can be set at some point in the program
let out_of_range: bool;
if num < 0 {
    out_of_range = true;
} else if num == 0 {
    out_of_range = true;
} else if num > 512 {
    out_of_range = true;
} else {
    out_of_range = false;
}
```

We'll use `if` and `else` conditional expressions in our upcoming exercises.

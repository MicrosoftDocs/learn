An essential part of any programming languages are ways to modify control flow. In this unit we are
going to learn how to control our code to run only under certain conditions.

## `if/else` expressions

We can create conditional branches in the execution of our code using the `if` and `else` keywords,
much similar to what other languages do.

The form of an `if` expression is a condition expression, followed by a consequent block, any number
of `else if` conditions and blocks, and an optional trailing `else` block. The condition expressions
must have type `bool`.

```rust
if 1 == 2 {
    println!("whoops, mathematics broke");
} else {
    println!("everything's fine!");
}
```

In the example above, the condition of our `if` is the expression: `1 == 2`, which evaluates into a
boolean type with the value **false**.

However, unlike in most languages, `if` blocks can also act as expressions so it's important to keep
in mind that all branches must return the same type for our code to compile.

```rust
let formal = true;
let greeting = if formal {
    "Good evening."
} else {
    "Hello, friend!"
};
println!(greeting) // prints "Good evening."
```

In the example above we can see that the result of the `if` expression is stored in the `greeting`
variable.

You can have multiple conditions by combining `if` and `else` in an `else if` expression. For
example:

```rust
let number = 6;

if number % 4 == 0 {
    println!("number is divisible by 4");
} else if number % 3 == 0 {
    println!("number is divisible by 3");
} else if number % 2 == 0 {
    println!("number is divisible by 2");
} else {
    println!("number is not divisible by 4, 3, or 2");
}
```

This program has four possible paths it can take. After running it, you should see the following output:

```output
    number is divisible by 3
```

If a condition expression evaluates to `true`, the consequent block is executed and any subsequent
`else if` or `else` block is skipped. If a condition expression evaluates to `false`, the consequent
block is skipped and any subsequent `else if` condition is evaluated. If all `if` and `else if`
conditions evaluate to `false` then any `else` block is executed.

## Looping forever with `loop`

A `loop` expression denotes an infinite loop. It repeats execution of its body continuously:

```rust
loop {
    println!("I loop forever");
}
```

Unlike the other kinds of loops in Rust like while and for, `loop` can be used in expressions that return values via
`break`.

```rust
let mut i = 1;
let something = loop {
    i *= 2;
    if i > 100 {
    break i;
    }
};
assert_eq!(something, 128);
```

Every `break` a loop has to have the same type. When it's not explicitly giving something, `break;`
returns `()` *(an empty tuple)*.

## Looping until a criteria is met with `while` loops

A `while` expression loops until a predicate is false.

A `while` loop begins by evaluating the boolean loop conditional expression. If the loop conditional
expression evaluates to `true`, the loop body block executes, then control returns to the loop
conditional expression. If the loop conditional expression evaluates to `false`, the `while`
expression completes.

The following code will loop until the predicate evaluates to `true`:

```rust
let mut counter = 0;

while counter < 10 {
    println!("hello");
    counter = counter + 1;
}
```

## Iterating with `for` loops

A `for` expression extracts values from an iterator, looping until the iterator is empty.

In Rust, a iterator is any type that implements the `IntoIterator` trait. We are going to cover
Traits in-depth in the following chapters, but for now, you can think of them as interfaces that
define some expected behaviors that any type can attempt to comply with.

Most collection types in Rust implements the `IntoIterator` interface, so we can easily step over
each element on those containers.

```rust
let a = [10, 20, 30, 40, 50];

for element in a.iter() {
    println!("the value is: {}", element);
}
```

The code above will iterate through each element in the array and bind it to the `element`
variable. The `println!` macro will then print each of those values in sequence.

Another easy way to create an iterator is to use the range notation `a..b`. This yields values from
`a` (inclusive) to `b` (exclusive) in steps of one.

```rust
for item in 0..5 {
    println!("{}", item * 2);
}
```

The code above will iterate through the numbers 0, 1, 2, 3 and 4 and bind it to the `item` variable
for each cycle of this loop.

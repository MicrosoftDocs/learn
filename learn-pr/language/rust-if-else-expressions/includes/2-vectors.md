As with arrays, vectors store multiple values that have the same data type. Unlike arrays, the size or length of a vector can grow or shrink at any time. The ability for the size to change over time is implied at compile time. As a result, Rust can't prevent you from accessing an invalid position in your vector like it does for out-of-bounds access in arrays.

### Define a vector

When you read code in the Rust language, you'll notice the syntax `<T>`. This syntax represents the use of a generic type `T`. We use a generic type declaration when we don't yet know the actual data type.

The generic type syntax is used to declare vectors. The syntax `<vector><T>` declares a vector type composed of a generic (not yet known) data type `T`. To actually create a vector, we use a concrete type like `<vector>u32`, a vector of type u32, or `<vector>String`, a vector of type String.

A common way to declare and initialize a vector is with the `vec!` macro. This macro also accepts the same syntax as the array constructor.

```rust
// Declare vector, initialize with three values
let three_nums = vec![15, 3, 46];
println!("Initial vector: {:?}", three_nums);  
  
// Declare vector, value = "0", length = 5
let zeroes = vec![0; 5];
println!("Zeroes: {:?}", zeroes); 
```

The output is:

```output
Initial vector: [15, 3, 46]
Zeroes: [0, 0, 0, 0, 0]
```

In this example, we use the colon question mark `{:?}` syntax with the `println!` macro. Rust doesn't know how to display a vector of integers. If we try to display the vector information without using special formatting, the compiler issues an error. We use the empty curly parenthesis `{}` to help display the vector values. 

Vectors can also be created by using the `Vec::new()` method. This method of vector creation lets us add and remove values at the end of the vector. To support this behavior, we declare the vector variable as mutable with the `mut` keyword.

```rust
// Create empty vector, declare vector mutable so it can grow and shrink
let mut fruit = Vec::new();
```

### Push and pop values

When we create a vector with the `Vec::new()` method, we can add and remove values at the end of the vector.

To add a value to the end of the vector, we use the `push(<value>)` method. 

```rust
// Push values onto end of vector, type changes from generic `T` to String
fruit.push("Apple");
fruit.push("Banana");
fruit.push("Cherry");
println!("Fruits: {:?}", fruit); 
```

In the output, notice the system displays the square brackets for the vector, and also the quotation marks around each `String` value:

```output
Fruits: ["Apple", "Banana", "Cherry"]
```

After the type of a vector is set to a concrete type, only values of that specific type can be added to the vector. If we try to add a value of a different type, the compiler returns an error.

```rust
// Push integer value, but vector expects String (&str) type value
fruit.push(1);
```

Compiler error:

```output
error[E0308]: mismatched types
  --> src/main.rs:11:17
   |
11 |     fruit.push(1);
   |                ^ expected `&str`, found integer

error: aborting due to previous error
```

To remove the value at the end of the vector, we use the `pop()` method.

```rust
// Pop off value at end of vector
// Call pop() method from inside println! macro
println!("Pop off: {:?}", fruit.pop());
println!("Fruits: {:?}", fruit); 
```

The output shows the "Cherry" value was removed and isn't attached to a vector:

```output
Pop off: Some("Cherry")
Fruits: ["Apple", "Banana"]
```

### Index into a vector

Vectors support indexing in the same manner as arrays. We can access element values in the vector by using an index. The first element is at index 0 and the last element is at vector length - 1. 

```rust
// Declare vector, initialize with three values
let mut index_vec = vec![15, 3, 46];
let three = index_vec[1];
println!("Vector: {:?}, three = {}", index_vec, three);  
```

The output is:

```output
Vector: [15, 3, 46], three = 3
```

Because vector values are mutable, we can change a value in place by accessing the element value with the index:

```rust
// Add 5 to the value at index 1, which is 5 + 3 = 8
index_vec[1] = index_vec[1] + 5;
println!("Vector: {:?}", index_vec);  
```

The output is:

```output
Vector: [15, 8, 46]
```

### Watch for out-of-bounds index values

As with arrays, we can't access an element in a vector with an index that's not in the allowed range. This type of expression for an array causes the compiler to return an error. For vectors, compilation passes, but the program enters an unrecoverable panic state at the expression and stops program execution.

For our example vector that has three elements, what happens if we try to access the element at index 10?

```rust
// Access vector with out-of-bounds index
let beyond = index_vec[10];
println!("{}", beyond);
```

The program aborts with the following error message:

```output
thread 'main' panicked at 'index out of bounds: the len is 3 but the index is 10'...
```

In another module, we look at how to safely access a vector element without causing a program panic. 

You can run this code and explore vectors in this [Rust Playground][RustPlay-vector].

### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.

<!-- Links -->
[RustPlay-vector]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=b5c73ebd5f094c758797cd4efee10012?azure-portal=true

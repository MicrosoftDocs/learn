Besides tuples, Rust has many other *compound types* that can group multiple values into one single type.

## Arrays

An array is a collection of objects of the same type that are stored sequentially in memory. The length or *size* of an array equals the number of elements in the array. The size of an array can be specified in the code, or computed by the compiler.

An array can be defined in two ways:

- A comma-separated list of values, where the length isn't specified.
- The initial value followed by a semicolon, and then the array length.

In both cases, the content is enclosed in square brackets `[]`.

```rust
// Declare array, initialize all values, compiler infers length = 7
let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  
// Declare array, first value = "0", length = 5
let bytes = [0; 5];
```

### Array signature

At compile time, the signature of an array is defined as `[T; size]`:

- `T` is the data type for all elements in the array.
- `size` is a nonnegative integer that represents the array length.

The signature reveals two important characteristics about arrays:

- Every element of an array has the same data type. The data type never changes.
- The size of an array is fixed. The length never changes. 

Only one thing about an array can change over time: the values for the elements in the array. The data type remains constant and the number of elements (length) remains constant. Only the values can change.


### Array indexing

The elements in an array are implicitly numbered starting from 0. We use indexing to access the elements in an array with the expression `<array>[<index>]`. `my_array[0]` accesses the element at index 0 in the `my_array` variable. The expression returns the value of the array element at that index location.

Let's look at an example.

```rust
// Set first day of week
let first  = days[0];

// Set second day of week
let second = days[1];
```

We have an array named `days` with seven elements. To access the elements in the array, we use an index that ranges from 0 to the array length - 1, or 6. In the `days` array, the first element at index 0 has the value "Sunday." The seventh element at index 6 has the value "Saturday."

To assign a value to the `first` variable, we use the expression `days[0]` to get the value of the first element in the `days` array, which is `Sunday`. For the `second` variable, we use a similar expression `days[1]` to get the value of the second element in the `days` array, which is `Monday`.


### Out-of-bounds index

If we try to access an element in our array with an index that's not in the allowed range, the compiler returns an error. An expression like `days[7]` is out of bounds because our array has only seven elements. The valid index range is 0 - 6. Any index that's equal to or greater than the array length is out of bounds. Any index that's a negative number is also out of bounds.

The following code shows the out-of-bounds compiler error:

```rust
// Set seventh day of week, use wrong index - should be 6
let seventh  = days[7];
```

Error output:

```output
    error: this operation will panic at runtime
     --> src/main.rs:19:42
   |
19 |     let seventh  = days[7];
   |                    ^^^^^^^ index out of bounds: the length is 7 but the index is 7
   |
```

Because the array length is known at compile time, Rust makes it impossible to build any program that attempts to access the array with an out-of-bounds index.

You can interact with this code and explore arrays in this [Rust Playground][RustPlay-array].


## Vectors

Just like with arrays, you can use vectors to store multiple values that all have the same data type. But unlike arrays, the size or length of a vector can grow or shrink at any time. The ability for the size to change over time is implied at compile time. As a result, Rust can't prevent you from accessing an invalid position in your vector like it does for out-of-bounds access in arrays.


### Generic type <T> syntax

When you read code in the Rust language, you'll notice the syntax `<T>`. This syntax represents the use of a generic type `T`. We use a generic type declaration when we don't yet know the actual data type.

The generic type syntax is used to declare vectors. The syntax `<vector><T>` declares a vector type composed of a generic (not yet known) data type `T`. To actually create a vector, we use a concrete type like `<vector>u32`, a vector of type u32, or `<vector>String`, a vector of type String.

A common way to declare and initialize a vector is with the `vec!` macro. This macro also accepts the same syntax as the array constructor. 

```rust
// Declare vector, initialize with three values
let three_nums = vec![15, 3, 46];
println!("Initial vector: {:?}", three_nums);  
  
// Declare vector, first value = "0", length = 5
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


### Push and pop

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


### Vector indexing

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


### Out-of-bounds index

As with arrays, we can't access an element in a vector with an index that's not in the allowed range. For arrays, this type of expression causes the compiler to return an error. For vectors, compilation passes, but the program enters an unrecoverable panic state at the expression and stops program execution.

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


## Hash maps

Another common collection type is the hash map. The `HashMap<K, V>` type stores data by mapping each key `K` with its value `V`. While data in a vector is accessed by using an integer index, data in a hash map is accessed by using a key.

The hash map type is used in many programming languages. Objects, hash tables, and dictionaries are some examples.

Like vectors, hash maps are growable. The data is stored in the heap and access to the hash map items are checked at run time.

The following example uses a hash map to track book reviews. The hash map keys are the book names and the values are the reader reviews.

```rust
use std::collections::HashMap;
let mut reviews: HashMap<String, String> = HashMap::new();

reviews.insert("Ancient Roman History".to_string(), "Very accurate.".to_string());
reviews.insert("Cooking with Rhubarb".to_string(), "Sweet recipes.".to_string());
reviews.insert("Programming in Rust".to_string(), "Great examples.".to_string());
```

Let's examine this code more closely. On the first line, we see a new type of syntax:

```rust
use std::collections::HashMap;
```

The `use` command brings the `HashMap` definition from the `collections` portion of the Rust standard library into scope for our program. This syntax is similar to what other programming languages call an *import*.

We create an empty hash map with the `HashMap::new` method. We declare the `reviews` variable as mutable so we can add or remove keys and values, as needed. In our example, both the hash map keys and values use the `String` type.

```rust
let mut reviews: HashMap<String, String> = HashMap::new();
```

We add elements to the hash map by using the `insert(<key>, <value>)` method. In the code, the syntax is `<hash_map_name>.insert()`:

```rust
reviews.insert("Ancient Roman History".to_string(), "Very accurate.".to_string());
```

Another new piece of syntax is the call to the `to_string()` method. This method converts a string literal (`&str`) value into the `String` type. We use this method so the hash map contains the actual value rather than a reference or *pointer* to the value.

After we add data to our hash map, we can get a specific value for a key with the `get(<key>)` method.

```rust
// Look for a specific review
let book: &str = "Programming in Rust";
println!("\nReview for \'{}\': {:?}", book, reviews.get(book));
```

The output is:

```rust
Review for 'Programming in Rust': Some("Great examples.")
```

Notice the output displays the book review as "Some("Great examples.")" rather than just "Great examples." Because the `get` method returns an `Option<&Value>` type, Rust wraps the result of the method call with the "Some()" notation.

We can remove entries from a hash map by using the `.remove()` method. If we use the `get` method for an invalid hash map key, the `get` method returns "None."

```rust
// Remove book review
let obsolete: &str = "Ancient Roman History";
println!("\n'{}\' removed.", obsolete);
reviews.remove(obsolete);

// Confirm book review removed
println!("\nReview for \'{}\': {:?}", obsolete, reviews.get(obsolete));
```

The output is:

```rust
'Ancient Roman History' removed.
Review for 'Ancient Roman History': None
```

You can try this code and work with hash maps in this [Rust Playground][RustPlay-hash].

In the next unit, we'll learn how to use loop expressions to *iterate* over collection values.


<!-- Links -->
[RustPlay-array]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=31b8dba4c5391da0abcd570b38ca8bf2?azure-portal=true
[RustPlay-hash]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=4a2cb73f79abec30bcb0a1ba4f016f49?azure-portal=true
[RustPlay-vector]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=b5c73ebd5f094c758797cd4efee10012?azure-portal=true

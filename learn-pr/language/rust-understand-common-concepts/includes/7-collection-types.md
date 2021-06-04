Besides tuples, Rust has many other *compound types* that can group multiple values into one single type.

## Arrays

An array is a collection of objects of the same type that are stored sequentially in memory. The length or *size* of an array equals the number of elements in the array. The size of an array can be specified in the code, or computed by the compiler.

An array can be defined in two ways:

- A comma-separated list of values, where the length isn't specified.
- The initial value followed by a semicolon, and then the array length.

In both cases, the content is enclosed in square brackets `[]`.

```rust
    // Declare array, don't specify size - compiler will infer length = 7
    // Initialize array elements using comma-separated list of values
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  
    // Declare array, specify length = 5, specify first element value = "0"
    // Declaration initializes every array element with value = "0"
    // Short form of: let bytes = ["0", "0", "0", "0", "0"]
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
    // Set the first day of the week
    let first  = days[0];
    // Set the second day of the week
    let second = days[1];
```

We have an array named `days` with seven elements. To access the elements in the array, we use an index that ranges from 0 to the array length - 1, or 6. In the `days` array, the first element at index 0 has the value "Sunday." The seventh element at index 6 has the value "Saturday."

To assign a value to the `first` variable, we use the expression `days[0]` to get the value of the first element in the `days` array, which is `Sunday`. For the `second` variable, we use a similar expression `days[1]` to get the value of the second element in the `days` array, which is `Monday`.


### Out-of-bounds index

If we try to access an element in our array with an index that's not in the allowed range, the compiler returns an error. An expression like `days[7]` is out of bounds because our array has only 7 elements. The valid index range is 0 - 6. Any index that's equal to or greater than the array length is out of bounds. Any index that's a negative number is also out of bounds.

The following code shows the out-of-bounds compiler error:

```rust
    // Set seventh day of the week, use wrong index - should be 6
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
    // Declare vector with three values
    let three_nums = vec![15, 3, 46];
    println!("Initial vector: {:?}", three_nums);  
  
    // Declare vector of length = 5, specify first element value = "0"
    // Short form of: let zeroes = vec!["0", "0", "0", "0", "0"]
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
    // Push values onto the end of the vector, type changes from generic `T` to String
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
    // Push an integer value, but vector expects String (&str) type value
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
    // We can call the pop() method from inside the println! macro
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
    // Declare vector with three values
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
    // Add 5 to the value at index 1, 5 + 3 = 8
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
    // Try to access the vector with an out-of-bounds index
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

The last of our common syntax for collection is the hash map. The type `HashMap<K, V>` stores a mapping of keys of some type `K` to values of some type `V`. Where vectors store values by an integer index, hash maps store values by key.

Many programming languages support this kind of data structure. They often use a different name, such as hash, map, object, hash table, dictionary, associative array, and so on.

Like vectors, hash maps are growable, store the data in the heap, and access to its items are checked
at run time.

In the following example, we're keeping track of a personal book review system. The keys are the
book names, and the values are the reviews made by one specific user.

You can create an empty hash map by using the `HashMap::new` method and then adding elements with the
`HashMap::insert` method.

```rust
fn main() {
    use std::collections::HashMap;
    
    let mut book_reviews: HashMap<String, String> = HashMap::new();
    
    // Add book reviews
    book_reviews.insert(
        "Adventures of Huckleberry Finn".to_string(),
        "My favorite book.".to_string(),
    );
    book_reviews.insert(
        "Grimms' Fairy Tales".to_string(),
        "Masterpiece.".to_string(),
    );
    book_reviews.insert(
        "Pride and Prejudice".to_string(),
        "Very enjoyable.".to_string(),
    );
    book_reviews.insert(
        "The Adventures of Sherlock Holmes".to_string(),
        "Eye lyked it alot.".to_string(),
    );
}
```

You can see from the first line that we need to use `HashMap` from the `collections` portion of the
standard library to bring its name into scope. This use is similar to what other programming languages call an import.

The next notable aspect of the preceding snippet is the use of the `.to_string()` method invocation. This method transforms a string literal (`&str`) value into `String`. This method is useful when we want our hash map to "own" the values it holds, instead of being a collection of references *(pointers)*. We'll cover those differences in detail when we reach the "Ownership and Borrowing" module.

After we've populated our hash map, we can query it:

```rust
    // Query the review list for a specific item
    if !book_reviews.contains_key("Les Misérables") {
        println!("{} reviews found. No reviews found for Les Misérables.", book_reviews.len());
    }
```

Hash maps can use references to query for existing entries, which means that even if our hash map is of type `HashMap<String, String>`, we can use the `&str` or `&String` types to look up its keys.

Just like with vectors, looking for a nonexistent key causes the program to panic:

```rust
    // Searching for an existing key returns the value associated to it
    println!("Review for Jane: {}", book_reviews["Pride and Prejudice"]);
    println!("Review for Tom: {}", book_reviews["Adventures of Huckleberry Finn"]);    
    println!("Review for Arthur: {}", book_reviews["The Adventures of Sherlock Holmes"]);
    
    // Searching for a non-existent key causes a panic - no entry found for key
    println!("Review for Herman: {}", book_reviews["Moby Dick"]);
```

Hash maps also have the `.get()` method for safely querying their content without causing any panic. We'll cover them in the next module.

We can remove entries from a hash map by using the `.remove()` method:

```rust
    // Remove an entry from the review list
    let sherlock = "The Adventures of Sherlock Holmes";
    assert_eq!(book_reviews.contains_key(sherlock), true);
    
    book_reviews.remove(sherlock);
    assert_eq!(book_reviews.contains_key(sherlock), false);
    
    // Verify review was removed
    if !book_reviews.contains_key("The Adventures of Sherlock Holmes") {
        println!("{} reviews found. No reviews found for The Adventures of Sherlock Holmes.", book_reviews.len());
    }
```

In the next unit, we'll learn how to *iterate* over the elements of those collection types.


<!-- Links -->
[RustPlay-array]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=31b8dba4c5391da0abcd570b38ca8bf2?azure-portal=true
[RustPlay-hash]: ?azure-portal=true
[RustPlay-vector]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=b5c73ebd5f094c758797cd4efee10012?azure-portal=true


<!-- Advanced content

- The array type supports working with data allocated on the stack rather than the heap. This is useful because...
- The array type can be used to ensure a data set has always a fixed number of elements.

- vectors, handle out-of-bounds and program panics: We'll use the `Vec::get` method *(that never panics)* in the following module, when we learn about error handling in Rust.

The program resulted in a runtime error at the point of using an invalid value in the indexing operation. The program exited with an error message and didn't execute the final println! statement. When you attempt to access an element using indexing, Rust will check that the index you’ve specified is less than the array length. If the index is greater than or equal to the length, Rust will panic. This check has to happen at runtime, especially in this case, because the compiler can't possibly know what value a user will enter when they run the code later.

This is the first example of Rust’s safety principles in action. In many low-level languages, this kind of check is not done, and when you provide an incorrect index, invalid memory can be accessed. Rust protects you against this kind of error by immediately exiting instead of allowing the memory access and continuing. Chapter 9 discusses more of Rust’s error handling.

- Learn moer about debugging, display special data type values: We're going to learn precisely how to do that when we reach the "Traits" module in this course.
-->



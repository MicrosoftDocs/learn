Besides tuples, Rust has many other *compound types* that can group multiple values into one single type.

## Arrays

An array is a collection of objects of the same type, which are stored sequentially in memory. Arrays are
created by using brackets `[]`. Their size, which is known at compile time, is part of their type
signature `[T; size]`, where `T` is the type of the values in the array and `size` is a nonnegative
integer checked at compile time.

In other words, arrays have a fixed length. Every element of an array must be of the same type.

An array can be defined in two ways:

- A comma-separated list inside brackets
- The initial value, followed by a semicolon, and then the length of the array in brackets

```rust
fn main() {
    // Comma-separated list inside brackets
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    // Print first weekday
    println!("First weekday is {}", weekdays[0]); 
  
    // Initialize an array of 512 elements where every element is a zero
    let byte_buffer = [0_u8; 512];
    // Print the 100th element in the buffer
    println!("Buffer element 100 is {}", byte_buffer[99]);
}
```

Arrays are useful when you want your data allocated on the stack rather than the heap. They're also useful when you want to ensure you always have a fixed number of elements.

You can access elements of an array by using indexing, which starts at 0, like this:

```rust
    let letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];
    // Print a few letters
    println!("First element of the array: {}", letters[0]);
    println!("Second element of the array: {}", letters[1]);
```

In this example, the expression `letters[0]` will get the value `'a'`, because that's the value at index `[0]` in the array. The expression `letters[1]` will get the value `'b'` from index `[1]` in the array.

If you try to access an element of an array that's out of bounds (past the end of the array), the compiler issues an error. For instance, the following code would fail to compile:

```rust
    let letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];
    // Try to access an element beyond the length of the array - error
    println!("Invalid array access, index is out of bounds: {}", letters[99]);
```

With the following error message:

```output
    error: this operation will panic at runtime
     --> src/main.rs:6:42
      |
    4 |     println!("Invalid array access, index is out of bounds: {}", letters[99]);
      |                                          ^^^^^^^^^^^ index out of bounds: the len is 7 but the index is 99
      |
```

Because the array length is known at compile time, Rust makes it impossible to build any program that attempts to access the array with an out-of-bounds index.

## Vectors

Just like with arrays, you can use vectors with the type `Vec<T>` to store multiple values of the same type. Unlike arrays, vectors can grow or shrink at any time. This capability is implied in their size not being known at compile time, so Rust can't prevent you from accessing an invalid position in your vector.

> [!NOTE]
> You'll notice the syntax `<T>` often in Rust. These are generic type parameters. When we write `Vec<T>`, what we're indicating is a `Vec` type composed of some type `T`. The name`T` is conventionally used as a type name for a type we don't yet know. When we actually create vectors, they'll have concrete types like `Vec<u32>` or `Vec<String>`.

You can use the `vec!` macro to initialize a vector.

```rust
fn main() {
    let three_numbers = vec![1, 2, 3];
    // Print [1, 2, 3]
    println!("Initial vector: {:?}", three_numbers);  

    // The vec! macro also accepts the same syntax as the array constructor
    let ten_zeroes = vec![0; 10];
    // Print [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    println!("Ten zeroes: {:?}", ten_zeroes); 
}
```

You might have noticed the colon question mark `{:?}` format parameter inside the `println!` calls. It's used whenever we want to print something for *debugging* reasons. We use the empty curly parenthesis `{}` to *display* information to an end user. Because Rust doesn't know how to represent a vector of integers to end users, using the former mark would result in a compilation error. We're going to learn precisely how to do that when we reach the "Traits" module in this course.

Vectors can also be created by using the `Vec::new()` method. You can push values onto the end of a vector, which will grow the vector as needed:

```rust
fn main() {
    // Create an empty vector
    let mut new_v = Vec::new();

    // Push the number five into the vector
    new_v.push(5);
    // Push the number six into the vector       
    new_v.push(6);

    // And so on...
    new_v.push(7);
    new_v.push(8);

    // Print [5, 6, 7, 8]
    println!("Current vector is {:?}", new_v); 
}
```

Popping values works in much the same way. You can pop off the value at the end of the vector:

```rust
fn main() {
    // Create a vector with three values
    let mut pop_vec = vec![1, 2, 3];
    // Pop off the last value in the vector
    pop_vec.pop();

    // Print the current values
    println!("Current vector is {:?}", pop_vec); 
}
```

Vectors also support indexing:

```rust
    let mut v = vec![1, 2, 3];
    let three = v[2];
    v[1] = v[1] + 5;
```

If you try to use an index value that the vector doesn't have an element for, the program will enter an unrecoverable panic state and terminate its thread.

Let's try this example. We have a vector with five elements. What will happen when we try to access the element at index 100?

```rust
fn main() {
    let v = vec![1, 2, 3, 4, 5];
    let does_not_exist = v[100];
    println!("{}", does_not_exist);
}
```

You can run this code and see what happens in this [Rust Playground][RustPlay-vector].

Attempting to access the element at index 100 in a vector that contains five elements aborts the
running program with the following error message:

```output
    thread 'main' panicked at 'index out of bounds: the len is 5 but the index is 100', src/main.rs:3:26
```

Don't be scared by this behavior. We're going to learn how to safely access a vector element without causing our program to panic. We'll use the `Vec::get` method *(that never panics)* in the following module, when we learn about error handling in Rust.

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
func main() {
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
[RustPlay-vector]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=97a26b29e4839247c4228ec75bfe856c?azure-portal=true

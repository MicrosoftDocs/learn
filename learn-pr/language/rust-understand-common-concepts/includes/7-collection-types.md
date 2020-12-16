Besides tuples, Rust has many other *compound types* that can group multiple values into one single type.

## Arrays

An array is a collection of objects of the same type, stored sequentially in memory. Arrays are
created using brackets `[]`, and their size, which is known at compile time, is part of their type
signature `[T; size]`, where `T` is the type of the values in the array and `size` is a non-negative
integer checked at compile-time.

In other words, arrays have a fixed length and every element of an array must be of the same type.

An array can be defined in two ways:

- a comma-separated list inside square brackets
- the initial value, followed by a semicolon, and then the length of the array in square brackets

```rust
fn main() {
    // a comma-separated list inside of square brackets
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

    // initialize an array of 512 elements where every element is a zero
    let byte_buffer = [0_u8; 512];
}
```

Arrays are useful when you want your data allocated on the stack rather than the heap or when you
want to ensure you always have a fixed number of elements.

You can access elements of an array using indexing, which starts at 0, like this:

```rust
let letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];
println!("first element of the array: {}", letters[0]);  // prints 'a'
println!("second element of the array: {}", letters[1]); // prints 'b'
```

In this example, the expression `letters[0]` will get the value `'a'`, because that is the value at
index `[0]` in the array. The expression `letters[1]` will get the value `'b'` from index [1] in the
array.

If you try to access an element of an array that is out of bounds (past the end of the array), the
compiled issues an error. For instance, the following code would fail to compile.

```rust
println!("invalid array access: {}", letters[99]);  // our `letters` array have only 7 elements
```

With the folloing error message:

```output
    error: this operation will panic at runtime
     --> src/main.rs:6:42
      |
    6 |     println!("invalid array access: {}", letters[99]);
      |                                          ^^^^^^^^^^^ index out of bounds: the len is 7 but the index is 99
      |
```

Since the array length is known at compile time, Rust makes impossible to build any program that
attempts to access an array out of its bounds.

## Vectors

Just like Arrays, Vectors allow you to store multiple values of the same type. But, unlike Arrays,
they can grow or shrink at any time. This implies in their size not being known at compile time, so
Rust can't prevent you from accessing an invalid position in your vector.

You can use the `vec!` macro to initialize a vector

```rust
let three_numbers = vec![1, 2, 3];
println!("Initial vector: {:?}", three_numbers);  // prints "[1, 2, 3]"

// the vec! macro also accepts the same syntax as the array constructor
let ten_zeroes = vec![0; 10];
println!("Ten zeroes: {:?}", ten_zeroes); // prints [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

You might have noticed the `{:?}` format parameter inside the `println!` calls. It is used whenever
we want to print something for *debugging* reasons whereas `{}` is used for *displaying* information
to an end-user. Since we didn't tell Rust how to represent a vector of integers to end-users, using
the former mark would result in a compilation error. We are going to learn precisely how to do that
when we reach the *Traits* module in this course.

Vectors can also be created using the `Vec::new()` method. You can push values onto the end of a
vector (which will grow the vector as needed):

```rust
  let mut v = Vec::new();  // creates an empty vector,
  v.push(5);               // pushes the number five into it...
  v.push(6);               // ... an then six, and so on
  v.push(7);
  v.push(8);
println!("{:?}", v); // prints [5, 6, 7, 8]
```

Popping values works in much the same way:

```rust
let mut v = vec![1, 2];
let two = v.pop();
```

Vectors also support indexing:

```rust
let mut v = vec![1, 2, 3];
let three = v[2];
v[1] = v[1] + 5;
```

If you try to use an index value that the vector doesn’t have an element for, the program will enter
an unrecoverable panic state and will terminate its thread.

As an example, let’s see what a program will do if it has a vector that holds five elements and then
tries to access an element at index 100, as shown below:

```rust
let v = vec![1, 2, 3, 4, 5];
let does_not_exist = v[100];
```

You can run this code and see what happens in this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=97a26b29e4839247c4228ec75bfe856c?azure-portal=true).

Attempting to access the element at index 100 in a vector containing five elements aborts the
running program with the following error message:

```output
    thread 'main' panicked at 'index out of bounds: the len is 5 but the index is 100', src/main.rs:3:26
```

Don't be scared by this behaviour. We are going to learn how to safely access a vector element
without causing our program to panic, using the `Vector::get` method *(that never panics)* in the
following module, when we learn about Error Handling in Rust.

## Hashmaps

The last of our common collections is the hash map. The type `HashMap<K, V>` stores a mapping of
keys of type `K` to values of type `V`. Where vectors store values by an integer index, HashMaps
store values by key.

Many programming languages support this kind of data structure, but they often use a different name,
such as hash, map, object, hash table, dictionary, or associative array, just to name a few.

Like vectors, HashMaps are growable, stores the data in the heap and access to its items are checked
at run time.

In the example below, we’re keeping track of a personal book review system where the keys are the
book names and the values are the reviews made by one specific user.

You can create an empty hash map using the `HashMap::new` method and then add elements with the
`HashMap::insert` method.

```rust
use std::collections::HashMap;

let mut book_reviews = HashMap::new();

// Review some books.
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

```

You can see from the first line that we need use the `HashMap` from the `collections` portion of the
standard library in order to bring its name into scope. This is similar to what other programming
languages call an "import".

The next notable aspect of the snippet above is the use of the `.to_string()` method
invocation. This method transforms a string literal (`&str`) value into a `String`. This is useful
when we want our hash map to "own" the values it holds, instead of being a collection of references
*(pointers)*. We will cover those differences in detail when we reach the "Ownership and Borrowing"
module.

After we populated our hash map we can query it:

```rust
if !book_reviews.contains_key("Les Misérables") {
    println!("We've got {} reviews, but Les Misérables ain't one.",
    book_reviews.len());
}
```

Hash maps we can use references to query for existing entries, meaning that even if our hash map is
of type `HashMap<String, String>` we can use the `&str` or `&String` types to look up its keys.

Just like Vectors, looking up for an non-existent key will cause the program to panic:

```rust
// Searching for an existing key returns the value associated to it
println!("Review for Jane: {}", book_reviews["Pride and Prejudice"]);

// But searching for a non-existing key will cause a panic
println!("Review for Herman: {}", book_reviews["Moby Dick"]);  // panics!
```

HashMaps also have the `.get()` method for safely querying their content without causing any
panics. We'll cover them in the next module.

We can remove entries from a hash map using the `.remove()` method:

```rust
let sherlock = "The Adventures of Sherlock Holmes";
assert_eq!(book_reviews.contains_key(sherlock), true);
book_reviews.remove(sherlock);
assert_eq!(book_reviews.contains_key(sherlock), false);
```

In the next unit we are going to learn how to **iterate** over the elements of those collection
types.

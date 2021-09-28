Another common collection type in Rust is the hash map. The `HashMap<K, V>` type stores data by mapping each key `K` with its value `V`. While data in a vector is accessed by using an integer index, data in a hash map is accessed by using a key.

The hash map type is used in many programming languages for data items like objects, hash tables, and dictionaries.

Like vectors, hash maps are growable. The data is stored in the heap and access to the hash map items are checked at run time.


## Define a hash map

The following example defines a hash map to track book reviews. The hash map keys are the book names and the values are the reader reviews.

```rust
use std::collections::HashMap;
let mut reviews: HashMap<String, String> = HashMap::new();

reviews.insert(String::from("Ancient Roman History"), String::from("Very accurate."));
reviews.insert(String::from("Cooking with Rhubarb"), String::from("Sweet recipes."));
reviews.insert(String::from("Programming in Rust"), String::from("Great examples."));
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


## Add a key-value pair

We add elements to the hash map by using the `insert(<key>, <value>)` method. In the code, the syntax is `<hash_map_name>.insert()`:

```rust
reviews.insert(String::from("Ancient Roman History"), String::from("Very accurate."));
```


## Get a key value

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

> [!Note]
> Notice the output displays the book review as "Some("Great examples.")" rather than just "Great examples." Because the `get` method returns an `Option<&Value>` type, Rust wraps the result of the method call with the "Some()" notation.


## Remove a key-value pair

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


### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.


<!-- Links -->

[RustPlay-hash]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=56715dd421ff405c57713c213f5445f1?azure-portal=true

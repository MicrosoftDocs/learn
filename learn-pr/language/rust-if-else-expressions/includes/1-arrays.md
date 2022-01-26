Rust has several compound data types that can be used to group multiple values into one single type. In another module, we reviewed the `tuple` data type, which is useful when you want to combine different types into a single value. In this section, we'll explore the `array` data type.

An array is a collection of objects of the same type that are stored sequentially in memory. The length or *size* of an array equals the number of elements in the array. The size of an array can be specified in the code, or computed by the compiler.

## Define an array

An array can be defined in two ways:

- A comma-separated list of values, where the length isn't specified.
- The initial value followed by a semicolon, and then the array length.

In both cases, the content is enclosed in square brackets `[]`.

```rust
// Declare array, initialize all values, compiler infers length = 7
let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  
// Declare array, initialize all values to 0, length = 5
let bytes = [0; 5];
```

### Read the array signature

At compile time, the signature of an array is defined as `[T; size]`:

- `T` is the data type for all elements in the array.
- `size` is a nonnegative integer that represents the array length.

The signature reveals two important characteristics about arrays:

- Every element of an array has the same data type. The data type never changes.
- The size of an array is fixed. The length never changes.

Only one thing about an array can change over time: the values of the elements in the array. The data type remains constant and the number of elements (length) remains constant. Only the values can change.

### Index into an array

The elements in an array are implicitly numbered starting from 0. We use indexing to access the elements in an array with the expression `<array>[<index>]`. For example, `my_array[0]` accesses the element at index 0 in the `my_array` variable. The expression returns the value of the array element at that index location.

Let's look at an array named `days` with seven elements:

```rust
// Days of the week
let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

// Get the first day of the week
let first = days[0];

// Get the second day of the week
let second = days[1];
```

To access the elements in the `days` array, we use an index that ranges from 0 to the array length - 1, or 6. The first element at index 0 has the value "Sunday." The seventh element at index 6 has the value "Saturday."

To assign a value to the `first` variable, we use the expression `days[0]` to get the value of the first element in the `days` array, which is `Sunday`. For the `second` variable, we use a similar expression `days[1]` to get the value of the second element in the `days` array, which is `Monday`.

### Watch for out-of-bounds index values

If we try to access an element in our array with an index that's not in the allowed range, the compiler returns an error. An expression like `days[7]` is out of bounds because our array has only seven elements. The valid index range is 0 - 6. Any index that's equal to or greater than the array length is out of bounds. Any index that's a negative number is also out of bounds.

The following code shows the out-of-bounds compiler error:

```rust
// Get the seventh day of the week using the wrong index - should be 6
let seventh = days[7];
```

Error output:

```output
    error: this operation will panic at runtime
     --> src/main.rs:19:42
   |
19 |     let seventh = days[7];
   |                    ^^^^^^^ index out of bounds: the length is 7 but the index is 7
   |
```

Because the array length is known at compile time, Rust makes it impossible to build any program that attempts to access the array with an out-of-bounds index.

You can interact with this code and explore arrays in this [Rust Playground][RustPlay-array].

### Check your knowledge

Answer the following questions to see what you've learned. Choose one answer for each question, and then select **Check your answers**.

<!-- Links -->
[RustPlay-array]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=31b8dba4c5391da0abcd570b38ca8bf2?azure-portal=true

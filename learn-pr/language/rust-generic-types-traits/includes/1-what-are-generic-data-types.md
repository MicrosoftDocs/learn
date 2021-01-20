A generic data type is a type that is defined in terms of other, partially unknown types. We've been using many generic data types since the beginning of this course, for example:

- The `Option<T>` enum is generic over the type `T`, which is the value contained by its `Some` variant.
- The `Result<T, E>` is generic over both its success and failure type, contained by its `Ok` and `Err` variants, respectively.
- The vector type `Vec<T>`, the array type `[T; n]` and the hash map `HashMap<K, V>` are generic over the types they contain.

When we use generic types, we can specify the operation we want without many concerns about some of the inner types held by the defined type.

To implement a new generic type, we must declare the name of the type parameter inside angle brackets just after the name of the struct. Then we can use the generic type in the struct definition where we would otherwise specify concrete data types.

```rust
  struct Point<T> {
      x: T,
      y: T,
  }

  fn main() {
    let boolean = Point { x: true, y: false };
    let integer = Point { x: 1, y: 9 };
    let float = Point { x: 1.7, y: 4.3 };
    let string_slice = Point { x: "high", y: "low" };
}

```

The code above defines a `Point<T>` struct that holds `x` and `y` values of any type `T`.

Note that even though `T` can assume any concrete type, `x` and `y` must be of that same type, as they were defined as being of the same type. If we tried to create an instance of a `Point<T>` that has values of different types, as in the following snippet, our code won’t compile.

```rust
struct Point<T> {
    x: T,
    y: T,
}

fn main() {
    let wont_work = Point { x: 25, y: true };
}
```

```output
    error[E0308]: mismatched types
     --> src/main.rs:7:39
      |
    7 |     let wont_work = Point { x: 25, y: true };
      |                                       ^^^^ expected integer, found `bool`
```

The error message says that the expected type for the `y` field was an integer, but since we had defined `y` to have the same type as `x`, the compiler complained of a type mismatch error.

If we wanted a `Point<T, U>` generic over two types so that `x` and `y` can be values of different types, we should use multiple generic type parameters:

```rust
struct Point<T, U> {
    x: T,
    y: U,
}

fn main() {
    let integer_and_boolean = Point { x: 5, y: false };
    let float_and_string = Point { x: 1.0, y: "hey" };
    let integer_and_float = Point { x: 5, y: 4.0 };
    let both_integer = Point { x: 10, y: 30 };
    let both_boolean = Point { x: true, y: true };
}
```

Keep in mind that all of the `Point` types above have **different concrete types**. In order:

- `Point<integer, bool>`
- `Point<f64, &'static str>`
- `Point<integer, f64>`
- `Point<ingeter, integer>`
- `Point<bool, bool>`

So you can't really mix those values directly with each other until you have implemented that kind of interaction in your code.

In the next unit we're going to learn about Traits and discover how generic types can be useful in our code, allowing us to write generic functions that will operate on objects of different, but related types.

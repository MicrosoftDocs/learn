
Most useful functions don't just do something—they produce a **result** the caller can use. That result is passed back with the `return` statement.

## Returning a value

Use `return` to send a value out of a function. Once `return` runs, the function ends immediately.

```python
def add(a, b):
    return a + b

result = add(3, 4)
print(result)   # Output: 7
```

You can use the returned value directly in an expression:

```python
print(add(10, 5) * 2)   # Output: 30
```

In this example, the `add()` function returns the sum of its two parameters, and that value is used in the multiplication expression before it's printed.

## Return vs. print

Notice the difference between `print()` and `return`:

- `print()` displays a value to the console.
- `return` gives a value back to the caller so it can be stored, used, or passed to another function.

```python
def add(a, b):
    print(a + b)   # Shows the result but returns None

x = add(3, 4)
print(x)           # Output: None
```

If you want to use the result of a function, you must use `return` instead of `print()`.

## Returning multiple values

A function can return more than one value by separating them with commas. Python packages them into a **tuple** you can unpack on the receiving end:

```python
#coordinates example
def get_coordinates():
    return 10.0, 20.0

x, y = get_coordinates()
print(f"x: {x}, y: {y}")   # Output: x: 10.0, y: 20.0
```

## Functions with no return value

A function that doesn't include a `return` statement still returns something—the special value `None`.

```python
def greet(name):
    print(f"Hello, {name}!")

result = greet("Alex")
print(result)   # Output: None
```

That's fine when the function's purpose is to *do* something (like print or write to a file) rather than produce a value.
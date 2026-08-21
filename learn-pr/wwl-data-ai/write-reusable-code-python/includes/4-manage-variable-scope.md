
**Scope** is the region of your code where a variable exists and can be used. Understanding scope helps you write functions that don't accidentally interfere with each other—and helps you avoid a whole class of confusing bugs.

## Local variables

A variable created inside a function is a **local variable**. It only exists while the function is running, and it can't be seen from outside the function.

```python
def calculate_total(price, tax):
    total = price + tax     # `total` is local to this function
    return total

calculate_total(10, 2)
print(total)                # NameError: name 'total' is not defined
```

Each call to a function gets its own set of local variables, so functions don't accidentally overwrite each other's data.

## Global variables

A variable created outside of any function is a **global variable**. Functions can *read* global variables, but by default they can't *change* them.

```python
message = "Hello"

def greet():
    print(message)   # Reading a global variable is fine

greet()              # Output: Hello
```

If you try to assign a new value to a variable that also exists globally, Python treats it as a new local variable—the value of the global is left alone.

```python
color = "blue"

def change_color():
    color = "red"   # This creates a new local variable, not the global one

change_color()
print(color)        # Output: blue
```

## The `global` keyword (use sparingly)

If you truly need to change a global variable from inside a function, you can declare it with the `global` keyword:

```python
count = 0

def increment():
    global count
    count = count + 1

increment()
print(count)   # Output: 1
```

However, modifying globals from inside functions makes code harder to follow and harder to test. A better pattern is to pass the value in as a parameter and return the updated value:

```python
def increment(count):
    return count + 1

count = 0
count = increment(count)
print(count)   # Output: 1
```

## Why scope matters

- Local variables keep functions **independent**—a variable in one function can't mess up another.
- Reading globals is fine for constants like configuration values.
- Writing to globals from inside functions is a common source of hard-to-find bugs. Prefer parameters and return values.
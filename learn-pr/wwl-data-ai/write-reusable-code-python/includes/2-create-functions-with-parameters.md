
A **function** is a named, reusable block of code that runs when you call it. Functions let you write logic once and use it as many times as you need—with different inputs each time.

## Defining a function

You define a function with the `def` keyword, followed by a name, parentheses, and a colon. The indented lines beneath make up the function body.

```python
def greet():
    print("Hello, world!")

greet()   # Output: Hello, world!
```

Function names should be lowercase with underscores between words, and they should describe what the function does.

## Adding parameters

**Parameters** are named inputs listed inside the parentheses. They let you pass information into the function each time you call it.

```python
def greet(name):
    print(f"Hello, {name}!")

greet("Alex")     # Output: Hello, Alex!
greet("Sam")      # Output: Hello, Sam!
```

You can define multiple parameters by separating them with commas:

```python
def greet(name, greeting):
    print(f"{greeting}, {name}!")

greet("Alex", "Hi")   # Output: Hi, Alex!
```

## Default parameter values

You can give a parameter a **default value** by using `=` in the function definition. If the caller doesn't provide that argument, the default is used.

```python
def greet(name, greeting="Hello"):
    print(f"{greeting}, {name}!")

greet("Alex")             # Output: Hello, Alex!
greet("Alex", "Welcome")  # Output: Welcome, Alex!
```

## Keyword arguments

You can also pass arguments by name, which makes your code easier to read—especially when a function has several parameters:

```python
greet(name="Alex", greeting="Welcome")
```

Keyword arguments can appear in any order, as long as they come after any positional arguments.
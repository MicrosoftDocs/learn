Functions are the next step after learning the Python's programming basics. In its simplest form, functions contain code that always returns a value (or values), and in some cases, with optional or required inputs.

When you start writing code that is duplicating other parts of the program, it becomes a perfect opportunity to extract the code out into a function. Although sharing common code with functions is useful, you will also want to use functions to keep code smaller in size, extracting parts out into smaller (and readable) functions.

Programs that avoid duplication and prevent large functions by using smaller functions is more readable, maintainable, and easier to debug when things aren't working quite right.

There are several rules about function inputs, which are critical to fully take advantage of everything that functions have to offer.

> [!IMPORTANT]
> Although we are using _input_ to describe what functions take in, these are usually referred to as arguments or parameters. For consistency in this module, we will refer to inputs as _arguments_.

## Functions with no arguments

To create a function, you'll need to use the `def` keyword followed by a name, parentheses, and then the body with the function code:

```python
def rocket_parts():
    print("payload, propellant, structure")
```

In this case, `rocket_parts` is the name of the function, followed by the empty parentheses, which indicate there are no arguments needed, and then the code, indented with four spaces. To use the function, you must call it by its name using the parentheses:

```python
>>> rocket_parts()
'payload, propellant, structure'
```

The `rocket_parts()` function doesn't take any arguments and prints a statement about gravity. If you need to use a value that a function is returning, you can assign the function output to a variable:

```python
>>> output = rocket_parts()
payload, propellant, structure
>>> output is None
True
```

It might seem surprising to see that the value for the `output` variable is `None`. This is because the `rocket_parts()` function didn't explicitly return a value. In Python, if a function doesn't explicitly return, then it will _implicitly_ return a `None`. Updating the function to return the string instead of printing it causes the `output` variable to have a different value:

```python
>>> def rocket_parts():
...     return "payload, propellant, structure"
...
>>> output = rocket_parts()
>>> output
'payload, propellant, structure'
```

If you need to use the value of a function, that function _must_ return explicitly, otherwise a `None` will be returned.

> [!NOTE]
> You don't need to always assign the return of a function. In most cases where a function doesn't return a value (or values) explicitly, it means that you don't need to assign or use the implicit `None` returned. 

## Required and optional arguments

In Python, there are several built-in functions that require arguments and others that make it optional. Built-in functions are immediately available without importing them explicitly. 

An example of a built-in function that requires an argument is `any()`. This function takes an iterable (for example a list) and returns `True` if any item in the iterable is `True`, otherwise it returns `False`. 

```python
>>> any([True, False, False])
True
>>> any([False, False, False])
False
```

If you call `any()` without any arguments a helpful exception is raised with an error message explaining that at least one argument is needed:

```python
>>> any()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: any() takes exactly one argument (0 given)
``` 

Functions also allow using optional arguments. You can verify this behavior using another built-in function called `str()`. This function creates a new string from a given arguments, but if no arguments are passed in, then it returns an empty string:

```python
>>> str()
''
>>> str(15)
'15'
```
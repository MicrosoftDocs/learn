Functions are the next step after you've learned Python's programming basics. In its simplest form, a function contains code that always returns a value (or values). In some cases, a function also has optional or required inputs.

When you start writing code that duplicates other parts of the program, it becomes a perfect opportunity to extract the code into a function. Although sharing common code through functions is useful, you can also limit the size of code by extracting parts out into smaller (more readable) functions.

Programs that avoid duplication and prevent large functions by using smaller functions are more readable and maintainable. They're also easier to debug when things aren't working right.

Several rules about function inputs are critical for you to fully take advantage of everything that functions have to offer.

> [!IMPORTANT]
> Although we're using the term _input_ to describe what functions take in, these elements are usually called *arguments* or *parameters*. For consistency in this module, we'll refer to inputs as _arguments_.

## Functions with no arguments

To create a function, you use the `def` keyword followed by a name, parentheses, and then the body with the function code:

```python
def rocket_parts():
    print("payload, propellant, structure")
```

In this case, `rocket_parts` is the name of the function. That name is followed by the empty parentheses, which indicate that no arguments are needed. Last is the code, indented with four spaces. To use the function, you must call it by its name by using parentheses:

```python
rocket_parts()
```

```Output
payload, propellant, structure
```

The `rocket_parts()` function doesn't take any arguments and prints a statement about gravity. If you need to use a value that a function is returning, you can assign the function output to a variable:

```python
output = rocket_parts()
```

```Output
payload, propellant, structure
```

```python
output is None
```

```Output
True
```

It might seem surprising that the value for the `output` variable is `None`. This is because the `rocket_parts()` function didn't explicitly return a value. In Python, if a function doesn't explicitly return a value, it _implicitly_ returns `None`. Updating the function to return the string instead of printing it causes the `output` variable to have a different value:

```python
def rocket_parts():
    return "payload, propellant, structure"
output = rocket_parts()
output
```

```Output
payload, propellant, structure
```

If you need to use the value of a function, that function _must_ return explicitly. Otherwise, `None` is returned.

> [!NOTE]
> You don't need to always assign the return of a function. In most cases where a function doesn't return a value (or values) explicitly, it means that you don't need to assign or use the implicit `None` that's returned.

## Required and optional arguments

In Python, several built-in functions require arguments. Some built-in functions make arguments optional. Built-in functions are immediately available, so you don't need to import them explicitly. 

An example of a built-in function that requires an argument is `any()`. This function takes an iterable (for example, a list) and returns `True` if any item in the iterable is `True`. Otherwise, it returns `False`. 

```python
any([True, False, False])
```

```Output
True
```

```python
any([False, False, False])
```

```Output
False
```

If you call `any()` without any arguments, a helpful exception is raised. The error message explains that you need at least one argument:

```python
 any()
```

```Output
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: any() takes exactly one argument (0 given)
```

You can verify that some functions allow the use of optional arguments by using another built-in function called `str()`. This function creates a string from an argument. If no argument is passed in, it returns an empty string:

```python
str()
```

```Output
''
```

```python
str(15)
```

```Output
'15'
```

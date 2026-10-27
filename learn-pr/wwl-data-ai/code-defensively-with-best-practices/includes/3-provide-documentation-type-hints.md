## Provide documentation and type hints

When you return to a function you wrote three months ago, you need to know what it does and what values to pass it.

**Documentation** provides that information. It tells readers, including you, what a function does, what it needs, and what it returns.

### Write docstrings to explain what functions do

A **docstring** is a string literal placed as the first statement in a function. It explains the function's purpose. Editors display it when you hover over the function, and `help()` prints it:

```python
def calculate_discount(price, discount_percent):
    """
    Calculate the final price after applying a discount.
    
    price: the original price as a number
    discount_percent: the discount amount (for example, 10 means 10% off)
    
    Returns the price after the discount is applied.
    """
    return price * (1 - discount_percent / 100)
```

This simple style works well for learning. Teams often adopt a standard docstring format, such as Google, NumPy, or reStructuredText style.

With this docstring, a reader can understand the function without reading its code.

### Add type hints to show which types to use

**Type hints** show readers and tools what type of value a function expects and returns:

```python
def calculate_discount(price: float, discount_percent: float) -> float:
    """Calculate price after applying a discount."""
    return price * (1 - discount_percent / 100)
```

Call the function:

```python
print(calculate_discount(100, 10))
```

```output
90.0
```

The `: float` after each parameter means the parameter should be a float. The `-> float` means the function returns a float.

Type hints help in two ways:
1. **Readers know** which type of value to pass in.
2. **Tools catch mistakes.** A type checker, such as Pylance in VS Code or mypy, flags a wrong type before you run the code.

Python doesn't enforce type hints when the program runs. It doesn't stop you from calling `calculate_discount("abc", 10)`, and the call fails later with an error. To reject bad values at run time, validate input. The next unit shows how.

### Review a complete example

```python
def find_largest_number(numbers: list[int]) -> int | None:
    """
    Find the largest number in a list.
    
    numbers: a list of integers
    
    Returns the largest number in the list.
    If the list is empty, returns None (meaning "no value").
    """
    if not numbers:  # if the list is empty
        return None
    
    largest = numbers[0]
    for number in numbers:
        if number > largest:
            largest = number
    
    return largest
```

```python
print(find_largest_number([4, 17, 9]))
print(find_largest_number([]))
```

```output
17
None
```

`int | None` means "an integer, or `None`." This syntax requires Python 3.10 or later. `list[int]` requires Python 3.9 or later.

From the docstring and hints, a reader knows:
- The function takes a list of integers.
- It returns an integer, or `None` if the list is empty.
- What the function is supposed to do.

### Why documentation matters

Without documentation:
- You and others waste time working out what code does.
- Functions are easy to use incorrectly.
- Your editor can't help catch mistakes.

With documentation:
- Code is easier to understand.
- Usage mistakes are easier to spot, especially when a type checker reads your hints.
- Code is easier to maintain.

Add a docstring to every function. Add type hints as you get comfortable with them. Both habits save you time later.


Once your program has more than a handful of functions, keeping everything in a single file becomes hard to navigate. Python solves this with **modules**. A module is just a `.py` file whose functions and variables can be reused from other files.

## Creating your own module

Any Python file you write can be imported as a module. The module's name is the file name without the `.py` extension.

Suppose you have this file, `math_utils.py`:

```python
# math_utils.py

def add(a, b):
    return a + b

def multiply(a, b):
    return a * b
```

## Importing a module

From another file in the same folder, you can bring `math_utils` in and use its functions:

```python
# app.py
import math_utils

print(math_utils.add(2, 3))        # Output: 5
print(math_utils.multiply(4, 5))   # Output: 20
```

## Importing specific names

If you only need a few things from a module, you can import them by name. This syntax lets you use them without the module prefix:

```python
from math_utils import add, multiply

print(add(2, 3))        # Output: 5
print(multiply(4, 5))   # Output: 20
```

## Using an alias

If a module name is long or clashes with another name, you can give it a shorter alias with `as`:

```python
import math_utils as mu

print(mu.add(2, 3))   # Output: 5
```

You'll see this pattern often with third-party libraries—for example, `import pandas as pd`.

## The `if __name__ == "__main__":` block

When you `import` a file, Python runs the code in it. If you want to include code that should only run when the file is executed directly, put it in an `if __name__ == "__main__":` block:

```python
# math_utils.py

def add(a, b):
    return a + b

if __name__ == "__main__":
    # Quick self-test — only runs when this file is executed directly
    print(add(2, 3))
```

This pattern lets a file work both as a standalone script *and* as an importable module.

## Why modules matter

- They keep each file focused on one responsibility.
- They make code easier to test, since functions live in one place.
- They make it natural to share and reuse code across projects.
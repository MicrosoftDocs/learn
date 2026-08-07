
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=592c4bd9-fc53-4571-92ce-a5f4ee92fce9]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

When you accept data from a user using the `input()` function, Python always captures it as text (a string)—even if the user types a number. To use that value in mathematical calculations, you must explicitly **convert** (or "cast") its data type first. 


## Type conversion functions

Python provides built-in functions to transform data from one type to another. To cast a value, you wrap it in the desired conversion function:

| Function | Converts to | Example | Result |
|---|---|---|---|
| `int()` | Whole number | `int("42")` | `42` |
| `float()` | Decimal number | `float("3.14")` | `3.14` |
| `str()` | Text | `str(100)` | `"100"` |

## Converting user input

Here are the steps to convert user input from text to a number:

```python
raw_input = input("Enter your score: ")  # Captured as text, e.g. "95"
score = float(raw_input)                 # Convert to a decimal number, e.g. 95.0
print(score + 5)                         # Math is now possible. Output: 100.0
```

You can try running this code yourself in an online python interpreter at [https://aka.ms/python-coder](https://aka.ms/python-coder). 

### One-line shorthand

You can combine these steps into a single line of code. When you nest the `input()` function inside a conversion function, Python first captures the user's input as text, then immediately converts it to the desired type:

```python
score = float(input("Enter your score: "))
```

1. Python runs the inside function first: : `input("Enter your score: ")` to grab the text.
2. It immediately passes that text to the outside function: `float()`
3. The converted number is then assigned to the variable `score`.

## What happens with incompatible values?

If you try to convert a value that can't be interpreted as a number, Python stops running your program and raises a `ValueError`:

```python
user_age = int("hello") 
```

Output:
```output
ValueError: invalid literal for int() with base 10: 'hello'
```

You can also get a `ValueError` if you try to convert a decimal number to an integer, because Python can't round it for you:

```python
user_age = int("3.14") # Pythoncan't drop the decimal for you
```

If you think a user might type a decimal number, use `float()` instead of `int()` to avoid this error. Floats can be converted to integers, but Python always rounds down the decimal portion (for example, `int(3.99)` becomes `3`).

## Checking a value's type

You can verify the data type of any variable using the built-in `type()` function:

```python
score = "95"
print(type(score))         # Output: <class 'str'>

score = float(score)
print(type(score))         # Output: <class 'float'>
```

::: zone-end

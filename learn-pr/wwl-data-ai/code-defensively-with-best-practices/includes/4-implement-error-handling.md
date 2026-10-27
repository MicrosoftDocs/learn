## Validate input and handle exceptions

Every program eventually crashes. A file doesn't exist, a user types letters instead of a number, or a calculation divides by zero.

**Error handling** means expecting these problems and responding to them instead of crashing. This unit covers two related habits: validating input before you use it, and handling exceptions when something still goes wrong.

### Understand exceptions

When Python encounters a problem, it raises an **exception**. If nothing handles the exception, the program stops:

```python
# This crashes
total_price = 100
item_count = 0
average_price = total_price / item_count  # Raises ZeroDivisionError
print(average_price)
```

```output
Traceback (most recent call last):
  File "main.py", line 4, in <module>
    average_price = total_price / item_count
ZeroDivisionError: division by zero
```

The last line names the exception type (`ZeroDivisionError`) and describes the problem.

### Handle exceptions with try-except

A **try-except** block runs code that might fail and handles the exception if it does:

```python
total_price = 100
item_count = 0

try:
    average_price = total_price / item_count
    print(average_price)
except ZeroDivisionError:
    print("Error: Can't divide by zero. The cart has no items.")

print("Program continues running")
```

```output
Error: Can't divide by zero. The cart has no items.
Program continues running
```

Instead of crashing, the program prints a clear message and keeps running.

### Catch specific exceptions

Different problems need different responses. Use a separate `except` clause for each exception type. In this example, the first `except` runs if the text isn't a whole number. The second runs if the count is zero:

```python
count_text = "abc"

try:
    item_count = int(count_text)      # Raises ValueError if the text isn't a whole number
    average_price = 100 / item_count  # Raises ZeroDivisionError if the count is 0
    print(average_price)
except ValueError:
    print("The item count must be a whole number.")
except ZeroDivisionError:
    print("The item count can't be zero.")
```

```output
The item count must be a whole number.
```

Change `count_text` to `"0"` and run the code again. `int("0")` succeeds, the division fails, and the second `except` runs:

```output
The item count can't be zero.
```

Catching specific exceptions lets you tell the user what went wrong. Don't use a bare `except:`. It catches every exception, including ones you didn't expect, and hides bugs.

### Learn common exceptions

| Exception | Raised when | Example |
|---|---|---|
| `ValueError` | The value has the right type but isn't acceptable. | `int("hello")` |
| `TypeError` | The value has the wrong type for the operation. | `int(None)` |
| `ZeroDivisionError` | You divide by zero. | `100 / 0` |
| `FileNotFoundError` | The file doesn't exist. | `open("missing.txt")` |
| `IndexError` | The list index doesn't exist. | `[1, 2, 3][10]` |

### Validate input

The best error handling prevents errors. **Validate input** before you use it. The `check_age` function converts the text to a number inside a `try` block, then checks that the value makes sense:

```python
def check_age(age_text):
    """Return the age as an int from 0 to 150, or None if the input is invalid."""
    try:
        age = int(age_text)
    except (ValueError, TypeError):
        return None

    if age < 0 or age > 150:
        return None

    return age
```

Call the function with valid and invalid values:

```python
print(check_age("25"))
print(check_age("abc"))
print(check_age("-5"))
print(check_age("200"))
```

```output
25
None
None
None
```

The function catches `ValueError` for text like `"abc"` and `TypeError` for values like `None`. The range check rejects numbers that make no sense for an age, such as `-5` or `200`.

### Raise exceptions for invalid input

Returning `None` tells the caller that something went wrong, but not what. When a function can't continue with a bad value, **raise** an exception with a clear message:

```python
def calculate_average(total_price: float, item_count: int) -> float:
    """Return the average price per item."""
    if item_count <= 0:
        raise ValueError("item_count must be greater than zero")
    return total_price / item_count

try:
    print(calculate_average(100, 0))
except ValueError as error:
    print(f"Invalid input: {error}")
```

```output
Invalid input: item_count must be greater than zero
```

The function rejects the bad value immediately and explains why. The caller decides how to respond.

### Decide when to handle errors

Not every error needs a try-except block. Handle errors that:
- Users can cause, such as invalid input.
- Can happen in real use, such as missing files.
- Your program can recover from.

Start with the places where your program accepts outside data, such as user input and files.
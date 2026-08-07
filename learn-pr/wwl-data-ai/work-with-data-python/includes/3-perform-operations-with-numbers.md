
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=6845bbe9-2c37-4883-bd39-f3faa620ffa3]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

At their core, computers are incredibly fast calculators. Python supports all the standard mathematical operations you'd expect, allowing you to perform calculations and instantly save the results inside variables.

## Arithmetic operators

Python uses standard symbols for basic math, along with a few special operators designed specifically for programming workflows:

| Operator | Action | Example | Result | Note |
|---|---|---|---|---|
| `+` | Addition | `10 + 3` | `13` | |
| `-` | Subtraction | `10 - 3` | `7` | |
| `*` | Multiplication | `10 * 3` | `30` | |
| `/` | Division | `10 / 2` | `5.0` | ⚠️ **Always** returns a `float` |
| `//` | Integer Division | `10 // 3` | `3` | Chops off the decimal remainder |
| `%` | Modulo | `10 % 3` | `1` | Returns **only** the remainder |
| `**` | Exponentiation | `2 ** 3` | `8` | $2$ to the power of $3$ ($2 \times 2 \times 2$) |

### Understanding modulo (`%`)

In python, the modulo operator `%` is unrelated to percentages. It divides the first number by the second and hands you back **whatever is left over**. 

The modulo operator is useful for different programming scenarios. For example, you can use it to determine if a number is even or odd. If  `number % 2` leaves a remainder of `0`, the number is perfectly even.

You can also use modulo to "wrap around" a number. For example, if you have a list of three items and you want to loop through them repeatedly, the modulo acts as a reset switch. If you take the `current_item % total_items`, the number will gracefully reset to `0`.

```python
total_items = 3

# If a user clicks 6 times in a row:
print(0 % total_items)  # Output: 0 (Item 1)
print(1 % total_items)  # Output: 1 (Item 2)
print(2 % total_items)  # Output: 2 (Item 3)
print(3 % total_items)  # Output: 0 (Loops back to Item 1!)
print(4 % total_items)  # Output: 1 (Item 2)
print(5 % total_items)  # Output: 2 (Item 3)
```

You can try running this code yourself in an online python interpreter at [https://aka.ms/python-coder](https://aka.ms/python-coder). 

## Order of operations

Python follows the standard mathematical order of operations (PEMDAS). You can use parentheses to force Python to calculate specific sections first:

```python
standard_order = 2 + 3 * 4   # Multiplication first, result = 14
forced_order = (2 + 3) * 4   # Parentheses first, result = 20
```

## Integers and floats

Python has two numeric types. An **integer** (`int`) is a whole number, and a **float-point** (`float`) contains a decimal.

Whenever you perform an operation that mixes an `int` and a `float`, Python automatically converts the result to a `float` to avoid losing decimal precision:

```python
base_value = 10          # int
bonus_value = 3.5        # float

total_score = base_value + bonus_value
print(total_score)       # Output: 13.5 (a float)
```

> [!NOTE]
> Whenever you mix an `int` and a `float` in an operation, Python returns a `float`.

## Updating a variable with itself

A common pattern in software development is updating a variable based on its current value. This pattern is useful for scenarios like adding a sum to an existing balance, or adding points to a player's score. Python has shorthand operators for this pattern:

```python
score = 50
score = score + 10  # Standard way
score += 10         # Shorthand — same result
```

Remember that python evaluates the right side first, then assigns the result to the variable on the left. The shorthand `+=` operator is a convenient way to update a variable without repeating its name.

The same shorthand works for `-=`, `*=`, `/=`, and others.

## Division by zero

Python doesn't allow you to divide by zero. If you try, you'll see a `ZeroDivisionError`:

Example:
```python
crash_test = 10 / 0  
```

Output:
```output
ZeroDivisionError: division by zero
```

::: zone-end

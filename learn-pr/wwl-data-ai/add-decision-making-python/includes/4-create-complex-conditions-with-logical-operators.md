
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b5af48e3-f2de-44eb-ac5e-4a59ed4d19dd]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Sometimes a single condition isn't enough to make a decision. You might want to check whether two things are both true, or whether at least one of them is true. For example, you might need to verify if an account is both active *and* funded, or if a user is either an admin *or* a moderator.

Python's **logical operators** let you combine multiple conditions into one expression.

## The three logical operators

| Operator | What it does | Example | Result |
|---|---|---|---|
| `and` | `True` **only** if **both** sides are `True` | `True and False` | `False` |
| `or` | `True` if **at least one** side is `True` | `True or False` | `True` |
| `not` | Flips a Boolean value | `not True` | `False` |

## Using and (all conditions must be met)

Use `and` when all conditions must be met to run a block of code:

```python
age = 20
has_ticket = True

if age >= 18 and has_ticket:
    print("Entry granted.")
else:
    print("Entry denied.")
```

Output:
```output
Entry granted.
```

## Using or (at least one condition must be met)

Use `or` when any one condition is enough to run a block of code. In everyday language, usually "or" means "one or the other, but not both." However, in Python, "or" means "one or the other, or both."

```python
is_weekend = False
is_holiday = True

if is_weekend or is_holiday:
    print("The office is closed.")
```

Output:

```output
The office is closed.
```

## Using not (reverse a condition)

The `not` operator reverses a Boolean value. If the condition is `True`, it becomes `False`, and vice versa. This operator is useful when you want to check for the absence of a condition.

```python
is_logged_in = False

if not is_logged_in:
    print("Please log in to continue.")
```

Output:
```output
Please log in to continue.
```

## Combining operators

You can combine `and`, `or`, and `not` in a single expression. Always use parentheses to group conditions and make your code easier to read:

```python
score = 85
has_extra_credit = True
is_past_due = False

# Example: Pass if (Score is high OR extra credit is earned) AND the work isn't late
if (score >= 90 or has_extra_credit) and not is_past_due:
    print("Requirement met.")
```

## Avoid shortcut errors

When comparing a single variable against multiple values, you might be tempted to write something like this:

```python
# Incorrect: This code will not work as intended
if score == 90 or 100:
    print("You got an A!")
```

In this case, Python evaluates `score == 90` first, which is either `True` or `False`. Then it evaluates `100`, which is always `True`. Nonzero numbers and nonempty strings always count as `True` in Python. As a result, the condition is always `True`, regardless of the value of `score`. Always compare each value explicitly:

```python
# Correct: Each value is compared explicitly
if score == 90 or score == 100:
    print("You got an A!")
```

::: zone-end


::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=c043e3b3-8cc1-4a17-927e-d05edbf7eb1f]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Before a program can make a decision, it needs a way to ask a question and get a yes or no answer. Python answers this kind of question with **Boolean values** and **comparison operators**.

## Boolean values

A **Boolean** (labeled as `bool`) is a data type that has exactly two possible values: `True` or `False`. These two values are the building blocks of all decision-making in Python.

```python
is_game_over = True
is_user_logged_in = False

print(type(is_game_over))  # Output: <class 'bool'>
```

> [!NOTE] 
> Python is case-sensitive. The Boolean values `True` and `False` must be capitalized exactly as shown. If you write `true` or `false`, Python treats them as undefined variables and raises a `NameError`.

## Comparison operators

**Comparison operators** compare two values and return a Boolean result:

| Operator | Meaning | Example | Result |
|---|---|---|---|
| `==` | Equal to | `5 == 5` | `True` |
| `!=` | Not equal to | `5 != 3` | `True` |
| `>` | Greater than | `10 > 3` | `True` |
| `<` | Less than | `3 < 10` | `True` |
| `>=` | Greater than or equal to | `5 >= 5` | `True` |
| `<=` | Less than or equal to | `4 <= 3` | `False` |

For example:
```python
score = 85
print(score >= 90)  # Output: False
print(score >= 70)  # Output: True
```
## Comparing strings

Comparison operators also work with strings. You can check if two strings are equal, or compare them alphabetically:

```python
entered_password = "secret123"
correct_password = "secret123"

print(entered_password == correct_password)  # Output: True
```

## Equality and assignment

Be careful not to confuse the equality operator (`==`) with the assignment operator (`=`). 

- **Single equals (`=`) is for Assignment:** It assigns the value on the right to the variable on the left.
- **Double equals (`==`) is for Comparison:** It checks if the two values are equal and returns a Boolean result.

Observe what happens if you accidentally use a single equals sign in a comparison:

```python
score = 100

# Trying to check if score equals 50, but accidentally resetting it:
print(score = 50)
```

Output:
```output
TypeError: 'score' is an invalid keyword argument for this function
```

Remember to use `==` when you want to compare values, and `=` when you want to assign a value to a variable.

::: zone-end

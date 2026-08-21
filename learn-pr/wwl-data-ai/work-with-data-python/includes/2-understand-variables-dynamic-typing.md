
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=03ba3d9f-01c4-4db9-8ab7-fcdd8df25f5d]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

A **variable** is a named container that holds a value in your computer's memory. You create a variable in Python by choosing a name and assigning it a value using the assignment operator (`=`).

## Right-to-left rule

When you assign a value to a variable, Python looks at the value on the **right** side first, and then assigns that value to the named container on the **left** side.

```python
player_name = "Alex"
player_age = 25
high_score = 98.5
```

You can update a variable at any time by assigning it a new value:

```python
score = 98.5
score = 100
print(score) # Output: 100
```

You can try running this code yourself in an online python interpreter at [https://aka.ms/python-coder](https://aka.ms/python-coder). 

## Naming variables

Python variable names must follow a few strict rules. Breaking them causes errors in your code:

- Must start with a letter or an underscore (`_`), never a number (for example, `1st_place` is illegal).
- Can only contain letters, numbers, and underscores. No spaces allowed.
- Are case-sensitive (`score` and `Score` are two completely separate containers).

By convention, Python developers use **snake_case**—all lowercase letters with underscores between words:

```python
student_name = "Alex"
final_score = 95
```

## Data types

Every value stored in Python has a **data type** that tells the computer how to treat it. The three most common types are:

| Type Name | Python Label | Description | Example |
|---|---|---|---|
| Integer | `int` | Whole numbers (positive or negative) | `42`, `-7` |
| Floating Point | `float` | Decimal numbers | `3.14`, `-0.5` |
| String | `str` | Text wrapped in quotes | `"Hello"`, `"42"` |

> [!NOTE] 
> In Python, the `int 42` and `str "42"` are two completely different values. The first is a number you can perform math operations on, while the second is text.

## Dynamic typing

In many programming languages, you must explicitly tell the computer what type a variable holds before you can use it. However, Python uses **dynamic typing**—it figures out the type automatically based on the value you assign.

Because of this behavior, a variable can even change its data type mid-program if you assign it something new:

```python
system_status = 10        # Python automatically sets system_status to an 'int'
system_status = "Active"  # Python dynamically changes system_status to a 'str'
```

## Checking a type

You can check the type of any variable using the built-in `type()` function:

```python
score = 98.5
print(type(score)) # Output: <class 'float'>
```

::: zone-end

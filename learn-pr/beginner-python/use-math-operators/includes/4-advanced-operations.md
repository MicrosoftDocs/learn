Beyond core arithmetic, you can use other operations on numbers. You might need to perform rounding, or convert strings into numbers.

In the unit scenario, you want to accept input from a user. The input will be a string rather than a number, so you will need to convert it to a number. Also, the user might enter values that give you a negative answer, which you won't want to display. You might need to convert the answer to the absolute value. Fortunately, Python provides utilities for these operations.

## Convert strings to numbers

Python supports two main types of numbers - integers (or int) and floating point (or float). The key difference between the two is the existence of a decimal point; integers are whole numbers while floats contain a decimal value.

When converting strings to numbers, you indicate the type of number you want to create. The decision point is if you need a decimal point. You will use `int` to convert to an integer and `float` to convert to a floating point number.

```python
demo_int = int('215')
print(demo_int)

demo_float = float('215.3')
print(demo_float)

# Output:
# 215
# 215.3
```

> [!IMPORTANT]
> If an invalid value is used for either `int` or `float` an error will be raised.

## Absolute values

An absolute value in math is the non-negative number without its sign. Using an absolute value can be useful in different situations, including our example of looking to determine distance between two planets. Consider the following math:

```python
39 - 16
16 - 39
```

Notice the difference between the two equations is the numbers are reversed. The answers are `23` and `-23` respectively. When determining the distance between two planets the order in which we enter the numbers does not matter as the absolute answer is the same. We need to convert the negative value to be its absolute value. We can do this by using `abs`. `abs` will provide the absolute value. If we perform the same operation using `abs` (and print the answers), we'll notice it will display `23` for both equations.

```python
print(abs(39 - 16))
print(abs(16 - 39))

# Output
# 23
# 23
```

## Rounding

Similar to `abs`, Python provides a built-in function for rounding numbers called `round`. `round` will round up to the nearest integer if the decimal value is `.5` or greater, and down if it's less than `.5`.

```python
print(round(14.5))

# Output: 15
```

## Math library

Python has different libraries to provide more advanced operations and calculations. One of the most common is the `math` library. `math` allows you to perform rounding with `floor` and `ceil`, provide the value of pi, and numerous other operations. Let's see how we can use `math` for rounding up or down.

Rounding numbers allows us to remove the decimal portion of a float. We can choose to always round up to the nearest whole number by using `ceil`, or down by using `floor`.

```python
from math import ceil, floor

round_up = ceil(12.5)
print(round_up)

round_down = floor(12.5)
print(round_down)

# Output
# 13
# 12
```

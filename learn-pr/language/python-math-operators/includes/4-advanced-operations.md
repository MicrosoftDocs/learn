Beyond core arithmetic, you can use other operations on numbers. You might need to perform rounding, or convert strings into numbers.

In the scenario for this module, you want to accept input from a user. The input will be a string rather than a number, so you'll need to convert it to a number. Also, the user might enter values that give you a negative answer, which you won't want to display. You might need to convert the answer to the absolute value. Fortunately, Python provides utilities for these operations.

## Convert strings to numbers

Python supports two main types of numbers: integers (or `int`) and floating point (or `float`). The key difference between the two is the existence of a decimal point; integers are whole numbers, while floats contain a decimal value.

When you're converting strings to numbers, you indicate the type of number you want to create. You must decide if you need a decimal point. You use `int` to convert to an integer, and `float` to convert to a floating point number.

```python
demo_int = int('215')
print(demo_int)

demo_float = float('215.3')
print(demo_float)
```

```Output
215
215.3
```

> [!IMPORTANT]
> If you use an invalid value for either `int` or `float`, you get an error.

## Absolute values

An absolute value in math is the non-negative number without its sign. Using an absolute value can be useful in different situations, including our example of looking to determine distance between two planets. Consider the following math:

```python
print(39 - 16)
print(16 - 39)
```

Notice the difference between the two equations is that the numbers are reversed. The answers are `23` and `-23`, respectively. When you're determining the distance between two planets, the order in which you enter the numbers doesn't matter, because the absolute answer is the same.

Convert the negative value to be its absolute value by using `abs`. If you perform the same operation by using `abs` (and print the answers), you notice that it shows `23` for both equations.

```python
print(abs(39 - 16))
print(abs(16 - 39))
```

```Output
23
23
```

## Rounding

The built-in Python function called `round` is also helpful. Use it to round up to the nearest integer if the decimal value is greater than `.5`, or down if it's less than or equal to `.5`.

```python
print(round(14.5))
```

Output: 14

## Math library

Python has libraries to provide more advanced operations and calculations. One of the most common is the `math` library. `math` allows you to perform rounding with `floor` and `ceil`, provide the value of pi, and numerous other operations. Let's see how to use this library for rounding up or down.

Rounding numbers enables you to remove the decimal portion of a float. You can choose to always round up to the nearest whole number by using `ceil`, or down by using `floor`.

```python
from math import ceil, floor

round_up = ceil(12.5)
print(round_up)

round_down = floor(12.5)
print(round_down)
```

```Output
13
12
```

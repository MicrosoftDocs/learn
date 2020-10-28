As in other programming languages, expressions are critical for decision-making and controlling the logical flow of Python programs. The most fundamental expressions use a comparison operator, such as less than ("<"):

```python
2 < 5
```

The output is:

```Output
True
```

Python supports several comparison operators:

| Operator | Description | Sample input | Sample output |
|:--:|---|---|---|
| < | Less than | `2 < 5` | `True` |
| > | Greater than | `2 > 5` | `False` |
| <= | Less than or equal | `2 <= 5` | `True` |
|     |   | `2 <= 2` | `True` |
| >= | Greater than or equal | `2 >= 5` | `False` |
| == | Equality | `2 == 2` | `True` |
|    |    | `2 == 5` | `False` |
| != | Inequality | `2 != 5` | `True` |
|    |    | `2 != 2` | `False` |

Python doesn't restrict you to comparing only two operands at a time:

```python
a, b, c = 1, 2, 3
a < b < c
```

The output is:

```Output
True
```

This entire expression is `True` because `1 < 2` is true and `2 < 3` is true.

You can also use built-in functions in Python for comparing data. For example:

```python
min(3, 2.4, 5)
```

The output is:

```Output
2.4
```

Here's another example:

```python
max(3, 2.4, 5)
```

The output is:

```Output
5
```

You can also combine comparison operators into compound expressions:

```python
1 < 2 and 2 < 3
```

The output is:

```Output
True
```

This compound expression uses the **and** Boolean operator. It returns `True` because both `1 < 2` and `2 < 3` are true. (This expression is equivalent to `1 < 2 < 3`.)

Python also supports the **or** Boolean operator, which requires that only one simple expression in a compound expression be true for the whole expression to return `True`:

```python
1 < 2 or 1 > 2
```

The output is:

```Output
True
```

Finally, the **not** operator inverts the truth evaluation of an expression:

```python
not (2 < 3)
```

The output is:

```Output
False
```

### Try it yourself

Copy the following code example into a Python cell in Visual Studio Code. Change different parts of the expression and predict what the result will be. Then, run the code cell to see if you got it right!

```python
i = 7
(i == 2) or not (i % 2 != 0 and 1 < i < 5)
```

<br />

<details>

 <summary>Hint <i>(expand to reveal)</i></summary>

 ```Output
 True
 ```

</details>

<br /><br />

***

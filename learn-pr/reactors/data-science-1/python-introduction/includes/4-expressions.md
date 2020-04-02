As with other programming languages, expressions are critical for decision making controlling the logical flow of Python programs. The most fundamental way of doing this in Python is with a comparison operator, such as "<":

Input:
```input
2 < 5
```

Output:
```output
True
```

> [!Note]
> **Sarah: Conversion feedback**
> 
> This unit has four knowledge check questions, which have been grouped together at the end of the unit.
>

Python supplies serveral comparison operators:

| Operator | Description | Sample input | Sample output |
|:--:|---|---|---|
| < | Less than | 2 < 5 | True |
| > | Greater than | 2 > 5 | False |
| <= | Less than or equal | 2 <= 5 | True |
|     |   | 2 <= 2 | True |
| >= | Greater than or equal | 2 >= 5 | False |
| == | Equality | 2 == 2 | True |
|    |    | 2 == 5 | False |
| != | Inequality | 2 != 5 | True |
|    |    | 2 != 2 | False |

Python does not restrict you to comparing just two operands at a time. For example:

Input:
```input
a, b, c = 1, 2, 3
a < b < c
```

Output:
```output
True
```

This entire expression is True because 1 < 2 is True and 2 < 3 is True.

You can also use built-in functions in Python for comparing data. For example:

Input:
```input
min(3, 2.4, 5)
```

Output:
```output
2.4
```

Input:
```input
max(3, 2.4, 5)
```

Output:
```output
5
```

You can also combine comparison operators into compound expressions. For example:

Input:
```input
1 < 2 and 2 < 3
```

Output:
```output
True
```

This compound expression returned True because both 1 < 2 is true and 2 < 3 is true. (Note that this is equivalent to 1 < 2 < 3.)

Python also provides the or Boolean operator, which requires that only one simple expression in a compound expression be true in order to return True. For example:

Input:
```input
1 < 2 or 1 > 2
```

Output:
```output
True
```

Finally, not inverts the truth evaluation of an expression, such as in:

Input:
```input
not (2 < 3)
```

Output:
```output
False
```

## Try it yourself

Copy the following code snippet and change different parts of the expression.
Predict what the result will be first and then run the code cell to see if you got it right!

Input:
```input
i = 7
(i == 2) or not (i % 2 != 0 and 1 < i < 5)
```

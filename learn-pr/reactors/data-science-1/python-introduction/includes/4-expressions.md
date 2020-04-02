As with other programming languages, expressions are critical for decision making controlling the logical flow of Python programs. The most fundamental way of doing this in Python is with a comparison operator, such as "<":


```input
2 < 5
```


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


```input
a, b, c = 1, 2, 3
a < b < c
```


```output
True
```

This entire expression is True because 1 < 2 is True and 2 < 3 is True.

You can also use built-in functions in Python for comparing data. For example:


```input
min(3, 2.4, 5)
```


```output
2.4
```


```input
max(3, 2.4, 5)
```


```output
5
```

You can also combine comparison operators into compound expressions. For example:


```input
1 < 2 and 2 < 3
```


```output
True
```

This compound expression returned True because both 1 < 2 is true and 2 < 3 is true. (Note that this is equivalent to 1 < 2 < 3.)

Python also provides the or Boolean operator, which requires that only one simple expression in a compound expression be true in order to return True. For example:


```input
1 < 2 or 1 > 2
```


```output
True
```

Finally, not inverts the truth evaluation of an expression, such as in:


```input
not (2 < 3)
```


```output
False
```

## Try it yourself

Copy the following code snippet and change different parts of the expression.
Predict what the result will be first and then run the code cell to see if you got it right!


```input
i = 7
(i == 2) or not (i % 2 != 0 and 1 < i < 5)
```

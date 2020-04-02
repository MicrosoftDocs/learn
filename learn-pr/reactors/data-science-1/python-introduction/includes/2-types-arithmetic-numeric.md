<!--- Reviewer note: This unit uses LaTex math formatting. The dollar sign $ starts and ends each LaTeX statement. -->

Expression syntax is straightforward. The operators plus (+), minus (-), multiply (*), and divide or slash (/) work just like in most other programming languages (such as Java or C). For example, type the following in a Python code cell in VS Code:

Input:
```input
2 + 3
```

And you should get:

```output
5
```

The order of operations also works as in other programming languages (and in math class):

Input:
```input
30 - 4 * 5
```

Output:
```output
10
```

Note what happens when you use division:

Input:
```input
7 / 5
```

Output:
```output
1.4
```

Division (/) always returns a floating-point number, which brings up a good point. Python (like other programming languages) has different numeric types. Integer numbers (such as 1, 3, and 20) have type int. Numbers with a fractional component (such as 3.0 or 1.6) have type float.

You can mix numeric types in calculations:

Input:
```input
3 * 3.5
```

Output:
```output
10.5
```

Input:
```input
7.0 / 5
```

Output:
```output
1.4
```

You can perform a type of division that returns an integer: floor division. Floor division uses the double slash (//) operator, discards any remainders, and just returns an int.

Input:
```input
7 // 5
```

Output:
```output
1
```

To calculate the remainder, you can use the modulo operator (%):

Input:
```input
7 % 5
```

Output:
```output
2
```

For exponents, use the power (**) operator. For example, you can write $5^2$ as:

Input:
```input
5 ** 2
```

Output:
```output
25
```

Conversely, $2^5$ would be:

Input:
```input
2 ** 5
```

Output:
```output
32
```

Note that power (**) has higher precedence in the order of operations than the negative sign (-). This means that $-5^2$ is actually the same thing as $-\left(5^2\right)$:

Input:
```input
-5 ** 2
```

Output:
```output
-25
```

In order to assert the order of precedence that you want, use parentheses ():

Input:
```input
(-5) ** 2
```

Output:
```output
25
```

Parentheses () can supersede the order of operations in any calculation you need to run:

Input:
```input
(30 - 4) * 5
```

Output:
```output
130
```

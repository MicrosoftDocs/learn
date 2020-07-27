<!--- Reviewer note: This unit uses LaTex math formatting. The dollar sign $ starts and ends each LaTeX statement. -->

Expression syntax in Python is straightforward. The operators plus ("+"), minus ("-"), multiply ("*"), and divide or slash ("/") work like they do in other programming languages such as Java or C. For example, enter the following expression in a Python code cell in Visual Studio Code:

```python
2 + 3
```

You'll get:

```Output
5
```

The order of operations also works as it does in other programming languages (and in math class). Enter this expression:

```python
30 - 4 * 5
```

The output looks like this:

```Output
10
```

Note what happens when you use division:

```python
7 / 5
```

The output is:

```Output
1.4
```

Division ("/") always returns a floating-point number, which brings up an important point. Python, like other programming languages, has different numeric types. Integer numbers, such as 1, 3, and 20, have type [int](https://docs.python.org/3.6/library/functions.html#int?azure-portal=true). Numbers like 3.0 or 1.6, which have a fractional component, have type [float](https://docs.python.org/3.5/library/functions.html#float?azure-portal=true).

You can mix numeric types in calculations:

```python
3 * 3.5
```

The output is:

```Output
10.5
```

Here's another example of mixed numeric types:

```python
7.0 / 5
```

The output is:

```Output
1.4
```

You can do a type of division that returns an integer. [Floor division](https://docs.python.org/3.6/glossary.html#term-floor-division?azure-portal=true) uses the double-slash ("//") operator, discards any remainders, and returns only an `int`.

```python
7 // 5
```

The output is:

```Output
1
```

To calculate only the remainder, use the modulo operator ("%"):

```python
7 % 5
```

The output is:

```Output
2
```

Use the power ("**") operator for exponents. For example, you can write $5^2$ as:

```python
5 ** 2
```

The output is:

```Output
25
```

Conversely, $2^5$ would be:

```python
2 ** 5
```

The output is:

```Output
32
```

Note that the power operator ("**") precedes the negative sign ("-") in the order of operations. So, $-5^2$ is the same as $-\left(5^2\right)$:

```python
-5 ** 2
```

The output is:

```Output
-25
```

To assert the order of precedence that you want, use parentheses ("()"):

```python
(-5) ** 2
```

The output is:

```Output
25
```

Parentheses can supersede the order of operations in any calculation:

```python
(30 - 4) * 5
```

The output is:

```Output
130
```

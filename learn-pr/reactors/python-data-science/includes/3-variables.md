As in other programming languages, it's often essential in Python to save values for later by using variables. Python assigns values to variables by using the equal sign ("="):

```python
length = 15
width = 3 * 5
length * width
```

The output is:

```Output
225
```

If you have a programming background in another language, such as Java, you might have noticed that we didn't specify the variable type when we declared our `length` and `width` variables. Python doesn't require you to specify type, and you can change variable types freely. For example:

```python
length = 15
length
```

The output is:

```Output
15
```

You can change `length` to floating point:

```python
length = 15.0
length
```

The output is:

```Output
15.0
```

Or, you can change `length` to a string:

```python
length = 'fifteen'
length
```

The output is:

```Output
'fifteen'
```

For all the flexibility of variables in Python, you do still have to define them. If you try to use an undefined variable, you'll produce an error:

```python
n
```

The error output is:

```Output
---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
<ipython-input-34-ab0680a89434> in <module>
----> 1 n
NameError: name 'n' is not defined
```

In Python's interactive mode and in Jupyter Notebook, you can use the built-in variable `_` (underscore). This variable automatically takes the value of the last printed expression. For example, start with this expression:

```python
tax = 11.3 / 100
price = 19.95
price * tax
```

The output is:

```Output
2.25435
```

Then, use `_` to reference the result of the most recent calculation in the next expression:

```python
price + _
```

The output is:

```Output
22.204349999999998
```

Always treat the `_` variable as read-only. Explicitly assigning a value to it will create an independent local variable with the same name and will mask the built-in variable and its behavior.

Our last output was kind of a mess, however. We typically use only two decimal points or fewer when working with prices. To clean up the output, we can use a built-in function called `round()`.

```python
round(_, 2)
```

The output is:

```Output
22.2
```

We'll cover some of the other functions that are built into Python later in this module. And, we'll cover user-defined functions in a later module.

You don't have to define variables one at a time. You can define multiple variables on a single line:

```python
a, b, c, = 3.2, 1, 6
a, b, c
```

The output is:

```Output
(3.2, 1, 6)
```

You can also augment variable assignments. This ability will be useful when we tackle loops in a later module.

```python
x = 5
x = x + 1  # Un-pythonic variable augmentation
x += 1  # Pythonic variable augmentation
x
```

The output is:

```Output
7
```

Augmented assignment isn't limited to increments of 1 or to addition operations. Beyond `+=`, augmented assignment statements in Python include `-=`, `*=`, `/=`, `%=`, and `**=`. Try playing around with different augmentation assignments until this concept makes sense.

Python supports other types of numbers beyond `int` and `float`, such as [Decimal](https://docs.python.org/3.6/library/decimal.html#decimal.Decimal?azure-portal=true) and [Fraction](https://docs.python.org/3.6/library/fractions.html#fractions.Fraction?azure-portal=true). Python also has built-in support for [complex numbers](https://docs.python.org/3.6/library/stdtypes.html#typesnumeric?azure-portal=true), which are beyond the scope of this learning path.

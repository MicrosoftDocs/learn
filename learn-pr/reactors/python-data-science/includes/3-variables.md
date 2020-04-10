As in other programming languages, it is often essential to save values for later using variables in Python. Python assigns values to variables using the equals sign (=):

```Python
length = 15
width = 3 * 5
length * width
```

The output is:

```Output
225
```

If you come from a programming background in another programming language (such as Java), you might have noticed that we never specified the variable type when we declared our variables `length` and `width`. Python does not require this, and you can change variable types as you wish:

```Python
length = 15
length
```

The output is:

```Output
15
```

Another example:

```Python
length = 15.0
length
```

The output is:

```Output
15.0
```

Another example:

```Python
length = 'fifteen'
length
```

The output is:

```Output
'fifteen'
```

Note that, for all the flexibility of variables in Python, you do have to define them. If you try to use an undefined variable, it will produce an error:

```Python
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

In Python's interactive mode and in Jupyter Notebooks, you can use the built-in variable _ (underscore), which automatically takes the value of the last printed expression. For example:

```Python
tax = 11.3 / 100
price = 19.95
price * tax
```

The output is:

```Output
2.25435
```

Another example:

```Python
price + _
```

The output is:

```Output
22.204349999999998
```

Note that you should always treat the _ variable as read-only. Explicitly assigning a value to it will create an independent local variable with the same name and will mask the built-in variable (and its behavior).

Our previous output was kind of a mess, however; we generally use only two or fewer decimal points when working with prices. In order to clean this up, we can use a built-in function, `round()`.

```Python
round(_, 2)
```

The output is:

```Output
22.2
```

We will cover some of the other functions built into Python later in this module and cover user-defined functions in a later module.

You do not have to define variables one at a time. You can define multiple variables on a single line, like so:

```Python
a, b, c, = 3.2, 1, 6
a, b, c
```

The output is:

```Output
(3.2, 1, 6)
```

You can also augment variable assignments. This will be particularly useful when we tackle loops in a later module.

```Python
x = 5
x = x + 1  # Un-pythonic variable augmentation
x += 1  # Pythonic variable augmentation
x
```

The output is:

```Output
7
```

Note that augmented assignment doesn’t have to be by 1 or even just addition. Beyond +=, augmented assignment statements in Python include -=, *=, /=, %=, and **=. Try playing around with different augmentation assignments until this concept makes sense.

Python supports other types of numbers beyond `int` and `float`, such as [Decimal](https://docs.python.org/3.6/library/decimal.html#decimal.Decimal) and [Fraction](https://docs.python.org/3.6/library/fractions.html#fractions.Fraction). Python also has built-in support for [complex numbers](https://docs.python.org/3.6/library/stdtypes.html#typesnumeric), which are beyond the scope of this learning path.

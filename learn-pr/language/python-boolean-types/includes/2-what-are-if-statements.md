To express conditional logic in Python, you use `if` statements. When you're writing an `if` statement, you're relying on another concept we cover in this module, *mathematical operators*. Python supports the common logic operators from math: equals, not equals, less than, less than or equal to, greater than, and greater than or equal to. You're probably used to seeing these operators displayed using symbols, which is how they’re represented in Python, too. 

* Equals: `a == b`
* Not Equals: `a != b`
* Less than: `a < b`
* Less than or equal to: `a <= b`
* Greater than: `a > b`
* Greater than or equal to: `a >= b`

## Test expressions

You need to use an `if` statement to run code only if a certain condition is satisfied. The first thing you do when you write an `if` statement is to check the condition by using a *test expression*. You then determine whether the statement evaluates to `True` or `False`. If it's `True`, the next indented code block is run:

```python
a = 97
b = 55
# test expression
if a < b:
    # statement to be run
    print(b)
```

In this example, `a < b` is the test expression. The program evaluates the test expression and then runs the code within the `if` statement only if the test expression is `True`. If you evaluate the expression, you know that it's `False`, so any code you write in the `if` statement won't be run.

> [!NOTE]
> In Python, `None` and `0` are also interpreted as `False`.

## Write `if` statements

You use an `if` statement if you want to run code only if a certain condition is satisfied. The syntax of an `if` statement is always:

```python
if test_expression:
    # statement(s) to be run
```

For example:

```python
a = 93
b = 27
if a >= b:
    print(a)
```

Output: `93`

In Python, the body of an `if` statement must be indented. Any code following a test expression that isn't indented will always be run:

```python
a = 24
b = 44
if a <= 0:
    print(a)
print(b)
```

Output:
`44`

In this example, the output is `44` because the test expression is `False` and the `print(b)` statement isn't indented at the same level as the `if` statement.

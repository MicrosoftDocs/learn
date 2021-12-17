To express conditional logic in Python, you'll need to use an `if` statement. When writing an `if` statement, you'll rely on another concept we covered in this module, mathematical operators. Python supports the common logic operators from math- equals, not equals, less than, less than or equal to, greater than, and greater than or equal to. You're probably used to seeing these operators displayed using symbols, which are how they are represented in Python, too. 

* Equals: a == b
* Not Equals: a != b
* Less than: a < b
* Less than or equal to: a <= b
* Greater than: a > b
* Greater than or equal to: a >= b

## Test expressions

You'll need to use an `if` statement to execute code only if a certain condition is satisfied. The first thing you'll do when writing an if statement is check the condition using a *test expression*, and determine whether it's `True` or `False`. If it's `True`, the next indented code block is executed:

```python
a = 97
b = 55
# test expression
if a < b:
    # statement to be executed
    print(b)
```

In this example, `a < b` is the test expression. The program will evaluate the test expression, and execute the code within the `if` statement only if the test expression is `True`. If we evaluate the expression, we know it is `False`, so any code we write in the `if` statement will not be executed.

> [!NOTE]
> In Python, `None` and `0` are also interpreted as `False`.

## Write if statements

You'll need to use an `if` statement if you want to execute code only if a certain condition is satisfied. The syntax of an `if` statement will always be:

```python
if test_expression:
    # statement(s) to be executed
```

For example:

```python
a = 93
b = 27
if a >= b:
    print(a)
```

In Python, the body of an `if` statement must be indented. Any code following a text expression that is not indented will always be executed:

```python
a = 24
b = 44
if a <= 0:
    print(a)
print(b)
```

Output:
`44`

In this example, the output is `44` because the test expression is `False`, and the `print(b)` statement is not indented to the same level as the `if` statement.

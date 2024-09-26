What if you also want your program to run a piece of code when your test expression is `False`? Or what if you want to include another test expression? Python has other keywords you can use to make more complex `if` statements, `else` and `elif`. When you use `if`, `else`, and `elif` in combination, you can write complex programs with multiple test expressions and statements to run.

## Work with `else`

You know that when you use an `if` statement, the body of the program will run only if the test expression is `True`. To add more code that will run when your test expression is `False`, you need to add an `else` statement.

Let's adapt an example from the previous section:

```python
a = 27
b = 93
if a >= b:
    print(a)
```

In this example, if `a` isn't greater than or equal to `b`, nothing happens. Let's say you want to instead print `b` if the test expression is `False`:

```python
a = 27
b = 93
if a >= b:
    print(a)
else:
    print(b)
```

Output: `93`

If the test expression is `False`, the code in the body of the `if` statement is skipped, and the program continues running from the `else` statement. The syntax of an `if/else` statement is always:

```python
if test_expression:
    # statement(s) to be run
else:
    # statement(s) to be run
```

## Work with `elif`

In Python, the keyword `elif` is short for *else if*. Using `elif` statements enables you to add multiple test expressions to your program. These statements run in the order in which they're written, so your program will enter an `elif` statement only if the first `if` statement is `False`. For example:

```python
a = 27
b = 93
if a <= b:
    print("a is less than or equal to b")
elif a == b:
    print("a is equal to b")
```

Output: `a is less than or equal to b`

In this variation, the `elif` statement in the block of code won't run, because the `if` statement is `True`.

The syntax of an `if/elif` statement is:

```python
if test_expression:
    # statement(s) to be run
elif test_expression:
    # statement(s) to be run
```

## Combine `if`, `elif`, and `else` statements

You can combine `if`, `elif`, and `else` statements to create programs with complex conditional logic. Remember that an `elif` statement is run only when the `if` condition is `false`.  Also note that an `if` block can have only one `else` block, but it can have multiple `elif` blocks.

Let's look at an example with an `if`, an `elif` and an `else` statement:

```python
a = 27
b = 93
if a < b:
    print("a is less than b")
elif a > b:
    print("a is greater than b")
else: 
    print ("a is equal to b")    
```

A code block that uses all three types of statements has the following syntax:

```python
if test_expression:
    # statement(s) to be run
elif test_expression:
    # statement(s) to be run
elif test_expression:
    # statement(s) to be run
else:
    # statement(s) to be run
```

## Work with nested conditional logic

Python also supports nested conditional logic, meaning that you can nest `if`, `elif`, and `else` statements to create even more complex programs. To nest conditions, indent the inner conditions, and everything at the same level of indentation will be run in the same code block:

```python
a = 16
b = 25
c = 27
if a > b:
    if b > c:
        print ("a is greater than b and b is greater than c")
    else: 
        print ("a is greater than b and less than c")
elif a == b:
    print ("a is equal to b")
else:
    print ("a is less than b")
```

This piece of code produces the output `a is less than b`.

Nested conditional logic follows the same rules as regular conditional logic within each code block. Here's one example of the syntax:

```python
if test_expression:
    # statement(s) to be run
    if test_expression:
        # statement(s) to be run
    else: 
        # statement(s) to be run
elif test_expression:
    # statement(s) to be run
    if test_expression:
        # statement(s) to be run
    else: 
        # statement(s) to be run
else:
    # statement(s) to be run
```

What if you also want your program to execute a piece of code when your test expression is False? Or if you want to include an another test expression? Python has other keywords you can use to make more complex if statements, `else` and `elif`. When you use `if`, `else`, and `elif` in combination, you can write complex programs with multiple test expressions and statements to execute. 

## Work with else

We know that when we use an `if` statement, the body of the program will only execute if the test expression is `True`. To add more code that will run when your test expression is false, you'll need to add an `else` statement.

Let's go back to our example from the previous section:

```python
a = 93
b = 27
if a >= b:
    print(a)
```

In this example, if `a` is not greater than or equal to `b`, nothing happens. Let's say you wanted to instead print `b` if the test expression is false:

```python
a = 93
b = 27
if a >= b:
    print(a)
else:
    print(b)
```

If the test expression is `False`, the code in the body of the `if` statement is skipped, and the program continues executing from the else statement. The syntax of an `if/else` statement will always be:

```python
if test_expression:
    # statement(s) to be executed
else:
    # statement(s) to be executed
```

## Work with elif

In Python, the key word `elif` is short for else if. Using `elif` statements enables you to add multiple test expressions to your program. These statements execute in the order they are written, so your program will only enter an `elif` statement if the first `if` statement is `False`. For example:

```python
a = 93
b = 27
if a >= b:
    print("a is greater than or equal to b")
elif a == b:
    print("a is equal to b")
```

The `elif` statement in this block of code will not execute, since the `if` statement is `True`.

The syntax of an `if/elif` statement is:

```python
if test_expression:
    # statement(s) to be executed
elif test_expression:
    # statement(s) to be executed
```

## Combine if, elif, and else statements

You can combine `if`, `elif`, and `else` statements to create programs with complex conditional logic. Remember that `elif` statements are only executed when the `if` condition is `False`.  Also note that an `if` block can only have one `else` block, but it can have multiple `elif` blocks.

Let's look at our example again with an added `elif` statement:

```python
a = 93
b = 27
if a > b:
    print("a is greater than b")
elif a < b:
    print("a is less than b")
else: 
    print ("a is equal to b")    
```

The syntax of a code block that uses all three types of statements is:

```python
if test_expression:
    # statement(s) to be executed
elif test_expression:
    # statement(s) to be executed
elif test_expression:
    # statement(s) to be executed
else:
    # statement(s) to be executed
```

## Work with nested conditional logic

Python also supports nested conditional logic, meaning that you can nest `if`, `elif`, and `else` statements to create even more complex programs. To nest conditions, indent the inner conditions, and everything with the same level of indentation will be executed in the same code block:

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

This piece of code will produce the following output:
`a is less than b`

Nested conditional logic follows the same rules as regular conditional logic within each code block. Here's one example of the syntax:

```python
if test_expression:
    # statement(s) to be executed
    if test_expression:
        # statement(s) to be executed
    else: 
        # statement(s) to be executed
elif test_expression:
    # statement(s) to be executed
    if test_expression:
        # statement(s) to be executed
    else: 
        # statement(s) to be executed
else:
    # statement(s) to be executed
```

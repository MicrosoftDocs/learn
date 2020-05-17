Using the `if ... elif ... else` statement is a vital part to building virtually any meaningful program.  It allows you to automate complicated decision logic so it can be applied repeatedly and consistently to your end-user input or data.  

When we use the term "code logic" or "decision logic" we are referring to our ability to imbue our program with the ability to make a decision based on inputs.  Based on the decision, we can instruct the Python interpreter to execute some code and skip over other code.

In this exercise, we'll use the `if` statement, along with optional `elif` and `else` statements, to branch the execution of our code depending on a Boolean expression.  

A **Boolean expression** is any code that returns a Boolean value.  A **Boolean** value is either `True` or `False` and is its own data type in Python, just like `str` and `int`.  

In this exercise, we'll use a Boolean expression to evaluate whether two values are equal.  However, in the next unit, we'll learn how to create more expressive Boolean expressions and work with functions that return a Boolean value.

Let's start with a simple example of an `if` statement.

### Step 1 - Create a new working folder and python code file.

Using the techniques you learned in previous modules, create a new folder for your work in this module.  For example, you might create a folder named `python-if`.

Inside that folder, create a file for this exercise.  For example, you might create a file named `exercise1.py`.

When it's time to execute your code you can use the Python Tools for Visual Studio Code integration by selecting the green arrow, or you can use a command in the integrated terminal using techniques we learned about in previous modules.

### Step 2 - Add an `if` statement to the new code file.

Add the following code to your code file:

```python
value = '7'

if value == '7':
    print('The value is 7')

print('Finished!')
```
There are three parts to the `if` statement:

- The `if` keyword
- The Boolean expression `value == '7'`
- The required colon `:` character

What comes next is just as important.  The next line must contain a code block that will be executed if the Boolean expression evaluates to `True`.  In Python, a code block is defined using indentation.  In this case, we used the <kdb>tab</kbd> key to insert four individual spaces.  This indentation tells the Python interpreter that this code "belongs to" the `if` statement and should be executed when the Boolean expression evaluates to `True`.

However, if the Boolean expression evaluates to `False`, all of the indented code should be ignored by the Python interpreter.

When you run the code, you should see the following output:

```output
The value is 7
Finished!
```
To see how this code operates when the Boolean expression evaluates to `False`, modify the first line of code setting `value` to the string `'6'`.

```python
value = '6'
```
When you run the code, you'll see the following output:

```output
Finished!
```
The line of code beneath the `if` statement is ignored because the Boolean expression evaluates to `False`.  However, the final line of code that prints the term `Finished` is executed because it is not indented beneath the `if` statement.

### Step 3 - Add a tab character to the last line of code to understand the importance of indentation.

Let's see what happens when we add indentation to the final line of code.  

Modify the last line of code by adding a <kdb>tab</kbd> before the line.  Your code should match the following:

```python
value = '6'

if value == '7':
    print('The value is 7')

    print('Finished!')
```

When you execute the code this time, there is no output.  That's because the last line of code is now part of the same code block that belongs to the `if` statement.  

Indentation defines a code block in Python.  A code block consists of one or more lines of code that are treated as a unit of work.  The code block is only executed based on the statement above it, which is the `if` statement in this case.  We'll encounter code blocks often in Python as we learn about new constructs like loops, functions, classes, and more.

Python is picky when it comes to indentation.  All lines must be indented at an equal level, and if they're not, Python will display an exception when you run the code.  If you remove a single empty space character before the last line of code:

```python
value = '6'

if value == '7':
    print('The value is 7')

   print('Finished!')
```

And then attempt to execute the code again, you'll see the following error:

```output
  File "exercise1.py", line 6
    print('Finished!')
                     ^
IndentationError: unindent does not match any outer indentation level
```

### Step 4 - Update the code example to include an `else` statement.

The `else` statement is an optional part of an `if` statement that can handle the opposite case.  In other words, when the Boolean expression in the `if` statement evaluates to `False`, execute the code block that belongs to the `else` statement instead.

Update your code to match the following code passage.  In addition to adding the `else` statement, notice that we removed the <kbd>tab</kbd> from the last line of code.

```python
value = '6'

if value == '7':
    print('The value is 7')
else:
    print('The value is not 7') 

print('Finished!')
```

If you execute the code, you'll see the following output:

```output
The value is not 7
Finished!
```

There are two parts to the `else` statement:

- The `else` keyword
- The colon `:` keyboard symbol

As before, the code block following the `else` statement is just as important.  All indented lines of code below the `else` statement become part of its code block and are executed with the Boolean expression in the `if` statement evaluates to `False`.


### Step 5 - Update the code example to include an `elif` statement.

The `elif`, or rather, "else if" statement is another optional statement that can be added below an `if` statement.  Use the `elif` to test another related Boolean expression.  If that Boolean expression evaluates to `True` the indented code below it will be executed and all code blocks belonging to other `if`, `elif` and `else` statements will be ignored.

Modify the code example to match the following:

```python
value = '8'

if value == '7':
    print('The value is 7')
elif value == '8':
    print('The value is 8')
else:
    print('The value is not one we''re looking for')

print('Finished!')
```

Just like the `if` statement, there are three parts to the `elif` statement:

- Must begin with the keyword `elif`
- Must include a Boolean expression
- Must terminate using a colon `:` keyboard symbol

And just as before, all indented code below the `elif` will be part of the code block that will be executed if the Boolean expression evaluates to `True`.

When you execute the code, you'll see the following output:

```output
The value is 8
```

You can use as many `elif` statements as you need.  However, if you will use an `else` statement, it must come after all `elif` statements.

Modify your code to include an addition `elif` statement before the `else` statement.

```python
value = '8'

if value == '7':
    print('The value is 7')
elif value == '8':
    print('The value is 8')
elif value == '9':
    print('The value is 9')
else:
    print('The value is not one we''re looking for')
```

Once any `if` or `elif` Boolean expression evaluates to `True`, the Python interpreter will not continue evaluating additional Boolean expressions.  It will exit the entire `if ... elif ... else` structure and continue to process the next line of code that is not indented.

### Be aware of overlapping Boolean expressions

Consider the following code:

```python
value = '6'

if value < '8':
    print('The value is less than 8')
elif value < '7':
    print('The value is less than 7')
else:
    print('The value is greater than 8')
```

First, we've introduced a new operator, which we'll learn more about in the next unit.  The less-than operator `<` compares two numeric values.  If the value on the left is less than the value on the right, this will evaluate to `True`.  Otherwise, it will evaluate to `False`.

Now, can you spot the problem with the `if` and `elif` statements?  Look closely and think through how this code will work.

The problem is that the `elif` statement will never execute because any `value` that would be `True` for the `if` statement will also be `True` for the `elif` statement.  Therefore, the execution path will never get to the `elif`.

This would likely never manifest in a runtime error.  However if we were expecting to handle these differently, we would have introduced a subtle logic error into our application.  We would need to swap the Boolean expressions between the `if` and the `elif` to fix the issue.  It's always useful to test your application with multiple inputs to make sure you get the intended result.

### Nested if code blocks

Consider the following code example:

```python
first_value = True
second_value = '6'

if first_value:
    if second_value == '6':
        print('Got here!')
```

Here we evaluate two separate data values.  First, we test the value of `first_value`.  Since a Boolean expression is any code that equates to `True` and `first_value` equates to `True` already, we do not need to type out the entire Boolean expression like so:

```Python
if first_value == True:
```

Secondly, and more pertinent to this code example, is the nesting of the second `if` statement inside the code block of the first `if` statement.  As a result, the second `if` statement is evaluated only when the first `if` statement evaluates to `True`.

This nesting structure is common when you need to test several related (but different) data values before performing some operation.

If you remove the proper indentation:

```python
first_value = True
second_value = '6'

if first_value:
if second_value == '6':
    print('Got here!')
```

... it's likely you would see the following error message:

```output
  File "c:/python/numeric-operations-decisions/exercise2.py", line 65
    if second_value == '6':
    ^
IndentationError: expected an indented block
```

## Recap

We learned about some crucial ideas in this unit, including:

- Use the `if` statement to evaluate a Boolean expression.  If the expression evaluates to `True`, then the code block beneath the `if` statement will be executed by the Python interpreter.  Otherwise, it will be ignored.
- A code block is one or more indented lines of code.  The code block "belongs" to the `if` statement, and will be executed or ignored depending on the evaluation of the Boolean expression.  Accidentally indenting (or not indenting) lines of code will undoubtedly impact how your code operates, and may even produce errors.  All indentation must use the same number of space characters or the Python interpreter will raise an error.
- Add an optional `else` statement when you want to execute code that's only relevant if the Boolean expression evaluates to `False`.  Otherwise it will be ignored.
- Add an optional `elif` after the `if` statement (but before the `else` statement, if it exists) to evaluate a second and subsequent Boolean expression.  Just like the `if` statement, the indented code block beneath it will be executed if the Boolean expression evaluates to `True`.  Otherwise it will be ignored.
- When using the `if` statement along with one or more `elif` statements and the `else` statement, once a Boolean expression is satisfied, no other statements will be evaluated.  Therefore, the order in which you perform your evaluations could be important.
- You may nest `if` statements if you need to check for related (but different) conditions before performing some operation.
We use conditional statements to tell the computer what to do if some condition is met, or is not met: do this; if not, do something else.

## If statement

The most basic conditional statement is the `if` statement. The `if` statement checks whether a condition is true or not true. If the condition is true, the `if` statement runs the code that's defined inside the statement. If the condition is not true, any code that's defined inside the `if` statement is skipped.

Some real world examples are:

- If the temperature is above freezing, the rocket will launch.
- If oxygen levels drop, grab a space suit and oxygen tank.

In Python, the format for an `if` statement is:

```python
if(conditionToTestIsTrue):
    doSomething
```

It's crucial to include the colon `:` at the end of the `if` statement, and also to indent each line of code that's defined inside the `if` statement. The indented lines of code will run when the `if` condition evaluates to True.

The following example shows how to use an `if` statement in Python. We use the `if` statement to test whether the count of basalt rocks is 0. If the count is 0, both `print()` statements run and display their output. If the count of rocks is not 0, the first `print()` statement is skipped, and only the second `print()` statement runs.

```python
basalt = 0
if(basalt == 0):
    print("We have found no basalt rocks.")
print("Done checking basalt rocks.")
```

```Output
We have found no basalt rocks.
Done checking basalt rocks.
```

```python
basalt = 1
if(basalt == 0):
    print("We have found no basalt rocks.")
print("Done checking basalt rocks.")
```

```Output
Done checking basalt rocks.
```

## Else statement

The `else` statement extends the `if` conditional statement and allows coders to have more control over what happens depending on the condition result. An `else` statement must be written after an `if` statement. The program always executes the code that's defined inside the `else` statement when the condition in the `if` statement is not met.

Here's an example.

```python
basalt = 0
if(basalt == 0):
    print("We have found no basalt rocks.")
else:
    print("We found some basalt rocks!")
print("Done checking basalt rocks.")
```

```Output
We have found no basalt rocks.
Done checking basalt rocks.
```

```python
basalt = 5
if(basalt == 0):
    print("We have found no basalt rocks.")
else:
    print("We found some basalt rocks!")
print("Done checking basalt rocks.")
```

```Output
We found some basalt rocks!
Done checking basalt rocks.
```

## Else-if statement

Python also supports else-if checks, for further control on actions based on data. The `elif` statement is written after an `if` statement and before an `else` statement. You can have as many `elif` statements as you want between the initial `if` statement and the final `else` statement.

The `elif` statement is just another `if` statement. When the conditions in the initial `if` statement are not met, the program checks whether the conditions in the next `elif` statement are met. When the conditions for the `elif` statement are met, the code that's defined inside the `elif` statement is run. Any code that's defined in a subsequent `elif` or `else` statement is skipped.

Here's an example of how an `elif` statement is used:

```python
basalt = 1
if(basalt == 0):
    print("We found no basalt rocks.")
elif(basalt == 1):
    print("We found exactly 1 basalt rock.")
else:
    print("We found more than 1 basalt rock!")
print("Done checking basalt rocks.")
```

```Output
We found exactly 1 basalt rock.
Done checking basalt rocks.
```

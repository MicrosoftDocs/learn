Programs don't merely crunch numbers. They make *decisions* based on those numbers and modify their behavior accordingly. For example, a program might take one action if the sum of a column of numbers is greater than 100, and another action if it does not. Statements that test a condition and act accordingly are as old as programming itself. Most programming languages use `if` statements to support such branching, and Python is no exception.

Now that the airport data in **airports.csv** has been parsed into a list of lists with each item in the inner list containing strings denoting an airport code, airport location, and airport name, the data can be organized and presented in more meaningful ways. In this lesson, you will filter the list of lists created in the previous lesson so that it includes only U.S. airports. And to do so, you will employ the `if` statement.

## Branching with `if` statements

`if` statements enact conditional logic in Python programs. You have already learned how to use `for-in` and `while` to write loops that execute a block of code repeatedly. Statements that use `if`, `for-in`, and `while` are known as *control-of-flow* statements because they control the flow of execution in a program.

Here is an `if` statement that performs an action only if a specified condition is met:

```python
x = 2

if x > 1:
    print('x is greater than 1')
```

`if` statements can also include `else` clauses that take action if the condition is not met:

```python
x = 2

if x > 1:
    print('x is greater than 1')
else:
    print('x is less than or equal to 1')
```

You can even include `elif` (short for "else-if") clauses that test for multiple conditions:

```python
x = 1

if x > 1:
    print('x is greater than 1')
elif x < 1:
    print('x is less than 1')
else:
    print('x is 1')
```

Blocks of code underneath an `if`, `elif`, or `else` aren't limited to one line each. They can be as long as you'd like, and as usual, Python uses indents to identify lines of code that constitute a block. in addition, there is no limit on the number of `elif` clauses an `if` statement may contain.

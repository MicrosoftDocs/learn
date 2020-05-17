As we learned in the previous unit, a Boolean value can only be one of two values: either `True` or `False`.  The Boolean data type is the foundation for Boolean expressions, which in turn are the basis for much of the code you'll write in Python to compare, evaluate, and add branching and looping logic to your applications.

A Boolean expression is any code that returns a Boolean value.

In this exercise, you will work with Boolean values and Boolean expressions, providing you a richer language to express your logic.

### Step 1 - Create a new python code file.

Create a new code file for this exercise.  For example, you might create a file named `exercise2.py`.

### Step 2 - Add code to display data types of a string, integer, and Boolean value.

Python has many different data types.  In the previous module, you worked with a string data type and a numeric data type called integer.  You can use a built-in function called `type()` to display the data type of any value.  This is often helpful to understand what type of data you're working with, and what you can do with that data.

Then, to better understand the nature of Boolean values, add the following lines of code to your new code file.

```python
print(type('Hello world'))
print(type(7))

print(type(True))
print(type(False))

print(type('True'))
print(type('False'))
```

The first two lines of code merely show you what to expect for a string and integer, respectively.  The `type()` method says that these values are instances of a class named `str` and `int`.  We'll talk about classes and instances later, but for now you can think of these as classifications of data, and based on the classification, you will be able to perform different tasks, whether string concatenation or arithmetic.

The next two lines of code display the Boolean data type `bool`.  Notice that the values `True` and `False` must be capitalized, and are not string values.

The final two lines of code illustrate that there's a difference between the Boolean values `True` and `False` and the string values `'True'` and `'False'`.

Execute the code file.  You should see the following output:

```output
<class 'str'>
<class 'int'>
<class 'bool'>
<class 'bool'>
<class 'str'>
<class 'str'>
```

### Step 3 - Comment code from the previous step, then add code that uses the built-in `bool()` function to convert various string values to Boolean values.

The `bool()` function works similarly to the `str()` and `int()` functions that we learned about in the previous module.  The function accepts any value and attempts to convert it into a Boolean value.

Sometimes, the result is predictable.  Other times it might not be obvious what is happening.

Comment out all the previous code in your code file, then add the following code that prints out the result of using the `bool()` function to convert different values to a Boolean.

```python
print(bool('True'))
print(bool('False'))
print(bool(''))
print(bool(' '))
print(bool('Hello world!'))

```
If you run the code, you'll see the following output:

```output
True
True
False
True
True
```
The `bool()` function was able to convert the strings `'True'` and `'False'` to Boolean values `True` and `False`.  However, when supplied an empty string, it returns `False`, while any other non-empty string returns `True`.


### Step 4 - Comment out code from the previous step, then add code that uses the built-in `bool()` function to convert various integer values to Boolean values.

Comment out all the previous code in your code file, then add the following code that prints out the result of using the `bool()` function to convert different values to a Boolean.

```python
print(bool(7))
print(bool(1))
print(bool(0))
print(bool(-1))
```
If you run the code, you'll see the following output:

```output
True
True
False
True
```
The `bool()` function converts any non-zero value to `True`, but converts the value `0` to `False`.


## What is a Boolean expression?

As we add logic to our applications, we'll evaluate Boolean expressions.  A simple example should illustrate the basic idea:

`1 + 1 = 3`

That is a `False` statement.  However:

`1 + 1 = 2`

... is a `True` statement.  In both of these examples from early math, we're evaluating the entire expression to see whether it is true or false.

In Python, a Boolean expression does the same thing.  A Boolean expression expands this idea to any function call that ultimately returns a `True` or `False`.

In Python, we would use the **equality operator** `==` to create a Boolean expression that evaluates two values for equality.  The equality operator uses two equal sign symbols.

### Step 5 - Comment out code from the previous step, then add code to print the result of Boolean expressions.

Comment out all the previous code in your code file, then add the following code that prints out the result of two Boolean expressions:

```Python
print(1 + 1 == 3)
print(1 + 1 == 2)
```
If you were to add this code to your code file and execute it, you would see the following output:

```Output
False
True
```
If Python is your first programming language, you will likely at some point forget to use two equal sign symbols when you want to check for equality.  A single equal sign is the **assignment operator**.  It is used to assign a value to a variable.  If you forget and attempt to use a single equal sign in a context where it is not appropriate, Python will raise an error and a helpful suggestion.

```python
print(1 + 1 = 3)
print(1 + 1 = 2)
```
If you were to add this code to your code file and execute it, you would see the following output:

```output
SyntaxError: expression cannot contain assignment, perhaps you meant "=="?
```

### What is an operator?

An operator is like a mini function.  Operators perform an operation on operands, which could be literal values, variable values, or any identifier like a method or class.  While there are dozens of operators in Python, they can be split up into one of several categories:

- Arithmetic operators
- Assignment operators
- Comparison operators
- Logical operators
- Identity operators
- Membership operators
- Bitwise operators

We'll look at comparison and logic operators in this unit.  We'll likely cover most operators as we continue through this Learning Path.

Some operators consist of a single symbol, like many of those we'll use in this unit.  They operate on the values to their left and right.  Other operators consist of a pair of symbols, and operate on the values in between their opening symbol and their closing symbol.

## Comparison Operators

The equality operator `==` is one of a family of operators that allow you to compare two values.  The following table is not exhaustive, but you'll likely use the following comparison operators often.

|`==`|equality operator|
|`!=`|inequality operator|
|`>`|greater than operator|
|`<`|less than operator|
|`>=`|greater than or equal to operator|
|`<=`|less than or equal to operator|

The inequality operator `!=` evaluates to `True` when the operands on either side are not the same.  This can be a bit confusing, but sometimes you want to ensure that two values are not equal.

### Step 6 - Comment out code from the previous step, then add code to print the result of Boolean expressions.

To exercise these comparison operators, comment out the code in your code file and add the following code.

```python
print(3 == 4)
print(3 != 4)

print(3 > 4)
print(3 < 4)
print(3 >= 4)
print(3 <= 4)
```
When you run this code, you'll see the following output:

```output
False
True
False
True
False
True
```


## Logical Operators

Sometimes, you'll want to evaluate more than one Boolean expression.  In this case, you can use the logical operators `and`,  `or`, and `not`.  These operators allow you to pair two Boolean expressions together to produce a final Boolean value.

Use the `and` operator to make sure both Boolean expressions evaluate to `True`.  Use the `or` operator to make sure at least one Boolean expression evaluates to `True`.

The `not` operator returns the opposite Boolean value and can be used to ensure that one or more Boolean expressions evaluate to `False`.

### Step 7 - Comment out code from the previous step, then add code to print the result of Boolean expressions.

To exercise these logical operators, comment out the code in your code file and add the following code.

```python
first_number = 5
second_number = 0
true_value = True
false_value = False

if first_number > 1 and first_number < 10:
    print('The value is between 1 and 10.')

if first_number > 1 or second_number < 1:
    print('At least one value is greater than 1')

print(not true_value)
print(not false_value)

if not first_number > 1 and second_number < 10:
    print('Both values pass the test')
else:
    print('Both values do NOT pass the test')
```
When you run this code, you'll see the following output:

```output
The value is between 1 and 10.
At least one value is greater than 1
False
True
Both values do NOT pass the test
```

## Recap

- Use the `bool()` function to convert strings and integers to Boolean values.  Non-empty strings will convert to `True` and non-zero numbers will convert to `True`.  The string value `'False'` and empty strings convert to `False`.  The value `0` converts to `False`.
- Python provides several comparison operators to test for equality, inequality, and greater or less than.
- Python also provides several logical operators to ensure one or both Boolean expressions are `True`.  It also provides the `not` operator to ensure Boolean expressions evaluate to `False`.

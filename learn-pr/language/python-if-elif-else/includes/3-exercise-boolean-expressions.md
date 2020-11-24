As you learned in the previous unit, a Boolean value can be only one of two values, either `True` or `False`. The Boolean data type is the foundation for Boolean expressions. Boolean expressions in turn are the basis for much of the code you'll write in Python to compare, evaluate, and add branching and looping logic to your apps.

A Boolean expression is any code that returns a Boolean value.

In this exercise, you'll work with Boolean values and Boolean expressions. They provide you with a richer language to express your logic.

### Step 1: Create a new Python code file

Create a new code file for this exercise. For example, you might create a file named `exercise2.py`.

### Step 2: Add code to display data types of a string, integer, and Boolean value

Python has many different data types. In the previous module, you worked with a string data type and a numeric data type called *integer*. To display the data type of any value, use a built-in function called `type()`. This function can help you understand what type of data you're working with and what you can do with that data.

To better understand the nature of Boolean values, add the following lines of code to your new code file.

```python
print(type('Hello world'))
print(type(7))

print(type(True))
print(type(False))

print(type('True'))
print(type('False'))
```

The first two lines of code show you what to expect for a string and integer, respectively. The `type()` method says that these values are instances of a class named `str` and `int`. More about classes and instances later. For now, think of these values as classifications of data. Based on the classification, you can perform different tasks, whether string concatenation or arithmetic.

The next two lines of code display the Boolean data type `bool`. Notice that the values `True` and `False` must be capitalized and aren't string values.

The final two lines of code illustrate that there's a difference between the Boolean values `True` and `False` and the string values `'True'` and `'False'`.

Run the code file. You should see the following output:

```output
<class 'str'>
<class 'int'>
<class 'bool'>
<class 'bool'>
<class 'str'>
<class 'str'>
```

### Step 3: Comment code from the previous step, and then add code that uses the built-in `bool()` function to convert various string values to Boolean values

The `bool()` function works similarly to the `str()` and `int()` functions that we learned about in the previous module. The function accepts any value and attempts to convert it into a Boolean value.

Sometimes the result is predictable. Other times it might not be obvious what's happening.

Comment out all the previous code in your code file. Then, add the following code that prints out the result of using the `bool()` function to convert different values to a Boolean.

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
The `bool()` function converted the strings `'True'` and `'False'` to the Boolean value `True`. When the function is supplied with an empty string, it returns `False`, while any other non-empty string returns `True`.


### Step 4: Comment out code from the previous step, and then add code that uses the built-in `bool()` function to convert various integer values to Boolean values

Comment out all the previous code in your code file. Then add the following code that prints out the result of using the `bool()` function to convert different values to a Boolean.

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
The `bool()` function converts any non-zero value to `True`, but it converts the value `0` to `False`.


## What is a Boolean expression?

As you add logic to our applications, you'll evaluate Boolean expressions. A simple example illustrates the basic idea.

`1 + 1 = 3`

That's a `False` statement. But:

`1 + 1 = 2`

... is a `True` statement. In both of these examples from early math, we're evaluating the entire expression to see whether it's true or false.

In Python, a Boolean expression does the same thing. A Boolean expression expands this idea to any function call that ultimately returns `True` or `False`.

In Python, we use the *equality operator* `==` to create a Boolean expression that evaluates two values for equality. The equality operator uses two equal sign symbols.

### Step 5: Comment out code from the previous step, and then add code to print the result of Boolean expressions

Comment out all the previous code in your code file. Then, add the following code that prints out the result of two Boolean expressions.

```Python
print(1 + 1 == 3)
print(1 + 1 == 2)
```
If you add this code to your code file and run it, you see the following output:

```Output
False
True
```
If Python is your first programming language, you're likely to forget to use two equal sign symbols when you want to check for equality. A single equal sign is the *assignment operator*. It's used to assign a value to a variable. If you forget and attempt to use a single equal sign in a context where it's not appropriate, Python raises an error and a helpful suggestion.

```python
print(1 + 1 = 3)
print(1 + 1 = 2)
```
If you add this code to your code file and run it, you see the following output:

```output
SyntaxError: expression cannot contain assignment, perhaps you meant "=="?
```

### What is an operator?

An operator is like a mini function. Operators perform an operation on operands, which could be literal values, variable values, or any identifier like a method or class. There are dozens of operators in Python. They can be split up into one of these categories:

- Arithmetic operators
- Assignment operators
- Bitwise operators
- Comparison operators
- Identity operators
- Logical operators
- Membership operators


In this unit, you'll look at comparison and logic operators. You'll likely cover most operators as you continue through this learning path.

Some operators consist of a single symbol, like many of the operators we'll use in this unit. They operate on the values to their left and right. Other operators consist of a pair of symbols. They operate on the values in between their opening symbol and their closing symbol.

## Comparison operators

The equality operator `==` is one of a family of operators that you can use to compare two values. The following table doesn't show all possible operators. These are the comparison operators you're likely to use most often.

| Operator | Description |
|------------|---------------|
|`==`| Equality operator|
|`!=`| Inequality operator|
|`>`| Greater than operator|
|`<`| Less than operator|
|`>=`| Greater than or equal to operator|
|`<=`| Less than or equal to operator|

The inequality operator `!=` evaluates to `True` when the operands on either side aren't the same. This concept can be a bit confusing, but sometimes you want to ensure that two values aren't equal.

### Step 6: Comment out code from the previous step, and then add code to print the result of Boolean expressions

To exercise these comparison operators, comment out the code in your code file and add the following code:

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


## Logical operators

Sometimes you'll want to evaluate more than one Boolean expression. In this case, you can use the logical operators `and`, `or`, and `not`. These operators enable you to pair two Boolean expressions together to produce a final Boolean value.

To make sure both Boolean expressions evaluate to `True`, use the `and` operator. To make sure at least one Boolean expression evaluates to `True`, use the `or` operator.

The `not` operator returns the opposite Boolean value. It can be used to ensure that one or more Boolean expressions evaluate to `False`.

### Step 7: Comment out code from the previous step, then add code to print the result of Boolean expressions

To exercise these logical operators, comment out the code in your code file, and add the following code:

```python
first_number = 5
second_number = 0
true_value = True
false_value = False

if first_number > 1 and first_number < 10:
    print('The value is between 1 and 10.')

if first_number > 1 or second_number > 1:
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

- Use the `bool()` function to convert strings and integers to Boolean values. Non-empty strings convert to `True` and non-zero numbers convert to `True`. Empty strings convert to `False`. The value `0` converts to `False`.
- Python provides several comparison operators to test for equality, inequality, and greater or less than.
- Python also provides several logical operators to ensure one or both Boolean expressions are `True`. It also provides the `not` operator to ensure Boolean expressions evaluate to `False`.

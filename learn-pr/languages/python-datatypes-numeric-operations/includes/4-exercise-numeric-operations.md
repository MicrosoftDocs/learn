Until now, you've been concerned with getting the data into the proper format so that you can perform mathematical operations on the numbers. Besides simple arithmetic, you haven't yet explored the other kinds of operations you can perform on numbers.

In this unit, we look at several mathematical operations that use Python operators.  

Other, more complex operations are available from the Python math module.  After you learn how to use other modules from the [Python Standard Library](https://docs.python.org/3/library/math.html?azure-portal=true), you'll understand how to take advantage of this added set of functionality.

You can obtain additional mathematical operations and data science and visualization functionality from third-party open source libraries, such as Pandas, NumPy, SciPy, Matplotlib, and many others. Later, you'll utilize some of these libraries in more advanced modules on Microsoft Learn.

In this exercise, you learn about operators that allow you to perform typical mathematical operations on numeric data.

### Step 1 - Create a new file

Use the techniques you learned in previous modules to add a new code file in the current folder that's dedicated to this module.  For example, you might create a file named *exercise3.py*.

### Step 2 - Write code that performs various mathematical operations in the new code file

In the new code file, add the following code:

```python
first_value = 5
second_value = 4

sum = first_value + second_value
difference = first_value - second_value
product = first_value * second_value
quotient = first_value / second_value
modulus = first_value % second_value
exponent = first_value ** second_value 

print('Sum: ' + str(sum))
print('Difference: ' + str(difference))
print('Product: ' + str(product))
print('Quotient: ' + str(quotient))
print('Modulus: ' + str(modulus))
print('Exponent: ' + str(exponent))
```
Many of the operators are obvious but if you're not sure, they're listed here:

- `+`: Addition operator 
- `-`: Subtraction operator 
- `*`: Multiplication operator 
- `/`: Division operator 
- `%`: Modulus operator, which gives you the remainder (if any) after you divide one value into another. It's useful to know whether one value is evenly divisible by the other.
- `**`: Exponent operator. For example, "5 to the fourth power" is expressed as 5 * 5 * 5 * 5.

> [!NOTE]
> In the next module, you'll learn how to use *format strings* or *f-strings* to avoid the data conversion back to a string.

If you run the code, you should see the following output:

```output
Sum: 9
Difference: 1
Product: 20
Quotient: 1.25
Modulus: 1
Exponent: 625
```

### Step 3 - Comment out the previous code and add code that allows you to control the default order of operations

Python follows the PEMDAS acronym, which indicates the order in which the operations should be performed.

- **P**arentheses: Resolve operations between parentheses first.
- **E**xponents: Resolve exponents.
- **M**ultiplication: Perform multiplication, from left to right.
- **D**ivision: Perform division, from left to right.
- **A**ddition: Perform addition, from left to right.
- **S**ubtraction: Perform subtraction, from left to right.

To see this operation in action, comment out the previous code in the file, and then add the following lines of code:

```python
print(3 + 4 * 5)
print((3 + 4) * 5)
```
In the first line, you allow the natural order of operations before introducing parentheses to control the order.  In the second line, you add parentheses around the first two values to force them to be evaluated first, and then you multiply by the last value.

If you run the code, you'll see the following output.

```output
23
35
```
Take a moment to observe how the placement of parentheses changes the order and, ultimately, the result of mathematical operations.


### Step 4 - Comment out the code from previous steps and add code to investigate division more closely

Let's revisit division for a moment.  When you perform division, you provide a dividend and a divisor.  If these are values are of an `int` data type, they will implicitly result in a quotient of type `float`.

To see this in action, comment out the previous code in the file, and then add the following lines of code:

```python
first_value = 5
second_value = 4

quotient = first_value / second_value

print(type(quotient))
print(quotient)
```

If you run the code, you'll see the following output:

```output
<class 'float'>
1.25
```

Usually, you'll be able to work with both `int` values and `float` values without any trouble.  Occasionally, you'll need to convert a `float` into an `int`.  Sometimes, this happens implicitly (without your explicit instruction).  So, you might want to take control of that process.

### Step 5 - Comment out the previous code and add code to convert a `float` into an `int`

When you convert a `float` value into an `int` value, you must be aware of truncation.

Comment out the code from the previous steps, and then add the following code listing to the code file:

```python
pi = 3.14
print(type(pi))
print(int(pi))

uptime = 99.99
print(type(uptime))
print(int(uptime))
```
If you run the code, you should see the following output:

```output
<class 'float'>
3
<class 'float'>
99
```
As you can see in the case of the variable called `uptime`, merely using the `int()` function causes the values after the decimal to be removed instead of rounding the entire value up to the next whole number (100).

To avoid truncation, you can use the built-in `round()` function.  Update the code you wrote in this step to include a call to the `round()` function.  Your code should match the following:

```python
pi = 3.14
print(type(pi))
print(int(pi))
print(round(pi))

uptime = 99.99
print(type(uptime))
print(int(uptime))
print(round(uptime))
```
If you run the code, you should see the following output:

```output
<class 'float'>
3
3
<class 'float'>
99
100
```

The `round()` function provides a way to perform rounding and conversion from a `float` value into an `int` value.

### Step 6 - Comment out the previous code and add code that rounds to a specific decimal place

You can use the built-in function `round()` to round to a certain number of decimal places, not just the next whole number as you did in the preceding step.

To see this in action, comment out the lines of code that you added in previous steps, and then add the following lines of code:

```python
first_value = round(7.654321, 2)
print(first_value)

second_value = round(9.87654, 3)
print(second_value)
```
By supplying a second argument when you call the `round()` function, you can control the number of decimal places to round to.

To call a function and pass more than one argument, you use a comma (**,**) to separate each argument.  As you'll learn when we dive deeper into functions, you can create functions that have optional input parameters.  In this case, if you don't supply the second argument, the `round()` function defaults to *0* places after the decimal, which gives you an `int` value.

If you run the code, you'll see the following result:

```output
7.65
9.877
```

### Recap

Here are a few important ideas to keep in mind from this unit:

- Operators are mini shortcut functions that perform an operation on one or more operands (literal or variable values, and so forth).
- There are built-in mathematical operators for most common needs.  More advanced mathematical operations have been addressed by the math module in the Python Standard Library. Other third-party, open source libraries cover a wide range of functionality that's needed in data science, data visualization, and machine learning.
- The order of mathematical operations in Python follows the rules of PEMDAS.
- When you convert from a value of type `float` to a value of type `int`, values after the decimal are truncated and lost.  Use the `round()` function to control how values are rounded.
- Some functions are defined with multiple input parameters.  To pass multiple arguments to the function, you use a comma (**,**) between each argument.  Sometimes, arguments are optional.  In these cases, the function continues to operate, but it uses a default value or alternative implementation.

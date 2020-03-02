Until now, we've been concerned with getting the data into the proper format so that we can perform mathematical operations on the numbers.  However, besides simple arithmetic, we've not explored the kinds of operations we can perform on numbers.

In this unit, we'll look at several mathematical operations using Python operators.  

Other more complex operations are available from Python's math module.  Once you learn how to use other modules from Python's Standard Library, you'll understand how to take advantage of this added set of functionality.  For more information, see the following URL:

[https://docs.python.org/3/library/math.html](https://docs.python.org/3/library/math.html?azure-portal=true)

Still other mathematical operations and data science and visualization functionality can be obtained from third-party Open Source libraries such as Pandas, NumPy, SciPy, Matplotlib, and many others.  We utilize some of these in more advanced modules on Microsoft Learn.

In this exercise, we'll learn about operators that allow us to perform typical mathematical operations on numeric data.

### Step 1 - Create a new file

Assuming you're continuing from the previous unit, use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module.  For example, you might create a new file named `exercise3.py`.

### Step 2 - Write code that performs various mathematical operations in the new code file.

Add the following code to your new code file:

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
Many of the operators are obvious, but just in case you're not sure:

- Addition operator `+`
- Subtraction operator `-`
- Multiplication operator `*`
- Division operator `/`
- Modulus operator `%` ... this gives you the remainder (if any) after dividing two values.  Useful to know whether one value is evenly divisible.
- Exponent operator `**` ... read like "5 to the fourth power", or 5 * 5 * 5 * 5.

![Note]
In the next module, we'll learn how to use "format strings" or "f-strings" to avoid the data conversion back to string.

If you run the code, you should see the following output:

```output
Sum: 9
Difference: 1
Product: 20
Quotient: 1.25
Modulus: 1
Exponent: 625
```

### Step 3 - Comment out the previous code and add code that allows you to control the default order of operations.

Python follows the PEMDAS acronym for the order of operations, which should be performed.

- **P**arenthesis - resolve operations between parenthesis first
- **E**xponents - resolve exponents
- **M**ultiplication - next, multiplication, order of left to right
- **D**ivision - then division, order of left to right
- **A**ddition - then addition, order of left to right
- **S**ubtraction - then subtraction, order of left to right

To see this in action, comment out the previous code in the file, then add the following lines of code:

```python
print(3 + 4 * 5)
print((3 + 4) * 5)
```
In the first line, we allow the natural order of operations before introducing parentheses to control the order.  In the second line, we add parentheses around the first two values to force that to be evaluated first, then we multiply by the last value.

If you run the code, you'll see the following output.

```output
23
35
```
Take a moment to observe how the placement of parentheses changes the order (and ultimately, the result) of mathematical operations.


### Step 4 - Comment out code from previous steps and add code to investigate division more closely.

Let's revisit division for a moment.  When we perform division, we provide a dividend and a divisor.  If these are values are of an `int` data type, they will implicitly result in a quotient of type `float`.

To see this in action, comment out the previous code in the file, then add the following lines of code:

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

Usually, you will be able to work with both `int` values and `float` values without any trouble.  Occasionally, you will need to convert a `float` into an `int`.  Sometimes, this will happen implicitly (without your explicit instruction).  So, you may want to take control of that process.

### Step 5 - Comment out the previous code and add the code to convert a float into an int.

When converting a `float` value into an `int` value, you must be aware of truncation.

Comment out code from the previous steps, then add the following code listing to the code file:

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

### Step 6 - Comment out the previous code and add code that rounds to a specific decimal place.

The built-in function `round()` can be used to round to a certain number of decimal places, not just the next whole number as we did in previous step.

To see this in action, comment out the lines of code added in previous steps, then add the following lines of code:

```python
first_value = round(7.654321, 2)
print(first_value)

second_value = round(9.87654, 3)
print(second_value)
```
By supplying a second argument when calling the `round()` function, we can control the number of decimal places to round to.

To call a function and pass more than one argument, you use a comma symbol `,` to separate each argument.  As we'll learn when we dive deeper into functions, you can create functions that have optional input parameters.  In this case, if we do not supply the second argument, the `round()` function will default to `0` values after the decimal place, thereby giving us an `int` value.

If you execute the code, you'll see the following result:

```output
7.65
9.877
```

### Recap

Here's a few important ideas to keep in mind from this unit:

- Operators are mini short-cut functions that perform an operation on one or more operands (literal or variable values, etc.)
- There are built in mathematical operators for most common needs.  More advanced mathematical operations have been addressed by the math module in the Python Standard Library. Other third-party Open Source libraries cover a wide range of functionality needed in Data Science, data visualization, and Machine Learning.
- The order of mathematical operations in Python follows the rules of PEMDAS.
- When converting from a value of type `float` to a value of type `int`, values after the decimal will be truncated and lost.  Use the `round()` function to control how values are rounded.
- Some functions are defined with multiple input parameters.  To pass multiple arguments to the function, you use the comma symbol `,` between each argument.  Sometimes, arguments are optional.  In these cases, the function continues to operator, but uses a default value or alternative implementation.
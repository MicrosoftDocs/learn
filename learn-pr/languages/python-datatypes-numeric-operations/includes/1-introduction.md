Almost every application you build will require that you handle data, whether that data is keyboard input from an end user or a file containing data you must process or transform.

We've already seen that we may need to convert data from a string to an integer in order to perform mathematical calculations.  This is a common task.  

But what happens if you write a program that performs calculations on numeric data, but when you prompt an end user for keyboard input, they enter non-numeric data instead?  If you don't account for this, your application will raise an error, the program will abruptly end, and your end user may be confused.

To guard against this situation, you should check to see if the value entered by the end user can be converted to a number before actually attempting the data type conversion.  If it can't be converted, you would ask the user to try entering the value again.  But how can you perform a data type conversion check using Python?

In this module, you will programmatically inspect a value to learn its current data type, and whether it could be converted to a different data type such as an integer.  You'll use the `if` decision statement that you learned about in the previous module to branch the execution of your code to either perform the data conversion, or display a message to the end user to enter a different value.  Using built-in mathematical operators, you will perform different numeric operations like addition, subtraction, division, multiplication, and more.

By the end of this module, you will be able to build a program that can accept user input, evaluate its data type, add logic to make a decision branching the execution of the code to handle different situations, and perform many different mathematical operations on numeric data.

## Learning objectives

In this module, you will:

- Use the `type()`, `isinstance()`, and `isnumeric()` methods to inspect a value's data type as well as its suitability for use or conversion to a numeric data type.
- Use mathematical operators to perform basic math operations on numeric data.
- Use the `float` data type to represent values that include fractional values represented with numbers after the decimal point.

## Prerequisites

- You should have your Python development environment already set up and know how to create, edit, and execute Python code stored in a `.py` file.
- You should have exposure to the use of input and output functions like `print()` and `input()`.
- You should know how to create and use variables, and how to perform basic operations on strings like concatenation.
- You should already have some exposure to data type conversion functions like the `int()` and `str()` functions.

If you need to review or learn any of these concepts, visit all preceding modules in this Learning Path.

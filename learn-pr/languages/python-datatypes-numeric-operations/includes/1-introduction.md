Almost every application you build requires that you handle data, whether that data is keyboard input from users or a file containing data that you must process or transform.

You've already seen that you might need to convert data from a string to an integer to perform mathematical calculations.  This is a common task.  

Let's suppose you're writing a program that performs calculations on numeric data. What happens if you prompt users for numeric keyboard input, but they enter a non-numeric value instead?  If you don't account for this possibility, your application will raise an error, the program will abruptly end, and your users might be confused.

To guard against this situation, you check to see whether the value they've entered can be converted to a number before the program attempts the data-type conversion.  If the value can't be converted, you would ask users to try entering the value again. 

How can you perform a data-type conversion check by using Python?

In this module, you will programmatically inspect a value to learn its current data type, and determine whether it can be converted to a different data type, such as an integer.  You'll use the `if` decision statement that you learned about in the preceding module to branch the code execution to either perform the data conversion or display a message to users to enter a different value. By using built-in mathematical operators, you will perform addition, subtraction, division, multiplication, and other numeric operations.

By the end of this module, you will be able to build a program that can accept user input, evaluate its data type, add logic to decide how to branch the code execution to handle a variety of situations and perform a variety of mathematical operations on numeric data.

## Learning objectives

In this module, you will:

- Use the `type()`, `isinstance()`, and `isnumeric()` methods to inspect a value's data type as well as its suitability for use or conversion to a numeric data type.
- Use mathematical operators to perform basic math operations on numeric data.
- Use the `float` data type to represent values that include fractional values represented by numbers after the decimal point.

## Prerequisites

Before you begin this module, you should:

- Have your Python development environment set up.
- Know how to create, edit, and execute Python code that's stored in a *.py* file.
- Have exposure to the use of input and output functions, such as `print()` and `input()`.
- Know how to create and use variables, and how to perform basic operations on strings, such as concatenation.
- Have some exposure to data-type conversion functions, such as `int()` and `str()`.

If you need to review or learn any of these concepts, visit all preceding modules in this learning path.

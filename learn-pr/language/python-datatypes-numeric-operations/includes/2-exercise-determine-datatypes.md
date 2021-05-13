Python makes it easy to work with data.  Every data value has an underlying data type, and that data type determines what you can do with the value.  For example, numeric values can be used for mathematical operations.  String values can be printed, concatenated, split, and so on.  

Python provides several ways for you to evaluate a value to view, evaluate, and convert its data type.  There are several built-in functions you can use.  You'll learn about all of these functions and techniques in this exercise.

## The `type()` function

In the preceding module, you learned about the `type()` function, which merely displays the data type of a specified value.

### Step 1 - Create a new working folder and python code file

By using the techniques you learned in previous modules, create a new folder for your work in this module.  For example, you might create a folder named *python-numeric-operations*.

Inside that folder, create a file for this exercise.  For example, you might create a file named *exercise1.py*.

When it's time to run your code, you can use the Python Tools for Visual Studio Code integration by selecting the green arrow, or you can use a command in the integrated terminal by using techniques you learned about in previous modules.

### Step 2 - Write code that utilizes the `type()` function to the code file

Add the following lines of code to print the data type for various values.  When you're finished, your code should match the following example:

```python
print(type('7'))
print(type(7))
print(type(7.1))
```

By using the techniques you learned in previous modules, run the code file that you added this code to.  You should see the following output:

```output
<class 'str'>
<class 'int'>  
<class 'float'>
```

For now, you can think of the term *class* as merely *classification*.  Soon, you'll learn more about Python classes and objects, and you'll come to understand the ramifications of the term *class* in Python.

More germane to this exercise, there are three data types:

- **str**: The data type for strings.  Strings can contain all alphanumeric characters.  Strings can be short (just a few characters) or very long (an entire paragraph of textual data).
- **int**: The data type for integer values, which can be any non-fractional number, positive or negative.
- **float**: The data type for float values, which can include fractional values represented as numbers that include a decimal point and numbers after the decimal.

The `type()` function merely examines the value you pass it as an input parameter (the word between the parentheses) and returns the data type.  It's a great tool to use as you're learning about Python and how it works with values under the hood.  However, for real applications, there are more useful ways at getting to this information.

## The `isinstance()` function

The next technique uses the `isinstance()` function, which allows you to assert that you expect a value to be a certain data type. The `isinstance()` function tells you whether the value is what you expected.  It returns the value `True` if your expectation is correct and `False` if it's incorrect.

### Step 3 - Comment out the previous code and add code that utilizes the `isinstance()` function to the code file

In your code file, comment out all the code that you wrote previously by adding a number sign (**#**), followed by a space, at the beginning of each line.

Next, add code that uses `isinstance()` to check the data type of the various values.  When you're finished, your code file should look like this:

```python
# print(type('7'))
# print(type(7))
# print(type(7.1))

print(isinstance('7', str))
print(isinstance(7, int))
print(isinstance(7.1, float))

print(isinstance(7, str))
print(isinstance('7', int))
print(isinstance('7.1', float))
```
When you run the code, you should see the following output:

```output
True
True 
True 
False
False
False
```

The `isinstance()` function returns a Boolean value.  Unlike the previous technique you used when you checked a value using the `type()` function and used the equality operator, `isinstance()` accomplishes the same result more succinctly.

You'll explore the term *is an instance of* in an upcoming module that explores classes and objects.  But for now, you can think of it as an easy way to compare a value and the data type that you expect it to be.

### Can you create a Boolean expression by using the `type()` function?

You might be wondering whether using the following code is the same as using the `isinstance()` function:

```python
print(type('7') == str)
print(type(7) == int)
print(type(7.1) == float)

print(type(7) == str)
print(type('7') == int)
print(type('7.1') == float)
```
The short answer is "yes." In these simple cases, they are roughly equivalent.  However, as you learn more about classes and objects, you'll see that this code might not give you the expected results in more complicated scenarios.  We recommend that you do not use the `type()` function with the intent to check for equality.

Although the `type()` and `isinstance()` functions both allow you to evaluate the current data type, you need to use a different technique to help you understand whether a specified value *could be converted* to a different type.  In the next unit, you'll learn about a third technique that allows you to do that.

### What is the relationship between data types and variables?

It's important to understand that the data type is part of the *value*.  The data type is *not* part of the variable that you might use to access the value.  A variable can point to any value, regardless of the value's data type.

```python
x = 'a string'
print(type(x))
x = 7
print(type(x))
x = False 
print(type(x))
```
When you run the code, you should see the following output:

```output
<class 'str'>
<class 'int'>
<class 'bool'>
```

In this code example, the only thing that changed was the literal value that you pointed the variable `x` to.  No data conversion was required to switch from having `x` point to a string in the first line of code and then to an integer or Boolean value in the next lines of code.

This is an important distinction in Python, and a key difference from other programming languages.

### Recap

You learned some important ideas in this unit:

- The `type()` function returns the data type of a specified value.
- The `isinstance()` function allows you to check to see whether a value is an instance of a specified data type.
- The `float` data type is for numeric values containing fractional values that are represented as numbers after the decimal point.
- Values have data types, and variables do not.  A variable is merely pointed to a value, and it can point to any value of any data type.

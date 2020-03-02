Python makes it easy to work with data.  Every data value has an underlying data type, and that data type determines what we can do with the value.  For example, numeric values can be used for mathematical operations.  String values can be printed, concatenated, split, and so on.  

Python provides several ways we can evaluate a value to view its data type, evaluate its data type, and convert its data type.

## Exercise: Inspecting values to learn about their data types

There are several built-in functions we can use.  We'll learn about all of these functions and techniques in this exercise.

## The `type()` function

In the previous module, we learned about the `type()` function, which merely displayed the data type of a given value.

### Step 1 - Create a new working folder and python code file.

Using the techniques you learned in previous modules, create a new folder for your work in this module.  For example, you might create a folder named `python-numeric-operations`.

Inside that folder, create a file for this exercise.  For example, you might create a file named `exercise1.py`.

When it's time to execute your code, you can use the Python Tools for Visual Studio Code integration by selecting the green arrow, or you can use a command in the integrated terminal using techniques we learned about in previous modules.

### Step 2 - Write code that utilizes the `type()` function to the code file.

Add the following lines of code to print the data type for different values.  When you're finished, your code should match the following code example:

```python
print(type('7'))
print(type(7))
print(type(7.1))
```

Using the techniques you learned in previous modules, execute the code file you added this code to.  You should see the following output:

```output
<class 'str'>
<class 'int'>  
<class 'float'>
```
For now, you can think of the term "class" as merely "classification".  Soon, we'll learn more about Python classes and objects, and you'll come to understand the ramifications of the term "class" in Python.

More germane to this exercise, there are three data types:

- **str** - This is the data type for strings.  Strings can contain all alphanumeric characters.  Strings can be short (just a few characters) or very long (like entire paragraphs of textual data).
- **int** - This is the data type for integer values, which can be any non-fractional number, positive or negative.
- **float** - This is the data type for float values, which can include fractional values represented as numbers that include a decimal point and numbers after the decimal.

The `type()` function merely examines the value you pass it as an input parameter (between the parentheses) and returns the data type.  It's a great tool to use as you're learning about Python and how it works with values under the hood.  However, for real applications, there are more useful ways at getting to this information.

## The isinstance() function

The next technique uses the `isinstance()` function, which allows you to assert that you expect a value to be a certain data type.  `isinstance()` will tell you whether the value is what you expected or not.  It returns the value `True` if your expectation was correct, and `False` if it was incorrect.

### Step 3 - Comment out the previous code and add code that utilizes the `isinstance()` function to the code file.

In your code file, comment out all the previous code you wrote using the `#` symbol before each line.

Next, add code that uses `isinstance()` to check the data type of different values.  When you're finished, your code file should look like this:

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
When you execute the code, you should see the following output:

```output
True
True 
True 
False
False
False
```

The `isinstance()` function returns a Boolean value.  Unlike the previous technique, we used when we checked a value using the `type()` function and used the equality operator, 

We'll explore this terminology "is an instance of" in an upcoming module that explores classes and objects.  But for now, we can just think of it as an easy way to compare a value and the data type we expect it to be.

### Can we create a Boolean expression using the type() function?

You might be wondering if the following code is the same as using the `isinstance()` function:

```python
print(type('7') == str)
print(type(7) == int)
print(type(7.1) == float)

print(type(7) == str)
print(type('7') == int)
print(type('7.1') == float)
```
The short answer is "yes", in these simple cases they are roughly equivalent.  However, as you'll learn more about classes and objects, you'll see that this might not give you the expected results in more complicated scenarios.  It's recommended that you do not use the `type()` function with the intent to check for equality.

While both the `type()` and `isinstance()` functions both allow us to evaluate the current data type, we need a different technique that will help us understand if a given value *could be converted* to a different type.  We'll learn about a third technique to allow us to do that in the next unit.

### What is the relationship between data types and variables?

It's important to understand that the data type is part of the *value*.  The data type is **not** part of the variable we might use to access the value.  A variable can point to any value, regardless of the value's data type.

```python
x = 'a string'
print(type(x))
x = 7
print(type(x))
x = False 
print(type(x))
```
When you execute the code, you should see the following output:

```output
<class 'str'>
<class 'int'>
<class 'bool'>
```

In this code example, the only thing that changed was the literal value we pointed the variable named `x` to.  There was no data conversion required to switch from `x` pointing to a string in the first line of code, then an integer or Boolean value in the next lines of code.

This is an important distinction in Python, and a key difference from other programming languages.

### Recap

We learned some important ideas in this unit:

- The `type()` function will return the data type of a given value.
- The `instanceof()` will allow you to check to see if a value is an instance of a given data type.
- The `float` data type is for numeric values containing fractional values represented as numbers with values after the decimal point.
- Values have data types, variables do not.  A variable is merely a pointed to a value, and it can point to any value of any data type.
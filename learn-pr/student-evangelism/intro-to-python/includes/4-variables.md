Variables are one of the fundamental building blocks of programs written in Python. Variables hold data in memory. They have names, and they can be referenced by those names. Variables also have *types*, which specify what type of data they can store  (such as string and integer), and they can be used in expressions that use *operators* (such as `+` and `-`) to manipulate their values.

## Variables

In Python, a variable is declared and assigned a value using the assignment operator `=`. The variable is on the left-hand side of the operator, and the value being assigned &mdash; which can be an expression such as `2 + 2` and can even include other variables &mdash; is on the right-hand side. For example:

```python
x = 1         # assign variable x the value 1
y = x + 5     # assign variable y the value of x plus 5
z = y         # assign variable z the value of y
```

These examples assign numbers to variables, but numbers are just one of several data types Python supports. Notice there's no type declared for the variables. This is because Python is a *dynamically typed* language, meaning the variable type is determined by the data assigned to it. In the examples above, the x, y, and z variables are integer types, capable of storing positive and negative whole numbers.

Variable names are case sensitive and can use any letter, number, and the underscore (`_`) character. However, they can't start with a number.

### Working with numbers

Most programs manipulate numbers. Computers treat integer numbers and decimal numbers differently. Consider the following code:

```python
x = 1       # integer
x = 1.0     # decimal (floating point)
```

Python creates integers from a built-in data type called `int`, and decimals (floating-point numbers) as instances of `float`. Python's built-in `type()` function returns a variable's data type. The following code outputs data types:

```python
x = 1
print(type(x)) # outputs: <class 'int'>

x = 1.0
print(type(x)) # outputs: <class 'float'>
```

The addition of the ".0" to the end of "1" makes a large difference in how the programming language treats a value. The data type impacts how the value is stored in memory, how the processor (CPU) handles the data when evaluating expressions, how the data relates to other data, and what kinds operations you can perform with it.

### Working with booleans

Another common data type is the Boolean type, which holds the value `True` or `False`:

```python
x = True
print(type(x)) # outputs: <class 'bool'>
```

Internally, `bool` is treated as a special type of integer. Technically, `True` has a value of 1 and `False` has a value of 0. Typically, Booleans aren't used to perform mathematical operations; rather, they're used to make decisions and perform branching. Nevertheless, it's interesting to understand the relationship between types. Many types are nothing more than specialized versions of more general types. Integers are a subset of floating point numbers, and Booleans are a subset of integers.

### Working with strings

Along with numbers, strings are among the most commonly used data types. A string is a collection of zero or more characters. Strings are commonly declared using single quotation marks, but you can also use double quotation marks:

```python
x = 'This is a string'
print(x) # outputs: This is a string
print(type(x)) # outputs: <class 'str'>
y = "This is also a string"
```

You can add strings to other strings &mdash; an operation known as "concatenation" &mdash; with the same `+` operator that adds two numbers:

```python
x = 'Hello' + ' ' + 'World!'
print(x) # outputs: Hello World!
```

You'll learn more about strings in another lesson, including how to parse them and how to manipulate them in various ways. You'll also learn about other important data types such as lists, which store collections of data and are frequently used to hold collections of strings.

## Print to the console

In Python, the `print` function, which is one of more than 60 functions built into the language, outputs text to the screen.

The following statement displays "Hello World!" on the screen:

```python
print('Hello World!')
```

The argument passed to `print` is a *string*, which is one of the fundamental data types in Python used to store and manage text. By default, `print` outputs a newline character at the end of the line, so subsequent calls to `print` will start on the next line.

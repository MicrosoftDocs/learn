Variables are one of the fundamental building blocks of programs written in Python. Variables hold data in memory. They have names, and they can be referenced by name. Variables also have *types* such as string and integer, and they can be used in expressions that use *operators* such as `+` and `-` to manipulate their values.

In Python, a variable is declared and assigned a value using the assignment operator `=`. The variable being assigned to is on the left-hand side of the operator, and the value being assigned, which can be an expression such as `2 + 2` and can even include other variables, is on the right-hand side:

```python
x = 1         # assign x the value 1
y = x + 5     # assign y the value of x plus 5
z = y         # assign z the value of y
```

These examples assign numbers to variables, but numbers are just one of several data types that Python supports.

### Working with numbers

Most programs manipulate numbers. Computers treat integer numbers and decimal numbers differently. Consider the following code:

```python
x = 1 # integer
x = 1.0 # decimal (floating point)
```

Python creates integers from a built-in data typed called `int`, and decimals (floating-point numbers) as instances of `float`. Python's built-in `type` function returns a variable's data type. The following code outputs types to the screen:

```python
x = 1
print(type(x)) # outputs: <class 'int'>

x = 1.0
print(type(x)) # outputs: <class 'float'>
```

The addition of the ".0" to the end of "1" makes a big difference in how the programming language treats a value. The data type impacts how the value is stored in memory, how the processor (CPU) handles the data when evaluating expressions, how the data relates to other data, and what kinds operations can be performed with it.

Another common data type is the Boolean type, which holds the value `True` or `False`:

```python
x = True
print(type(x)) # outputs: <class 'bool'>
```

Internally, `bool` is treated as a special type of integer. Technically, `True` has a value of 1 and `False` has a value of 0. Typically, Booleans are not used to perform mathematical operations; rather, they are used to make decisions and perform branching. Nevertheless, it is interesting to understand the relationship between types. Many types are nothing more than specialized versions of more general types. Integers are a subset of floating point numbers, and Booleans are a subset of integers.

### Working with strings

Along with numbers, strings are among the most commonly used data types. A string is a collection of zero or more characters. Strings are commonly declared using single quotation marks, but double quotation marks may be used, too:

```python
x = 'This is a string'
print(x) # outputs: This is a string
print(type(x)) # outputs: <class 'str'>
y = "This is also a string"
```

Strings can be added to other strings (an operation known as "concatenation") with the same `+` operator that adds two numbers:

```python
x = 'Hello' + ' ' + 'World!'
print(x) # outputs: Hello World!
```

You will learn more about strings in another lesson, including how to parse them and how to manipulate them in various ways. You will also learn about other important data types such as lists, which store collections of data and are frequently used to hold collections of strings.

## Reading keyboard input

For reading input from the keyboard, Python provides the `input` function. `input` reads what the user types on the keyboard and returns it as a string. Here is an example that combines `input` and `print` to capture a person's name and then display it on the screen:

```python
name = input('Enter your name:')
print(name)
```

The string passed as an argument to the `input` function is the prompt that the user will see. In this example, you are asking the user to type his or her name ('Enter your name'). Once the user types a name and presses **Enter**, the `input` function will return. The function's return value is the text that the user typed, and that text is assigned to the variable named `name`. The `name` variable is then used as an input or argument to the `print` function which will output the name that the user entered.

## Commenting your code

Just about all programming languages support including comments in source code. Comments do not change what the code does when it runs. Instead, they serve to explain how the code works or why it was written that way. Comments are a great way to document complicated code and to include TODOs reminding you to come back and do something later — for example, "make sure this code works with empty strings."

Python supports comments using the pound sign (or hash) followed by the text of the comment:

```python
# I am a comment...
```

Comments always extend to the end of the line and are always one-line only. For multiline comments, place a pound sign at the start of each line. A comment may appear at the start of a line or following whitespace or code, but not within a string - in that case it's just a literal pound sign in text.

```python
# I am a comment...
x = 1   # the rest of the line is a comment
        # ... and this is a 3rd comment
text = "# But this isn't a comment because it's a string literal and in quotes."
```

Some programmers avoid comments in favor of writing "self-documenting code," which is easy to understand as a result of descriptive variable and function names. There is nothing wrong with self-documenting code, but never hesitate to use comments in an effort to be as explicit as possible about your thoughts and intentions. The purpose of a block of code may be clear to you if you wrote it 10 minutes ago. But a year from now, a well-placed comment may be as helpful to you as it is to other programmers who are seeing your code for the first time.
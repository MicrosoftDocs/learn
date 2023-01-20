When you start learning any programming language, you first try out a few statements of code in a read-evaluate-print loop (REPL). You soon want to move into serious development, though. That means learning more about the language, how to structure a program, and more.

## A Python program

To create a program in Python, you need to store it in a file. The file should have the extension *.py*.

The idea of a program is to do something or carry out a task. To have the program do something, you'll need to add the statements or instructions to perform the task. For example, an instruction could print some text or calculate something. An example program, named *python.py*, can look something like this:

```python
# program.py
sum = 1 + 2
print(sum)
```

### Run a program

Assume you created a program that consists of multiple statements. You run it by launching the Python executable program in a console. A console is a command-line application that lets you interact with the operating system. To run a program, type the name of the Python executable program, followed by the name of your program. Here's an example of such an execution:

```console
python3 program.py
```

Running such a program would show the following result on the console:

```output
3
```

## The print() function

One of the first things you're likely to do is print to a console. On the console, you can run commands and programs. You can also enter information and show information as text on the screen.

To write information to the console, you can use the `print()` function and implement it as a core function. Because it's a core function, you'll have access to it if Python is installed. To use `print()` in your program, give it an argument:

```python
print("show this in the console")
```

Running the program now would show the following result on the console:

```output
show this in the console
```

Note how the command calls `print()` by using parentheses. That's how you execute a function. If you used square brackets (`[]`) instead of parentheses, it wouldn't work, as you'll notice if you run the program again with this code:

```python
print["show this in the console"]
```

Here's the output:

```output
Traceback (most recent call last):
  File "/<path>/program.py", line 1, in <module>
    print["show this in the console"]
TypeError: 'builtin_function_or_method' object is not subscriptable
```

Another thing to notice is the use of double quotation marks (`""`). That's how you declare a so-called string literal, with the value like the one you're printing: "show this in the console".

## Variables

To get anywhere with coding, you need to understand that you're operating on data. As your program is working on data, you might need to remember a certain value throughout the program's execution. For that, you use variables.

The following example makes a calculation and stores it in variables:

```python
sum = 1 + 2 # 3
product = sum * 2
print(product)
```

### Data types

A variable assumes a data type. In the preceding program, `sum` gets the type `int`. However, there are many more data types. Here are a few that you're likely to encounter:

| Type          | Description                                | Example(s)                     |
| ------------- | ------------------------------------------ | --------------------------- |
| Numeric type | Number, with or without decimals | `int, float, complex, no = 3` |
| Text type    | String of characters      | `str = "a literal string"`    |
| Boolean type  | Boolean                                       | `continue = True`             |

There are more complex types, but let's start with these.

Here's a piece of code that demonstrates some of the preceding types:

```python
planets_in_solar_system = 8 # int, pluto used to be the 9th planet, but is too small
distance_to_alpha_centauri = 4.367 # float, lightyears
can_liftoff = True
shuttle_landed_on_the_moon = "Apollo 11" #string 
```

How do you know what type something has? If you see the data being assigned to the variable as shown in the following code, you can spot it:

```python
distance_to_alpha_centauri = 4.367 # looks like a float
```

The other way is to use the `type()` function:

```python
type(distance_to_alpha_centauri) ## <class 'float'>
```

## Operators

Operators let you perform various operations on variables and their values. The general idea is that you have a left side and a right side and an operator in the middle:

```python
<left side> <operator> <right side>
```

Here's what a real example of the preceding placeholder code would look like:

```python
left_side = 10
right_side = 5
left_side / right_side # 2
```

This example uses a slash (`/`) to divide the `left_side` value by the `right_side` value.

There are many more operators. This unit describes some important ones you're likely to encounter.

Python uses two types of operators: *arithmetic* and *assignment*.

### Arithmetic operators

With *arithmetic* operators, you perform calculations like addition, subtraction, division, and multiplication. Here's a subset of arithmetic operators you can use:

| Type | Description                                                                        | Example |
| ---- | ---------------------------------------------------------------------------------- | ------- |
| +    | Addition operator that adds two values together                                         | `1 + 1`   |
| -    | Subtraction operator that removes the value of the right side from the left side       | `1 - 2`   |
| /    | Division operator that divides the left side as many times as the right side specifies | `10 / 2`  |
| *    | Multiplication operator                                                            | `2 * 2`   |

### Assignment operators

You can use *assignment* operators to assign values to a variable throughout the lifecycle of the variable. Here are some assignment operators you're likely to encounter as you're learning to build programs:

| Operator | Example                                                                     |
| -------- | --------------------------------------------------------------------------- |
| =        | `x = 2` <br>x now contains 2.                                                     |
| +=       | `x += 2` <br>x incremented by 2. If it contained 2 before, it now has a value of 4. |
| -=       | `x -= 2` <br>x decremented by 2. If it contained 2 before, it now has a value of 0. |
| /=       | `x /= 2` <br>x divided by 2. If it contained 2 before, it now has a value of 1.     |
| *=       | `x *= 2` <br>x multiplied by 2. If it contained 2 before, it now has a value of 4.  |

## Dates

When you're building programs, you're likely to interact with dates. A date in a program usually means both the calendar date and the time.

You can use a date in various applications, like these examples:

- **Backup file:**. Using a date as part of a backup file's name is a good way to indicate when a backup was made and when it needs to be made again.
- **Condition:**. You might want to carry a specific logic when there's a certain date.
- **Metric:**. Dates are used to check performance on code to (for example) measure the time it takes to execute a function.

To work with a date, you need to import the `date` module:

```python
from datetime import date
```

You can then call the functions that you want to work with. To get today's date, you can call the `today()` function:

```python
date.today()
```

To show the date on the console, you can use the `print()` function. The `print()` function takes many types of data as input. Here's how you can show today's date:

```python
print(date.today())
```

### Data type conversion

You want to use a date with something, usually a string. If you, for example, want to show today's date on the console, you might run into a problem:

```python
print("Today's date is: " + date.today())
```

What you get is an error:

```output
Traceback (most recent call last):
  File "/<path>/program.py", line 4, in <module>
    print("Today's date" + date.today())
TypeError: can only concatenate str (not "datetime.date") to str
```

The last row of the message tells you what the problem is. You're trying to use the `+` operator and combine two different data types, a string and a date.

To make this code work, you need to convert the date into a string. You accomplish such a conversion by using the utility function `str()`:

```python
print("Today's date is: " + str(date.today()))
```

The output looks like this:

```output
Today's date is: <date>
```

When you start learning any programming language, you first try out a few statements of code in a REPL (a Read Evaluate Print Loop) a console-based program. You soon want to move into serious development though, which means learning more about the language, how to structure a program and more.

## A Python program

To create a program in Python, you need to store it in a file. The file should have the file extension `.py`.

The idea of a program is to do something, carry out a task.

To have the program do something, you need to add statements of code that performs an instruction. An instruction could print some text or calculate something for example. An example program can look something like so:

```python
# program.py
sum = 1 + 2
print(sum)
```

### Run a program

Assume you created a program, consisting of statements, you run it by invoking the python executable followed by the program name. Here's an example of such an invocation:

```bash
python3 program.py
```

Running such a program would show the following result in the console:

```output
3
```

## The print() function

One of the first things you are likely to do is to print to a console. A console is a command-line application that lets you interact with the operation system. On the console, you can run commands, programs, and you can input information and output information as text on the screen. To write information to the console, you can use the function `print()` that's implemented as a core function, meaning you will have access to it, if Python is installed. To use `print()`, give it an argument like so:

```python
print("show this in the console")
```

Note how the invocation of `print()` was done with a left and right parenthesis, that's how you invoke function. Were you to use a square brackets `[]` instead of `()`, it would not work:

```bash
python3 program.py
```

Here's the output:

```output
Traceback (most recent call last):
  File "/<path>/program.py", line 1, in <module>
    print["show this in the console"]
TypeError: 'builtin_function_or_method' object is not subscriptable
```

Another thing to notice is the use of double quotation marks (`""`), that's how you declare a so called string literal, like the one you are printing "show this in the console".

## Variables

To get anywhere with coding, you need to understand that you are operating on data. As your program is working on data, throughout the programs execution you might need to remember a certain value, for that we use variables. In the below example, a calculation is made and stored in different variables:

```python
sum = 1 + 2 # 3
product = sum * 2
print(product)
```

### Data types

One thing we need to know is that variable assumes a data type when you assign a variable to it. In the above program, `sum` gets the type `int`. But there are many more data types. Here are some more that you are likely to encounter:

| Type          | Description                                | Example                     |
| ------------- | ------------------------------------------ | --------------------------- |
| Numeric types | stores a number, with our without decimals | int, float, complex, no = 3 |
| Text types    | string, stores a string of characters      | str = "a literal string"    |
| Boolean type  | bool                                       | continue = True             |

There are more complex types, but lets start with these above.

Here's a piece of code that demonstrates some of the above types:

```python
planets_in_solar_system = 8 # int, pluto used to be the 9th planet, but is too small
distance_to_alpha_centauri = 4.367 # float, lightyears
can_liftoff = True
shuttle_landed_on_the_moon = "Apollo 11" #string 
```

How do we know what type something has? Well, if we see the data being assigned to the variable like so, we can spot it:

```python
distance_to_alpha_centauri = 4.367 # looks like a float
```

The other way is to use the `type()` function like so:

```python
type(distance_to_alpha_centauri) ## <class 'float'>
```

## Operators

Operators allow us to perform calculations on variables and their values. The general idea is that you have a left side and a right side and an operator in the middle, like so:

```python
<left side> <operator> <right side>
```

A real example of the above would look like so:

```python
left_side = 10
right_side = 5
left_side / right_side # 2
```

Here, division is used, `/` to divide the value of `left_side` with `right_side` value.

There are many more operators, here are some important ones you are likely to encounter.

Python differs between two types of operators:

- **arithmetic operators**, with these operators you perform arithmetic calculations like additions, subtraction, multiplication, and so on.
- **assignment operators**, these operators are used to assign values to a variable, either the first time or later on in the program.

### Arithmetic operators

Here's a subset of all mathematical operators you can use:

| Type | Description                                                                        | Example |
| ---- | ---------------------------------------------------------------------------------- | ------- |
| +    | Addition operator, adds to values together                                         | 1 + 1   |
| -    | Subtraction operator, removes the value of the right side from the left side       | 1 - 2   |
| /    | Division operator, divides the left side as many times as the right side specifies | 10 / 2  |
| *    | Multiplication operator                                                            | 2 * 2   |

### Assignment operators

These operators are used to assign values to a variable throughout the lifecycle of a variable. Here are some of these operators you are likely to encounter learning to build programs:

| Operator | Example                                                                     |
| -------- | --------------------------------------------------------------------------- |
| =        | x = 2, x now contains 2                                                     |
| +=       | x += 2, x incremented by 2, so if it contained 2 before, it now has value 4 |
| -=       | x -= 2, x decremented by 2, so if it contained 2 before, it now has value 0 |
| /=       | x /= 2, x divided by 2, so if it contained 2 before, it now has value 1     |
| *=       | x *= 2, x multiplied by 2, so if it contained 2 before, it now has value 4  |

## Work with date

One thing you are likely to interact with when building programs are dates. When talking about date, you usually mean both the calendar date and the time.

A date can be used in various applications like, for example,  the following areas:

- **a backup file**, using a date as part of a backup file name is a good way to indicate when the backup was made and when it needs to be made again.
- **a condition**, you might want to carry about a specific logic when there's a certain date
- **metric**, dates are used to check performance on code to, for example,  measure the time it takes to execute a function.

To work with a date, you need to import the `date` module like so:

```python
from datetime import date
```

Once you've done so, you can invoke the functions you want to work with. To get today's date, you can call the `today()` function like so:

```python
date.today()
```

To output the date to the console, you can use the `print()` function. The `print()` function takes many different types of data types as input. Here's how you can show today's date:

```python
print(date.today())
```

### Data type conversion

You want to use a date with something. That something is usually a string, if you, for example,  want to output it to the console, you might run into a problem:

```python
print("Today's date is: " + date.today())
```

What you get is an error like so:

```output
Traceback (most recent call last):
  File "/<path>/program.py", line 4, in <module>
    print("Today's date" + date.today())
TypeError: can only concatenate str (not "datetime.date") to str
```

The last row of the message tells us what the problem is. We are trying to use the `+` operator and combine two different data types, a string and a date. To make this code work, we need to convert the date into a string. The way to accomplish such a conversion is by using the utility function `str()`. Using `str()` your code now looks like so:

```python
print("Today's date is: " + str(date.today()))
```

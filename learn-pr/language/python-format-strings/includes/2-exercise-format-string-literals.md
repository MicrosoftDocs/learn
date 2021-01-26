Python strings have many built-in features, including some that might not be obvious. Before we explore some advanced string formatting that uses special functions, let's make use of everything strings can do by themselves.

### Step 1 - Create a new working folder and Python code file

Using the techniques you learned in previous modules, create a new folder for your work in this module. For example, you might create a folder named `python-format-strings`.

Inside that folder, create a file for this exercise. For example, you might create a file named `exercise1.py`.

When it's time to run your code, use Python tools for Visual Studio Code integration, by selecting the green arrow. Alternatively, you can use a command in the integrated terminal by using techniques we learned about in previous modules.

### Step 2 - Add code to compare literal strings defined by using single and double quotation marks

Define literal strings by using either a pair of single-quote symbols (`'`) or a pair of double-quote symbols (`"`).  Add the following lines of code to your new code file:

```python
first_string = 'A literal string'
second_string = "A literal string"
print(second_string == first_string)
```
When you run the code, you'll see the following output:

```output
True
```
You can use either single or double quotes. Here, we'll typically use single quotes.

### Step 3 - Comment out the previous code, and add code that uses quotes inside other quotes

If you need to use a single- or double-quotation mark in the string itself, you can use a double quote inside a set of single quotes, and vice versa.

Comment out the code from the previous step, and add the following code to your code file:

```python
third_string = 'A single quoted literal string with a " double quote'
fourth_string = "A double quoted literal string with a ' single quote"
print(third_string)
print(fourth_string)
```
In this case, `third_string` points to a literal string that embeds a double quote inside a string defined with single quotes. Conversely, `fourth_string` points to a literal string that embeds a single quote inside a string defined with double quotes.

When you run the code, you should see the following output:

```output
A single quoted literal string with a " double quote
A double quoted literal string with a ' single quote
```

### Step 4 - Comment out the previous code, and add code that uses escape sequences

But what if you need to embed a single quote in a literal string, and you want to define the string by using single quotes? Or, conversely, use a double quote inside a literal string defined with double quotes? In this case, you can use the `\` character to create an escape sequence.

There are several escape sequences available to Python strings. Comment out the code from the previous steps, and then add the code in the following code listing:

```python
fifth_string = 'A single quoted literal string with an \' escaped single quote'
sixth_string = "A double quoted literal string with a \" double quote"
seventh_string = 'A literal string with a \n new line character'
eighth_string = 'A literal string with a \t tab character'

print(fifth_string)
print(sixth_string)
print(seventh_string)
print(eighth_string)
```
As the content of the literal strings themselves suggest, the `\n` escape sequence creates a new line, and the `\t` escape sequence adds a tab to the string when it's displayed.

When you run the code, you should see the following output:

```output
A single quoted literal string with an ' escaped single quote
A double quoted literal string with a " double quote
A literal string with a
 new line character
A literal string with a          tab character
```
Other escape sequences exist, but these are by far the most popular.

### Step 5 - Comment out the previous code and add code that displays raw strings

But what if you need to display the contents of an escape sequence without performing the escape sequence's command? In other words, what if you need to literally display the value `\n`? In that case, you prefix a literal string with the `r` character to produce a raw output, without any escaping. This is helpful if you need to ignore escape sequences, and display the entire string as it appears in code.

Comment out the code that you added in the previous steps, and then add the following code to the code file:

```python
ninth_string = r"A literal string with a \n new line character printed raw"

print(ninth_string)
```
When you run the code, you should see the following output:

```output
A literal string with a \n new line character printed raw
```

### Step 6 - Comment out the previous code, and add code that uses multi-line strings

If you need to display a string across multiple lines, you can use the new line escape sequence we just learned about. Alternatively, you can create a multi-line string by defining the string with a set of three single quotes, or a set of three double quotes.

Comment out the code from the previous step, and add the code from the following code listing:

```python
tenth_string = '''A literal string
on more than one line
sometimes known as a verbatim string'''

eleventh_string = """Another literal string
     on more than one line
using double quotes"""

print(tenth_string)
print(eleventh_string)
```
In some programming languages, this type of multi-line string that retains its formatting is called a "verbatim string".

When you run the code, you should see the following output:

```output
A literal string
on more than one line
sometimes known as a verbatim string
Another literal string
     on more than one line
using double quotes
```

Notice that the literal string we point to with the `eleventh_string` variable includes several empty spaces. These are faithfully kept when we print out the string a few lines later.


### Step 7 - Comment out the previous code, and add code that formats string by using the `print()` function

In this exercise, we've used various techniques inherent to strings to influence their formatting. The `print()` function also has a few built-in features that allow us to concatenate strings and influence their formatting.

Comment out the code from the previous steps, and then add the code in the following code listing. This demonstrates how you can supply the `print()` function with additional arguments to modify the output.

```python
first = 'Conrad'
second = 'Grant'
third = 'Bob'
print(first, second)
print(first, second, third)
print(first, second, third, sep='-')
print(first, second, third, sep='-', end='.')
```

The first and second calls of the `print()` function concatenate strings together before displaying them to the console. The `print()` function is defined in such a way that we can send in a variable number of arguments (two, three, four, or more). Each of them will be concatenated together, each separated by an empty space, and displayed to the console.

The third call to the `print()` function adds an optional named argument `sep`. This defines the character we want to use to separate the strings as they're concatenated together for display.

The fourth call to the `print()` function adds another optional named argument `end`. This defines the character we want to use at the very end of the sequence.

If you run the code, you'll see the following output.

```output
Conrad Grant
Conrad Grant Bob
Conrad-Grant-Bob
Conrad-Grant-Bob.
```

### Functions with variable and named arguments

In a previous module, we learned how you can define functions with optional input parameters. These parameters allow the caller to decide whether to accept the default value or implementation, or supply the argument with a value.  

Similarly, you can define functions with variable parameters. This allows the caller to pass in as many arguments as needed, and the function processes each parameter.

Named parameters allow the caller to use the convention `name=value`. This allows us to send the arguments in any order, and it makes the purpose of those arguments clearer to those who might read your code in the future.

In another module, you'll learn how to add variable and named parameters to the functions you define when you create your own functions.

## Recap

In this exercise, you learned some important details about working with strings:

- You can define a literal string by using either a set of single-quote or double-quote symbols.
- You can add an escape sequence to use a special character inside your string, such as a single-quote escape sequence (`\'`), double-quote escape sequence (`\"`), a new line escape sequence (`\n`), or a tab escape sequence (`\t`).
- You can print the raw output of a string by prefixing it with the `r` character.
- You can define a multi-line verbatim string by using either a set of three single-quote characters (`'''`) or a set of three double-quote characters (`"""`).
- The `print()` function can concatenate a variable number of strings sent as arguments into the function. You can specify the character you want to separate each argument, as well as the ending character.

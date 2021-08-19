Python has evolved through the years. You might see code examples that format strings in many different ways. In this exercise, we'll focus on the most recent enhancements to string formatting.

The `format()` helper function merges values into a literal string template, without the need for messy string concatenation. It can also format those merged values for proper display, as in the case of numbers, dates, and times.

In the Python 3.6 version, developers simplified the `format()` method into a string prefix, the letter `f`. This performs virtually all of the same functionality, with less typing.

### Step 1 - Create a new code file for this exercise

Use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module. For example, you might create a new file `exercise3.py`.

### Step 2 - Add the following code to illustrate the `format()` function's merge feature

Add the following code to the new file.

```python
medicine = 'Coughussin'
dosage = 5
duration = 4.5

instructions = '{} - Take {} ML by mouth every {} hours'.format(medicine, dosage, duration)
print(instructions)

instructions = '{2} - Take {1} ML by mouth every {0} hours'.format(medicine, dosage, duration)
print(instructions)

instructions = '{medicine} - Take {dosage} ML by mouth every {duration} hours'.format(medicine = 'Sneezergen', dosage = 10, duration = 6)

print(instructions)
```

In this code example, we define a format string that contains a series of replacement fields, as defined by a set of curly braces `{}`.

In the first example, the replacement fields have no values inside them. By using the member access operator, we call the `format()` function. We pass in the values we want to substitute in each replacement field, in the order in which they appear.

In the second example, we fill the replacement fields with a zero-based numeric value, which accesses the argument passed into the `format()` function. We intentionally mixed up the order to show that you can use the arguments in any position of your format string. You do this by changing the ordinal position in the replacement field.

In the third example, we fill the replacement fields with variable names. Those same variable names are passed as named arguments into the `format()` function.

When you run the code, you should see the following output:

```output
Coughussin - Take 5 ML by mouth every 4.5 hours
4.5 - Take 5 ML by mouth every Coughussin hours
Sneezergen - Take 10 ML by mouth every 6 hours
```

### Step 3 - Comment out the previous code, and add code to use formatted string literals, or "f-strings"

The `format()` function is powerful and flexible. You can do the same thing with less typing using formatted string literals, also known as *f-strings*.

Comment out the code from the previous step, and add the following code listing:

```python
name = 'World'
message = f'Hello, {name}.'
print(message)

count = 10
value = 3.14
message = f'Count to {count}.  Multiply by {value}.'
print(message)
```

In the first example, we create replacement fields just like we did with the `format()` function. We fill the replacement field with the name of variable we want to substitute into the format string.

In the second example, the variable `count` is set to an `int` value, and the variable `value` is set to a `float` value. The format string takes care of the data type conversion for us, so we don't need to call `str()` around those values.

When you run the code, you should see the following output:

```output
Hello, World.
Count to 10.  Multiply by 3.14.
```

### Step 4 - Comment out the previous code, and add code to evaluate simple expressions in the replacement field of an f-string

You can perform just about any expression inside a replacement field. In the following example, we'll perform calculations directly inside the replacement field. You might not prefer to do this, because it's less readable than creating a temporary variable to perform the calculations. But it's helpful to know what's possible.

Comment out the code from the previous step, and add the following code listing:

```python
width = 5
height = 10

print(f'The perimeter is {(2 * width) + (2 * height)} and the area is {width * height}.')
```

When you run the code, you should see the following output:

```output
The perimeter is 30 and the area is 50.
```

### Step 5 - Comment out the previous code, and add code to define format specifiers to control alignment and padding

Format string literal replacement fields have a special format specifier syntax that is almost a mini-programming language unto itself. We'll merely scratch the surface of what's possible in this step of the exercise. You can use the format specifier syntax to format numbers, dates, time, percentages, and exponents.

In this step, we'll use the format specifier syntax to add alignment and padding to our format strings.

Comment out the code from the previous step, and add the following code listing:

```python
value = 'hi'

print(f'.{value:<25}.')
print(f'.{value:>25}.')
print(f'.{value:^25}.')
print(f'.{value:-^25}.')
```

A format specifier uses a colon symbol (`:`) after the variable name, to specify how that value should be formatted.

In the first f-string, we use the less-than symbol (`<`) to align the text to the left of a string that is 25 total characters wide. The string `hi` occupies two of the 25 total characters. We add period symbols (`.`) on the left and right of the replacement field, to help us see the total width of the string.

In the second f-string, we use the greater-than symbol (`>`) to align the text to the right of a string that is 25 total characters wide.

In the third f-string, we use the caret symbol (`^`) to center the text in the middle of a string that is 25 total characters wide.

In the fourth f-string, we use the caret symbol (`^`) again. But this time, we preface it with a single dash symbol (`-`) to use instead of an empty space to fill the remaining width of the string.

When you run the code, you should see the following output:

```output
.hi                       .
.                       hi.
.           hi            .
.-----------hi------------.
```

For more information, see [Python's documentation](https://docs.python.org/3/library/string.html#formatspec?azure-portal=true).

## Recap

- The `format()` function allows you to define a format string (essentially, a template). The string contains a series of replacement fields that are replaced with arguments you pass into the function.
- The new format string literal, or f-string, reduces the keystrokes of the `format()` method. This allows you to use variables or expressions in the replacement fields.
- Format specifiers are a compact syntax that allows you to format numbers, dates, and percentages, as well as alignment and spacing.

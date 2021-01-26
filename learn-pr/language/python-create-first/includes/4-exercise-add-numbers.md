In this exercise, you learn about the values in your program, data types, and how to convert a value of one data type into another.

## Build a program that performs addition

By using techniques like the ones presented in the previous exercises, you'll create a new program that prompts the end user for two values, adds them together, and displays the results.  Along the way, you'll encounter new issues and solutions that will give you deeper insight into how Python works.

### Step 1 - Create a new .py code file

Let's create a new file for the next exercise. By using the technique you've just learned, create a new file, and name it *numbers.py*.

> [!Note]
> Remember, in Visual Studio Code, you can select **File** > **New File** to create the file, and then select **File** > **Save As** to give it a name.

### Step 2 - Add code to your new file

In the new *numbers.py* file, type the following code:

```python
print("First Number:")
first_number = input()
print("Second Number:")
second_number = input()
sum = first_number + second_number
print(sum)
```
For the most part, this code example is almost identical to what you built in previous exercises.  However, you did something subtly different in this line of code:

```python
sum = first_number + second_number
```
Here you introduce a *temporary variable* to hold a computed value that you'll use later in the program.  In other words, you could have written the last line of code this way instead:

```python
print(first_number + second_number)
```

If you chose to do this, you wouldn't need to introduce the `sum` variable.  So then, why did you create the `sum` variable?  Sometimes a temporary variable can make your code more readable.  In this case, you know that the last line of code will grow more complex later in this exercise, and it might make that line shorter and more manageable to just eliminate the addition, concatenation, and printing all in a single line of code.  These are matters of judgment, and as a developer, you'll develop a style and personal preferences about what looks readable to you the more you write code.  

The Python community merely recommends that you make sure your code is readable for your own future sanity, or the sanity of others who will read your code in the future.  One often-recited phrase in the Python developer community is that "you'll write your code once, but will read it many times, so optimize for readability."

### Naming variables

You can give your variables any name you like, but it's a good practice to choose a name that describes the data that the variable points to.  Sometimes it's hard to choose the right name, but it's a worthwhile task.  Ideally, the name would be as short as possible and as descriptive as possible.  Generally speaking, you should be able to accomplish that in one or two words.

A Python best practice is to use all lowercase letters for variable names. If you need more than one word to adequately describe the variable's purpose, separate the words with an underscore (**_**) character.

### Step 3 - Save and execute the code

Save and run the program by using one of the techniques that you learned earlier.  You should see the following output:

```output
First Number:
5
Second Number:
4
54
```

This is not the desired output.  You want your program to add two numbers to create a sum, but it appears that your program has concatenated two strings instead.  The problem is that the `input()` function returns data represented as strings, not numbers.  

In Python, every value in your programs has an associated data type that describes what kind of data it is and what you can do with it.  In other words, since your two values are strings, they can only be concatenated.  If you want to perform mathematical operations on two values, they both must be numeric data types.

How can you convert a string value into an integer value, and why do you need to?

### What is a data type?

Data types exist in all programming languages.  Most programming languages have many different data types, which represent different kinds of data and the kinds of operations you want to perform on the data itself.  Python has both simple data types, such as string, integer, and float (which can represent numeric data containing fractions), and complex data types that represent collections of values and more.

Each data type exists to fill a need that programmers have at some point during their career.  You'll use some data types frequently and others infrequently, if ever.

If the values you're working with in your program are not of the right data type, you can convert them to the desired data type by using built-in functions.  In this scenario, you'll use the `int()` function to convert a string into an integer (whole) number.  When the value is of the correct data type, you can use it as you'd like.  For example, after you convert the string data to integer data, you can perform the addition operation on the data.

### Step 4 - Revise code to convert input to integers

Update your code to match the following code example:

```python
print("First Number:")
first_number = int(input())
print("Second Number:")
second_number = int(input())
sum = first_number + second_number
print(sum)
```

Note the key difference in this code example.  Here, you're wrapping the call to the `input()` function with a call to the `int()` function.  In other words, the Python interpreter first executes the `input()` function and, after a value is returned from the `input()` function containing user input, it's passed as an input parameter to the `int()` function, which converts the value from a string to an integer.

> [!TIP]
> The `print()` method is flexible.  It can display the string data type, the int data type,  the float data type, and other data types we haven't talked about yet.

### Step 5 - Save and execute the code

Save and run the program by using one of the techniques that you learned earlier.  You should see the following output:

```output
First Number:
5
Second Number:
4
9
```

Success!

But what happens if you rerun the program and provide non-numeric values?  In other words, what happens if you enter your first and last name instead of two numbers when prompted?

```output
First Number:
bob
Traceback (most recent call last):
  File "c:/python/hello/stuff.py", line 8, in <module>
    first_number = int(input())
ValueError: invalid literal for int() with base 10: 'bob'
```

Here, when you reran the program, you entered a first name, *bob*, instead of a number.  When you select Enter, your program encounters a runtime error and exits.  Unlike a compile-time error that the Python compiler can catch when you attempt to run your program and fix before you distribute the program to end users, a runtime error occurs when users, through no fault of their own, experience an error when using the program.

Ideally, you would first perform a check to ensure that the value users enter can be converted into a number before you actually perform a data conversion.  If users didn't enter a number, you could ignore their entry and ask them again to enter a number.  For now, acknowledge that this is a potential issue with your program. You can address it after you learn more about Python.

### Step 6 - Revise the code to display a label in front of the sum value

The next task is to format the last line of content to make it clear what the number `9` represents.  Ideally, you would preface that number with a label, such as *Sum :*.

Update the last line of code to match the following code example:

```python
print("Sum: " + sum)
```

Do you think this will work?  Why or why not?

### Step 7 - Save and execute the code

Save and run the program by using one of the techniques that you learned earlier.  You should see the following output:

```output
First Number:
5
Second Number:
4
Traceback (most recent call last):
  File "c:/python/hello/numbers.py", line 11, in <module>
    print("Sum: " + first_number + second_number)
TypeError: can only concatenate str (not "int") to str
```

The problem seems to be related to concatenating a *string* to an *int*.

The reason this code won't work is because Python won't implicitly convert your first_number to a string.  It looks at the literal string, then sees a `+` and is expecting another value of type string so that it can perform a concatenation.  When it encounters an integer, it throws up its hands and reports an error.

To fix this, you need to perform the addition operation first, convert the sum from an integer to a string, and then perform the concatenation.

### Step 8 - Revise the code to convert the integer to string for concatenation

To fix the issue, modify the last line of code to match the following code example:

```python
print("Sum: " + str(sum))
```

Here you're using the `str()` function to convert the sum variable's value into a string.  Then, you can perform the string concatenation so that the sum is formatted correctly.

### Step 9 - Save and execute the code

Save and run the program by using one of the techniques that you learned earlier.  You should see the following output:

```output
First Number:
5
Second Number:
4
Sum: 9
```
Success!

## Recap

- Choose good variable names that lend to the readability of your code.
- Choose to introduce temporary variables if they help increase the readability of your code.  Use your best judgment and optimize for readability.
- To perform mathematical operations on data, it must first be converted to a numeric data type.  If you have a string value that represents a whole number, and you want to perform math, you can use the `int()` function to convert the value into an integer.
- If you attempt to use `int()` to convert a string to an integer, but the string isn't a value that can be converted such as a name, the end user will experience a runtime error.  Runtime errors happen when the programmer doesn't anticipate issues with data or other potential logic issues in advance.
- When used with a numeric data type, the plus sign (**+**) symbol performs addition.
- You can call a function and pass its return value to another function.
- Use the `str()` function to convert a numeric value to a string.

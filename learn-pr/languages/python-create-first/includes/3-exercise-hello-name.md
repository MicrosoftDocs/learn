Programs are more interesting when we can prompt the user for input and use that input in our programs.

## What you'll build

We'll build on our previous exercise to prompt the user for their name to deliver a customized message.

### Step 1 - Comment out the code from the previous exercise

When you comment out a line of code, you want to keep the code in your code file, but you're telling the compiler to ignore this instruction.  You might want to add a line comment if you're not sure you want to permanently delete the line of code or not, and want to defer that decision.

You can also use code comments to add brief notes to yourself or other software developers who might see the code, explaining something about the code that wouldn't be obvious by merely reading it.

To comment out the code, place a single `#` character before the line, then an empty space.  Your code should now match the following code example.

```python
# print("Hello World!")
```
If you save and run the program now, nothing would happen because you've instructed the Python compiler to skip this line of code.

### Step 2 - Add the following code beneath the commented code

Next, we'll add an empty line and three new lines of code.  Make sure your code matches the following code example.

```python
# print("Hello World!")

print("What is your name?")
name = input()
print("Hello, " + name)
```

There are three new ideas in this code example.

The first line is similar to our previous exercise.  We are merely printing a new literal string to output.

In the second line, we're performing three distinct operations.  To begin, we're invoking the `input()`, which retrieves keyboard input from an end user.  When the user types information and selects the <kbd>enter</kbd> or <kbd>return</kbd> key, it will be returned from the `input()` function.

Some functions can finish their work quietly like the `print()` function.  It sends alphanumeric text to output and exits the function without returning any value.  Other functions can return a value when they exit.  In this case, the `input()` function will return all of the alphanumeric characters that the user typed in.

What should we do with the value returned from the `input()` function?  We need to temporarily store it for use in the next lines of code.  To do that, we create a variable.  

### What is a variable?

In Python, you can create a variable by merely choosing a variable name that isn't already in use and isn't one of Python's special keywords.  In this case, we create a variable called `name` that will store the alphanumeric characters that are returned from the `input()` function.

Now that we have a variable defined, we need to assign a value to it.  The the `=` character is the assignment operator.  We're assigning the value retrieved from the `input()` function to the new `name` variable.

To to recap line two, the three operations we performed:
- Call the `input()` function to retrieve user input
- Create a new variable called `name`
- Perform an assignment, setting name to the value returned from `input()`

Once this line of code is executed, the `name` variable holds the value that was typed in by the user.

In the third line, we want to print a message that combines a literal string and the variable from line 2.  Here again, we call the `print` function and pass a literal string `"Hello, "`.  But we also use the `+` symbol and the variable name.  Combining two or more strings is called **string concatenation**.  We want to append the literal string to the variable.  When the `+` symbol is used in this context, the Python compiler knows that we want to combine these two values together into a new value.

Once the new string value is created, it's passed to the `print` function.

### Step 3 - Save and execute the program using the py utility

To see our program in action, we could use the green arrow icon in Visual Studio Code like we did in the previous exercise.  But this time, just to show you that there are many different ways to run your code, let's use Visual Studio Code's terminal.

In the terminal window below the code editor, place your mouse cursor on the command prompt and type the following command, then select <kbd>enter</kbd>:

```dos
py hello.py
```

If you typed it in successfully, you should see the following output (when prompted, you should use your own name):

```output
What is your name?
Bob
Hello, Bob
```

The `py` command launches Python's compiler.  You provide the source code file name as an argument.  If you installed Python correctly and your command prompt is working in the same directory as your code files, this should work.  Otherwise, you'll need to use the full path and file name of your code file.

### What are keywords?

Keywords are commands built into the programming language that each have a special meaning in Python.  We'll learn many of these keywords in upcoming modules.  If you want to see a list of keywords that you cannot use as variable names, check out this list from Python's documentation:

[https://docs.python.org/3/reference/lexical_analysis.html#keywords](https://docs.python.org/3/reference/lexical_analysis.html#keywords?azure-portal=true)

### What are operators?

An operator is a symbol that instructs the Python compiler to perform some special operation.  We've already seen several operators:

- `()` are function invocation operators (when used to the right of a function name)
- `=` is the assignment operator, to assign a value to a variable
- `+` is the string concatenation operator.  As you'll see in the next unit, it's also the addition operator when working with numbers.
- `#` is the comment operator, which instructs the compiler to ignore all code or text that come after it on any given line of a code file.

Python has dozens of operators that perform mathematical, logical, and relational operations in your code.

### Where do the functions come from?

As stated earlier, functions like `print()` and `input()` were created by Python's developers.  They are part of the Python Standard Library, an extensive set of functionality that is available either automatically or can be easily refenced and added as needed.  The Library is divided into modules.  Each module contains related functions.  based o  We'll learn more about accessing the full breadth of functionality in upcoming modules.

When you say you want to "learn Python", you are really saying that you want to learn:

- what many (if not all) of the keywords and operators do
- how to write code that uses the keywords and operators correctly (or, in other words, the syntax)
- you want to become familiar with a few of the most important functions and modules in the Python Standard Library, and how to use functions and modules from third-party libraries
- you want to learn how to structure your code to build increasingly more interesting and complex programs

Throughout these modules and learning paths, you'll learn all of these things.

## Recap

Let's quickly recap the most important things to remember in this unit:

- Use the `#` character to comment out a line of code or to add a short note.  Everything after the `#` symbol on a particular line is ignored by the compiler and won't be executed.
- Use the `input` function to retrieve keyboard input from an end user.
- A variable is a friendly pointer to a value stored in the computer's memory.
- Create a new variable by choosing a name that has not already been used in your program, and that is not one of Python's reserved keywords.
- Use the `+` symbol to concatenate two strings together to create a new string value.
- A keyword is a command that is part of a programming language that performs some special function.
- An operator is a symbol that is part of a programming language that performs some special operation.
- Functions are collections of code that perform a single task in a software system.
- The Python Standard Library contains hundreds of functions spread across dozens of modules supplying common functionality for all developers.  Other third-party libraries contain additional functionality to extend the capabilities of the programming language.
Programs are more interesting when you can prompt the user for input and use that input in your programs.

## What you'll build

You'll build on the preceding exercise to prompt users for their name to deliver a customized message.

### Step 1 - Comment out the code from the preceding exercise

When you comment out a line of code, you want to keep the code in your code file, but you're telling the compiler to ignore this instruction. You might want to add a line comment if you're not sure whether you want to permanently delete the line of code, and you want to defer that decision.

You can also use code comments to add brief notes to yourself or other software developers who might see the code, explaining something about the code that wouldn't be obvious by merely reading it.

To comment out the code, place a single number sign (**#**) symbol at the beginning of the line, followed by an empty space. Your code should now match the following code example:

```python
# print("Hello World!")
```
If you save and run the program now, nothing happens because you've instructed the Python compiler to skip this line of code.

### Step 2 - Add code below the commented code

Next, add an empty line and three new lines of code. Make sure your code matches the following code example:

```python
# print("Hello World!")

print("What is your name?")
name = input()
print("Hello, " + name)
```

This code example presents three new ideas:

* The first line is similar to that in the preceding exercise. You're merely printing a new literal string to output.

* The second line performs three distinct operations. To begin, you're invoking the `input()` function, which retrieves keyboard input from an end user. When the user types information and selects Enter, the information is returned from the `input()` function.

* Some functions, such as the `print()` function, can finish their work quietly. The function sends alphanumeric text to output and exits without returning any value. Other functions can return a value when they exit. In this case, the `input()` function returns all the alphanumeric characters that the user entered.

What should you do with the value returned from the `input()` function? You need to temporarily store it for use in the next lines of code. To do that, you create a variable.

### Create a variable

In Python, you can create a variable by merely choosing a variable name that isn't already in use and isn't one of Python's special keywords. In this case, you create a variable called `name` that will store the alphanumeric characters that are returned from the `input()` function.

Now that you've defined a variable, you need to assign a value to it. The equal sign (**=**) symbol is the assignment operator. You're assigning the value retrieved from the `input()` function to the new `name` variable.

To recap line 2, you've performed three operations:
- Called the `input()` function to retrieve user input.
- Created a new variable called `name`.
- Performed an assignment, setting `name` to the value returned from `input()`.

After this line of code is executed, the `name` variable holds the value that was entered by the user.

In the third line, you want to print a message that combines a literal string and the variable from line 2. Here again, you call the `print` function and pass a literal string `"Hello, "`. But you also use the plus sign (**+**) symbol and the variable name. Combining two or more strings is called *string concatenation*. You want to append the literal string to the variable. When the plus sign (**+**) symbol is used in this context, the Python compiler knows that you want to combine these two values into a new value.

After the new string value is created, it's passed to the `print` function.

### Step 3 - Save and execute the program by using the py utility

To see your program in action, you could use the green arrow icon in Visual Studio Code, as you did in the preceding exercise. This time, to demonstrate that there are many different ways to run your code, let's use the Visual Studio Code terminal.

In the terminal window below the code editor, place your mouse cursor on the command prompt, enter the following command, and then press Enter.

```dos
py hello.py
```

If you entered it successfully, you should see the following output (at the prompt, use your own name).

```output
What is your name?
Bob
Hello, Bob
```

The `py` command launches Python's compiler. You provide the source code file name as an argument. If you installed Python correctly and your command prompt is working in the same directory as your code files, this should work. Otherwise, you'll need to use the full path and file name of your code file.

    >[!NOTE]
    >
    >"py" is specific to Windows. Use "python" or "python3" for MacOS and Linux.

### What are keywords?

Keywords are commands built into the programming language that have a special meaning in Python. You'll learn many of these keywords in upcoming modules. For a list of keywords that you can't use as variable names, see this [Python documentation](https://docs.python.org/3/reference/lexical_analysis.html#keywords?azure-portal=true).

### What are operators?

An operator is a character that instructs the Python compiler to perform some special operation. You've already seen several operators:

- The opening and closing parentheses `()` are function invocation operators (when placed to the right of a function name).
- The equal sign `=` is the assignment operator, used to assign a value to a variable.
- The plus sign `+` is the string concatenation operator. As you'll see in the next unit, it's also the addition operator when you're working with numbers.
- The number sign `#` is the comment operator, which instructs the compiler to ignore all code or text that comes after it on a line of a code file.

Python has dozens of operators that perform mathematical, logical, and relational operations in your code.

### Where do the functions come from?

As mentioned earlier, functions such as `print()` and `input()` were created by Python developers. The functions are part of the Python Standard Library, an extensive set of functionality that's available either automatically or can be easily referenced and added as needed. The library is divided into modules. Each module contains related functions. You'll learn more about accessing the full breadth of functionality in upcoming modules.

When you say you want to "learn Python," you're really saying that you want to:

- Learn what many or all of the keywords and operators do.
- Learn how to write code that uses the keywords and operators correctly (that is, the syntax).
- Become familiar with a few of the most important functions and modules in the Python Standard Library, and learn how to use functions and modules from third-party libraries.
- Learn how to structure your code to build increasingly more interesting and complex programs.

Throughout these modules and learning paths, you'll learn all of these things.

## Recap

Let's quickly recap the most important things to remember in this unit:

- Use the number sign (**#**) symbol to comment out a line of code or to add a short note. Everything after the number sign (**#**) symbol on a particular line is ignored by the compiler and isn't executed.
- Use the `input` function to retrieve keyboard input from an end user.
- A variable is a friendly pointer to a value that's stored in the computer's memory.
- Create a new variable by choosing a name that hasn't already been used in your program, and that isn't one of Python's reserved keywords.
- Use the plus sign (**+**) symbol to concatenate two strings to create a new string value.
- A keyword is a command that's part of a programming language that performs some special function.
- An operator is a symbol that's part of a programming language that performs some special operation.
- Functions are collections of code that perform a single task in a software system.
- The Python Standard Library contains hundreds of functions that are spread across dozens of modules, supplying common functionality for all developers. Other third-party libraries contain additional functionality to extend the capabilities of the programming language.

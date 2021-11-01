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

### Step 2 - Start writing a new program

Next, add an empty line and a new line of code, make sure your code matches the following code example:

```python
# print("Hello World!")

print("What is your name?")
```

At this point, your code outputs to the console, but you want this program to be able to collect input from the user, so you'll be looking at using the `input()` function next.

### Step 3 - Collect user input

To collect user input, use the `input()` function by adding this line at the bottom line of your file:

```python
name = input()
```

Now the program will halt, waiting for user input. As the user, type your name at the prompt in the terminal window, and press <kbd>Enter</kbd>, the program will continue. The program also accepts <kbd>Enter</kbd>, even with no input. 

### Step 4 - Output the user's input

You now have a program capable of collecting user input but no way of verifying that it works.

Add the following line to the bottom of your code to output the user's input:

```python
print("Hello, " + name)
```

The preceding line will concatenate the string "Hello " with the value of the `name` variable.

### Step 5 - Test your program

An important part of writing programs is running them to ensure everything works as intended.

1. Start your program by running `python3 hello.py` in a console:

   > [!NOTE]
   > replace `hello.py` with whatever you named the file that your program lives in.

1. Type **Bob** when asked for input, and press <kbd>enter</kbd> to progress the program.

   The output looks like so:

   ```output
   What is your name? 
   Bob
   Hello, Bob
   ```

    The `python3` command launches Python's compiler. You provide the source code file name as an argument. If you installed Python correctly and your command prompt is working in the same directory as your code files, this command should work. Otherwise, you'll need to use the full path and file name of your code file.

    >[!NOTE]
    > Use "python" or "python3" for MacOS and Linux; use "py" for Windows.

The full program looks like so:

```python
# print("Hello World!")
print("What is your name?")
name = input()
print("Hello" + name)
```

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

As mentioned earlier, functions `print()` and `input()` were created by Python developers. These functions are part of the Python Standard Library, an extensive set of functionality that's available either automatically or can be easily referenced and added, as needed. The library is divided into modules. Each module contains related functions. You'll learn more about accessing the full breadth of functionality in upcoming modules.

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
- The Python Standard Library contains hundreds of functions that are spread across dozens of modules, supplying common functionality for all developers. Third-party libraries contain additional functionality to extend the capabilities of the programming language.

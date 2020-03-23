The easiest way to learn programming is to write dozens (if not hundreds) of tiny programs that help you understand fundamental ideas and practice crucial techniques.

## What you'll build

In this unit, we start building a program that prints a message to screen by using a single line of code.  This activity requires you to navigate Visual Studio Code and work in the code editor.

### Step 1 - Create a new folder for your first Python project

First, you create a folder structure on your computer where you'll store your work.  

We recommend that you create one folder to contain all of the exercises for each module.  You can call the new parent folder anything you like, such as *python* or *learn*.  Use the tools and techniques you're comfortable with, and create it in a place on your hard drive that's easy to find.  

Second, in your top-level folder, you create a subfolder for the exercise files you'll work with in this module.  You can call the new child folder anything you like, such as *hello*.

In upcoming Python modules, when you're instructed to create a new folder, be sure to create new subfolders as children to the parent folder you're creating in this step.

### Step 2 - Open Visual Studio Code

Use the technique you're comfortable with to open Visual Studio Code from your operating system.

### Step 3 - Open the folder you just created

In Visual Studio Code, select **File** > **Open Folder**.  

In the **Open Folder** window, look for and select the folder that you created in Step 1.

The name of the folder is listed in the left pane of Explorer view.

### Step 4 - Create and save a new file

Select **File** > **New File**.  This adds a new tab titled "Untitled-1" in the editor pane.

Select **File** > **Save As**, and then name the file *hello.py*.

### Step 5 - Add code to the file

The new *hello.py* file is empty. In the editor pane, type the following code:

```python
print("Hello World!")
```

> [!Important]
> Enter the code exactly as you see it here, typing the parentheses and quotation marks in the correct order and using lowercase letters for the word *print*.  If you type even one character incorrectly, it could cause your program to have an error and not work.

### Step 6 - Save the file and execute your program

After typing the code, select **File** > **Save**.

> [!Note]
> You can see that your file needs to be saved if there's a white dot to the right of the file name on the tab.

To execute your program, select the green arrow to the right of the tabs.  If you hover over the arrow, you'll see the tooltip "Run Python File in Terminal."  That lets you know you're in the right place.

![alt text](../media/2-exercise-hello-world-03.png "The Visual Studio Code green arrow button")

When the code is run, two lines appear in the **Terminal** window:

* The first line is the command to compile and execute the code file.  

  ```output
  C:\python\hello>C:/Users/<user>/AppData/Local/Programs/Python/Python38-32/python.exe c:/python/hello/hello.py
  ```

  > [!NOTE] 
  > The output varies depending on your operating system.  Also, from Windows, your path will be different.  For *\<user>*, substitute your user name.

* The other line printed to the Terminal window appears below the code window:

  ```output
  Hello World!
  ```
Success!

### Wait, I got an error

It's possible to experience an error when you attempt to run the code.  This can happen for many different reasons.

For example, you might have used an uppercase *P* instead of a lowercase *p* in *print*, as shown:

```python
Print("Hello World!")
```
An uppercase *P* would produce the following error message in your output:

```output
Traceback (most recent call last):
  File "c:/python/hello/hello.py", line 1, in <module>
    Print("Hello World!")
NameError: name 'Print' is not defined
```

As discussed earlier, you must be precise when writing code.  Python is case-sensitive, which means that *print* and *Print* are two different things, and there's no function called `Print` with an uppercase *P*.

Fortunately, Visual Studio Code can help you spot mistakes like this before you run the code.  You should see a red squiggly line under *Print*.  If you hover over the word, a tooltip displays the phrase "Undefined variable 'Print'".  The specific message requires more explanation, but for now you can at least spot potential problems in your code.

![alt text](../media/2-exercise-hello-world-01.png "The word "Print" with a red squiggly line")

> [!Important]
> You must save the changes to your file to remove the red squiggly line.

You can use this same technique to locate other types of issues in your code.  For example, let's say you transposed the order of certain characters, such as the closing parenthesis and closing quotation mark, as shown here:

```python
print("Hello World!)"
```
If you were to run the code, you would see the following error message:

```output
  File "c:/python/hello/hello.py", line 2

                         ^
SyntaxError: unexpected EOF while parsing
```
Here again, the error message may not be meaningful yet, but after you save the file, Visual Studio Code adds a red squiggly line under the closing quotation mark, which should at least provide a useful clue as you self-diagnose the error.

The reason this doesn't work is because it doesn't follow the syntax rules of Python.  Syntax is similar to grammar in a human-language.  We'll explain the reason this violates Python's syntax rules in just a moment.

Some errors are easy to spot and easy to fix.  Others require a bit more effort.  Suppose you used a set of square brackets instead of a set of parenthesis like so:

```python
print["Hello World!"]
```
Once you save the file, you will see a red squiggly line under *print*.  This time when you hover over the red squiggly line, you see a large dialog with additional information.  

![alt text](../media/2-exercise-hello-world-02.png "Screenshot of Visual Studio Code as the mouse hovers over a red squiggly line to reveal a large message box filled with reference information about the print command and an error message")

We'll talk about what all this information means in another module, but let's just skip over it for now since it's a bit advanced at this point.  The main takeaway is that there's a problem with the code.

When you run the program, you see the following error message in the output.

```output
Traceback (most recent call last):
  File "c:/python/hello/hello.py", line 1, in <module>
    print["Hello World!"]
TypeError: 'builtin_function_or_function' object is not subscriptable
```
Unfortunately, this error message isn't helpful because it doesn't just come out and tell you the exact problem: that you need to replace the square brackets for a set of parenthesis.

In these situations, you will need to lean on your knowledge of Python and your keen eye to spot the problem -- that you cannot use square brackets when invoking a function.  You must use a set of parenthesis.

You gain both the knowledge and the keen eye through experience.  It may seem daunting at first, but with practice you will master this and much more.

## How did your program work?

You invoked a **function** named `print`.  A function contains code that works together to complete a single task in a software system.  The function is given a name so that you can call it by its name to invoke its functionality.  The `print` function's only job is to send information to output, and that output may be displayed via a command line or terminal window.

To invoke a function, we must use a set of parentheses called the function invocation operators.  This is our instruction to the Python interpreter that we want it to actually execute that function for us.

Later, you'll learn how to create your own functions.  At first, you'll use functions that the creators of Python have created to help you write applications more quickly.  Also, you'll learn how to leverage third-party libraries that dramatically expand the functionality available to your Python programs to perform a vast array of tasks.

Some functions allow you to pass an argument, which the function can use to complete its task.  In this case, we sent the `print` function a **literal string** containing our message `Hello World!`.  We pass arguments inside of the function invocation operators.

A literal string is a hard-coded value containing alphanumeric characters.  In other words, we want to print to output exactly this string of characters: `H`, `e`, `l`, `l`, `o`, an empty space, `W`, and so on.  You define a literal string by using a pair of quotation marks or a pair of single quotation marks.

When the Python compiler evaluates code, it checks for syntax errors and then converts the code into a compact syntax called *bytecode*, which consists of only zeros and ones.  The Python interpreter understands how to read this syntax, and it processes each instruction therein, line by line.  

In our scenario, there's only one line of code.  If there were more, it would work from the top to the bottom. Then, after it has executed the last line, it would exit the program and return control to the operating system.

## Recap

Let's take a moment to recap the most important lessons from this first unit:

- Writing Python code is an exercise in precision.  Use the correct spelling, capitalization, and symbols when typing code.
- Use the `print` function to display textual information to output via a command line or terminal interface.
- A literal string is a string of individual characters that you want to use exactly as written in your program.  You define a literal string by using a pair of quotation marks or a pair of single quotation marks.
- Visual Studio Code makes it easy to create a code file, save your work, and then run your code by using the green arrow icon.
- If your code includes invalid syntax, the Python compiler stops the execution and displays an error.  By using the clues provided by the compiler, you can fix the error and try again.
- When you save your code file, Visual Studio Code analyzes your code and adds a visual clue that helps you spot potential errors before you attempt to execute your program.
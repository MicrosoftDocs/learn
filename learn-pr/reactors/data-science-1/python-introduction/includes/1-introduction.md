Since its first release in 1991, Python has risen to become not just a popular general-purpose programming language, but a preeminent computer language for data science. This learning path will use Python and the Python extension for Visual Studio Code as the primary means of illustrating data-science tools and resources.

> [!Note]
> **Sarah: Conversion feedback**
> 
> The environment set up content is the first module in this learning path and it's extremely short--one unit topic.
> Suggest moving the setup content into this unit topic, or making it the next unit topic in this module.
> Then, duplicate the set up content in the same topic location in all modules in the learning path.
>

Several examples in this learning path draw from the python.org introductory tutorial and examples given in the Python 3 documentation (with edits and amendments). This introduction to Python is written for Python 3.6.7 but is generally applicable to other Python 3.x versions.

Original material from python.org is Copyright (c) 2001-2019 Python Software Foundation.

This learning path makes extensive use of Jupyter Notebooks that run in Visual Studio Code. Visual Studio Code runs on macOS, Linux, and Windows. To get started, follow the instructions in 0-IntroductionAndSetup.

Jupyter Notebooks are divided into cells. Each cell contains either text written in the Markdown markup language or a space in which to write and execute computer code. Because all the code resides inside code cells, you can run each code cell inline rather than using a separate Python interactive window.

> [!Note]
> This learning path is designed to have you copy and run code cells one by one, and several code cells contain deliberate errors for demonstration purposes.

## Comments

Many of the examples in this notebook include comments. Comments in Python start with the hash character (#) and extend to the end of the physical line. A comment may appear at the start of a line or following white space or code, but not within a string literal. A hash character within a string literal is just a hash character. Because comments are there to clarify code and are not interpreted by Python, they may be omitted when typing in examples. For example:

> [!Note]
> **Sarah: Action items**
> 
> - Use the code style for comment that appear on a separate line and not with other syntax?
> We might format these instances as plain text or another style.
>

 
```input
# this is the first comment
spam = 1  # and this is the second comment
          # ... and now a third!
text = "# This is not a comment because it's inside quotes."
print(text)
```

## Try it Yourself
Open the TBD in VS Code. Copy and paste the code snippet from above into a Python code cell Run it and you should get the following 

```output
# This is not a comment because it's inside quotes.
```

Python is an interpreted language, which means that you can interactively use the interpreter to get immediate results. You can see this by using the Python interpreter as a simple calculator: type an expression, and you can see the output immediately.

How can you see the results? The Python interpreter runs inside this notebook. To run the code inside a cell, either click the Run Cell button at the top of the window or press Ctrl+Enter. Try running the contents of the cell below. (Don't worry, we'll cover what the syntax of the Python code means later on in this module.)

Open VS Code and type this into a Python cell:

 
```input
print("Hello, world.")
```

Run the cell and your output should be:

```output
Hello, world.
```

## Learning objectives
<!-- List of learning objectives for this module -->
In this module, you will:

- TBD
- TBD
- TBD

## Prerequisites
<!-- List of prerequisites for this module; otherwise, "None." -->

None.

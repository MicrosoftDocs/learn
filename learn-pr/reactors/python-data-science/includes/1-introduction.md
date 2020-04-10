Since its first release in 1991, Python has risen to become not just a popular general-purpose programming language, but a preeminent computer language for data science. This learning path will use Python and the Python extension for Visual Studio Code as the primary means of illustrating data-science tools and resources.

>
> **Sarah: Action items**
>
> - Search on "TBD" and add content as needed, including Hints for Try it yourself blocks.
>

Several examples in this learning path draw from the [python.org introductory tutorial](https://docs.python.org/3.5/tutorial/introduction.html) and examples given in the [Python 3 documentation](https://docs.python.org/3/) (with edits and amendments). This introduction to Python is written for Python 3.6.7 but is generally applicable to other Python 3.x versions.

Original material from python.org is Copyright (c) 2001-2019 Python Software Foundation.

This learning path makes extensive use of Jupyter Notebooks that run in Visual Studio Code. Visual Studio Code runs on macOS, Linux, and Windows. Throughout this learning path, you will be encouraged to test out Python code in Visual Studio Code (VS Code) by using the Python extension and integrated Jupyter Notebooks.

Jupyter Notebooks are divided into cells. Each cell contains either text written in the Markdown markup language or a space in which to write and execute computer code. Because all the code resides inside code cells, you can run each code cell inline rather than using a separate Python interactive window.

> [!Note]
> This learning path is designed to have you run code cells one by one. As you complete these modules, you are encouraged to copy the code snippets into your VS Code Jupyter Notebook and run each cell one at a time.

## Comments

Many of the examples in this notebook include comments. Comments in Python start with the hash character (#) and extend to the end of the physical line. A comment may appear at the start of a line or following white space or code, but not within a string literal. A hash character within a string literal is just a hash character. Because comments are there to clarify code and are not interpreted by Python, they may be omitted when typing in examples. For example:
 
```Python
# this is the first comment
spam = 1  # and this is the second comment
          # ... and now a third!
text = "# This is not a comment because it's inside quotes."
print(text)
```

The output is:

```Output
# This is not a comment because it's inside quotes.
```

### Try it yourself

Open the TBD in VS Code. Copy and paste the code snippet from above into a Python code cell. Run the code and you should get the following output:

<details>
  <summary>Sarah: TBD Hint <i>(expand to reveal)</i></summary>

  Hint goes here.
</details>

Python is an interpreted language, which means that you can interactively use the interpreter to get immediate results. You can see this by using the Python interpreter as a simple calculator: type an expression, and you can see the output immediately.

How can you see the results? The Python interpreter runs inside this notebook. To run the code inside a cell, either click the **Run Cell** button at the top of the window or press **Ctrl+Enter**.  

Open the Python.ipynb file in VS Code and type this into a Python cell. (Don't worry, we'll cover what the syntax of the Python code means later on in this module.)

```Python
print("Hello, world.")
```

Run the cell and your output should be:

```Output
Hello, world.
```

## Learning objectives

In this module, you will:

- Learn the basics of Python syntax
- Understand Python basic types, variables, and expressions
- Test out functions for Python strings, lists, tuples, and dictionaries
- Understand Python control flow and functions
- Explore advanced list comprehension
- Learn how to import additional Python libraries to your notebook

## Prerequisites

- [Set up your environment](https://github.com/MicrosoftDocs/learn-pr/blob/new-data-science-1/learn-pr/reactors/python-data-science/includes/1-introduction.md#set-up-your-environment)
- [Introduction to NumPy for data science](https://github.com/MicrosoftDocs/learn-pr/blob/new-data-science-1/learn-pr/reactors/numpy-data-science/index.yml)
- [Introduction to pandas for data science](https://github.com/MicrosoftDocs/learn-pr/blob/new-data-science-1/learn-pr/reactors/pandas-data-science/index.yml)

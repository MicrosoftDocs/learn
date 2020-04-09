Since its first release in 1991, Python has risen to become not just a popular general-purpose programming language, but a preeminent computer language for data science. This learning path will use Python and the Python extension for Visual Studio Code as the primary means of illustrating data-science tools and resources.

>
> **Sarah: Action items**
>
> - Search on "TBD" and add content as needed.
>

Several examples in this learning path draw from the [python.org introductory tutorial](https://docs.python.org/3.5/tutorial/introduction.html) and examples given in the [Python 3 documentation](https://docs.python.org/3/) (with edits and amendments). This introduction to Python is written for Python 3.6.7 but is generally applicable to other Python 3.x versions.

Original material from python.org is Copyright (c) 2001-2019 Python Software Foundation.

This learning path makes extensive use of Jupyter Notebooks that run in Visual Studio Code. Visual Studio Code runs on macOS, Linux, and Windows. Throughout this learning path, you will be encouraged to test out Python code in Visual Studio Code (VS Code) by using the Python extension and integrated Jupyter Notebooks.

## Set up your environment

To learn most effectively throughout this learning path, we recommend that you set up your environment so you can follow along. 

Complete these steps to set up your environment:

1. Download and install [VS Code](https://code.visualstudio.com). This is free and works on Windows, Mac, and Linux. Select the stable build for your platform. 
2. Download and install the [Python extension for Visual Studio code](https://marketplace.visualstudio.com/items?itemName=ms-python.python). This will include first installing a supported version of Python.
3. Activate the [Anaconda environment in VS Code](https://code.visualstudio.com/docs/python/jupyter-support) to be able to run Jupyter notebooks.
4. Set up a [Data Science environment in VS Code](https://code.visualstudio.com/docs/python/data-science-tutorial) to be able to use NumPy and Pandas.

## Test your environment

If you have successfully setup your environment with VS Code, Python, Anaconda, and the NumPy and Pandas libraries you should be able to run a Jupyter notebook inside of VS Code.

1. Clone the [Reactor repository](https://github.com/microsoft/Reactors) and open the [Learn/Intro-Python-Data-Science folder](https://github.com/microsoft/Reactors/tree/master/Learn/Intro-python-data-science/README.md) in VS Code.
2. Run the [`Test-Setup-Config.ipynb`](https://github.com/microsoft/Reactors/tree/master/Learn/Intro-python-data-science/Test-Setup-Config.ipynb) file to ensure you're ready to continue through the Learning Path.

*Embedded Video Goes Here*

## Working through this learning path

As you're working through this learning path, you will be encouraged to try out code. Use the files you cloned to do this.

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

## Try it yourself

Open the TBD in VS Code. Copy and paste the code snippet from above into a Python code cell Run it and you should get the following 

```Output
# This is not a comment because it's inside quotes.
```

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

Have Visual Studio Code set up with the Python extension running Jupyter Notebooks. 

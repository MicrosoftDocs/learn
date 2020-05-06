Since its release in 1991, Python has become more than a popular, general-purpose programming language. It's also a preeminent computer language for data science. This learning path uses Python and the Python extension for Visual Studio Code to illustrate data-science tools and resources.

Several examples in this learning path draw from the Python documentation. Material from the [python.org introductory tutorial](https://docs.python.org/3.5/tutorial/introduction.html?azure-portal=true) and examples from the [Python 3 documentation](https://docs.python.org/3/?azure-portal=true) are presented with edits and amendments. Original material from python.org is copyright (c) 2001-2019 Python Software Foundation.

This introduction to Python is written for Python version 3.6.7 but generally applies to other Python 3._x_ versions.

This learning path makes extensive use of Jupyter Notebook, which runs in Visual Studio Code. Visual Studio Code runs on macOS, Linux, and Windows. Throughout the learning path, we encourage you to try out Python code in Visual Studio Code by using the Python extension and integrated Jupyter notebooks.

## Set up your environment

We recommend that you set up your environment so that you can follow along and learn effectively throughout this learning path.

To set up your environment:

1. Download and install [Visual Studio Code](https://code.visualstudio.com?azure-portal=true). It's free and works on Windows, Mac, and Linux. Select the stable build for your platform. 
2. Download and install the [Python extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-python.python?azure-portal=true). This step requires that you first install a supported version of Python.
3. Activate the [Anaconda environment in Visual Studio Code](https://code.visualstudio.com/docs/python/jupyter-support?azure-portal=true) so that you can run Jupyter Notebook.
4. Set up a [Data Science environment in Visual Studio Code](https://code.visualstudio.com/docs/python/data-science-tutorial?azure-portal=true) so that you can use the NumPy and Pandas libraries.

## Test your environment

You've successfully set up your environment with Visual Studio Code, Python, Anaconda, and the NumPy and Pandas libraries. You're now ready to run a Jupyter notebook inside Visual Studio Code.

1. Clone the [Reactor repository](https://github.com/microsoft/Reactors?azure-portal=true) and open the [Learn/Intro-Python-Data-Science folder](https://github.com/microsoft/Reactors/tree/master/Learn/Intro-python-data-science/README.md?azure-portal=true) in Visual Studio Code.
2. Run the [`Test-Setup-Config.ipynb`](https://github.com/microsoft/Reactors/tree/master/Learn/Intro-python-data-science/Test-Setup-Config.ipynb?azure-portal=true) file to ensure that you're ready to continue through the learning path.

<!--*Embedded Video Goes Here*-->

## About this learning path

As you work through this learning path, you're encouraged to try out code. Use the files you cloned for this purpose.

Jupyter notebooks are divided into cells. Each cell contains either text that's written in the Markdown markup language or a space in which to write and execute computer code. Because all the code is inside code cells, you can run each code cell inline instead of using a separate Python interactive window.

> [!Note]
> This learning path has you run code cells one by one. As you complete these modules, we encourage you to copy the code snippets into your Jupyter notebook in Visual Studio Code and run the cells one at a time.

## Comments

Many of the examples in this notebook include comments. In Python, comments start with the hash character (#) and extend to the end of the physical line. A comment might appear at the start of a line or after white space or code, but not within a string literal. A hash character within a string literal is just a hash character. Because comments are there to clarify code and are not interpreted by Python, you can omit them when you type in examples. For example:

```python
# This is the first comment
spam = 1  # and this is the second comment
          # ... and now a third!
text = "# This isn't a comment because it's inside quotation marks."
print(text)
```

The output is:

```Output
# This isn't a comment because it's inside quotation marks.
```

## Try it yourself

Open the Python.ipynb file in Visual Studio Code. Then, copy and paste the preceding code example into a Python code cell. Run the code and you should get the same output as shown in the preceding section.

Python is an interpreted language, which means that you can use the interpreter interactively to get immediate results. For example, you can use the Python interpreter as a simple calculator: type an expression, and you see the output immediately.

How do you see the results? The Python interpreter runs inside this notebook. To run the code inside a cell, either select **Run Cell** at the top of the window or press Ctrl+Enter.

In the Python.ipynb file in Visual Studio Code, enter the aft into a Python cell. (We'll cover what the syntax of the Python code means later on in this module.)

```python
print("Hello, world.")
```

Run the cell. Your output should be:

```Output
Hello, world.
```

## Learning objectives

In this module, you will:

- Learn the basics of Python syntax
- Understand Python basic types, variables, and expressions
- Try out functions for Python strings, lists, tuples, and dictionaries
- Understand Python control flow and functions
- Explore advanced list comprehension
- Learn how to import additional Python libraries to your notebook

## Prerequisites

- None

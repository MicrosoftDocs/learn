The goal of this module is to help you install the software you'll need on your local computer to write Python code.  While there are ways to learn and run Python code solely in your browser, we think you'll gain deeper insights into how Python works by installing the tools locally as a first step.

### What is a programming language?

Programming languages like Python allow you to write instructions that you want the computer to carry out. Each programming language has a different syntax, but after you learn your first programming language and then attempt to learn a second one, you'll quickly realize that they all share many similar ideas. 

A programming language's job is to enable a human to write instructions in a human-readable and understandable way. The instructions you write in a programming language is called "source code", or just "code".

Once you write Python source code, you must use a tool called an interpreter to compile and execute your code on your computer.  Its job is to translate between human-readable code into computer-understandable code.

We'll learn much more about Python syntax and Python tools in the next module in this learning path.  In this module, we'll focus on installing these tools so you can get started.

## Why learn Python?

In the introduction, we noted that Python could be used to build a variety of different applications.  Python is a great general purpose programming language!  However, it excels at some tasks, like:

- **automation and scripting** - Python can be used to tie together several file system, file, data, network, and internet activities into an automated workflow.
- **web-based applications** - Python can be used to build dynamic database-backed web applications like a Content Management System, eCommerce application or Web API.
- **data science** - Python can be used to load data from sources, perform analysis on the data, and present the data in meaningful ways.

Another reason to learn Python is because it's widely considered as one of the easiest programming languages to learn.

## How do I get started?

Before you can begin writing Python code, you'll need to install a few tools on your local computer.  You'll need:

- Python 3, which contains the interpreter that compiles and executes your code, additional code libraries and other useful tools for Python developers.  It's possible you already have it installed.  In a moment, we'll check whether you have it installed.
- A code editor, ideally one with features that can help you write Python code.  In this module, we'll walk through the installation of Visual Studio Code, one of the most popular free code editors.

### Python 2 versus Python 3

In this module, we make an effort to distinguish between Python versions 2 and 3.  This is because the creators of Python discourage developers from using Python 2 from now on.  Significant improvements were made in Python version 3 and some of those changes impacted code that was written originally using Python version 2.

The key idea is that you want to use Python version 3 from now on.

![Note]
Why is it important to emphasize the need to use Python version 3?  Computers running macOS and some distributions of Linux have Python 2 pre-installed, so you'll need to take extra steps to install Python 3.

### How do I know if I already have Python 3 installed on my computer?

It's possible you already have Python 3 installed on your computer.  Sometimes this can happen because another application installed Python 3 without your awareness.

Select the appropriate tab below that represents your operating system.

::: zone pivot="windows"

### Windows

To determine if your Windows computer already has Python 3 installed:

- Open a command prompt by typing `Command Prompt` in the Windows 10 search bar, then select the Command Prompt App from the "Best Match" section of the results.
- Type the following command and select the `Enter` key:

```console
py --version
```
It's likely that executing `py --version` will produce no output at all.  This means that no version of Python has been installed on your computer.  We'll walk through installation of Python 3 on Windows in the next unit.

However, if you see the word `Python` with a set of numbers separated with the `.` character, then some version of Python has been installed.  Here's an example of the output you might see.

```output
Python 3.8.0
```
As long as the first of the three numbers is `3`, you're all set.  There's nothing more to do.  You can skip the next unit where we install Python on Windows.

If the first of the three numbers is `2`, then you'll need to install Python 3.  We'll walk through installation of Python 3 in the next unit.

::: zone-end

::: zone pivot="linux"

### Linux

To determine if your Linux computer already has Python 3 installed:

- Open a Linux terminal session.  The way you do this is different depending on your distribution and version of Linux.  Consult the online documentation for your Linux distribution for instructions on how to open a terminal.
- Type the following command and select the `Enter` or `Return` key on your keyboard:

```bash
python3 --version
```

You might see the word `Python` with a set of numbers separated with the `.` character.  Here's an example of the output you might see:

```output
Python 3.6.7
```
As long as the first of the three numbers is `3`, you're all set.  There's nothing more to do.

Python is pre-installed on some Linux distributions (like Ubuntu).  Even if it's not the most up-to-date version, you'll be able to follow along in all of these beginner-focused Python modules on Microsoft Learn.

However, on other Linux distributions Python 3 is not installed by default, so you might see some other message.  Here's the output you would see on Debian version 10:

```output
-bash: python3: command not found
```
In this case, you'll need to install Python 3.  We'll walk through the installation of Python 3 on Linux in the next unit.

::: zone-end

::: zone pivot="macos"

### macOS

To determine if your macOS computer already has Python 3 installed:

- Open the Terminal app.  To locate and launch it, you can use the `command` + `[space bar]` key combination to search using Spotlight.  In the search bar, type `Terminal`.  This should highlight the Terminal app in the results.  Use the `[return]` key to launch the app.
- Type the following instruction at the command prompt:

```bash
python3 --version
```

You might see the word `Python` with a set of numbers separated with the `.` character.  Here's an example of the output you might see:

```output
Python 3.6.7
```
As long as the first of the three numbers is `3`, you're all set.  There's nothing more to do.

Python 3 is **not** pre-installed on macOS, but it's possible that you or some program you use installed Python 3.  Even if it's not the most up-to-date version, you'll be able to follow along in all of these beginner-focused Python modules on Microsoft Learn.

However, it's likely that you saw the following output instead.

```output
command not found
```

We'll walk through installation of Python 3 on macOS in the next unit.

::: zone-end

## Recap

The main takeaway from this unit is that Python version 2 should no longer be used and you should write new code using Python version 3 from now on.  You should always use Python's `--version` flag to be sure you know which version of Python you're currently working with.
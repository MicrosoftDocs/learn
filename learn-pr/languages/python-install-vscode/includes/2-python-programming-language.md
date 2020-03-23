As you learned in the previous module, before you can begin writing Python code, you'll need to install a few tools on your local computer. You'll need:

- The Python installer, which contains the interpreter that compiles and runs your code, additional code libraries, and other useful tools for Python developers. You might already have it installed. In a moment, we'll check whether you have it installed.

- A code editor, ideally one that has features that can help you write Python code. In this module, we'll walk through the installation of Visual Studio Code, one of the most popular free code editors. We'll also install the Python extension for Visual Studio Code to add enhanced functionality.

### Python 2 vs. Python 3

In this module, we make an effort to distinguish between Python version 2 and Python version 3. We make this distinction because the creators of Python discourage developers from using Python 2. Significant improvements were made in Python 3, and some of those changes affected code that was written years ago in Python 2.

The key idea is that you want to use Python 3 from now on.

> [!NOTE]
> Why is it important to emphasize the need to use Python 3? Computers that run macOS and some distributions of Linux have Python 2 pre-installed on them, so you'll need to take extra steps to install Python 3.

### How do I know if I already have Python 3 installed on my computer?

It's possible you already have Python 3 installed on your computer. Sometimes an application will install Python 3 without you knowing about it.

At the top of this page, select the tab that represents your operating system.

::: zone pivot="windows"

### Windows

To determine if your Windows computer already has Python 3 installed:

1. Open a command prompt by entering **command prompt** in the Windows 10 search box and selecting the **Command Prompt App** in the **Best match** section of the results.
1. Enter the following command and then select the <kbd>Enter</kbd> key:

```console
py --version
```
Running `py --version` probably won't produce any output. If you don't get any output, you don't have any version of Python on your computer. We'll walk through the installation of Python 3 on Windows in the next unit.

But if you see the word `Python` with a set of numbers separated by `.` characters, some version of Python is installed. Here's an example of the output you might see:

```output
Python 3.8.0
```
As long as the first number is `3`, you're all set.  There's nothing more to do. You can skip the next unit, where we install Python on Windows.

If the first number is `2`, you'll need to install Python 3. We'll walk through installation of Python 3 in the next unit.

::: zone-end

::: zone pivot="linux"

### Linux

To determine if your Linux computer already has Python 3 installed:

- Open a Linux terminal session. The instructions for opening this session depend on your distribution and version of Linux. Consult the online documentation for your Linux distribution for instructions on how to open a terminal.
- Enter the following command and then select the <kbd>Enter</kbd> key on your keyboard:

```bash
python3 --version
```

You might see the word `Python` with a set of numbers separated by `.` characters. Here's an example of the output you might see:

```output
Python 3.6.7
```
As long as the first number is `3`, you're all set. There's nothing more to do.

Python is pre-installed on some Linux distributions (like Ubuntu). Even if you don't have the most up-to-date version, you'll be able to follow along in all of these beginner Python modules on Microsoft Learn.

On other Linux distributions, Python 3 isn't installed by default, so you might see some other message. Here's the output you would see on Debian version 10:

```output
-bash: python3: command not found
```
In this case, you'll need to install Python 3. We'll walk through the installation of Python 3 on Linux in the next unit.

::: zone-end

::: zone pivot="macos"

### macOS

To determine if your macOS computer already has Python 3 installed:

- Open the Terminal app. To locate and start it, you can use the <kbd>Command</kbd> + <kbd>Spacebar</kbd> key combination to search by using Spotlight.  In the search box, enter **Terminal**. You should see the Terminal app in the results. Use the <kbd>Return</kbd> key to start the app.
- Enter the following command at the command prompt:

```bash
python3 --version
```

You might see the word `Python` with a set of numbers separated by `.` characters.  Here's an example of the output you might see:

```output
Python 3.6.7
```
As long as the first number is `3`, you're all set. There's nothing more to do.

Python 3 isn't pre-installed on macOS, but it's possible that you or a program you use has installed Python 3. Even if you don't have the most up-to-date version, you can still follow along with the beginner Python modules on Microsoft Learn.

It's more likely that you see this output:

```output
command not found
```

We'll walk through installation of Python 3 on macOS in the next unit.

::: zone-end

## Recap

The main takeaway from this unit is that Python version 2 should no longer be used. You should write new code by using Python version 3 from now on.  Use Python's `--version` flag to be sure you know which version of Python you're working with.
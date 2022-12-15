Before you can begin writing Python code, you'll need to install a few tools on your local computer. You'll need the Python interpreter that compiles and runs your code, and a code editor with features that can help you write Python code. In this module, you'll install and configure the necessary tooling.

## Python versions

In this module, we make an effort to distinguish between Python version 2 and Python version 3. We make this distinction because [Python 2](https://www.python.org/doc/sunset-python-2/) was discontinued in 2020. The key idea is that you want to use Python 3 from now on.

> [!NOTE]
> Why is it important to emphasize the need to use Python 3? Some systems may have Python 2 pre-installed, so you'll need to take extra steps to install Python 3.

### How do I know if I already have Python 3 installed on my computer?

Your computer may already have Python 3 installed. Sometimes an application will install Python 3 without you knowing about it.

At the top of this page, select the tab that represents your operating system.

::: zone pivot="windows"

### Windows

To determine if your Windows computer already has Python 3:

1. To open the **Command Prompt** app, go to **Start** on the Windows Taskbar.
1. Enter **cmd** in the Windows search box and select the **Command Prompt App** in the **Best match** results.
1. Enter the following command and then press <kbd>Enter</kbd>:

    ```console
    python --version
    ```

    or

    ```console
    py --version
    ```

    > [!NOTE]
    > Running `python --version` or `py --version` may not return a value, or may return an error message stating *'py' is not recognized as an internal or external command, operable program or batch file.* This indicates Python is not installed on your Windows system.

    If you see the word `Python` with a set of numbers separated by `.` characters, some version of Python is installed. Here's an example of the output you might see:

    ```output
        Python 3.10.0
    ```

As long as the first number is `3`, you have Python 3 installed on your computer. Even if you don't have the most up-to-date version, you'll be able to follow along in any of the beginner Python modules on Microsoft Learn.

If the first number is `2` or if you received an error message, you'll need to install Python 3. We'll walk you through installation of Python 3 in the next unit.

::: zone-end

::: zone pivot="linux"

### Linux

Python is pre-installed on most Linux distributions (like Ubuntu).

To determine if your Linux computer already has Python 3 installed:

1. Open a Linux terminal session. The instructions for opening this session depend on your distribution and version of Linux. Check the online documentation for your Linux distribution for instructions on how to open a terminal session.
1. Enter the following command and then press <kbd>Enter</kbd>.

    ```bash
    python3 --version
    ```

    > [!NOTE]
    > Running `python3 --version` may return an error message stating *bash: python3: command not found*. This indicates Python 3 is not installed on your Linux system.

  The output may include the word `Python` with a set of numbers separated by `.` characters, for example:

```output
    Python 3.10.0
```

As long as the first number is `3`, you have Python 3 installed on your computer. Even if you don't have the most up-to-date version, you'll be able to follow along in any of the beginner Python modules on Microsoft Learn.

If you received an error message, you'll need to install Python 3. We'll walk you through installation of Python 3 in the next unit.

::: zone-end

::: zone pivot="macos"

### macOS

To determine if your macOS computer already has Python 3 installed:

1. Open the Terminal app by pressing <kbd>Command</kbd> + <kbd>Spacebar</kbd> key combination to search by using Spotlight.
1. In the search box, enter **Terminal**. In the results set select **Terminal app**, and then press <kbd>Return</kbd> to start the app.

1. At the command prompt, enter the following command:

    ```bash
    python3 --version
    ```

    > [!NOTE]
    > Running `python3 --version` may return an error message stating *command not found*. This indicates Python 3 is not installed on your iOS system.

    You may see the return output contains the word `Python` followed by a set of numbers separated by `.` characters, for example:

    ```output
    Python 3.10.0
    ```

As long as the first number is `3`, you have Python 3 installed on your computer. Even if you don't have the most up-to-date version, you'll be able to follow along in any of the beginner Python modules on Microsoft Learn.

If you received an error message, you'll need to install Python 3. We'll walk through installation of Python 3 in the next unit.

::: zone-end

## Recap

The main takeaways from this unit are:

- Python version 2 should no longer be used. Any new code should be written using Python version 3.
- Use Python's `--version` flag to be sure you know which version of Python you're working with.

A great way to get started with Python is learning how to perform input and output. In Python, the `print` function, which is one of more than 60 functions built into the language, outputs text to the screen. The following statement displays "Hello World!" on the screen:

```python
print('Hello World!')
```

The argument passed to `print` is a *string*, which is one of the fundamental data types in Python used to store and manage text. By default, `print` outputs a newline character at the end of the line so that subsequent output — for example, additional calls to `print` — will start on the next line.

## Try your first Python statement

Python supports an interactive console experience which allows you to type in commands and see the results immediately. This is sometimes referred to as a "Read-Eval-Print-Loop" or REPL. We can try this in the Cloud Shell to the right.

1. Type `python` to start the Python interpreter in the interactive mode.

    ```bash
    python
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. You should see output that looks something like:

    ```output
    Python 3.5.2 (default, Nov 12 2018, 13:43:14)
    [GCC 5.4.0 20160609] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>>
    ```

1. The `>>>` is the interpreter waiting for you to type a Python command. Type the following statement into the interpreter.

    ```python
    print('Hello World!')
    ```

1. It should echo the text directly back to you and then put another prompt waiting for the next command.

    ```output
    Hello World!
    >>>
    ```

## Getting help

The REPL has a built-in help function you can use to lookup keywords and functions. The generalized syntax for this function is:

```python
help([object])
```

Where `[object]` is a specific function or keyword you want help on. Let's try a few examples.

1. Type the following command to get help on the `print` function.

    ```python
    help(print)
    ```

1. This will display the following output:

    ```output
    Help on built-in function print in module builtins:
    
    print(...)
        print(value, ..., sep=' ', end='\n', file=sys.stdout, flush=False)
    
        Prints the values to a stream, or to sys.stdout by default.
        Optional keyword arguments:
        file:  a file-like object (stream); defaults to the current sys.stdout.
        sep:   string inserted between values, default a space.
        end:   string appended after the last value, default a newline.
        flush: whether to forcibly flush the stream.
    ```

1. Type `q` to exit the help screen and return to the interpreter prompt.

### Interactive help console

If you don't pass an argument to the help function, an interactive help facility is started.

1. Type `help()` to enter the interactive help console. This will list some basic instructions on how to use the help system.

1. From here you can just type in the element you're interested in. Type in `string` to get help on the `string` data type. It will display something like:

    ```output
    Help on module string:
    
    NAME
        string - A collection of string constants.
    
    MODULE REFERENCE
        https://docs.python.org/3.5/library/string.html
    
        The following documentation is automatically generated from the Python
        source files.  It may be incomplete, incorrect or include features that
        are considered implementation detail and may vary between Python
        implementations.  When in doubt, consult the module reference at the
        location listed above.
    ```

1. When there is more than one page of output, you can press <kbd>Enter</kbd> to display line-by-line, or <kbd>Space</kbd> to go page-by-page.

1. Once you hit the end of the help screen, type `q` to exit the page. This will return you back to the interactive help prompt.

1. Feel free to explore more things here - for example, you can get a list of Python keywords by typing `keywords`.

1. Once you are done, type `quit` to return to the interactive prompt.
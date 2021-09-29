Sometimes you want to try a piece of a code out, without having to go through creating a file for it first. For those occasions, it's a good idea to use a built-in program called a REPL that lets you type shorter statements and have those statements evaluated.

## The Python REPL

Python supports an interactive console experience, which allows you to type in commands and see the results immediately. This experience is sometimes referred to as a "Read-Eval-Print-Loop" or REPL.

To use the REPL, you type `python` in your console. What you are phased with is a prompt looking like similar to the below output, it waits for you to input commands:

```output
Python 3.9.5 (default, May 27 2021, 19:45:35)
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

### What can it do

With the REPL you can do most things you would be able to do in a code file like for example:

- **Run and evaluate statements**. You can have the REPL evaluate a statement like so:

   ```output
   >>> 1+1
   2
   >>>
   ```

- **Declare variables and functions**. Another thing you can do is to create variables and functions and REPL will remember that they exist, should you try to use them later:

   ```output
   >>> PI = 3.14
   >>> PI
   3.14
   ```

- **Use the built-in help**. Getting help on a topic can be useful as you don't have to leave the editor of your choice, to browsing on the Web, but you can continue to author code.

## Using help

The REPL has a built-in help function you can use to look up keywords and functions. The generalized syntax for this function is:

```python
help([object])
```

Where `[object]` is a specific function or keyword you want help on.

### Interactive help console

If you don't pass an argument to the help function, an interactive help facility is started.

You enter the interactive help console by typing `help()`. This command will list some basic instructions on how to use the help system.

From here, you can just type in the element you're interested in. By, for example,  typing `string` it will display information about the topic `string`, which looks something like the below:

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

When there is more than one page of output, you can press <kbd>Enter</kbd> to display line-by-line, or <kbd>Space</kbd> to go page-by-page.

At the end of the help screen, you can type `q` to exit the page. You will be returned to the back of the interactive help prompt.

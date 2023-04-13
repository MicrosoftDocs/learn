Sometimes you want to try out a piece of a code without having to create a file for it first. For those occasions, it's a good idea to use a built-in program called a REPL, which lets you type shorter statements and have those statements evaluated.

## The Python REPL

Python supports an interactive console experience, which allows you to type in commands and see the results immediately. This experience is sometimes referred to as a "Read-Eval-Print-Loop", or **REPL**.

To use the REPL, type `python` in your console. You'll get a prompt similar to the below output, which then waits for you to input commands:

```output
Python 3.9.14 (main, Oct 29 2022, 22:18:10) 
[GCC 11.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

### What can it do?

With the REPL, you can do most things you would be able to do in a code file. For example:

- **Run and evaluate statements**. You can have the REPL evaluate a statement like so:

   ```output
   >>> 1+1
   2
   >>>
   ```

- **Declare variables and functions**. You can also create variables and functions, and REPL will remember that they exist, should you try to use them later:

   ```output
   >>> PI = 3.14
   >>> PI
   3.14
   ```

- **Use the built-in help**. Getting help on a topic can be useful, as you don't have to leave the editor of your choice, to browsing on the Web, but you can continue to author code.

## Using help

The REPL has a built-in help function you can use to look up keywords and functions. The generalized syntax for this function is:

```python
help([object])
```

Where `[object]` is a specific function or keyword you want help on.

### Interactive help console

If you don't pass an argument to the help function, Python will start an interactive help.

You enter the interactive help console by typing `help()`. This command will list some basic instructions on how to use the help system.

From here, you can just type in the element you're interested in. For example, by typing `string` you'll get information about the topic `string`, which looks something like this:

```output
Help on module string:

NAME
    string - A collection of string constants.

MODULE REFERENCE
    https://docs.python.org/3.9/library/string
    
    The following documentation is automatically generated from the Python
    source files.  It may be incomplete, incorrect or include features that
    are considered implementation detail and may vary between Python
    implementations.  When in doubt, consult the module reference at the
    location listed above.
```

When there is more than one page of output, you can press <kbd>Enter</kbd> to display line-by-line, or <kbd>Space</kbd> to go page-by-page.

At the end of the help screen, you can type `q` to exit the page. You'll be returned to the interactive help prompt.

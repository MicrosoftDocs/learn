Exceptions in Python are a core feature of the language. You might be surprised to read that something that produces errors is highlighted as a feature. This surprise can be because robust software tools don't seem to crash with a traceback (several lines of text that indicate how the error started and ended). 

But exceptions are useful because they help in decision-making by producing descriptive error messages. They can help you handle both expected and unexpected problems.

## Tracebacks

A *traceback* is the body of text that can point to the origin (and ending) of an unhandled error. Understanding the components of a traceback will make you more effective when you're fixing errors or debugging a program that's not working well.

The first time you encounter exceptions in Python, you might be tempted to avoid the error by suppressing it. When a program suffers an unhandled error, a traceback appears as the output. As you'll see in this module, tracebacks are useful. There are ways to properly handle the errors so that they don't appear or they only show helpful information.

Open a Python interactive session and try opening a nonexistent file:

```python
open("/path/to/mars.jpg")
```

```Output
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
FileNotFoundError: [Errno 2] No such file or directory: '/path/to/mars.jpg'
```

That output has several key parts. First, the traceback mentions the order of the output. Then it informs you that the file is `stdin` (input in the interactive terminal) on the first line of the input. The error is `FileNotFoundError` (the exception name), which means that the file doesn't exist or perhaps the directory to it doesn't exist.

That's a lot of information. It can be hard  to understand why line 1 is meaningful or what `Errno 2` means.

Open your desired directory in Visual Studio Code and create a Python file named *open.py*.

:::image type="content" source="../media/create-new-file.png" alt-text="Screenshot showing the creation of a new Python file in Visual Studio Code. ":::

Add the following contents to the file and save:

```python
def main():
    open("/path/to/mars.jpg")

if __name__ == '__main__':
    main()
```

It's a single `main()` function that opens the nonexistent file, just like before. At the end, this function uses a Python helper that tells the interpreter to execute the function `main()` when it's called on the terminal. Run the command in a Bash terminal with Python and check the error message:

```bash
python3 open.py
```

```Output
Traceback (most recent call last):
  File "/tmp/open.py", line 5, in <module>
    main()
  File "/tmp/open.py", line 2, in main
    open("/path/to/mars.jpg")
FileNotFoundError: [Errno 2] No such file or directory: '/path/to/mars.jpg'
```

The error output makes more sense now. The paths are pointing to a single file called _open.py_. The output mentions that the error starts on line 5, which includes the call to `main()`. Next, the output follows the error to line 2 in the `open()` function call. And finally, `FileNotFoundError` again reports that the file or the directory doesn't exist.

Tracebacks almost always include the following information:

- All file paths involved, for every call to every function.
- Line numbers associated with every file path.
- The names of functions, methods, or classes involved in producing an exception.
- The name of the exception that was raised.

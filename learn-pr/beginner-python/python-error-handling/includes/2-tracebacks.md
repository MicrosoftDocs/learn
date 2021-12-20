Exceptions in Python are a core feature of the language. You might be surprised to read that the one thing that produces errors is highlighted as a feature. This surprise can be because robust software tools don't seem to crash with a traceback (several lines of text indicating how the error started and ended). But exceptions are a useful feature because they help in decision making, producing useful error messages, and handle both expected and unexpected problems.


## Tracebacks

A traceback is the body of text that can point to the origin (and ending) of an unhandled error. Understanding the components of a traceback will make you more effective when fixing errors or debugging a program that is not working well.

The first time you encounter exceptions in Python you might be tempted to avoid the error by suppressing it. When a program suffers an unhandled error, a traceback is produced as output. As you'll see in this module, tracebacks are useful, and there are ways to properly handle the errors so that they don't show, or show useful information.

Open up a Python interactive session and try opening a non-existent file:

```python
>>> open("/path/to/mars.jpg")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
FileNotFoundError: [Errno 2] No such file or directory: '/path/to/mars.jpg'
```

There are several key parts in that output. First, the traceback mentions the order of the output, then it informs that the file is `stdin` (input in the interactive terminal), on the first line of the input, and the error is a `FileNotFoundError` (the exception name) which means that the file doesn't exist or perhaps the directory to it doesn't exist.

That is a lot of information, and it can be difficult to understand why _line 1_ is meaningful or what `Errno 2` means. Create a new Python file and name it `open.py`, with the following contents:

```python
def main():
    open("/path/to/mars.jpg")

if __name__ == '__main__':
    main()
```

It's a single `main()` function that opens the non-existent file, just like before. At the end, it uses a Python helper that tells the interpreter to execute the function `main()` when called on the terminal. Run it with Python and check the error message:

```
$ python3 open.py
Traceback (most recent call last):
  File "/tmp/open.py", line 5, in <module>
    main()
  File "/tmp/open.py", line 2, in main
    open("/path/to/mars.jpg")
FileNotFoundError: [Errno 2] No such file or directory: '/path/to/mars.jpg'
```

The error output makes more sense now. The paths are pointing to a single file called _open.py_ and it mentions that the error starts on line 5, where the call to `main()` is done. Next, it follows the error to line 2 in the `open()` function call. And finally, the `FileNotFoundError`, just as before, reports that the file or the directory doesn't exist.

Tracebacks will almost always include the following information:

- All file paths involved, for every call to every function
- Line numbers associated with every file path
- The names of functions, methods, or classes involved in producing an exception
- The name of the exception that was raised
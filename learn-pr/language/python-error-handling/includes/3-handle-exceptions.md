When you first find exceptions that show large tracebacks as output, you might be tempted to catch every error to prevent that from happening. 

If you're in a mission to Mars, what could you do if a text on the navigation system reads _"an error occurred"_? Imagine that there's no other information or context, just a blinking red light with the error text. As a developer, it's useful to put yourself on the other side of the program: what can a user do when there's an error?

Although this module covers how to handle exceptions by catching them, it's not necessary to catch exceptions all the time. Sometimes it's useful to let exceptions be raised so other callers can deal with the errors.

## Try and except blocks

Let's use the navigator example to create code that opens configuration files for the Mars mission. Configuration files can have all kinds of problems, so it's critical to report problems accurately when they come up. We know that if a file or directory doesn't exist, `FileNotFoundError` is raised. If we want to handle that exception, we can do that with a `try` and `except` block:

```python
try:
     open('config.txt')
except FileNotFoundError:
     print("Couldn't find the config.txt file!")

```

```Output
Couldn't find the config.txt file!
```

After the `try` keyword, you add code that has the potential to cause an exception. Next, you add the `except` keyword along with the possible exception, followed by any code that needs to run when that condition happens. Because _config.txt_ doesn't exist in the system, Python prints that the configuration file is not there. The `try` and `except` block, along with a helpful message, prevents a traceback and still informs the user about the problem.

Although a file that doesn't exist is common, it isn't the only error you might find. Invalid file permissions can prevent reading a file, even if the file exists. Let's create a new Python file called _config.py_ in Visual Studio Code. Add the following code to the file that finds and reads the navigation system's configuration file:

```python
def main():
    try:
        configuration = open('config.txt')
    except FileNotFoundError:
        print("Couldn't find the config.txt file!")


if __name__ == '__main__':
    main()
```

Next, create a _directory_ called _config.txt_. Try calling the _config.py_ file to see a new error that should be similar to this one:

```bash
python3 config.py
````

```Output
Traceback (most recent call last):
  File "/tmp/config.py", line 9, in <module>
    main()
  File "/tmp/config.py", line 3, in main
    configuration = open('config.txt')
IsADirectoryError: [Errno 21] Is a directory: 'config.txt'
```

A useless way of handling this error would be to catch all possible exceptions to prevent a traceback. To understand why catching all exceptions is problematic, try it by updating the `main()` function in the newly created *config.py* file:

```python
def main():
    try:
        configuration = open('config.txt')
    except Exception:
        print("Couldn't find the config.txt file!")
```

Now run the code again in the same place where the _config.txt_ directory exists with improper permissions:

```bash
python3 config.py
```

```Output
Couldn't find the config.txt file!
```

The problem now is that the error message is incorrect. The directory does exist, but it has different permissions and Python can't read it. When you're dealing with software errors, it can be frustrating to have errors that:

- Don't indicate what the real problem is.
- Give output that doesn't match the actual problem.
- Don't hint at what can be done to fix the problem.

Let's fix this piece of code to address all these frustrations. Revert to catching `FileNotFoundError`, and then add another `except` block to catch `PermissionError`:

```python
def main():
    try:
        configuration = open('config.txt')
    except FileNotFoundError:
        print("Couldn't find the config.txt file!")
    except IsADirectoryError:
        print("Found config.txt but it is a directory, couldn't read it")
```

Now run it again, in the same place where the _config.txt_ directory is: 

```bash
python3 config.py
```

```Output
Found config.txt but couldn't read it
```

Now delete the _config.txt_ directory to ensure that the first `except` block will be reached instead:

```bash
 rm -f config.txt
 python3 config.py
```

```Output
Couldn't find the config.txt file!
```

When errors are of a similar nature and there's no need to handle them individually, you can group the exceptions together as one by using parentheses in the `except` line. For example, if the navigation system is under heavy loads and the file system becomes too busy, it makes sense to catch `BlockingIOError` and `TimeOutError` together:

```python
def main():
    try:
        configuration = open('config.txt')
    except FileNotFoundError:
        print("Couldn't find the config.txt file!")
    except IsADirectoryError:
        print("Found config.txt but it is a directory, couldn't read it")
    except (BlockingIOError, TimeoutError):
        print("Filesystem under heavy load, can't complete reading configuration file")
```

> [!TIP]
> Even though you can group exceptions together, do so only when there's no need to handle them individually. Avoid grouping many exceptions together to provide a generalized error message.

If you need to access the error that's associated with the exception, you must update the `except` line to include the `as` keyword. This technique is handy if an exception is too generic and the error message can be useful:

```python
try:
    open("mars.jpg")
except FileNotFoundError as err:
     print("Got a problem trying to read the file:", err)
```

```Output
Got a problem trying to read the file: [Errno 2] No such file or directory: 'mars.jpg'
```

In this case, `as err` means that `err` becomes a variable with the exception object as a value. It then uses this value to print the error message that's associated with the exception. Another reason to use this technique is to access attributes of the error directly. For example, if you're catching a more generic `OSError` exception, which is the _parent exception_ of both `FilenotFoundError` and `PermissionError`, you can tell them apart by the `.errno` attribute:

```python
try:
    open("config.txt")
except OSError as err:
     if err.errno == 2:
         print("Couldn't find the config.txt file!")
     elif err.errno == 13:
        print("Found config.txt but couldn't read it")
```

```Output
Couldn't find the config.txt file!
```

Always try to use the technique that provides the best readability for the code and helps maintain it in the future. Sometimes it's necessary to use less readable code to offer a better user experience when an error happens.


To work with a file in Python, you first need to **open** it. Opening a file gives you a file object you can read from or write to. When you're finished, you need to **close** the file so the operating system can release its resources and any pending writes are saved.

## The problem with forgetting to close a file

You can open a file with `open()` and close it with `.close()`:

```python
file = open("notes.txt", "r")
contents = file.read()
print(contents)
file.close()
```

The problem is that if an error happens after `open()` but before `.close()`, the file stays open—which can lead to lost data, locked files, or resource leaks.

## Using the `with` statement

The safer, more Pythonic way to work with files is the `with` statement. It uses a feature called a **context manager** that automatically closes the file when the block finishes—even if an error occurs.

```python
with open("notes.txt", "r") as file:
    contents = file.read()
    print(contents)
# File is automatically closed here
```

Everything after `as` is the name you give the file object inside the block. Once the block ends, the file is closed for you.

## File modes

The second argument to `open()` is the **mode**, which tells Python what you plan to do with the file:

| Mode | Meaning |
|---|---|
| `"r"` | Read (default). The file must already exist. |
| `"w"` | Write. Creates a new file, or overwrites the existing one. |
| `"a"` | Append. Adds to the end of the file, or creates it if missing. |
| `"r+"` | Read and write. |

Pick the mode that matches what you want to do—using the wrong mode is a common cause of accidentally erased files.

## A safer default

For the rest of this module, always open files using `with`. It's the safest pattern and the one you'll see in almost every real Python codebase.
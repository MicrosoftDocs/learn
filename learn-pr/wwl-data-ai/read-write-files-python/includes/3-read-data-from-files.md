

Python gives you several ways to read text from a file. The best choice depends on the size of the file and what you want to do with it.

## Read the entire file at once

The `.read()` method returns the entire file as a single string:

```python
with open("notes.txt", "r") as file:
    contents = file.read()

print(contents)
```

This approach works well for small files, but for very large files it loads everything into memory at once.

> [!NOTE]
> If the file doesn't exist, `open()` in read mode raises a `FileNotFoundError`. Be sure the file exists before you try to read it!

## Read the file as a list of lines

The `.readlines()` method returns each line as a separate string in a list. Each string keeps the newline character (`\n`) at the end.

```python
with open("notes.txt", "r") as file:
    lines = file.readlines()

for line in lines:
    print(line.strip())   # .strip() removes the trailing newline
```

## Read one line at a time

The most memory-friendly way is to iterate over the file object directly. Python reads one line per loop:

```python
with open("notes.txt", "r") as file:
    for line in file:
        print(line.strip())
```

This pattern is recommended for large files because only one line is held in memory at a time.

## Choosing the right approach

| If you want to... | Use... |
|---|---|
| Work with the entire file as one string | `.read()` |
| Get a list of lines you can index into | `.readlines()` |
| Process each line one at a time efficiently | `for line in file` |

Writing to a file lets your program save results, keep logs, or persist data between runs. Python offers two main modes for putting data into a file: **write** and **append**.

## Writing to a file with `"w"`

Opening a file in write mode (`"w"`) creates a new file—or **completely overwrites** any existing file with the same name. Use the `.write()` method to add text:

```python
with open("greeting.txt", "w") as file:
    file.write("Hello, world!\n")
    file.write("Welcome to Python.\n")
```

> [!WARNING]
> Write mode erases the file the moment it's opened. Only use `"w"` when you're sure you want to replace the file's contents.

Notice the `\n` at the end of each string. Unlike `print()`, `.write()` doesn't add a newline for you.

## Appending to a file with `"a"`

Opening a file in append mode (`"a"`) adds to the **end** of the file, keeping anything that's already there. If the file doesn't exist yet, Python creates it.

```python
with open("log.txt", "a") as file:
    file.write("New entry added.\n")
```

Append mode is a good fit for log files, notes, and any data you want to build up over time.

## Writing multiple lines

To write a list of strings at once, use `.writelines()`. Just remember that it doesn't add newlines—you need to include them yourself:

```python
tasks = ["Buy groceries\n", "Walk the dog\n", "Finish homework\n"]

with open("tasks.txt", "w") as file:
    file.writelines(tasks)
```

## Choosing between write and append

| Use `"w"` when... | Use `"a"` when... |
|---|---|
| You want to start fresh each time | You want to keep the existing content |
| You're saving the final result of a process | You're recording new events or entries |
| Overwriting is intentional | Preserving history matters |
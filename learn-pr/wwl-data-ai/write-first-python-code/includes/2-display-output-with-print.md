
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=3ad21eed-096a-462a-8b4a-d75ffee19b58]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

The most fundamental thing a program can do is communicate with you. In Python, you display output to the screen using the built-in `print()` function.

## Using print()

The `print()` function outputs text to the console. You call it by passing the text you want to display inside parentheses, enclosed in quotes:

```python
print("Hello, world!")
```

Output:

```output
Hello, world!
```

You can try running this code yourself in an online python interpreter at [https://aka.ms/python-coder](https://aka.ms/python-coder). 

### Single vs. double quotes

Python doesn't care if you use single quotes (`'`) or double quotes (`"`), as long as you match them up. For example, `print('Hello, world!') works the exact same way.

### Avoid missing quotes

If you want to print words, you **must** use quotes. Omitting them tells Python to look for a variable instead of text. A variable acts as a container for a value. For example:

```python
# This code is missing quotes around the text
print(Hello)
```

This code results in an error `NameError: name 'Hello' is not defined`. Don't panic if you see this; it just means Python is looking for a container that doesn't exist yet!

> [!NOTE]
> The `#` symbol is used to add comments to your code. Comments are notes for humans reading the code, and Python ignores them when running the program.

## Printing multiple items

You can pass multiple values to `print()` by separating them with commas. Python automatically inserts a space between each item for you, which is great for combining text:

```python
print("Hello", "world!")
```

Output:

```output
Hello world!
```

## Using escape characters

Adding a space between items is helpful, but sometimes you need more control over how your text is formatted, like starting a new line, adding a tab space, or including quotation marks inside your text. You can't just press <kbd>Enter</kbd> or <kbd>Tab</kbd> inside your quotes to do this. Instead, Python uses **escape characters**, which act as secret commands inside your text. They always start with a **backslash (`\`)**:

| Escape sequence | What it does | Example | Output |
|---|---|---|---|
| `\n` | Moves text to a new line | `print("Line 1\nLine 2")` | `Line 1`<br>`Line 2` |
| `\t` | Adds a tab space | `print("Name:\tAlex")` | `Name:   Alex` |
| `\\` | Prints a literal backslash | `print("C:\\Users")` | `C:\Users` |
| `\"` | Prints a double quote | `print("She said, \"Hi!\"")` | `She said, "Hi!"` |

Make sure to use the backslash (`\`) and not the forward slash (`/`). Typing `/n` will just print `/n` on your screen.

::: zone-end

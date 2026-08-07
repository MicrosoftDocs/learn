
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=c45fc831-d02e-4f7b-be0e-48885c81d2ec]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"



Text is one of the most common types of data in programming. In Python, text is represented as a **string**—a sequence of characters enclosed in single or double quotes. Python provides many built-in ways to manipulate and format strings.

## Concatenation (gluing strings together)

You can join two or more strings together into a single string using the `+` operator:

```python
first = "Hello"
last = "world"
message = first + ", " + last + "!"
print(message)
```

Output:
```output
Hello, world!
```

While concatenation works great for simple combinations, it can become complicated when you try to mix variables, punctuation, and spaces together.

## A better way: f-strings

A cleaner, modern way to combine strings and variables is with an **f-string** (short for formatted string). To create this kind of string, place the letter `f` directly outside your opening quotes, and place any variable names inside curly braces `{}`:

```python
name = "Alex"
print(f"Hello, {name}!")
```

Output:
```output
Hello, Alex!
```

You can try running this code yourself in an online python interpreter at [https://aka.ms/python-coder](https://aka.ms/python-coder). 

### No more Type Errors

In the previous unit, we saw how `input() + 1` resulted in a `TypeError` because Python can't mix text and numbers. F-strings solve this problem. In an f-string, Python automatically formats numbers inside curly braces into text:

```python
age = input("How old are you? ")
print(f"Next year you will be {age + 1}") # Works perfectly!
```

> [!NOTE]
> If you forget the `f` prefix (e.g., `print("Hello, {name}")`), Python won't look inside the braces—it will literally print `{name}` on the screen.

## Common string methods

Python strings have many built-in methods for common operations:

| Method | What it does | Example | Result |
|---|---|---|---|
| `.upper()` | Converts text to uppercase | `"hello".upper()` | `"HELLO"` |
| `.lower()` | Converts text to lowercase | `"HELLO".lower()` | `"hello"` |
| `.strip()` | Trims accidental blank spaces from the ends | `" hi ".strip()` | `"hi"` |
| `.replace(old, new)` | Swaps out specific characters | `"cat".replace("c", "b")` | `"bat"` |

## Counting characters with len()

To find the total number of characters (including spaces and punctuation) in a string, use the standalone `len()` function. Notice that the text goes inside the parentheses:

```python
username = "Alex!"
print(len(username)) # Output: 5
```

## String methods return a new string

String methods don't modify your original variable. Instead, they create a **brand-new copy** of the altered text.

Look at this behavior:

```python
greeting = "hello"
greeting.upper()
print(greeting) # Output is STILL lowercase "hello"!
```

If you want to keep the changes, you must overwrite the old variable or save the result to a new one:

```python
greeting = "hello"
greeting = greeting.upper() # Saving the new uppercase copy
print(greeting) # Output: "HELLO"
```

::: zone-end


::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=5d9c4b8c-b251-4fcc-911c-61b73684c527]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Programs become truly powerful when they can interact with the people using them. Python's built-in `input()` function lets you pause your program, wait for the user to type something, and capture that information.

## Using input()

Think of the `input()` function as a question prompt. When Python hits this line, it waits  until the user types their answer and presses the **Enter** key before continuing with the rest of the code.

To save their answer, you must "catch" it using a variable:

```python
favorite_color = input("What is your favorite color? ")
print("Oh, I love", favorite_color, "too!")
```

In this code, `favorite_color` is a variable that catches the user's response. If the user types `Blue` and presses **Enter**, the output is:

```output
What is your favorite color? Blue
Oh, I love Blue too!
```

You can try running this code yourself in an online python interpreter at [https://aka.ms/python-coder](https://aka.ms/python-coder). 

> [!TIP]
> Notice the blank space at the end of the prompt: `"What is your favorite color? "`. When accepting user input, add a space or new line before closing your quotes. If you don't, the user's typing will be glued directly to your text, looking messy like this: 
> `What is your favorite color?Blue`

## A quick word about data types

Before you go further, it helps to know that every value in Python has a **data type**, which is a label that tells Python what kind of value it's working with. For example, some common data types are:

- **String (`str`)**: Text wrapped in quotes, like `"Blue"` or `"25"`. Even a number becomes text when it's inside quotes.
- **Integer (`int`)**: A whole number without quotes, like `25` or `100`. Python can do math with these.

Why does this matter? Python treats these two types very differently. You can add numbers together (`25 + 1` equals `26`), but you can't add a number to text (`"25" + 1` causes an error).

## The input is always text

An essential rule to remember is that the `input()` function *always* returns text, even if the user types a number. For example:

```python
age = input("How old are you? ")
print("Next year you will be", age + 1)
```

If you run this code and type `25`, you might expect it to print `26`. Instead, Python crashes and displays an error message in your console:

```output
TypeError: can only concatenate str (not "int") to str
```

Because the `age` is locked as text, you can't perform math operations on it just yet. 

### How to read this error

Errors are clues to what went wrong in the code. Let's break down these clues:

- `TypeError`: You are trying to mix two data types that don't belong together.
- `can only concatenate str (not "int") to str`: "Concatenate" means to glue text together.
 
Python is saying: "You gave me the text "25", and asked me to glue the number 1 to it. I can glue text to text, but I don't know how to glue a math number to text!"

Because `input()` locks your user's response inside text quotes, Python sees your calculation as "25" + 1, which is an impossible math equation.

::: zone-end

Strings are among the most commonly used data types in Python and in other programming languages. Strings contain text — text output to the screen, retrieved from user input, or read from a CSV file. Knowing how to parse and manipulate strings is an essential skill for any programmer, because virtually every program uses strings in some way. Many of today's most commonly used data formats, including [CSV](https://en.wikipedia.org/wiki/Comma-separated_values), [JSON](https://www.json.org/), and [XML](https://www.w3.org/XML/), use strings to store data.

In the previous lesson, you downloaded a CSV file containing a list of airports all over the world inside Azure Noteboks and wrote some Python code to read the file and create a list of strings from the file's content. In this lesson, you will parse the content that you read and convert the data into a more useful format.

## Working with strings

A string is a collection of zero or more characters. A string with no characters is called an *empty string*. Any text contained within single or double quotation marks is a string value:

```python
message = 'This is a string'
print(message) # outputs: This is a string
```

Strings can be added to other strings (an operation known as "concatenation") with the `+` operator:

```python
message = 'Hello' + ' ' + 'World!'
print(message) # outputs: Hello World!
```

You may use single or double quotation marks to quote strings. There is no difference in the results, or in how the strings are stored internally. You can embed a double quotation mark in a string by enclosing the string itself in single quotes, and you can embed a single quotation mark in a string by enclosing the string in double quotes. If the string contains the same quotation mark as the one used to quote the string, you can escape the embedded quotation mark with a backslash:

```python
message = 'Tim said, \'Hello World!\''
print(message) # outputs: Tim said, 'Hello World!'
```

Strings support slicing using the same syntax used for slicing lists. (Lists and strings are both examples of *sequences* in Python, and slicing can be performed on any sequence.) The following examples demonstrate how slicing is performed and substrings are extracted from other strings:

```python
message = 'This is fun!'
print(message[0]) # outputs T
print(message[0:4]) # outputs This
print(message[:4]) # outputs This
print(message[8:]) # outputs fun!
print(message[8:-1]) # outputs fun
print(message[-4:-1]) # outputs fun
```

Specifying a negative number for a starting or ending index represents an offset from the end of the string. In Python, [:-1] is a clever way to remove the final character from a string. Not surprisingly, [:-2] removes the final two characters, [:-3] removes the final three, and so on.

String slicing will play a large role in parsing the airport data that you loaded in the previous lesson. So will string functions, which can be called to manipulate strings in various ways.

### Using string functions

Strings come with an extensive API (Application Programming Interface) for manipulating them. For example, the `upper` function can be called on any string. It changes a string's characters to all uppercase:

```python
message = 'Hello'
message.upper()
print(message) # outputs: HELLO
```

Similarly, the `lower` function changes the string to all lowercase:

```python
message = 'Hello'
message.lower()
print(message) # outputs: hello
```

The `replace` function replaces a specified sequence of characters in a string with another sequence of characters:

```python
message = 'This is fun!'
message.replace('is', 'was')
print(message) #outputs: This was fun!
```

A common requirement is to split a string containing a collection of strings separated by commas, spaces, or other characters into a list of strings. Here's an example that splits a string containing a list of strings separated by commas into a list of strings using the `split` function:

```python
colors_data = 'red,green,blue'
colors = colors_data.split(',')
print(colors) # outputs: ['red','blue','green']
```

Another example involves combining a list of strings into a single string using the `join` function:

```python
colors = ['red','blue','green']
colors_data = ','.join(colors)
print(colors_data) # outputs: 'red,green,blue'
```

`upper`, `lower`, `replace`, `split`, and `join` are but a few of the 40+ functions that you can call on a string in Python. There's a link to a complete list in the summary. Let's use some of these to process the airport data.
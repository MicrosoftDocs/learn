Besides numbers, Python can also manipulate strings. You can enclose strings in single (') or double (") quotation marks with the same result. Use a backslash (\\) to escape quotation marks that you want to use within the string itself. Here's an example that uses single quotation marks.

```python
'spam eggs'  # Use single quotation marks.
```

The output is:

```Output
'spam eggs'
```

This example uses the backslash:

```python
'doesn\'t'  # Use backslash \' to escape the single quotation mark or apostrophe.
```

The output is:

```Output
"doesn't"
```

This example encloses the apostrophe between double quotation marks:

```python
"doesn't"  # Use double quotation marks to enclose the entire string.
```

The output is:

```Output
"doesn't"
```

In Python's interactive interpreter and Jupyter Notebook in Visual Studio Code, the output string is enclosed in quotation marks, and special characters are escaped by using backslashes. Although this output sometimes looks different from the input (the enclosing quotation marks could change), the two strings are equivalent. The string is enclosed in double quotation marks if the string contains a single quotation mark and no double quotation marks. Otherwise, it’s enclosed in single quotation marks.

The [print()](https://docs.python.org/3.6/library/functions.html#print?azure-portal=true) function produces more readable output by omitting the enclosing quotes and by printing escaped special characters. Here's an example without `print()`:

```python
'"Isn\'t," she said.'
```

The output is:

```Output
'"Isn\'t," she said.'
```

Here's another example that uses `print()`:

```python
print('"Isn\'t," she said.')
```

The output is:

```Output
"Isn't," she said.
```

If you don't want escaped characters (prefaced by a backslash) to be interpreted as special characters, use _raw strings_ by adding an "r" before the first quotation mark. First, here's an example without the "r":

```python
print('C:\some\name')  # Here, the slash before the "n" (\n) means newline!
```

The output is:

```Output
C:\some
ame
```

Here's an example that uses the "r":

```python
print(r'C:\some\name')  # Note the "r" before the single quotation mark.
```

The output is:

```Output
C:\some\name
```

## String literals

String literals can span multiple lines and are delimited by three quotation marks (""") or (''').

Because Python doesn't provide a way to create multiline comments, developers often just use three quotation marks for this purpose. In a Jupyter notebook, however, such quotation marks define a string literal that appears as the output of a code cell:

```python
"""
Everything between the sets of three quotation marks, including new lines,
is part of the multiline comment. Technically, the Python interpreter
sees the comment as simply a string. And, because the string is not otherwise
used in code, it's ignored.
"""
```

The output is:

```Output
"\nEverything between the sets of three quotation marks, including new lines,\nis part of the multiline comment. Technically, the Python interpreter\nsees the comment as simply a string. And, because the string is not otherwise\nused in code, it's ignored.\n"
```

For this reason, it's best in notebooks to use the hash ("#") comment character at the beginning of each line. Better still, just use a Markdown cell outside a code cell in a Jupyter notebook!

Strings can be _concatenated_ (glued together) by using the plus ("+") operator, and repeated by using the multiply ("*") operator:

```python
# 3 times 'un', followed by 'ium'
3 * 'un' + 'ium'
```

The output is:

```Output
'unununium'
```

The order of operations applies to operators in the same way when they're used with strings as when they're used with numeric types. Experiment with different combinations and orders of operators and strings to see what happens.

## Concatenate strings

Two or more _string literals_ placed next to each other are automatically concatenated:

```python
'Py' 'thon'
```

The output is:

```Output
'Python'
```

However, to concatenate variables or a variable and a literal, use the plus ("+") operator:

```python
prefix = 'Py'
prefix + 'thon'
```

The output is:

```Output
'Python'
```

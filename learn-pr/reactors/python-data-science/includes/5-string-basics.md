Besides numbers, Python can also manipulate strings. Strings can be enclosed in single quotes ('...') or double quotes ("...") with the same result. Use backslash (\) to escape quotes; that is, use \ in order to use quotation marks within the string itself:

```Python
'spam eggs'  # Single quotes.
```

```output
'spam eggs'
```

```Python
'doesn\'t'  # Use \' to escape the single quote...
```

```output
"doesn't"
```

```Python
"doesn't"  # ...or use double quotes instead.
```

```output
"doesn't"
```

In Python's interactive interpreter and Jupyter Notebooks in VS Code, the output string is enclosed in quotes and special characters are escaped with backslashes. Although this output sometimes looks different from the input (the enclosing quotes could change), the two strings are equivalent. The string is enclosed in double quotes if the string contains a single quote and no double quotes; otherwise, it’s enclosed in single quotes. The [print()](https://docs.python.org/3.6/library/functions.html#print) function produces a more readable output by omitting the enclosing quotes and by printing escaped and special characters:

```Python
'"Isn\'t," she said.'
```

```output
'"Isn\'t," she said.'
```

```Python
print('"Isn\'t," she said.')
```

```output
"Isn\'t," she said.
```

If you don't want escaped characters (prefaced by \) to be interpreted as special characters, use _raw strings_ by adding an `r` before the first quote:

```Python
print('C:\some\name')  # Here \n means newline!
# Im adding some more comments - woo!
```

```output
C:\some
ame
```

```Python
print(r'C:\some\name')  # Note the r before the quote.
```

```output
C:\some\name
```

## String literals

String literals can span multiple lines and are delineated by triple-quotes: """...""" or '''...'''.

Because Python doesn't provide a means for creating multi-line comments, developers often just use triple quotes for this purpose. In a Jupyter notebook, however, such quotes define a string literal that appears as the output of a code cell:

```Python
"""
Everything between the first three quotes, including new lines,
is part of the multi-line comment. Technically, the Python interpreter
simply sees the comment as a string, and because it's not otherwise
used in code, the string is ignored. Convenient, eh?
"""
```

```output
"\nEverything between the first three quotes, including new lines,\nis part of the multi-line comment. Technically, the Python interpreter\nsimply sees the comment as a string, and because it's not otherwise\nused in code, the string is ignored. Convenient, eh?\n"
```

For this reason, it's best in notebooks to use the # comment character at the beginning of each line, or better still, just use a Markdown cell outside of a code cell in a Jupyter notebook!

Strings can be _concatenated_ (glued together) with the plus (+) operator, and repeated with multiply (*):

```Python
# 3 times 'un', followed by 'ium'
3 * 'un' + 'ium'
```

```output
'unununium'
```

The order of operations applies to operators when they are used with strings as well as numeric types. Try experimenting with different combinations and orders of operators and strings to see what happens.

## Concatenate strings

Two or more _string literals_ placed next to each other are automatically concatenated:

```Python
'Py' 'thon'
```

```output
'Python'
```

However, to concatenate variables or a variable and a literal, use +:

```Python
prefix = 'Py'
prefix + 'thon'
```

```output
'Python'
```

> [!div class="alert is-tip"]
> ### Learning goal
>
> By the end of this unit, you should be comfortable working with strings at a basic level in Python.

Besides numbers, Python can also manipulate strings. Strings can be enclosed in single quotes ('...') or double quotes ("...") with the same result. Use \ to escape quotes; that is, use \ in order to use quotation marks within the string itself:

Input:
```input
'spam eggs'  # Single quotes.
```

Output:
```output
'spam eggs'
```

Input:
```input
'doesn\'t'  # Use \' to escape the single quote...
```

Output:
```output
"doesn't"
```

Input:
```input
"doesn't"  # ...or use double quotes instead.
```

Output:
```output
"doesn't"
```

In the interactive interpreter and Jupyter Notebooks, the output string is enclosed in quotes and special characters are escaped with backslashes. Although this output sometimes looks different from the input (the enclosing quotes could change), the two strings are equivalent. The string is enclosed in double quotes if the string contains a single quote and no double quotes; otherwise, it’s enclosed in single quotes. The print() function produces a more readable output by omitting the enclosing quotes and by printing escaped and special characters:

Input:
```input
'"Isn\'t," she said.'
```

Output:
```output
'"Isn\'t," she said.'
```

Input:
```input
print('"Isn\'t," she said.')
```

Output:
```output
"Isn\'t," she said.
```

If you don't want escaped characters (prefaced by \) to be interpreted as special characters, use raw strings by adding an r before the first quote:

Input:
```input
print('C:\some\name')  # Here \n means newline!
# Im adding some more comments - woo!
```

Output:
```output
C:\some
ame
```

Input:
```input
print(r'C:\some\name')  # Note the r before the quote.
```

Output:
```output
C:\some\name
```

## String literals

String literals can span multiple lines and are delineated by triple-quotes: """...""" or '''...'''.

Because Python doesn't provide a means for creating multi-line comments, developers often just use triple quotes for this purpose. In a Jupyter notebook, however, such quotes define a string literal that appears as the output of a code cell:

Input:
```input
"""
Everything between the first three quotes, including new lines,
is part of the multi-line comment. Technically, the Python interpreter
simply sees the comment as a string, and because it's not otherwise
used in code, the string is ignored. Convenient, eh?
"""
```

Output:
```output
"\nEverything between the first three quotes, including new lines,\nis part of the multi-line comment. Technically, the Python interpreter\nsimply sees the comment as a string, and because it's not otherwise\nused in code, the string is ignored. Convenient, eh?\n"
```

For this reason, it's best in notebooks to use the # comment character at the beginning of each line, or better still, just use a Markdown cell outside of a code cell in a Jupyter notebook!

Strings can be concatenated (glued together) with the + operator, and repeated with *:

Input:
```input
# 3 times 'un', followed by 'ium'
3 * 'un' + 'ium'
```

Output:
```output
'unununium'
```

The order of operations applies to operators when they are used with strings as well as numeric types. Try experimenting with different combinations and orders of operators and strings to see what happens.

## Concatenate strings

Two or more string literals placed next to each other are automatically concatenated:

Input:
```input
'Py' 'thon'
```

Output:
```output
'Python'
```

However, to concatenate variables or a variable and a literal, use +:

Input:
```input
prefix = 'Py'
prefix + 'thon'
```

Output:
```output
'Python'
```

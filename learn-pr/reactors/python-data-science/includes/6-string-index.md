Strings can be _indexed_ (subscripted), with the first character having index 0. There is no separate character type; a character is simply a string of size one:

```Python
word = 'Python'
word[0]  # Character in position 0.
```

```Output
'P'
```

```Python
word[5]  # Character in position 5.
```

```Output
'n'
```

Indices may also be negative numbers, which means to start counting from the end of the string. Note that because -0 is the same as 0, negative indices start from -1:

```Python
word[-1]  # Last character.
```

```Output
'n'
```

```Python
word[-2]  # Second-last character.
```

```Output
'o'
```

```Python
word[-6]
```

```Output
'P'
```

## Slicing strings

In addition to indexing, which extracts individual characters, Python also supports _slicing_, which extracts a substring. To slice, you indicate a _range_ in the format `start:end`, where the start position is included but the end position is excluded:

```Python
word[0:2]  # Characters from position 0 (included) to 2 (excluded).
```

```Output
'Py'
```

```Python
word[2:5]  # Characters from position 2 (included) to 5 (excluded).
```

```Output
'tho'
```

If you omit either position, the default start position is 0 and the default end is the length of the string:

```Python
word[:2]   # Character from the beginning to position 2 (excluded).
```

```Output
'Py'
```

```Python
word[4:]  # Characters from position 4 (included) to the end.
```

```Output
'on'
```

```Python
word[-2:] # Characters from the second-last (included) to the end.
```

```Output
'on'
```

This characteristic means that `s[:i] + s[i:]` is always equal to `s`:

```Python
word[:2] + word[2:]
```

```Output
'Python'
```

```Python
word[:4] + word[4:]
```

```Output
'Python'
```

One way to remember how slices work is to think of the indices as pointing between characters, with the left edge of the first character numbered 0. Then the right edge of the last character of a string of `n` characters has index `n`. For example:

```
+---+---+---+---+---+---+ | P | y | t | h | o | n | +---+---+---+---+---+---+ 0 1 2 3 4 5 6 -6 -5 -4 -3 -2 -1
```

The first row of numbers gives the position of the indices 0–6 in the string; the second row gives the corresponding negative indices. The slice from `i` to `j` consists of all characters between the edges labeled `i` and `j`, respectively.

For non-negative indices, the length of a slice is the difference of the indices, if both are within bounds. For example, the length of `word[1:3]` is 2.

Attempting to use an index that is too large results in an error:


```Python
word[42]  # The word only has 6 characters.
```

```Output
---------------------------------------------------------------------------
IndexError                                Traceback (most recent call last)
<ipython-input-70-e894f93573ea> in <module>
----> 1 word[42]  # The word only has 6 characters.
IndexError: string index out of range
```

However, when used in a range, an index that's too large defaults to the size of the string and does not give an error. This characteristic is useful when you always want to slice at a particular index regardless of the length of a string:

```Python
word[4:42]
```

```Output
'on'
```

```Python
word[42:]
```

```Output
''
```

Python strings are [immutable](https://docs.python.org/3.6/glossary.html#term-immutable), which means they cannot be changed. Therefore, assigning a value to an indexed position in a string results in an error:

```Python
word[0] = 'J'
```

```Output
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-73-91a956888ca7> in <module>
----> 1 word[0] = 'J'
TypeError: 'str' object does not support item assignment
```

The following cell also produces an error:

```Python
word[2:] = 'py'
```

```Output
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-74-6488bbf78f5a> in <module>
----> 1 word[2:] = 'py'
TypeError: 'str' object does not support item assignment
```

A slice is itself a value that you can concatenate with other values using +:

```Python
'J' + word[1:]
```

```Output
'Jython'
```

```Python
word[:2] + 'Py'
```

```Output
'PyPy'
```

A slice, however, is not a string literal, and it cannot be used with automatic concatenation. The following code produces an error:

```Python
word[:2] 'Py'    # Slice is not a literal; produces an error
```

```Output
  File "<ipython-input-77-60be1c701626>", line 1
    word[:2] 'Py'    # Slice is not a literal; produces an error
                ^
SyntaxError: invalid syntax
```

Oftentimes, while working with strings, it can be useful to evaluate the length of a string. The built-in function [len()](https://docs.python.org/3.5/library/functions.html#len) returns the length of a string:

```Python
s = 'supercalifragilisticexpialidocious'
len(s)
```

```Output
34
```

Another useful built-in function for working with strings is [str()](https://docs.python.org/3.6/library/stdtypes.html#str). This function takes any object and returns a printable string version of that object. For example:

```Python
str(2)
```

```Output
'2'
```

```Python
str(2.5)
```

```Output
'2.5'
```

> [!div class="alert is-tip"]
> ### Takeaway
>
> Operations on string data form the other fundamental task you will do in data science in Python. Becoming comfortable with strings now will pay large dividends to you later as you work with increasingly complex data.
>

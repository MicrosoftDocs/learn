Strings can be _indexed_ (or subscripted). The index of the first character of a string is 0. There is no separate character type. A character is simply a string of size 1. Here's how to get the character at a specific index.

```python
word = 'Python'
word[0]  # Character in position 0.
```

The output is:

```Output
'P'
```

Specify a different index value to return the character in that position:

```python
word[5]  # Character in position 5.
```

The output is:

```Output
'n'
```

And index can also be a negative number, which indicates that counting is to start from the end of the string. Because -0 is the same as 0, a negative index starts from -1:

```python
word[-1]  # Last character.
```

The output is:

```Output
'n'
```

Again, a different negative index returns the character from the corresponding position:

```python
word[-2]  # Second-to-last character.
```

The output is:

```Output
'o'
```

## Slices

Python supports both indexing, which extracts individual characters from a string, and _slicing_, which extracts a substring or _slice_. To slice, you indicate a _range_ in the format _start_**:**_end_. The start position is included in the returned substring but the end position is excluded from it:

```python
word[0:2]  # Characters from position 0 (included) to 2 (excluded).
```

The output is:

```Output
'Py'
```

Here's another example that specifies a different range:

```python
word[2:5]  # Characters from position 2 (included) to 5 (excluded).
```

The output is:

```Output
'tho'
```

If you omit either position, the default start position is 0 and the default end is the length of the string:

```python
word[:2]   # Characters from the beginning to position 2 (excluded).
```

The output is:

```Output
'Py'
```

Here's an example in which the end position is omitted:

```python
word[4:]  # Characters from position 4 (included) to the end.
```

The output is:

```Output
'on'
```

This example shows the use of a negative index in the start position:

```python
word[-2:] # Characters from the second-to-last (included) to the end.
```

The output is:

```Output
'on'
```

This characteristic means that `s[:i] + s[i:]` is always equal to `s`, as shown here:

```python
word[:2] + word[2:]
```

The output is:

```Output
'Python'
```

If you supply a different index value for `i`, the result is the same:

```python
word[:4] + word[4:]
```

The output is:

```Output
'Python'
```

One way to remember how slices work is to think of the indices as pointing **between** characters. The left edge of the first character in the string is numbered 0. We can slice from this location with the index `i`. The right edge of the last character of a string of `n` characters has the index `n`. We can slice from this location with the index `j`. For example:

```python
 +---+---+---+---+---+---+
 | P | y | t | h | o | n |
 +---+---+---+---+---+---+
 0   1   2   3   4   5   6
 +---+---+---+---+---+---+
-6  -5  -4  -3  -2  -1  
 +---+---+---+---+---+---+
 i                       j
 +---+---+---+---+---+---+
```

In our example:

- The first row contains the string that we want to slice, "Python".
- The second row shows the position of the indices 0 to 6 in the string.
- The third row shows the corresponding negative indices. Notice there is no 0 in this row.
- The fourth row shows the starting locations for our slicing indices, `i` and `j`.

The slice from `i` to `j` includes all characters between the edges labeled `i` and `j`, respectively.

For non-negative indices, the length of a slice is the difference between the indices, if both are within bounds. For example, the length of `word[1:3]` is 2.

## Large index values

If you specify an index value that's too large, an error occurs:

```python
word[42]  # The word only has 6 characters.
```

The error output is:

```Output
---------------------------------------------------------------------------
IndexError                                Traceback (most recent call last)
<ipython-input-70-e894f93573ea> in <module>
----> 1 word[42]  # The word only has 6 characters.
IndexError: string index out of range
```

However, in a range, an index value that's too large defaults to the size of the string and doesn't cause an error. This characteristic is useful when you always want to start your slice at a particular index, regardless of the length of the string:

```python
word[4:42]
```

The output is:

```Output
'on'
```

This example shows what happens if the start index of your slice is larger than the length of the string:

```python
word[42:]
```

The output is:

```Output
''
```

## String immutability

Python strings are [immutable](https://docs.python.org/3.6/glossary.html#term-immutable?azure-portal=true), which means that they can't be changed. Assigning a value to an indexed position in a string therefore results in an error:

```python
word[0] = 'J'
```

The error output is:

```Output
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-73-91a956888ca7> in <module>
----> 1 word[0] = 'J'
TypeError: 'str' object does not support item assignment
```

The following cell also produces an error:

```python
word[2:] = 'py'
```

The error output is:

```Output
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-74-6488bbf78f5a> in <module>
----> 1 word[2:] = 'py'
TypeError: 'str' object does not support item assignment
```

A slice is itself a value that you can concatenate with other values by using the plus ("+") operator:

```python
'J' + word[1:]
```

The output is:

```Output
'Jython'
```

Here's another example:

```python
word[:2] + 'Py'
```

The output is:

```Output
'PyPy'
```

A slice isn't a string literal, however. It can't be used with automatic concatenation. The following code produces an error:

```python
word[:2] 'Py'    # Slice is not a literal; produces an error.
```

The output is:

```Output
  File "<ipython-input-77-60be1c701626>", line 1
    word[:2] 'Py'    # Slice is not a literal; produces an error.
                ^
SyntaxError: invalid syntax
```

It can often be useful to evaluate the length of a string. The built-in function [len()](https://docs.python.org/3.5/library/functions.html#len?azure-portal=true) returns the length of a string:

```python
s = 'supercalifragilisticexpialidocious'
len(s)
```

The output is:

```Output
34
```

Another useful built-in function for working with strings is [str()](https://docs.python.org/3.6/library/stdtypes.html#str?azure-portal=true). This function takes any object and returns a printable string version of that object. For example:

```python
str(2)
```

The output is:

```Output
'2'
```

Here's one more example:

```python
str(2.5)
```

The output is:

```Output
'2.5'
```

> [!div class="alert is-tip"]
> ### Takeaway
>
> Operations on string data are fundamental to other tasks that you'll do in data science in Python. Becoming comfortable with strings now will pay large dividends later as you work with increasingly complex data.
>

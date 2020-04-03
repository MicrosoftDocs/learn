Python knows a number of compound data types, which are used to group together other values. The most versatile is the [list](https://docs.python.org/3.5/library/stdtypes.html#typesseq-list), which can be written as a sequence of comma-separated values (items) between square brackets. Lists might contain items of different types, but usually the items all have the same type.

> [!Note]
> **Sarah: Conversion feedback**
> 
> This unit has a knowledge check question at the end that's more similar to a Try it yourself block. We revised the format.
>

```Python
squares = [1, 4, 9, 16, 25]
squares
```

```output
[1, 4, 9, 16, 25]
```

Like strings (and all other built-in [sequence types](https://docs.python.org/3.5/glossary.html#term-sequence)), lists can be indexed and sliced:

```Python
squares[0]  # Indexing returns the item.
```

```output
1
```

```Python
squares[-1]
```

```output
25
```

```Python
squares[-3:]  # Slicing returns a new list.
```

```output
[9, 16, 25]
```

All slice operations return a new list containing the requested elements. This means that the following slice returns a new (shallow) copy of the list:

```Python
squares[:]
```

```output
[1, 4, 9, 16, 25]
```

Lists also support concatenation with the + operator:

```Python
squares + [36, 49, 64, 81, 100]
```

```output
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```

Unlike strings, which are [immutable](https://docs.python.org/3.5/glossary.html#term-immutable), lists are a [mutable](https://docs.python.org/3.5/glossary.html#term-mutable) type, which means you can change any value in the list:

```Python
cubes = [1, 8, 27, 65, 125]  # Something's wrong here ...
4 ** 3  # the cube of 4 is 64, not 65!
```

```output
64
```

```Python
cubes[3] = 64  # Replace the wrong value.
cubes
```

```output
[1, 8, 27, 64, 125]
```

You can assign to slices, which can change the size of the list or clear it entirely:

```Python
letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
letters
```

```output
['a', 'b', 'c', 'd', 'e', 'f', 'g']
```

```Python
# Replace some values.
letters[2:5] = ['C', 'D', 'E']
letters
```

```output
['a', 'b', 'C', 'D', 'E', 'f', 'g']
```

```Python
# Now remove them.
letters[2:5] = []
letters
```

```output
['a', 'b', 'f', 'g']
```

```Python
# Clear the list by replacing all the elements with an empty list.
letters[:] = []
letters
```

```output
[]
```

The built-in [len()](https://docs.python.org/3.6/library/functions.html#len) function also applies to lists for getting their lengths:

```Python
letters = ['a', 'b', 'c', 'd']
len(letters)
```

```output
4
```

You can nest lists, which means to create lists that contain other lists. For example:

```Python
a = ['a', 'b', 'c']
n = [1, 2, 3]
x = [a, n]
x
```

```output
[['a', 'b', 'c'], [1, 2, 3]]
```

`x` is a list of lists, and you can access its constituent lists through the same indexing you use with simpler lists:

```Python
x[0]
```

```output
['a', 'b', 'c']
```

And by using additional index numbers, you can directly access elements within those sub-lists:

```Python
x[0][0]
```

```output
'a'
```

## Try it yourself

Nested lists come up a lot in programming, so it pays to practice.
- Which indices would you include after `x` to get the output `c`?
- How about to get the output `3`?

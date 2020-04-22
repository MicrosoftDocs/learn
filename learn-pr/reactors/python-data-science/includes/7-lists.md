Python knows a number of compound data types, which are used to group together other values. The most versatile is the [list](https://docs.python.org/3.5/library/stdtypes.html#typesseq-list?azure-portal=true), which can be written as a sequence of comma-separated values (items) between square brackets. Lists might contain items of different types, but usually the items all have the same type.

```python
squares = [1, 4, 9, 16, 25]
squares
```

The output is:

```Output
[1, 4, 9, 16, 25]
```

Like strings (and all other built-in [sequence types](https://docs.python.org/3.5/glossary.html#term-sequence?azure-portal=true)), lists can be indexed and sliced:

```python
squares[0]  # Indexing returns the item.
```

The output is:

```Output
1
```

Another example:

```python
squares[-1]
```

The output is:

```Output
25
```

Another example shows how slicing returns a new list:

```python
squares[-3:]  # Slicing returns a new list.
```

The output is:

```Output
[9, 16, 25]
```

All slice operations return a new list containing the requested elements. This means that the following slice returns a new (shallow) copy of the list:

```python
squares[:]
```

The output is:

```Output
[1, 4, 9, 16, 25]
```

Lists also support concatenation with the + operator:

```python
squares + [36, 49, 64, 81, 100]
```

The output is:

```Output
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```

Unlike strings, which are [immutable](https://docs.python.org/3.5/glossary.html#term-immutable?azure-portal=true), lists are a [mutable](https://docs.python.org/3.5/glossary.html#term-mutable?azure-portal=true) type, which means you can change any value in the list:

```python
cubes = [1, 8, 27, 65, 125]  # Something's wrong here ...
4 ** 3  # the cube of 4 is 64, not 65!
```

The output is:

```Output
64
```

Another example shows how to replace an incorrect value:

```python
cubes[3] = 64  # Replace the wrong value.
cubes
```

The output is:

```Output
[1, 8, 27, 64, 125]
```

You can assign to slices, which can change the size of the list or clear it entirely:

```python
letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
letters
```

The output is:

```Output
['a', 'b', 'c', 'd', 'e', 'f', 'g']
```

Another example shows how to replace values:

```python
# Replace some values.
letters[2:5] = ['C', 'D', 'E']
letters
```

The output is:

```Output
['a', 'b', 'C', 'D', 'E', 'f', 'g']
```

Another example shows how to remove values: 

```python
# Now remove them.
letters[2:5] = []
letters
```

The output is:

```Output
['a', 'b', 'f', 'g']
```

Another example shows how to clear the list:

```python
# Clear the list by replacing all the elements with an empty list.
letters[:] = []
letters
```

The output is:

```Output
[]
```

The built-in [len()](https://docs.python.org/3.6/library/functions.html#len?azure-portal=true) function also applies to lists for getting their lengths:

```python
letters = ['a', 'b', 'c', 'd']
len(letters)
```

The output is:

```Output
4
```

You can nest lists, which means to create lists that contain other lists. For example:

```python
a = ['a', 'b', 'c']
n = [1, 2, 3]
x = [a, n]
x
```

The output is:

```Output
[['a', 'b', 'c'], [1, 2, 3]]
```

`x` is a list of lists, and you can access its constituent lists through the same indexing you use with simpler lists:

```python
x[0]
```

The output is:

```Output
['a', 'b', 'c']
```

And by using additional index numbers, you can directly access elements within those sub-lists:

```python
x[0][0]
```

The output is:

```Output
'a'
```

### Try it yourself

Nested lists come up a lot in programming, so it pays to practice.

- Which indices would you include after `x` to get the output `c`?
- How about to get the output `3`?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  x[0][2]
  ```

  ```python
  x[1][2]
  ```
  
</details>

<br /><br />

***

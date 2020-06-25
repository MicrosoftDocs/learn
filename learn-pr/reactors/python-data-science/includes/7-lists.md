Python supports a number of _compound data types_, which group other values together. The most versatile is the [list](https://docs.python.org/3.5/library/stdtypes.html#typesseq-list?azure-portal=true), which can be written as a sequence of comma-separated values, or _items_ between square brackets. A list might contain items of different types, but usually the items all have the same type:

```python
squares = [1, 4, 9, 16, 25]
squares
```

The output is:

```Output
[1, 4, 9, 16, 25]
```

Like strings and all other built-in [sequence types](https://docs.python.org/3.5/glossary.html#term-sequence?azure-portal=true)), lists can be indexed and sliced:

```python
squares[0]  # Indexing returns the item.
```

The output is:

```Output
1
```

This example shows a negative index:

```python
squares[-1]
```

The output is:

```Output
25
```

This example shows how slicing returns a new list:

```python
squares[-3:]  # Slicing returns a new list.
```

The output is:

```Output
[9, 16, 25]
```

All slice operations return a new list that contains the requested elements. So, the following slice returns a new, shallow copy of the list:

```python
squares[:]
```

The output is:

```Output
[1, 4, 9, 16, 25]
```

Lists also support concatenation by using the plus ("+") operator:

```python
squares + [36, 49, 64, 81, 100]
```

The output is:

```Output
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```

Unlike strings, which are [immutable](https://docs.python.org/3.5/glossary.html#term-immutable?azure-portal=true), lists are a [mutable](https://docs.python.org/3.5/glossary.html#term-mutable?azure-portal=true) type. That is, you can change any value in the list. Suppose you define a list that contains an incorrect item:

```python
cubes = [1, 8, 27, 65, 125]  # Something's wrong here...
4 ** 3  # The cube of 4 is 64, not 65!
```

The output is:

```Output
64
```

Here's how to correct the item and display the result:

```python
cubes[3] = 64  # Replace the wrong value.
cubes
```

The output is:

```Output
[1, 8, 27, 64, 125]
```

You can assign to slices, which can change the size of the list or clear it entirely. First, create a new list:

```python
letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
letters
```

The output is:

```Output
['a', 'b', 'c', 'd', 'e', 'f', 'g']
```

Then, you can replace some values by using a slice:

```python
# Replace some values.
letters[2:5] = ['C', 'D', 'E']
letters
```

The output is:

```Output
['a', 'b', 'C', 'D', 'E', 'f', 'g']
```

Here's how to remove values from the list:

```python
# Now remove them.
letters[2:5] = []
letters
```

The output is:

```Output
['a', 'b', 'f', 'g']
```

This example shows how to clear the list:

```python
# Clear the list by replacing all the elements with an empty list.
letters[:] = []
letters
```

The output is:

```Output
[]
```

The built-in [len()](https://docs.python.org/3.6/library/functions.html#len?azure-portal=true) function also applies to lists. Use it to get the length of a list:

```python
letters = ['a', 'b', 'c', 'd']
len(letters)
```

The output is:

```Output
4
```

You can _nest_ lists. That is, you can create a list that contains other lists. For example:

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

`x` is a list of lists. You can access its constituent lists by using the same indexing that you use with simpler lists:

```python
x[0]
```

The output is:

```Output
['a', 'b', 'c']
```

And, by specifying additional index numbers, you can directly access elements within those constituent lists:

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

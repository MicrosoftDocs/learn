Dictionaries in Python provide a means of mapping information between unique keys and values. You create dictionaries by listing zero or more key-value pairs inside braces, like this:

```python
capitals = {'France': ('Paris', 2140526)}
```

A key for a dictionary can be one of three types: a string, a number, or a tuple. If a key is a tuple, it can contain only strings, numbers, or other tuples. The important thing is that dictionary keys be of immutable types. For example, a list can't be a key in a dictionary because lists are mutable.

Here's how you add to a dictionary:

```python
capitals['Nigeria'] = ('Lagos', 6048430)
capitals
```

The output is:

```Output
{'France': ('Paris', 2140526), 'Nigeria': ('Lagos', 6048430)}
```

### Try it yourself

Try adding another country (or something else) to the capitals dictionary.

<br />

<details> 

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  capitals['United States'] = ('DC', 100000000000)
  capitals
  ```

  ```Output
  {'France': ('Paris', 2140526),
 'Nigeria': ('Lagos', 6048430),
 'United States': ('DC', 100000000000)}
  ```

</details>

<br /><br />

***

You reference dictionary entries much like you reference parts of a string, list, or tuple. But, instead of an index, you use a key:

```python
capitals['France']
```

The output is:

```Output
('Paris', 2140526)
```

You can also update entries in the dictionary:

```python
capitals['Nigeria'] = ('Abuja', 1235880)
capitals
```

The output is:

```Output
{'France': ('Paris', 2140526), 'Nigeria': ('Abuja', 1235880)}
```

When used on a dictionary, the `len()` method returns the number of keys in a dictionary:

```python
len(capitals)
```

The output is:

```Output
2
```

The [popitem()](https://docs.python.org/3.6/library/stdtypes.html?highlight=popitem#dict.popitem?azure-portal=true) method is similar to the `pop()` method for lists. It randomly removes a key and its associated value from the dictionary:

```python
capitals.popitem()
```

The output is:

```Output
('Nigeria', ('Abuja', 1235880))
```

Another example:

```python
capitals
```

The output is:

```Output
{'France': ('Paris', 2140526)}
```

> [!div class="alert is-tip"]
> ### Takeaway
>
> Regardless of the complexity and volume of the data you work with, these basic data structures will often be your means for handling and manipulating it. Comfort with these structures is essential to understanding and using Python code written by others.

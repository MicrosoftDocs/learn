Dictionaries in Python provide a means of mapping information between unique keys and values. You create dictionaries by listing zero or more key-value pairs inside of braces, like this:

```python
capitals = {'France': ('Paris', 2140526)}
```

Keys for dictionaries can be three things: strings, numbers, or tuples (that contain only strings, numbers, or other tuples). The important thing is that dictionary keys be immutable, so lists cannot be used for keys in dictionaries, for example.

You add to dictionaries like this:

```python
capitals['Nigeria'] = ('Lagos', 6048430)
capitals
```

The output is:

```Output
{'France': ('Paris', 2140526), 'Nigeria': ('Lagos', 6048430)}
```

### Try it yourself

Now try adding another country (or something else) to the capitals dictionary.

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

You reference entries much like you do as through an index number for a string, list, or tuple, but instead of an index, use a key:

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

Similar to the `pop()` method for lists, the [popitem()](https://docs.python.org/3.6/library/stdtypes.html?highlight=popitem#dict.popitem?azure-portal=true) method randomly removes a key from the dictionary, along with its associated value:

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
> Regardless of how complex and voluminous the data you will work with, these basic data structures will repeatedly be your means for handling and manipulating it. Comfort with these basic data structures is essential to being able to understand and use Python code written by others.

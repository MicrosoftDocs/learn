Dictionaries in Python provide a means of mapping information between unique keys and values. You create dictionaries by listing zero or more key-value pairs inside of braces, like this:

```Python
capitals = {'France': ('Paris', 2140526)}
```

Keys for dictionaries can be three things: strings, numbers, or tuples (that contain only strings, numbers, or other tuples). The important thing is that dictionary keys be immutable, so lists cannot be used for keys in dictionaries, for example.

You add to dictionaries like this:

```Python
capitals['Nigeria'] = ('Lagos', 6048430)
capitals
```

```output
{'France': ('Paris', 2140526), 'Nigeria': ('Lagos', 6048430)}
```

## Exercise

Now try adding another country (or something else) to the capitals dictionary.

You reference entries much like you do as through an index number for a string, list, or tuple, but instead of an index, use a key:

```Python
capitals['France']
```

```output
('Paris', 2140526)
```

You can also update entries in the dictionary:

```Python
capitals['Nigeria'] = ('Abuja', 1235880)
capitals
```

```output
{'France': ('Paris', 2140526), 'Nigeria': ('Abuja', 1235880)}
```

When used on a dictionary, the len() method returns the number of keys in a dictionary:

```Python
len(capitals)
```

```output
2
```

Similar to the pop() method for lists, the popitem() method randomly removes a key from the dictionary, along with its associated value:

```Python
capitals.popitem()
```

```output
('Nigeria', ('Abuja', 1235880))
```

```Python
capitals
```

```output
{'France': ('Paris', 2140526)}
```

> [!div class="alert is-tip"]
> ### Takeaway
>
> Regardless of how complex and voluminous the data you will work with, these basic data structures will repeatedly be your means for handling and manipulating it. Comfort with these basic data structures is essential to being able to understand and use Python code written by others.
> 
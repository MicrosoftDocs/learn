A `Series` object can act like both a one-dimensional `ndarray` and a standard Python dictionary. Like a dictionary, the `Series` object maps a collection of arbitrary keys to a collection of arbitrary values. Back to an old example:

```python
series_example2 = pd.Series([-0.5, 0.75, 1.0, -2], index=['a', 'b', 'c', 'd'])
series_example2
```

The output is:

```Output
a   -0.50
b    0.75
c    1.00
d   -2.00
dtype: f
```

```python
series_example2['b']
```

The output is:

```Output
0.75
```

You can also examine the keys or indices and values by using dictionary-like, Python tools:

```python
'a' in series_example2
```

The output is:

```Output
True
```

Another example:

```python
series_example2.keys()
```

The output is:

```Output
Index(['a', 'b', 'c', 'd'], dtype='object')
```

Another example:

```python
list(series_example2.items())
```

The output is:

```Output
[('a', -0.5), ('b', 0.75), ('c', 1.0), ('d', -2.0)]
```

You can extend a dictionary by assigning to a new key. Similarly, you can extend a `Series` by assigning to a new index value:

```python
series_example2['e'] = 1.25
series_example2
```

The output is:

```Output
a   -0.50
b    0.75
c    1.00
d   -2.00
e    1.25
dtype: float64
```

## Series as one-dimensional array

Because `Series` also provide array-style functionality, you can use the NumPy techniques you looked at earlier, like slices, masking, and fancy indexing.

### Slicing by using the explicit index

```python
series_example2['a':'c']
```

The output is:

```Output
a   -0.50
b    0.75
c    1.00
dtype: float64
```

### Slicing by using the implicit integer index

```python
series_example2[0:2]
```

The output is:

```Output
a   -0.50
b    0.75
dtype: float64
```

### Masking

```python
series_example2[(series_example2 > -1) & (series_example2 < 0.8)]
```

The output is:

```Output
a   -0.50
b    0.75
dtype: float64
```

### Fancy indexing

```python
series_example2[['a', 'e']]
```

The output is:

```Output
a   -0.50
e    1.25
dtype: float64
```

> [!Note]
> When you're slicing with an explicit index (that is, `series_example2['a':'c']`), the final index is included in the slice. When you're slicing with an implicit index (that is, `series_example2[0:2]`), the final index is excluded from the slice.

## Indexers: loc and iloc

pandas allows you to use a lot different things for your explicit indices, but this capability can also be confusing. Integers are a good example. To avoid confusion between integer indices that you might supply, and those implicit integer indices that pandas generates, pandas provides special _indexer_ attributes. These attributes explicitly expose certain indexing schemes.

> [!Note]
> These aren't functional methods. They are attributes that expose a particular slicing interface to the data in the `Series`.

The `loc` attribute allows indexing and slicing that always references the explicit index:

```python
series_example2.loc['a']
```

The output is:

```Output
-0.5
```

Another example:

```python
series_example2.loc['a':'c']
```

The output is:

```Output
a   -0.50
b    0.75
c    1.00
dtype: float64
```

The `iloc` attribute enables indexing and slicing by using the implicit, Python-style index:

```python
series_example2.iloc[0]
```

The output is:

```Output
-0.5
```

Another example:

```python
series_example2.iloc[0:2]
```

The output is:

```Output
a   -0.50
b    0.75
dtype: float64
```

A guiding principle of the Python language is the idea that "explicit is better than implicit." Professional code generally uses explicit indexing with `loc` and ` iloc`, and you should as well. This makes your code clean and readable.

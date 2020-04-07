As a refresher, a `Series` object acts in many ways like both a one-dimensional `ndarray` and a standard Python dictionary.

> [!Note]
> **Sarah: Action items**
> 
> - Add one or more sentences as introduction / scenario statement for the `Series` as one-dimensional array H2 heading and H3 headings that follow.
>

Like a dictionary, the `Series` object provides a mapping from a collection of arbitrary keys to a collection of arbitrary values. Back to an old example:

```Python
series_example2 = pd.Series([-0.5, 0.75, 1.0, -2], index=['a', 'b', 'c', 'd'])
series_example2
```

```Output
a   -0.50
b    0.75
c    1.00
d   -2.00
dtype: f
```

```Python
series_example2['b']
```

```Output
0.75
```

You can also examine the keys/indices and values using dictionary-like Python tools:

```Python
'a' in series_example2
```

```Output
True
```

```Python
series_example2.keys()
```

```Output
Index(['a', 'b', 'c', 'd'], dtype='object')
```

```Python
list(series_example2.items())
```

```Output
[('a', -0.5), ('b', 0.75), ('c', 1.0), ('d', -2.0)]
```

As with dictionaries, you can extend a dictionary by assigning to a new key, you can extend a `Series` by assigning to a new index value:

```Python
series_example2['e'] = 1.25
series_example2
```

```Output
a   -0.50
b    0.75
c    1.00
d   -2.00
e    1.25
dtype: float64
```

## Series as one-dimensional array

Because `Series` also provide array-style functionality, you can use the NumPy techniques we looked at earlier, like slices, masking, and fancy indexing.

### Slicing using the explicit index

```Python
series_example2['a':'c']
```

```Output
a   -0.50
b    0.75
c    1.00
dtype: float64
```

### Slicing using the implicit integer index

```Python
series_example2[0:2]
```

```Output
a   -0.50
b    0.75
dtype: float64
```

### Masking

```Python
series_example2[(series_example2 > -1) & (series_example2 < 0.8)]
```

```Output
a   -0.50
b    0.75
dtype: float64
```

### Fancy indexing

```Python
series_example2[['a', 'e']]
```

```Output
a   -0.50
e    1.25
dtype: float64
```

One note to avoid confusion. When slicing with an explicit index (that is, `series_example2['a':'c']`), the final index is **included** in the slice. When slicing with an implicit index (that is, `series_example2[0:2]`), the final index is **excluded** from the slice.

## Indexers: loc and iloc

A great thing about pandas is that you can use a lot different things for your explicit indices. A potentially confusing thing about pandas is that you can use a lot different things for your explicit indices, including integers. To avoid confusion between integer indices that you might supply and those implicit integer indices that pandas generates, pandas provides special _indexer_ attributes that explicitly expose certain indexing schemes.

> [!Note]
> These are not functional methods. They are attributes that expose a particular slicing interface to the data in the `Series`.

The `loc` attribute allows indexing and slicing that always references the explicit index:

```Python
series_example2.loc['a']
```

```Output
-0.5
```

```Python
series_example2.loc['a':'c']
```

```Output
a   -0.50
b    0.75
c    1.00
dtype: float64
```

The `iloc` attribute enables indexing and slicing using the implicit, Python-style index:

```Python
series_example2.iloc[0]
```

```Output
-0.5
```

```Python
series_example2.iloc[0:2]
```

```Output
a   -0.50
b    0.75
dtype: float64
```

A guiding principle of the Python language is the idea that "explicit is better than implicit." Professional code will generally use explicit indexing with `lo`c and` iloc` and you should as well in order to make your code clean and readable.

A huge part of data science is manipulating data in order to analyze it. (One rule of thumb is that 80% of any data science project will be concerned with cleaning and organizing the data for the project.) So it makes sense to learn the tools that pandas provides for handling data in `Series` and especially `DataFrames`. Because both of those data structures are ordered, let's first start by taking a closer look at what gives them their structure: the `Index`.

> [!Note]
> **Sarah: Action items**
> 
> - Search on "code cell below." These statements will need to be updated to coordinate with the new side-by-side exercise model. 
> - Line 77: Address how to handle the input request. Added comments for now.
>

## Index objects in pandas

Both `Series` and `DataFrames` in pandas have explicit indices that enable you to reference and modify data in them. These indices are actually objects themselves. The `Index` object can be thought of as both an immutable array or as fixed-size set.

It's worth the time to get to know the properties of the `Index` object. Let's return to an example from earlier in the section to examine these properties.

```Python
series_example = pd.Series([-0.5, 0.75, 1.0, -2], index=['a', 'b', 'c', 'd'])
ind = series_example.index
ind
```

```Output
Index(['a', 'b', 'c', 'd'], dtype='object')
```

The `Index` works a lot like an array. we have already seen how to use standard Python indexing notation to retrieve values or slices:

```Python
ind[1]
```

```Output
'b'
```

```Python
ind[::2]
```

```Output
Index(['a', 'c'], dtype='object')
```

But `Index` objects are immutable; you cannot be modified via the normal means:

```Python
ind[1] = 0
```

```Error
TypeError                                 Traceback (most recent call last)
<ipython-input-34-906a9fa1424c> in <module>
----> 1 ind[1] = 0

/opt/anaconda3/lib/python3.7/site-packages/pandas/core/indexes/base.py in __setitem__(self, key, value)
   2063 
   2064     def __setitem__(self, key, value):
-> 2065         raise TypeError("Index does not support mutable operations")
   2066 
   2067     def __getitem__(self, key):

TypeError: Index does not support mutable operations
```

This immutability is a good thing: it makes it safer to share indices between multiple `Series` or `DataFrames` without the potential for problems arising from inadvertent index modification.

In addition to being array-like, a `Index` also behaves like a fixed-size set, including following many of the conventions used by Python's built-in set data structure, so that unions, intersections, differences, and other combinations can be computed in a familiar way. Let's play around with this to see it in action.

```Python
ind_odd = pd.Index([1, 3, 5, 7, 9])
ind_prime = pd.Index([2, 3, 5, 7, 11])
```

In the code cell below, try out the intersection (`ind_odd & ind_prime`), union (`ind_odd | ind_prime`), and the symmetric difference (`ind_odd ^ ind_prime`) of `ind_odd` and `ind_prime`.

```Python
# Try out the intersection `ind_odd & ind_prime` of `ind_odd` and `ind_prime`

# Try out the union `ind_odd | ind_prime` of `ind_odd` and `ind_prime`

# Try out the symmetric difference `ind_odd ^ ind_prime`of `ind_odd` and `ind_prime`
```

These operations may also be accessed via object methods, for example `ind_odd.intersection(ind_prime)`. Below is a table listing some useful `Index` methods and properties.

| Method | Description |
|---|---|
| `append` | Concatenate with additional `Index` objects, producing a new `Index`. |
| `diff` | Compute set difference as an `Index`. |
| `drop` | Compute new `Index` by deleting passed values. |
| `insert` | Compute new `Index` by inserting element at index `i`. |
| `is_monotonic` | Returns True if each element is greater than or equal to the previous element. |
| `is_unique` | Returns True if the `Index` has no duplicate values. |
| `isin` | Compute boolean array indicating whether each value is contained in the passed collection. |
| `unique` | Compute the array of unique values in order of appearance. |

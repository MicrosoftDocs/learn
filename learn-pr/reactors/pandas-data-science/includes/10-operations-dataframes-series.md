Index and column alignment is maintained in operations between a `DataFrame` and a `Series` as well. To see this, consider a common operation in data science, wherein you find the difference of a `DataFrame` and one of its rows. Because pandas inherits `ufuncs` from NumPy, pandas will compute the difference row-wise by default:

```python
df3 = pd.DataFrame(rng.randint(10, size=(3, 4)), columns=list('WXYZ'))
df3
```

The output is:

```Output
|    | W  | X  | Y  | Z  |
--------------------------
| 0  | 3  | 8  | 2  | 4  |
| 1  | 2  | 6  | 4  | 8  |
| 2  | 6  | 1  | 3  | 8  |
```

Another example:

```python
df3 - df3.iloc[0]
```

The output is:

```Output
|    | W   | X   | Y  | Z  |
----------------------------
| 0  | 0   | 0   | 0  | 0  |
| 1  | -1  | -2  | 2  | 4  |
| 2  | 3   | -7  | 1  | 4  |
```

But what if you need to operate column-wise? You can do this by using object methods, and specifying the `axis` keyword.

```python
df3.subtract(df3['X'], axis=0)
```

The output is:

```Output
|    | W   | X  | Y   | Z   |
-----------------------------
| 0  | -5  | 0  | -6  | -4  |
| 1  | -4  | 0  | -2  | 2   |
| 2  | 5   | 0  | 2   | 7   |
```

And when you do operations between `DataFrames` and `Series` operations, you still get automatic index alignment:

```python
halfrow = df3.iloc[0, ::2]
halfrow
```

The output is:

```Output
W    3
Y    2
Name: 0, dtype: int64
```

Note that the output from that operation was transposed. That was so that you can subtract it from the `DataFrame`:

```python
df3 - halfrow
```

The output is:

```Output
|    |  W   |  X   |  Y   |  Z   |
----------------------------------
| 0  | 0.0  | NaN  | 0.0  | NaN  |
| 1  | -1.0 | NaN  | 2.0  | NaN  |
| 2  | 3.0  | NaN  | 1.0  | NaN  |
```

Remember, pandas preserves and aligns indices and columns, and so preserves data context. This will be of huge help to you in your next module, when you look at data cleaning and preparation.

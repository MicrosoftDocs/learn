In addition to missing data, in real-world datasets, you frequently encounter duplicated data. Fortunately, pandas provides an easy way to detect and remove duplicate entries.

## Identify duplicates: `duplicated`

You can easily spot duplicate values by using the `duplicated` method in pandas. `duplicated` returns a Boolean mask that indicates whether an entry in a `DataFrame` is a duplicate of an earlier one. Let's create another example `DataFrame` to see this in action:

```python
example6 = pd.DataFrame({'letters': ['A','B'] * 2 + ['B'],
                         'numbers': [1, 2, 1, 3, 3]})
example6
```

Here's the output:

```Output
|   | letters | numbers |
-------------------------
| 0 | A       | 1       |
| 1 | B       | 2       |
| 2 | A       | 1       |
| 3 | B       | 3       |
| 4 | B       | 3       |
```

Then run this code in a cell:

```python
example6.duplicated()
```

Here's the output:

```Output
0    False
1    False
2     True
3    False
4     True
dtype: bool
```

## Drop duplicates: `drop_duplicates`

`drop_duplicates` simply returns a copy of the data for which all of the duplicated values are `False`.

Run this code in a cell:

```python
example6.drop_duplicates()
```

Here's the output:

```Output
|   | letters | numbers |
-------------------------
| 0 | A       | 1       |
| 1 | B       | 2       |
| 3 | B       | 3       |
```

Both `duplicated` and `drop_duplicates` default to consider all columns, but you can specify that they examine only a subset of columns in your `DataFrame`.

Run this code in a cell:

```python
example6.drop_duplicates(['letters'])
```

Here's the output:

```Output
|   | letters | numbers |
-------------------------
| 0 | A       | 1       |
| 1 | B       | 2       |
```

> [!div class="alert is-tip"]
> ### Takeaway
>
> Removing duplicate data is an essential part of almost every data science project. Duplicate data can change the results of your analyses and give you spurious results.
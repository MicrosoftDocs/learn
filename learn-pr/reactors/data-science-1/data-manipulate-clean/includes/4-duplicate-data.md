> [!div class="alert is-tip"]
> ### Learning goal
>
> By the end of this subsection, you should be comfortable identifying and removing duplicate values from DataFrames.

In addition to missing data, often, you encounter duplicated data in real-world datasets. Fortunately, pandas provides an easy means of detecting and removing duplicate entries.

## Identify duplicates: `duplicated`

You can easily spot duplicate values by using the `duplicated` method in pandas, which returns a Boolean mask indicating whether an entry in a DataFrame is a duplicate of an ealier one. Let's create another example DataFrame to see this in action:

```python
example6 = pd.DataFrame({'letters': ['A','B'] * 2 + ['B'],
                         'numbers': [1, 2, 1, 3, 3]})
example6
```

The output looks like this:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

```python
example6.duplicated()
```

The output looks like this:

```output
0    False
1    False
2     True
3    False
4     True
dtype: bool
```

## Drop duplicates: `drop_duplicates`

`drop_duplicates` simply returns a copy of the data for which all of the duplicated values are `False`:

```python
example6.drop_duplicates()
```

The output looks like this:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Both `duplicated` and `drop_duplicates` default to consider all columns, but you can specify that they examine only a subset of columns in your DataFrame:

```python
example6.drop_duplicates(['letters'])
```

The output looks like this:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

> [!div class="alert is-tip"]
> ### Takeaway
>
> Removing duplicate data is an essential part of almost every data-science project. Duplicate data can change the results of your analyses and give you spurious results!
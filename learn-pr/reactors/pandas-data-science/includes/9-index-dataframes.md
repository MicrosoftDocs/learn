The same kind of alignment takes place in both dimensions (columns and indices) when you perform operations on `DataFrames`.

```python
df1 = pd.DataFrame(rng.randint(0, 20, (2, 2)),
                   columns=list('AB'))
df1
```

The output is:

```Output
|    | A  | B  |
----------------
| 0  | 1  | 11 |
| 1  | 5  | 1  |
```

Another example:

```python
df2 = pd.DataFrame(rng.randint(0, 10, (3, 3)),
                   columns=list('BAC'))
df2
```

The output is:

```Output
|    | B  | A  | C  |
---------------------
| 0  | 4  | 0  | 9  |
| 1  | 5  | 8  | 0  |
| 2  | 9  | 2  | 6  |
```

### Try it yourself

Add df1 and df2. Is the output what you expected?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  df1 + df2
  ```

  ```Output
  |    | A  | B  | C  |
  ---------------------
  | 0  | 1.0  | 15.0 | NaN |
  | 1  | 13.0 | 6.0  | NaN |
  | 2  | NaN  | NaN  | NaN |
  ```
  
</details>

<br /><br />

***

Even though you passed the columns in a different order in `df2` than in `df1`, the indices were aligned correctly sorted in the resulting union of columns.

You can also use fill values for missing values with `DataFrames`. In this example, let's fill the missing values with the mean of all values in `df1` (computed by first stacking the rows of `df1`):

```python
fill = df1.stack().mean()
df1.add(df2, fill_value=fill)
```

The output is:

```Output
|    |  A   |  B   |  C   |
---------------------------
| 0  | 1.0  | 15.0 | 13.5 |
| 1  | 13.0 | 6.0  | 4.5  |
| 2  | 6.5  | 13.5 | 10.5 |
```

This table lists Python operators and their equivalent pandas object methods:

| Python operator | pandas method(s) |
|:------------:|----------|
| +  | add() |
| -  | sub(), subtract() |
| *  | mul(), multiply() | 
| /  | truediv(), div(), divide() |
| // | floordiv() |
| %  | mod() |
| ** | pow() |

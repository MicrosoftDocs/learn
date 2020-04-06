<div>
<style>
   table { border-collapse: collapse; border: 1px solid darkgrey; background-color:rgb(240,240,240); width: 300px; padding: 5px; }
   tr { border: 1px solid darkgrey; text-align: left; padding: 5px; }
   td { border: 1px solid darkgrey; padding: 5px; }
</style>
</div>

The same kind of alignment takes place in both dimension (columns and indices) when you perform operations on `DataFrames`.

```Python
df1 = pd.DataFrame(rng.randint(0, 20, (2, 2)),
                   columns=list('AB'))
df1
```

```Output```

|   | A | B |
|---|---|---|
| **0** | 1 | 11 |
| **1** | 5 | 1 |


```Python
df2 = pd.DataFrame(rng.randint(0, 10, (3, 3)),
                   columns=list('BAC'))
df2
```

```Output```

|   | B | A | C |
|---|---|---|---|
| **0** | 4 | 0 | 9 |
| **1** | 5 | 8 | 0 |
| **2** | 9 | 2 | 6 |


```Python
# Add df1 and df2. Is the output what you expected?
```

Even though we passed the columns in a different order in `df2` than in `df1`, the indices were aligned correctly sorted in the resulting union of columns.

You can also use fill values for missing values with `DataFrames`. In this example, let's fill the missing values with the mean of all values in `df1` (computed by first stacking the rows of `df1`):

```Python
fill = df1.stack().mean()
df1.add(df2, fill_value=fill)
```

```Output```

|   | A | B | C |
|---|---|---|---|
| **0** | 1.0 | 15.0 | 13.5 |
| **1** | 13.0 | 6.0 | 4.5 |
| **2** | 6.5 | 13.5 | 10.5 |

This table lists Python operators and their equivalent pandas object methods:

> [!div class="mx-tdBreakAll"]
> | Python operator | Pandas method(s) |
> |:------------:|----------|
> | + | add() |
> | - | sub(), subtract() |
> | * | mul(), multiply() | 
> | / | truediv(), div(), divide() |
> | // | floordiv() |
> | % | mod() |
> | ** | pow() |
>

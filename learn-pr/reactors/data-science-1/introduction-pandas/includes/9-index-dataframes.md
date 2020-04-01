The same kind of alignment takes place in both dimension (columns and indices) when you perform operations on DataFrames.

> [!Note]
> **Sarah: Action items**
> 
> - Add output for commands.
> - There are a few input commands where the input syntax is not specified. Search on "???".
>

```input
df1 = pd.DataFrame(rng.randint(0, 20, (2, 2)),
                   columns=list('AB'))
df1
```

Output:
```output
TBD
```

```input
df2 = pd.DataFrame(rng.randint(0, 10, (3, 3)),
                   columns=list('BAC'))
df2
```

Output:
```output
TBD
```

Add df1 and df2. Is the output what you expected?

```input
???
```

Output:
```output
TBD
```

Even though we passed the columns in a different order in df2 than in df1, the indices were aligned correctly sorted in the resulting union of columns.

You can also use fill values for missing values with Data Frames. In this example, let's fill the missing values with the mean of all values in df1 (computed by first stacking the rows of df1):

```input
fill = df1.stack().mean()
df1.add(df2, fill_value=fill)
```

Output:
```output
TBD
```

This table lists Python operators and their equivalent pandas object methods:

| Python operator | Pandas method(s) |
|:--:|---|
| + | add() |
| - | sub(), subtract() |
| * | mul(), multiply() | 
| / | truediv(), div(), divide() |
| // | floordiv() |
| % | mod() |
| ** | pow() |

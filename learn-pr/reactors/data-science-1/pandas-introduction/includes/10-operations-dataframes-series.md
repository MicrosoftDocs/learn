Index and column alignment gets maintained in operations between a DataFrame and a Series as well. To see this, consider a common operation in data science, wherein we find the difference of a DataFrame and one of its rows. Because pandas inherits ufuncs from NumPy, pandas will compute the difference row-wise by default:

> [!Note]
> **Sarah: Action items**
> 
> - Add output for commands.
>

```Python
df3 = pd.DataFrame(rng.randint(10, size=(3, 4)), columns=list('WXYZ'))
df3
```


```output
TBD
```

```Python
df3 - df3.iloc[0]
```


```output
TBD
```

But what if you need to operate column-wise? You can do this by using object methods and specifying the axis keyword.

```Python
df3.subtract(df3['X'], axis=0)
```


```output
TBD
```

And when you do operations between DataFrames and Series operations, you still get automatic index alignment:

```Python
halfrow = df3.iloc[0, ::2]
halfrow
```


```output
TBD
```

Note that the output from that operation was transposed. That was so that we can subtract it from the DataFrame:

```Python
df3 - halfrow
```


```output
TBD
```

Remember, pandas preserves and aligns indices and columns so preserve data context. This will be of huge help to you in our next module when we look at data cleaning and preparation.

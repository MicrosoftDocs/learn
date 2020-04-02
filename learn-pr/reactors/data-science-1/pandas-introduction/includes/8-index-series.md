For our first example, suppose we are combining two different data sources and find only the top five countries by area and the top five countries by population:

> [!Note]
> **Sarah: Action items**
> 
> - Add output for commands.
> - There are a few input commands where the input syntax is not specified. Search on "???".
>

```input
area = pd.Series({'Russia': 17075400, 'Canada':  9984670,
                  'USA': 9826675, 'China': 9598094, 
                  'Brazil': 8514877}, name='area')
population = pd.Series({'China': 1409517397, 'India': 1339180127,
                        'USA': 324459463, 'Indonesia': 322179605, 
                        'Brazil': 207652865}, name='population')
```


```output
TBD
```

Now divide these to compute the population density

```input
???
```


```output
TBD
```

Your resulting array contains the union of indices of the two input arrays: seven countries in total. All of the countries in the array without an entry (because they lacked either area data or population data) are marked with the now familiar NaN, or "Not a Number," designation.

Index matching works the same way built-in Python arithmetic expressions and missing values are filled in with NaNs. You can see this clearly by adding two Series that are slightly misaligned in their indices:

```input
series1 = pd.Series([2, 4, 6], index=[0, 1, 2])
series2 = pd.Series([3, 5, 7], index=[1, 2, 3])
series1 + series2
```


```output
TBD
```

NaN values are not always convenient to work with; NaN combined with any other values results in NaN, which can be a pain, particularly if you are combining multiple data sources with missing values. To help with this, pandas allows you to specify a default value to use for missing values in the operation. For example, calling series1.add(series2) is equivalent to calling series1 + series2, but you can supply the fill value:

```input
series1.add(series2, fill_value=0)
```


```output
TBD
```

Much better!

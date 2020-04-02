DataFrames also exhibit dual behavior, acting both like a two-dimensional ndarray and like a dictionary of Series sharing the same index.

> [!Note]
> **Sarah: Action items**
> 
> - Add output for commands.
> - Add one or more sentences as introduction / scenario statement for the Exercise H2 heading.
> - There are a few input commands where the input syntax is not specified. Search on "???".
>

## DataFrame as dictionary of Series

Let's return to our earlier example of countries' areas and populations in order to examine DataFrames as a dictionary of Series.

```Python
area = pd.Series({'Albania': 28748,
                  'France': 643801,
                  'Germany': 357386,
                  'Japan': 377972,
                  'Russia': 17125200})
population = pd.Series ({'Albania': 2937590,
                         'France': 65429495,
                         'Germany': 82408706,
                         'Russia': 143910127,
                         'Japan': 126922333})
countries = pd.DataFrame({'Area': area, 'Population': population})
countries
```


```output
TBD
```

You can access the individual Series that make up the columns of a DataFrame via dictionary-style indexing of the column name:

```Python
countries['Area']
```


```output
TBD
```

An you can use dictionary-style syntax can also be used to modify DataFrames, such as by adding a new column:

```Python
countries['Population Density'] = countries['Population'] / countries['Area']
countries
```


```output
TBD
```

## DataFrame as two-dimensional array

You can also think of DataFrames as two-dimensional arrays. You can examine the raw data in the DataFrame/data array using the values attribute:

```Python
countries.values
```


```output
TBD
```

Viewed this way it makes sense that we can transpose the rows and columns of a DataFrame the same way we would an array:

```Python
countries.T
```


```output
TBD
```

DataFrames also uses the loc and iloc indexers. With iloc, you can index the underlying array as if it were an ndarray but with the DataFrame index and column labels maintained in the result:

```Python
countries.iloc[:3, :2]
```


```output
TBD
```

loc also permits array-like slicing but using the explicit index and column names:

```Python
countries.loc[:'Germany', :'Population']
```


```output
TBD
```

You can also use array-like techniques such as masking and fancy indexing with loc.

## Exercise

Can you think of how to combine masking and fancy indexing in one line?

- Your masking could be something like `countries['Population Density'] > 200`.
- Your fancy indexing could be something like `['Population', 'Population Density']`.

Be sure to put the the masking and fancy indexing inside the square brackets: `countries.loc[]`.

```Python
???
```


```output
TBD
```

## Indexing conventions

In practice in the world of data science (and pandas more generally), indexing refers to columns while slicing refers to rows:

```Python
countries['France':'Japan']
```


```output
TBD
```

Such slices can also refer to rows by number rather than by index:

```Python
countries[1:3]
```


```output
TBD
```

Similarly, direct masking operations are also interpreted row-wise rather than column-wise:

```Python
countries[countries['Population Density'] > 200]
```


```output
TBD
```

These two conventions are syntactically similar to those on a NumPy array, and while these may not precisely fit the mold of the Pandas conventions, they are nevertheless quite useful in practice.


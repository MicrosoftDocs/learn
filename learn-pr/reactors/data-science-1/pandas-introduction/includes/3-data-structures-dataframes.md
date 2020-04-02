The other crucial data structure in pandas to get to know for data science is the DataFrame. Like the Series object, DataFrames can be thought of either as generalizations of ndarrays (or as specializations of Python dictionaries).

Just as a Series is like a one-dimensional array with flexible indices, a DataFrame is like a two-dimensional array with both flexible row indices and flexible column names. Essentially, a DataFrame represents a rectangular table of data and contains an ordered collection of labeled columns, each of which can be a different value type (string, int, float, etc.). The DataFrame has both a row and column index; in this way you can think of it as a dictionary of Series, all of which share the same index.

> [!Note]
> **Sarah: Action items**
> 
> - Add output for commands.
> - There are a few input commands where the input syntax is not specified. Search on "???".
>

Let's take a look at how this works in practice. We will start by creating a Series called **area**:

```input
area_dict = {'Albania': 28748,
             'France': 643801,
             'Germany': 357386,
             'Japan': 377972,
             'Russia': 17125200}
area = pd.Series(area_dict)
area
```


```output
TBD
```

Now you can combine this with the population Series you created earlier by using a dictionary to construct a single two-dimensional table containing data from both Series:

```input
countries = pd.DataFrame({'Population': population, 'Area': area})
countries
```


```output
TBD
```

As with Series, note that DataFrames also automatically order indices (in this case, the column indices Area and Population).

So far we have combined dictionaries together to compose a DataFrame (which has given our DataFrame a row-centric feel), but you can also create DataFrames in a column-wise fashion. Consider adding a Capital column using our reliable old array-analog, a list:

```input
countries['Capital'] = ['Tirana', 'Paris', 'Berlin', 'Tokyo', 'Moscow']
countries
```


```output
TBD
```

As with Series, even though initial indices are ordered in DataFrames, subsequent additions to a DataFrame stay in the ordered added. However, you can explicitly change the order of DataFrame column indices this way:

```input
countries = countries[['Capital', 'Area', 'Population']]
countries
```


```output
TBD
```

Commonly in a data science context, it is necessary to generate new columns of data from existing data sets. Because DataFrame columns behave like Series, you can do this is by performing operations on them as you would with Series:

```input
countries['Population Density'] = countries['Population'] / countries['Area']
countries
```


```output
TBD
```

> [!Note]
> Don't worry if IPython gives you a warning over this. The warning is IPython trying to be a little too helpful. The new column you created is an actual part of the DataFrame and not a copy of a slice.

We have stated before that DataFrames are like dictionaries, and it's true. You can retrieve the contents of a column just as you would the value for a specific key in an ordinary dictionary:

```input
countries['Area']
```


```output
TBD
```

What about using the row indices?

```input
???
```

```output
TBD
```

Now try accessing row data with a command like `countries['Japan']`

```input
countries['Japan']
```


```output
TBD
```

This returns an error: DataFrames are dictionaries of Series, which are the columns. DataFrame rows often have heterogeneous data types, so different methods are necessary to access row data. For that, we use the .loc method:

```input
countries.loc['Japan']
```


```output
TBD
```

Note that what .loc returns is an indexed object in its own right and you can access elements within it using familiar index syntax:

```input
countries.loc['Japan']['Area']
```


```output
TBD
```

Can you think of a way to return the area of Japan without using .iloc?

> [!Tip]
> Try putting the column index first.

```input
???
```


```output
TBD
```

Can you slice along these indices as well?

```input
???
```


```output
TBD
```

Sometimes it is helpful in data science projects to add a column to a DataFrame without assigning values to it:

```input
countries['Debt-to-GDP Ratio'] = np.nan
countries
```


```output
TBD
```

Again, you can disregard the warning (if it triggers) about adding the column this way.

You can also add columns to a DataFrame that do not have the same number of rows as the DataFrame:

```input
debt = pd.Series([0.19, 2.36], index=['Russia', 'Japan'])
countries['Debt-to-GDP Ratio'] = debt
countries
```


```output
TBD
```

You can use the del command to delete a column from a DataFrame:

```input
del countries['Capital']
countries
```


```output
TBD
```

In addition to their dictionary-like behavior, DataFrames also behave like two-dimensional arrays. For example, it can be useful at times when working with a DataFrame to transpose it:

```input
countries.T
```


```output
TBD
```

Again, note that DataFrame columns are Series and thus the data types must consistent, hence the upcasting to floating-point numbers. If there had been strings in this DataFrame, everything would have been upcast to strings. Use caution when transposing DataFrames.

## From a two-dimensional NumPy array
Given a two-dimensional array of data, we can create a DataFrame with any specified column and index names. If omitted, an integer index will be used for each:

```input
pd.DataFrame(np.random.rand(3, 2),
             columns=['foo', 'bar'],
             index=['a', 'b', 'c'])
```


```output
TBD
```

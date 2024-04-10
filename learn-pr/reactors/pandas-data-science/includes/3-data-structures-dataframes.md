The other crucial data structure in pandas to get to know for data science is the `DataFrame`. Like the `Series` object, `DataFrames` can be thought of either as generalizations of `ndarrays`, or as specializations of Python dictionaries.

Just as a `Series` is like a one-dimensional array with flexible indices, a `DataFrame` is like a two-dimensional array with both flexible row indices and flexible column names. A `DataFrame` represents a rectangular table of data, and contains an ordered collection of labeled columns, each of which can be a different value type (for example, `string`, `int`, or `float`). The `DataFrame` has both a row and column index. You can think of it as a dictionary of `Series`, all of which share the same index.

Let's take a look at how this works in practice. Start by creating a `Series` called `area`:

```python
area_dict = {'Albania': 28748,
             'France': 643801,
             'Germany': 357386,
             'Japan': 377972,
             'Russia': 17125200}
area = pd.Series(area_dict)
area
```

The output is:

```Output
Albania       28748
France       643801
Germany      357386
Japan        377972
Russia     17125200
dtype: int64
```

Now you can combine this with the `population` `Series` that you created earlier. Use a dictionary to construct a single, two-dimensional table that contains data from both `Series`:

```python
countries = pd.DataFrame({'Population': population, 'Area': area})
countries
```

The output is:

```Output
|          | Population   | Area      |
---------------------------------------
| Albania  | NaN          | 28748     |
| France   | 65429495.0   | 643801    |
| Germany  | 82408706.0   | 357386    |
| Japan    | 126922333.0  | 377972    |
| Russia   | 143910127.0  | 17125200  |
```

As with `Series`, `DataFrames` also automatically order indices (in this case, the column indices *Area* and *Population*).

So far, you've combined dictionaries together to compose a `DataFrame` (which has given our `DataFrame` a row-centric feel), but you can also create `DataFrames` in a column-wise fashion. Consider adding a *Capital* column by using our reliable old array-analog, a list:

```python
countries['Capital/Major City'] = ['Tirana', 'Paris', 'Berlin', 'Tokyo', 'Moscow']
countries
```

The output is:

```Output
|          | Population   | Area      | Capital/Major City  |
-------------------------------------------------------------
| Albania  | NaN          | 28748     | Tirana              |
| France   | 65429495.0   | 643801    | Paris               |
| Germany  | 82408706.0   | 357386    | Berlin              |
| Japan    | 126922333.0  | 377972    | Tokyo               |
| Russia   | 143910127.0  | 17125200  | Moscow              |
```

As with `Series`, even though initial indices are ordered in `DataFrames`, subsequent additions to a `DataFrame` stay in the order added. However, you can explicitly change the order of `DataFrame` column indices this way:

```python
countries = countries[['Capital/Major City', 'Area', 'Population']]
countries
```

The output is:

```Output
|          | Capital/Major City   | Area      | Population   |
--------------------------------------------------------------
| Albania  |  Tirana              | 28748     | NaN          | 
| France   |  Paris               | 643801    | 65429495.0   | 
| Germany  |  Berlin              | 357386    | 82408706.0   | 
| Japan    |  Tokyo               | 377972    | 126922333.0  | 
| Russia   |  Moscow              | 17125200  | 143910127.0  | 
```

Commonly in a data-science context, you need to generate new columns of data from existing datasets. Because `DataFrame` columns behave like `Series`, you can do this by performing operations on them as you would with `Series`:

```python
countries['Population Density'] = countries['Population'] / countries['Area']
countries
```

The output is:

```Output
|          | Capital/Major City   | Area      | Population   | Population density |
-----------------------------------------------------------------------------------
| Albania  |  Tirana              | 28748     | NaN          | NaN                |
| France   |  Paris               | 643801    | 65429495.0   | 101.629999         |
| Germany  |  Berlin              | 357386    | 82408706.0   | 230.587393         |
| Japan    |  Tokyo               | 377972    | 126922333.0  | 335.798242         |
| Russia   |  Moscow              | 17125200  | 143910127.0  | 8.403413           |
```

> [!Note]
> Don't worry if IPython gives you a warning over this. The warning is IPython trying to be a little too helpful. The new column you created is an actual part of the `DataFrame`, and not a copy of a slice.

We have stated before that `DataFrames` are like dictionaries. You can retrieve the contents of a column just as you would the value for a specific key in an ordinary dictionary:

```python
countries['Area']
```

The output is:

```Output
Albania       28748
France       643801
Germany      357386
Japan        377972
Russia     17125200
Name: Area, dtype: int64
```

### What about using the row indices?

Now try accessing row data with a command like `countries['Japan']`.

This returns an error. `DataFrames` are dictionaries of `Series`, which are the columns. `DataFrame` rows often have heterogeneous data types, so different methods are necessary to access row data. For that, we use the `.loc` method:

```python
countries.loc['Japan']
```

The output is:

```Output
Capital/Major City                     Tokyo
Area                                  377972
Population                       1.26922e+08
Population Density                   335.798
Name: Japan, dtype: object
```

Note that what the `.loc` method returns is an indexed object in its own right, and you can access elements within it using familiar index syntax:

```python
countries.loc['Japan']['Area']
```

The output is:

```Output
377972
```

Can you think of a way to return the area of Japan without using the `.iloc` method?

> [!Tip]
> Try putting the column index first.

### Can you slice along these indices as well?

Sometimes it's helpful in data science projects to add a column to a `DataFrame` without assigning values to it:

```python
countries['Debt-to-GDP Ratio'] = np.nan
countries
```

The output is:

```Output
|          | Capital/Major City   | Area      | Population   | Population density | Debt-to-GDP ratio |
-------------------------------------------------------------------------------------------------------
| Albania  |  Tirana              | 28748     | NaN          | NaN                | NaN               |
| France   |  Paris               | 643801    | 65429495.0   | 101.629999         | NaN               |
| Germany  |  Berlin              | 357386    | 82408706.0   | 230.587393         | NaN               |
| Japan    |  Tokyo               | 377972    | 126922333.0  | 335.798242         | NaN               |
| Russia   |  Moscow              | 17125200  | 143910127.0  | 8.403413           | NaN               |
```

Again, you can disregard any warning you see about adding the column this way.

You can also add columns to a `DataFrame` that don't have the same number of rows as the `DataFrame`:

```python
debt = pd.Series([0.19, 2.36], index=['Russia', 'Japan'])
countries['Debt-to-GDP Ratio'] = debt
countries
```

The output is:

```Output
|          | Capital/Major City   | Area      | Population   | Population density | Debt-to-GDP ratio |
-------------------------------------------------------------------------------------------------------
| Albania  |  Tirana              | 28748     | NaN          | NaN                | NaN               |
| France   |  Paris               | 643801    | 65429495.0   | 101.629999         | NaN               |
| Germany  |  Berlin              | 357386    | 82408706.0   | 230.587393         | NaN               |
| Japan    |  Tokyo               | 377972    | 126922333.0  | 335.798242         | 2.36              |
| Russia   |  Moscow              | 17125200  | 143910127.0  | 8.403413           | 0.19              |
```

You can use the `del` command to delete a column from a `DataFrame`:

```python
del countries['Capital']
countries
```

The output is:

```Output
|          | Area      | Population   | Population density | Debt-to-GDP ratio |
--------------------------------------------------------------------------------
| Albania  | 28748     | NaN          | NaN                | NaN               |
| France   | 643801    | 65429495.0   | 101.629999         | NaN               |
| Germany  | 357386    | 82408706.0   | 230.587393         | NaN               |
| Japan    | 377972    | 126922333.0  | 335.798242         | 2.36              |
| Russia   | 17125200  | 143910127.0  | 8.403413           | 0.19              |
```

In addition to their dictionary-like behavior, `DataFrames` also behave like two-dimensional arrays. For example, when you're working with a `DataFrame`, you might want to transpose it:

```python
countries.T
```

The output is:

```Output
|                     | Albania  | France        | Germany       | Japan         | Russia        |
--------------------------------------------------------------------------------------------------
| Area                | 28748.0  | 6.438010e+05  | 3.573860e+05  | 3.779720e+05  | 1.712520e+07  |
| Population          | NaN      | 6.542950e+07  | 8.240871e+07  | 1.269223e+08  | 1.439101e+08  |
| Population density  | NaN      | 1.016300e+02  | 2.305874e+02  | 3.357982e+02  | 8.403413e+00  |
| Debt-to-GDP ratio   | NaN      | NaN           | NaN           | 2.360000e+00  | 1.900000e-01  |
```

Again, note that `DataFrame` columns are `Series`, and thus the data types must be consistent. This is the reason you see the upcasting to floating-point numbers.

> [!Important]
> If there had been strings in this `DataFrame`, everything would have been upcast to the `string` type. Use caution when transposing `DataFrames`.

## From a two-dimensional NumPy array

Given a two-dimensional array of data, you can create a `DataFrame` with any specified column and index names. If this is omitted, an integer index will be used for each:

```python
pd.DataFrame(np.random.rand(3, 2),
             columns=['random', 'example'],
             index=['a', 'b', 'c'])
```

The output is:

```Output
|    | random       | example       |
------------------------------
| a  | 0.733086  | 0.708453  |
| b  | 0.722008  | 0.048097  |
| c  | 0.275534  | 0.822378  |
```

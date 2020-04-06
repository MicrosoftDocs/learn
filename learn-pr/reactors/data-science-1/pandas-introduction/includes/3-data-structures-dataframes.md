The other crucial data structure in pandas to get to know for data science is the `DataFrame`. Like the `Series` object, `DataFrames` can be thought of either as generalizations of `ndarrays` (or as specializations of Python dictionaries).

Just as a `Series` is like a one-dimensional array with flexible indices, a `DataFrame` is like a two-dimensional array with both flexible row indices and flexible column names. Essentially, a `DataFrame` represents a rectangular table of data and contains an ordered collection of labeled columns, each of which can be a different value type (`string`, `int`, `float`, and so on). The `DataFrame` has both a row and column index; in this way you can think of it as a dictionary of `Series`, all of which share the same index.

> [!Note]
> **Sarah: Conversion feedback**
> 
> - Line 223: I converted some bold text to an Important note alert. I revised the text to "upcast to the `string` type."
>
> **Sarah: Action items**
> 
> - Search on "code cell below." These statements will need to be updated to coordinate with the new side-by-side exercise model. 
>

Let's take a look at how this works in practice. We will start by creating a `Series` called `area`:

```Python
area_dict = {'Albania': 28748,
             'France': 643801,
             'Germany': 357386,
             'Japan': 377972,
             'Russia': 17125200}
area = pd.Series(area_dict)
area
```

```Output
Albania       28748
France       643801
Germany      357386
Japan        377972
Russia     17125200
dtype: int64
```

Now you can combine this with the `population` `Series` you created earlier by using a dictionary to construct a single two-dimensional table containing data from both `Series`:

```Python
countries = pd.DataFrame({'Population': population, 'Area': area})
countries
```

### Table created with Markdown syntax

```Output```

|   | Population | Area |
|---|---|---|
| **Albania** | NaN | 28748 |
| **France** | 65429495.0 | 643801 |
| **Germany** | 82408706.0 | 357386 |
| **Japan** | 126922333.0 | 377972 |
| **Russia** | 143910127.0 | 17125200 |

### Table created with HTML div and table syntax

<div>
<style>
   table { border-collapse: collapse; border: 1px solid darkgrey; background-color:rgb(240,240,240); width: 300px; padding: 5px; }
   th { border: 1px solid darkgrey; text-align: left; padding: 5px; }
   tr { border: 1px solid darkgrey; text-align: left; padding: 5px; }
   td { border: 1px solid darkgrey; padding: 5px; }
</style>
<table>
   <tr>
       <th style="width: 100px"  ></th>
       <th style="width: 125px" >Population</th>
       <th style="width: 75px"  >Area</th></tr>
   <tr><th>Albania</th>
       <td>NaN</td><td>28748</td></tr>
   <tr><th>France</th>
       <td>65429495.0</td><td>643801</td></tr>
   <tr><th>Germany</th>
       <td>82408706.0</td><td>357386</td></tr>
   <tr><th>Japan</th>
       <td>126922333.0</td><td>377972</td></tr>
   <tr><th>Russia</th>
       <td>143910127.0</td><td>17125200</td></tr>
</table></div>


As with `Series`, the `DataFrames` also automatically order indices (in this case, the column indices 'Area' and 'Population').

So far we have combined dictionaries together to compose a `DataFrame` (which has given our `DataFrame` a row-centric feel), but you can also create `DataFrames` in a column-wise fashion. Consider adding a 'Capital' column using our reliable old array-analog, a list:

```Python
countries['Capital'] = ['Tirana', 'Paris', 'Berlin', 'Tokyo', 'Moscow']
countries
```

```Output```

|   | Population | Area | Capital |
|---|---|---|---|
| **Albania** | NaN | 28748 | Tirana |
| **France** | 65429495.0 | 643801 | Paris |
| **Germany** | 82408706.0 | 357386 | Berlin |
| **Japan** | 126922333.0 | 377972 | Tokyo |
| **Russia** | 143910127.0 | 17125200 | Moscow |

As with `Series`, even though initial indices are ordered in `DataFrames`, subsequent additions to a `DataFrame` stay in the ordered added. However, you can explicitly change the order of `DataFrame` column indices this way:

```Python
countries = countries[['Capital', 'Area', 'Population']]
countries
```

```Output```

|   | Capital | Area |  Population |
|---|---|---|---|
| **Albania** | Tirana | 28748 | NaN |
| **France** | Paris | 643801 | 65429495.0 |
| **Germany** | Berlin | 357386 | 82408706.0 |
| **Japan** | Tokyo | 377972 | 126922333.0 |
| **Russia** | Moscow | 17125200 | 143910127.0 |

Commonly in a data science context, it is necessary to generate new columns of data from existing data sets. Because `DataFrame` columns behave like `Series`, you can do this is by performing operations on them as you would with `Series`:

```Python
countries['Population Density'] = countries['Population'] / countries['Area']
countries
```

```Output```

|   | Capital | Area |  Population | Population density |
|---|---|---|---|---|
| **Albania** | Tirana | 28748 | NaN | NaN |
| **France** | Paris | 643801 | 65429495.0 | 101.629999 |
| **Germany** | Berlin | 357386 | 82408706.0 | 230.587393 |
| **Japan** | Tokyo | 377972 | 126922333.0 | 335.798242 |
| **Russia** | Moscow | 17125200 | 143910127.0 | 8.403413 |

> [!Note]
> Don't worry if IPython gives you a warning over this. The warning is IPython trying to be a little too helpful. The new column you created is an actual part of the `DataFrame` and not a copy of a slice.

We have stated before that `DataFrames` are like dictionaries, and it's true. You can retrieve the contents of a column just as you would the value for a specific key in an ordinary dictionary:

```Python
countries['Area']
```

```Output
Albania       28748
France       643801
Germany      357386
Japan        377972
Russia     17125200
Name: Area, dtype: int64
```

What about using the row indices?

Now try accessing row data with a command like `countries['Japan']`

This returns an error. `DataFrames` are dictionaries of `Series`, which are the columns. `DataFrame` rows often have heterogeneous data types, so different methods are necessary to access row data. For that, we use the `.loc` method:

```Python
countries.loc['Japan']
```

```Output
Capital                     Tokyo
Area                       377972
Population            1.26922e+08
Population Density        335.798
Name: Japan, dtype: object
```

Note that what the `.loc` method returns is an indexed object in its own right and you can access elements within it using familiar index syntax:

```Python
countries.loc['Japan']['Area']
```

```Output
377972
```

Can you think of a way to return the area of Japan without using the `.iloc` method?

> [!Tip]
> Try putting the column index first.


Can you slice along these indices as well?

Sometimes it's helpful in data science projects to add a column to a `DataFrame` without assigning values to it:

```Python
countries['Debt-to-GDP Ratio'] = np.nan
countries
```

```Output```

|   | Capital | Area |  Population | Population density | Debt-to-GDP ratio |
|---|---|---|---|---|---|
| **Albania** | Tirana | 28748 | NaN | NaN | NaN |
| **France** | Paris | 643801 | 65429495.0 | 101.629999 | NaN |
| **Germany** | Berlin | 357386 | 82408706.0 | 230.587393 | NaN |
| **Japan** | Tokyo | 377972 | 126922333.0 | 335.798242 | NaN |
| **Russia** | Moscow | 17125200 | 143910127.0 | 8.403413 | NaN |

Again, you can disregard the warning (if it triggers) about adding the column this way.

You can also add columns to a `DataFrame` that do not have the same number of rows as the `DataFrame`:

```Python
debt = pd.Series([0.19, 2.36], index=['Russia', 'Japan'])
countries['Debt-to-GDP Ratio'] = debt
countries
```

```Output```

|   | Capital | Area |  Population | Population density | Debt-to-GDP ratio |
|---|---|---|---|---|---|
| **Albania** | Tirana | 28748 | NaN | NaN | NaN |
| **France** | Paris | 643801 | 65429495.0 | 101.629999 | NaN |
| **Germany** | Berlin | 357386 | 82408706.0 | 230.587393 | NaN |
| **Japan** | Tokyo | 377972 | 126922333.0 | 335.798242 | 2.36 |
| **Russia** | Moscow | 17125200 | 143910127.0 | 8.403413 | 0.19 |

You can use the`del` command to delete a column from a `DataFrame`:

```Python
del countries['Capital']
countries
```

```Output```

|   | Area |  Population | Population density | Debt-to-GDP ratio |
|---|---|---|---|---|
| **Albania** | 28748 | NaN | NaN | NaN |
| **France** | 643801 | 65429495.0 | 101.629999 | NaN |
| **Germany** | 357386 | 82408706.0 | 230.587393 | NaN |
| **Japan** | 377972 | 126922333.0 | 335.798242 | 2.36 |
| **Russia** | 17125200 | 143910127.0 | 8.403413 | 0.19 |

In addition to their dictionary-like behavior, `DataFrames` also behave like two-dimensional arrays. For example, it can be useful at times when working with a `DataFrame` to transpose it:

```Python
countries.T
```

```Output```

|   | Albania |  France | Germany | Japan | Russia |
|---|---|---|---|---|---|
| **Area** | 28748.0 | 6.438010e+05 | 3.573860e+05 | 3.779720e+05 | 1.712520e+07 |
| **Population** | NaN | 6.542950e+07 | 8.240871e+07 | 1.269223e+08 | 1.439101e+08 |
| **Population density** | NaN | 1.016300e+02 | 2.305874e+02 | 3.357982e+02 | 8.403413e+00 |
| **Debt-to-GDP ratio** | NaN | NaN | NaN | 2.360000e+00 | 1.900000e-01 |

Again, note that `DataFrame` columns are `Series` and thus the data types must consistent, hence the upcasting to floating-point numbers.

> [!Important]
> If there had been strings in this `DataFrame`, everything would have been upcast to the `string` type. Use caution when transposing `DataFrames`.

## From a two-dimensional NumPy array
Given a two-dimensional array of data, we can create a `DataFrame` with any specified column and index names. If omitted, an integer index will be used for each:

```Python
pd.DataFrame(np.random.rand(3, 2),
             columns=['foo', 'bar'],
             index=['a', 'b', 'c'])
```

```Output```

|   | foo | bar |
|---|---|---|
| **a** | 0.733086 | 0.708453 |
| **b** | 0.722008 | 0.048097 |
| **c** | 0.275534 | 0.822378 |

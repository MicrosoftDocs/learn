`DataFrames` also exhibit dual behavior, acting both like a two-dimensional `ndarray` and like a dictionary of `Series` sharing the same index.

> [!Note]
> **Sarah: Action items**
> 
> - Search on "TBD" in Hints for Try it yourself blocks.
>

## DataFrame as dictionary of Series

Let's return to our earlier example of countries' areas and populations in order to examine `DataFrames` as a dictionary of `Series`.

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

The output is:

```Output
|          | Area     | Population | 
------------------------------------
| Albania  | 28748    | 2937590    |
| France   | 643801   | 65429495   | 
| Germany  | 357386   | 82408706   | 
| Japan    | 377972   | 126922333  | 
| Russia   | 17125200 | 143910127  | 
```

You can access the individual `Series` that make up the columns of a `DataFrame` via dictionary-style indexing of the column name:

```Python
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

And you can use dictionary-style syntax can also be used to modify `DataFrames`, such as by adding a new column:

```Python
countries['Population Density'] = countries['Population'] / countries['Area']
countries
```

The output is:

```Output
|          | Area      | Population   | Population density |
------------------------------------------------------------
| Albania  | 28748     | 2937590      | 102.184152         |
| France   | 643801    | 65429495.0   | 101.629999         |
| Germany  | 357386    | 82408706.0   | 230.587393         |
| Japan    | 377972    | 126922333.0  | 335.798242         |
| Russia   | 17125200  | 143910127.0  | 8.403413           |
```

## DataFrame as two-dimensional array

You can also think of `DataFrames` as two-dimensional arrays. You can examine the raw data in the `DataFrame` or data array using the `values` attribute:

```Python
countries.values
```

The output is:

```Output
array([[2.87480000e+04, 2.93759000e+06, 1.02184152e+02],
       [6.43801000e+05, 6.54294950e+07, 1.01629999e+02],
       [3.57386000e+05, 8.24087060e+07, 2.30587393e+02],
       [3.77972000e+05, 1.26922333e+08, 3.35798242e+02],
       [1.71252000e+07, 1.43910127e+08, 8.40341292e+00]])
```

Viewed this way, it makes sense that we can transpose the rows and columns of a `DataFrame` the same way we would an array:

```Python
countries.T
```

The output is:

```Output
|                     | Albania       | France        | Germany       | Japan         | Russia        |
-------------------------------------------------------------------------------------------------------
| Area                | 2.874800e+04  | 6.438010e+05  | 3.573860e+05  | 3.779720e+05  | 1.712520e+07  |
| Population          | 2.937590e+06  | 6.542950e+07  | 8.240871e+07  | 1.269223e+08  | 1.439101e+08  |
| Population density  | 1.021842e+02  | 1.016300e+02  | 2.305874e+02  | 3.357982e+02  | 8.403413e+00  |
```

`DataFrames` also uses the `loc` and `iloc` indexers. With `iloc`, you can index the underlying array as if it were an `ndarray` but with the `DataFrame` index and column labels maintained in the result:

```Python
countries.iloc[:3, :2]
```

The output is:

```Output
|          | Area     | Population | 
------------------------------------
| Albania  | 28748    | 2937590    |
| France   | 643801   | 65429495   | 
| Germany  | 357386   | 82408706   | 
```

`loc` also permits array-like slicing but using the explicit index and column names:

```Python
countries.loc[:'Germany', :'Population']
```

The output is:

```Output
|          | Area     | Population | 
------------------------------------
| Albania  | 28748    | 2937590    |
| France   | 643801   | 65429495   | 
| Germany  | 357386   | 82408706   | 
```

You can also use array-like techniques such as masking and fancy indexing with loc.

### Try it yrouself

Can you think of how to combine masking and fancy indexing in one line?

- Your masking could be something like `countries['Population Density'] > 200`.
- Your fancy indexing could be something like `['Population', 'Population Density']`.

Be sure to put the the masking and fancy indexing inside the square brackets: `countries.loc[]`.

<details>
  <summary>Sarah: TBD Hint <i>(expand to reveal)</i></summary>

  Hint goes here.
</details>

## Indexing conventions

In practice in the world of data science (and pandas more generally), _indexing_ refers to columns while _slicing_ refers to rows.

```Python
countries['France':'Japan']
```

The output is:

```Output
|          | Area      | Population   | Population density |
------------------------------------------------------------
| France   | 643801    | 65429495.0   | 101.629999         |
| Germany  | 357386    | 82408706.0   | 230.587393         |
| Japan    | 377972    | 126922333.0  | 335.798242         |
```

Such slices can also refer to rows by number rather than by index:

```Python
countries[1:3]
```

The output is:

```Output
|          | Area      | Population   | Population density |
------------------------------------------------------------
| France   | 643801    | 65429495.0   | 101.629999         |
| Germany  | 357386    | 82408706.0   | 230.587393         |
```

Similarly, direct masking operations are also interpreted row-wise rather than column-wise:

```Python
countries[countries['Population Density'] > 200]
```

The output is:

```Output
|          | Area      | Population   | Population density |
------------------------------------------------------------
| Germany  | 357386    | 82408706.0   | 230.587393         |
| Japan    | 377972    | 126922333.0  | 335.798242         |
```

These two conventions are syntactically similar to those on a NumPy array, and while these may not precisely fit the mold of the Pandas conventions, they are nevertheless quite useful in practice.

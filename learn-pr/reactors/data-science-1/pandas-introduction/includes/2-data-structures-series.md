Both Series and DataFrames are a lot like the `ndarrays` you encountered in the NumPy module. They provide clean, efficient data storage and handling at the scales necessary for data science. What both of them provide that ndarrays lack, however, are essential data-science features like flexibility when dealing with missing data and the ability to label data. These capabilities (along with others) help make Series and DataFrames essential to the "data munging" that make up so much of data science.

> [!Note]
> **Sarah: Action items**
> 
> - Add output for commands.
> - Add one or more sentences as introduction / scenario statement for the Exercises H2 heading and H3 headings that follow.
> - Lead sentence mentions NumPy module in the LP, which isn't standard for Learn content.
>

## Series objects in pandas

A pandas `Series` is a lot like an `ndarray` in NumPy, a one-dimensional array of indexed data. You can create a simple `Series` from an array of data like this:

```Python
series_example = pd.Series([-0.5, 0.75, 1.0, -2])
series_example
```


```output
TBD
```

Similar to an `ndarray`, a `Series` upcasts entries to be of the same type of data (that -2 integer in the original array became a -2.00 float in the Series).

What is different from an ndarray is that the Series automatically wraps both a sequence of values and a sequence of indices. These are two separate objects within the Series object that can access with the values and index attributes.

Try accessing the values first; they are just a familiar NumPy array:

```Python
series_example.values
```


```output
TBD
```

The index is also an array-like object:

```Python
series_example.index
```


```output
TBD
```

Just as with ndarras, you can access specific data elements in a Series via the familiar Python square-bracket index notation and slicing:

```Python
series_example[1]
series_example[1:3]
```


```output
TBD
```

Despite a lot of similarities, pandas Series have an important distinction from NumPy ndarrays: whereas ndarrays have implicitly defined integer indices (as do Python lists), pandas Series have explicitly defined indices. The best part is that you can set the index:

```Python
series_example2 = pd.Series([-0.5, 0.75, 1.0, -2], index=['a', 'b', 'c', 'd'])
series_example2
```


```output
TBD
```

These explicit indices work exactly the way you would expect them to:

```Python
series_example2['b']
```


```output
TBD
```

## Exercises

Let's try these exercises.

### Slice series_example2 Series

Do explicit Series indices work _exactly_ the way you might expect? Try slicing `series_example2` using its explicit index and find out.

With explicit indices in the mix, a Series is basically a fixed-length, ordered dictionary in that it maps arbitrary typed index values to arbitrary typed data values. But like ndarrays these data are all of the same type, which is important. Just as the type-specific compiled code behind ndarray makes them more efficient than a Python lists for certain operations, the type information of pandas Series makes them much more efficient than Python dictionaries for certain operations.

But the connection between Series and dictionaries is nevertheless very real. You can construct a Series object directly from a Python dictionary:

```Python
population_dict = { 'France': 65429495,
                    'Germany': 82408706,
                    'Russia': 143910127,
                    'Japan': 126922333 }
population = pd.Series(population_dict)
population
```


```output
TBD
```

Did you see what happened there? The order of the keys Russia and Japan in the switched places between the order in which they were entered in population_dict and how they ended up in the population Series object. While Python dictionary keys have no order, Series keys are ordered.

So, at one level, you can interact with Series as you would with dictionaries:

```Python
population['Russia']
But you can also do powerful array-like operations with Series like slicing:
```

### Slice population Series

Try slicing on the `population` Series on your own. Would slicing be possible if Series keys were not ordered?
You can also add elements to a Series the way that you would to an ndarray. Try it in the code cell below:

You can also add elements to a Series the way that you would to an ndarray. Try it in the code cell below:

```Python
???
```


```output
TBD
```

### Run population Series

```Python
population['Albania'] = 2937590
```


```output
TBD
```

Try running population['Albania'] = 2937590 (or another country of your choice)
What order do the keys appear in when you run population? Is it what you expected?

Another useful Series feature (and definitely a difference from dictionaries) is that Series automatically aligns differently indexed data in arithmetic operations:

```Python
pop2 = pd.Series({'Spain': 46432074, 'France': 102321, 'Albania': 50532})
population + pop2
```


```output
TBD
```

Notice that in the case of Germany, Japan, Russia, and Spain (and Albania, depending on what you did in the previous exercise), the addition operation produced NaN (not a number) values. pandas does not treat missing values as 0, but as NaN (and it can be helpful to think of arithmetic operations involving NaN as essentially NaN$ + x=$ NaN).

> [!Note]
> **Sarah: Conversion feedback**
> 
> We recommend a transition to a new unit topic here.
> Move to the next unit inthe module to continue with the content from the source material.

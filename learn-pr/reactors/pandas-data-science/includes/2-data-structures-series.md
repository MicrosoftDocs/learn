<!--- Reviewer note: This unit uses LaTex math formatting. The dollar sign $ starts and ends each LaTeX statement. -->

Both `Series` and `DataFrames` are a lot like the `ndarrays` you encountered in the NumPy module. They provide clean, efficient data storage and handling at the scales necessary for data science. What both of them provide that `ndarrays` lack, however, are essential data-science features like flexibility when dealing with missing data and the ability to label data. These capabilities (along with others) help make `Series` and `DataFrames` essential to the "data munging" that make up so much of data science.

## Series objects in pandas

A pandas `Series` is a lot like an `ndarray` in NumPy, a one-dimensional array of indexed data. You can create a simple `Series` from an array of data like this:

```python
Series_example = pd.`Series`([-0.5, 0.75, 1.0, -2])
Series_example
```

The output is:

```Output
0   -0.50
1    0.75
2    1.00
3   -2.00
dtype: float64
```

Similar to an `ndarray`, a `Series` upcasts entries to be of the same type of data (that -2 integer in the original array became a -2.00 float in the `Series`).

What is different from an `ndarray` is that the `Series` automatically wraps both a sequence of values and a sequence of indices. These are two separate objects within the `Series` object that you can access with the `values` and `index` attributes.

Try accessing the `values` first. They're just a familiar NumPy array:

```python
Series_example.values
```

The output is:

```Output
array([-0.5 ,  0.75,  1.  , -2.  ])
```

The `index` is also an array-like object:

```python
Series_example.index
```

The output is:

```Output
RangeIndex(start=0, stop=4, step=1)
```

Just as with `ndarrays`, you can access specific data elements in a `Series` via the familiar Python square-bracket `[]` index notation and slicing:

```python
series_example[1]
```

The output is:

```Output
0.75
```

Another example:

```python
series_example[1:3]
```

The output is:

```Output
1    0.75
2    1.00
dtype: float64
```

Despite a lot of similarities, pandas `Series` have an important distinction from NumPy `ndarrays`. Whereas `ndarrays` have _implicitly defined_ integer indices (as do Python lists), pandas `Series` have explicitly defined indices. The best part is that you can set the index:

```python
Series_example2 = pd.`Series`([-0.5, 0.75, 1.0, -2], index=['a', 'b', 'c', 'd'])
Series_example2
```

The output is:

```Output
a   -0.50
b    0.75
c    1.00
d   -2.00
dtype: float64
```

These explicit indices work exactly the way you would expect them to:

```python
Series_example2['b']
```

The output is:

```Output
0.75
```

### Try it yourself

You're experienced in Jupyter Notebooks and experimenting with Python now, so use those new super-powers to predict and test.

- Predict: What would happen if you sliced `series_example2` by using its explicit index?
- Test: Try it out in Visual Studio Code. Was the output what you expected?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  series_example2['b':]
  ```

  ```Output
  b    0.75
  c    1.00
  d   -2.00
  dtype: float64
  ```

</details>

<br /><br />

***

Do explicit `Series` indices work exactly the way you might expect? Try slicing `Series_example2` by using its explicit index, and find out.

With explicit indices in the mix, a `Series` is basically a fixed-length, ordered dictionary in that it maps arbitrary typed index values to arbitrary typed data values. But like `ndarrays`, these data are all of the same type, which is important. Just as the type-specific compiled code behind `ndarray` makes them more efficient than a Python lists for certain operations, the type information of pandas `Series` makes them much more efficient than Python dictionaries for certain operations.

But the connection between `Series` and dictionaries is nevertheless very real. You can construct a `Series` object directly from a Python dictionary:

```python
population_dict = { 'France': 65429495,
                    'Germany': 82408706,
                    'Russia': 143910127,
                    'Japan': 126922333 }
population = pd.`Series`(population_dict)
population
```

The output is:

```Output
France      65429495
Germany     82408706
Russia     143910127
Japan      126922333
dtype: int64
```

Did you see what happened there? The order of the keys *Russia* and *Japan* switched places, between the order in which they were entered in `population_dict`, and how they ended up in the `population` `Series` object. While Python dictionary keys have no order, `Series` keys are ordered.

So, at one level, you can interact with `Series` as you would with dictionaries:

```python
population['Russia']
```

The output is:

```Output
143910127
```

### Try it yourself

But you can also do powerful, array-like operations with `Series`, like slicing.

- Predict: Would slicing be possible if `Series` keys weren't ordered?
- Test: Try it out in Visual Studio Code. Create an unordered `Series`, and try slicing it. Did it do what you expected?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  population['Germany':]
  ```

  ```Output
  Germany     82408706
  Japan      126922333
  Russia     143910127
  dtype: int64
  ```

</details>

<br /><br />

***

### Try it yourself

You can also add elements to a `Series` the way that you would to an `ndarray`.

- Try adding elements to a `Series` in the following code cell.
- Try running `population['Albania'] = 2937590` (or another country of your choice).
- Predict what order the keys appear in when you run `population`. Is it what you expected?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  population['Albania'] = 2937590
  population
  ```

  ```Output
  France      65429495
  Germany     82408706
  Japan      126922333
  Russia     143910127
  Albania      2937590
  dtype: int64
  ```
  
</details>

<br /><br />

***

Another useful `Series` feature (and definitely a difference from dictionaries) is that `Series` automatically aligns differently indexed data in arithmetic operations:

```python
pop2 = pd.`Series`({'Spain': 46432074, 'France': 102321, 'Albania': 50532})
population + pop2
```

The output is:

```Output
Albania           NaN
France     65531816.0
Germany           NaN
Japan             NaN
Russia            NaN
Spain             NaN
dtype: float64
```

Notice that in the case of *Germany*, *Japan*, *Russia*, and *Spain* (and *Albania*, depending on what you did in the previous exercise), the addition operation produced NaN (not a number) values. pandas doesn't treat missing values as 0, but as NaN. (It can be helpful to think of arithmetic operations involving NaN as essentially $NaN + x = NaN$).

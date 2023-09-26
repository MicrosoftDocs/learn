For our first example, suppose you're combining two different data sources to find only the top five countries/regions by area and the top five countries/regions by population:

```python
area = pd.Series({'Russia': 17075400, 'Canada':  9984670,
                  'USA': 9826675, 'China': 9598094, 
                  'Brazil': 8514877}, name='area')
population = pd.Series({'China': 1409517397, 'India': 1339180127,
                        'USA': 324459463, 'Indonesia': 322179605, 
                        'Brazil': 207652865}, name='population')
```

### Try it yourself

Now divide these to compute the population density.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  population / area
  ```

  ```Output
  Brazil        24.387066
  Canada              NaN
  China        146.853885
  India               NaN
  Indonesia           NaN
  Russia              NaN
  USA           33.018235
  dtype: float64
  ```
  
</details>

<br /><br />

***

Your resulting array contains the union of indices of the two input arrays: seven countries/regions in total. All the countries/regions in the array without an entry (because they lacked either area data or population data) are marked with the now-familiar NaN, or "Not a Number," designation.

Index matching works the same way as built-in Python arithmetic expressions, and missing values are filled in with NaNs. You can see this clearly by adding two `Series` that are slightly misaligned in their indices:

```python
series1 = pd.Series([2, 4, 6], index=[0, 1, 2])
series2 = pd.Series([3, 5, 7], index=[1, 2, 3])
series1 + series2
```

The output is:

```Output
0     NaN
1     7.0
2    11.0
3     NaN
dtype: float64
```

NaN values aren't always convenient to work with. NaN combined with any other values results in NaN, which can be a pain, particularly if you are combining multiple data sources with missing values. To help with this, pandas allows you to specify a default value to use for missing values in the operation. For example, calling `series1.add(series2)` is equivalent to calling `series1 + series2`, but you can supply the fill value:

```python
series1.add(series2, fill_value=0)
```

The output is: 

```Output
0     2.0
1     7.0
2    11.0
3     7.0
dtype: float64
```

Much better!

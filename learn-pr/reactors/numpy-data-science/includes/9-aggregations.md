One of the first things you'll find yourself doing with most datasets is computing the summary statistics for the data to get a general overview of your data before exploring it further. These summary statistics include the mean and standard deviation, in addition to other aggregates, like the sum, product, median, minimum and maximum, and quantiles of the data.

NumPy has fast built-in aggregation functions for working on arrays. They are the subject of this subsection.

## Summing the values of an array

You can use the built-in Python `sum` function to sum up the values in an array.

```python
import numpy as np
```

```python
myList = np.random.random(100)
sum(myList)
```

The output is:

```Output
50.461758453195614
```

If you guessed that there's also a built-in NumPy function for this operation, you guessed correctly:

```python
np.sum(myList)
```

The output is:

```Output
50.46175845319564
```

And if you guessed that the NumPy version is faster, you're doubly correct:

```python
large_array = np.random.rand(1000000)
%timeit sum(large_array)
%timeit np.sum(large_array)
```

The output is:

```Output
124 ms ± 5.38 ms per loop (mean ± std. dev. of 7 runs, 10 loops each)
814 µs ± 74.4 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)
```

For all their similarity, keep in mind that `sum` and `np.sum` aren't identical. Their optional arguments have different meanings, and `np.sum` is aware of multiple array dimensions.

## Minimum and maximum

Just as Python has built-in `min` and `max` functions, NumPy has similar, vectorized versions:

```python
np.min(large_array), np.max(large_array)
```

The output is:

```Output
(7.071203171893359e-07, 0.9999997207656334)
```

You can also use `min`, `max`, and `sum` (and several other NumPy aggregates) as methods of the array object itself:

```python
print(large_array.min(), large_array.max(), large_array.sum())
```

The output is:

```Output
7.071203171893359e-07 0.9999997207656334 500216.8034810001
```

## Multidimensional aggregates

You'll often treat the rows and columns of two-dimensional arrays differently (treating columns as variables and rows as observations of those variables, for example). So it can often be desirable to aggregate array data along a row or column. Consider a two-dimensional array:

```python
md = np.random.random((3, 4))
print(md)
```

The output is:

```Output
[[0.79832448 0.44923861 0.95274259 0.03193135]
 [0.18441813 0.71417358 0.76371195 0.11957117]
 [0.37578601 0.11936151 0.37497044 0.22944653]]
```

Unless you specify otherwise, each NumPy aggregation function will compute the aggregate for the entire array. So, for:

```python
md.sum()
```

The output is:

```Output
5.1136763453287335
```

Aggregation functions take an additional argument that specifies the *axis* along which to compute the aggregation. For example, we can find the minimum value within each column by specifying `axis=0`:

```python
md.min(axis=0)
```

The output is:

```Output
array([0.18441813, 0.11936151, 0.37497044, 0.03193135])
```

### Try it yourself

What do you get when you try `md.max(axis=1)`?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  md.max(axis=1)
  ```
  
  The output is:

  ```Output
  array([0.95274259, 0.76371195, 0.37578601])
  ```
  
</details>

<br /><br />

***

Remember that the `axis` keyword specifies the *dimension of the array that's to be collapsed*, not the dimension that will be returned. So if you specify `axis=0`, the first axis will be collapsed. For two-dimensional arrays, this means that values within each column will be aggregated.

## Other aggregation functions

This table lists other NumPy aggregation functions. Most NumPy aggregates have a "`NaN`-safe" version, which computes the result while it ignores missing values marked by the `NaN` value.

| Function name | NaN-safe version | Description |
| --- | --- | --- |
| `np.sum` | `np.nansum` | Compute sum of elements |
| `np.prod` | `np.nanprod` | Compute product of elements |
| `np.mean` | `np.nanmean` | Compute mean of elements |
| `np.std` | `np.nanstd` | Compute standard deviation |
| `np.var` | `np.nanvar` | Compute variance |
| `np.min` | `np.nanmin` | Find minimum value |
| `np.max` | `np.nanmax` | Find maximum value |
| `np.argmin` | `np.nanargmin` | Find index of minimum value |
| `np.argmax` | `np.nanargmax` | Find index of maximum value |
| `np.median` | `np.nanmedian` | Compute median of elements |
| `np.percentile` | `np.nanpercentile` | Compute rank-based statistics of elements |
| `np.any` | Not applicable | Evaluate whether any elements are true |
| `np.all` | Not applicable | Evaluate whether all elements are true |

We'll see these aggregates often in the rest of this course.

>[!div class="alert is-tip"]
>### Takeaway
>
>Aggregation is the main method you'll use to explore you data, not just when you use NumPy, but particularly in conjunction with pandas, the Python library you'll learn about in the next section. That section builds off of NumPy and therefore off of everything you've learned so far.

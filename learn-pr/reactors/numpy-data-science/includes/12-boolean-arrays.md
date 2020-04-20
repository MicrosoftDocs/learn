Given a Boolean array, there are a host of useful operations you can do. We'll work with `two_dim_array`, the two-dimensional array we created earlier.

```Python
print(two_dim_array)
```

```Output
[[5 0 3 3]
 [7 9 3 5]
 [2 4 7 6]]
```

## Counting entries

To count the number of `True` entries in a Boolean array, `np.count_nonzero` is useful:

How many values less than 6?

```Python
np.count_nonzero(two_dim_array < 6)
```

```Output
8
```

We see that there are eight array entries that are less than 6. Another way to get at this information is to use `np.sum`; in this case, `False` is interpreted as `0`, and `True` is interpreted as `1`:

```Python
np.sum(two_dim_array < 5)
```

```Output
6
```

The benefit of `sum()` is that, like with other NumPy aggregation functions, this summation can be done along rows or columns as well:

How many values less than 5 in each row?

```Python
np.sum(two_dim_array < 5, axis=1)
```

```Output
array([3, 1, 2])
```

This counts the number of values less than 5 in each row of the matrix.

If we're interested in quickly checking whether any or all the values are true, we can use (you guessed it) `np.any` or `np.all`:

Are there any values less than zero?

```Python
np.any(two_dim_array < 0)
```

```Output
False
```

### Try it yourself

Now check to see if all values less than 10?

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```Python
  np.all(two_dim_array < 10)
  ```
  
  ```Output
  True
  ```

</details>

`np.all` and `np.any` can be used along particular axes as well. For example:

Are all values in each row less than 7?

```Python
np.all(two_dim_array < 7, axis=1)
```

```Output
array([ True, False, False])
```

Here, all the elements in the first and third rows are less than 7, while this is not the case for the second row.

>[!div class="alert is-tip"]
>### Reminder
>
>Python has built-in `sum()`, `any()`, and `all()` functions. These have a different syntax than the NumPy versions, and, in particular, will fail or produce unintended results when used on multidimensional arrays. Be sure that you are using `np.sum()`, `np.any()`, and `np.all()` for these examples.

## Boolean operators

We've already seen how we might count, say, all months with rain less than four inches, or all months with more than two inches of rain. But what if we want to know about all months with rain less than four inches and greater than one inch? This is accomplished through Python's *bitwise logic operators*, `&`, `|`, `^`, and `~`. Like with the standard arithmetic operators, NumPy overloads these as ufuncs which work element-wise on (usually Boolean) arrays.

For example, we can address this sort of compound question as follows:

```Python
np.sum((rainfall_2003 > 0.5) & (rainfall_2003 < 1))
```

```Output
2
```

So we see that there are two months with rainfall between 0.5 and 1.0 inches. Note that the parentheses here are important - because of operator-precedence rules, with parentheses removed, this expression would be evaluated as follows, which results in an error:

```Python
rainfall_2003 > (0.5 & rainfall_2003) < 1
```

```Output
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-215-4dddd2f98919> in <module>
----> 1  rainfall_2003 > (0.5 & rainfall_2003) < 1

TypeError: ufunc 'bitwise_and' not supported for the input types, and the inputs could not be safely coerced to any supported types according to the casting rule ''safe''
```

Using the equivalence of *A AND B and NOT (NOT A OR NOT B)* (which you might remember if you've taken an introductory logic course), we can compute the same result in a different manner:

```Python
np.sum(~((rainfall_2003 <= 0.5) | (rainfall_2003 >= 1)))
```

```Output
2
```

Combining comparison operators and Boolean operators on arrays can lead to a wide range of efficient logical operations.

The following table summarizes the bitwise Boolean operators and their equivalent ufuncs:

| Operator | Equivalent ufunc |
| --- | --- |
| & | `np.bitwise_and` | 
| \| | `np.bitwise_or` |
| ^ | `np.bitwise_xor` |
| ~ | `np.bitwise_not` |

Using these tools, you can start to answer the types of questions we listed above about the Seattle rainfall data. Here are some examples of results we can compute when combining masking with aggregations:

```Python
print("Number of months without rain:", np.sum(rainfall_2003 == 0))
print("Number of months with rain:   ", np.sum(rainfall_2003 != 0))
print("Months with more than 1 inch: ", np.sum(rainfall_2003 > 1))
print("Rainy months with < 1 inch:   ", np.sum((rainfall_2003 > 0) &
                                              (rainfall_2003 < 1)))
```

```Output
Number of months without rain: 0
Number of months with rain:    12
Months with more than 1 inch:  7
Rainy months with < 1 inch:    5
```

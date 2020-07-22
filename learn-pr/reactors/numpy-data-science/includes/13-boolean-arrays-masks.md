In the previous section, we looked at aggregates computed directly on Boolean arrays. A more powerful pattern is to use Boolean arrays as masks to select particular subsets of the data themselves. Returning to our `two_dim_array` array from earlier, suppose we want an array of all values in the array that are less than 5:

```python
two_dim_array
```

The output is:

```Output
array([[5, 0, 3, 3],
       [7, 9, 3, 5],
       [2, 4, 7, 6]])
```

You can obtain a Boolean array for this condition easily:

```python
two_dim_array < 5
```

The output is:

```Output
array([[False,  True,  True,  True],
       [False, False,  True, False],
       [ True,  True, False, False]])
```

Now, to *select* these values from the array, you can simply index on this Boolean array. This is the *masking* operation:

```python
two_dim_array[two_dim_array < 5]
```

The output is:

```Output
array([0, 3, 3, 3, 2, 4])
```

What is returned is a one-dimensional array filled with all the values that meet your condition. Put another way, these are all the values in positions at which the mask array is `True`.

You can use masking as a way to compute some relevant statistics on the Seattle rain data:

```python
# Construct a mask of all rainy months
rainy = (rainfall_2003 > 0)

# Construct a mask of all summer months (June through September)
months = np.arange(1, 13)
summer = (months > 5) & (months < 10)

print("Median precip in rainy months in 2003 (inches):   ",
      np.median(rainfall_2003[rainy]))
print("Median precip in summer months in 2003 (inches):  ",
      np.median(rainfall_2003[summer]))
print("Maximum precip in summer months in 2003 (inches): ",
      np.max(rainfall_2003[summer]))
print("Median precip in non-summer rainy months (inches):",
      np.median(rainfall_2003[rainy & ~summer]))
```

The output is:

```Output
Median precip in rainy months in 2003 (inches):    1.94
Median precip in summer months in 2003 (inches):   0.41000000000000003
Maximum precip in summer months in 2003 (inches):  0.97
Median precip in non-summer rainy months (inches): 2.865
```

>[!div class="alert is-tip"]
>### Takeaway
>
>By combining Boolean operations, masking operations, and aggregates, you can quickly answer questions similar to those we posed about the Seattle rainfall data about any dataset. Operations like these will form the basis for the data exploration and preparation for analysis that will be our primary concerns in Sections 4 and 5.

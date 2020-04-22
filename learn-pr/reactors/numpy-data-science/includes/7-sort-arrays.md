So far we have just worried about accessing and modifying NumPy arrays. Another huge thing you will need to do as a data scientist is sort array data. Sorting is often an important means of teasing out the structure in data (such as outlying data points).

Although you could use Python's built-in `sort` and `sorted` functions, they will not work nearly as efficiently as NumPy's `np.sort` function.

`np.sort` returns a sorted version of an array without modifying the input:

```Python
a = np.array([2, 1, 4, 3, 5])
np.sort(a)
```

The output is:

```Output
array([1, 2, 3, 4, 5])
```

In order to sort the array in-place, use the `sort` method directly on arrays:

```Python
a.sort()
print(a)
```

The output is:

```Output
[1 2 3 4 5]
```

A related function is `argsort`, which returns the *indices* of the sorted elements rather than the elements themselves:

```Python
a = np.array([2, 1, 4, 3, 5])
b = np.argsort(a)
print(b)
```

The output is:

```Output
[1 0 3 2 4]
```

The first element of this result gives the index of the smallest element, the second value gives the index of the second smallest, and so on. These indices can then be used (via fancy indexing) to reconstruct the sorted array:

```Python
a[b]
```

The output is:

```Output
array([1, 2, 3, 4, 5])
```

## Sorting along rows or columns

A useful feature of NumPy's sorting algorithms is the ability to sort along specific rows or columns of a multidimensional array using the `axis` argument. For example:

```Python
rand = np.random.RandomState(42)
table = rand.randint(0, 10, (4, 6))
print(table)
```

The output is:

```Output
[[6 3 7 4 6 9]
 [2 6 7 4 3 7]
 [7 2 5 4 1 7]
 [5 1 4 0 9 5]]
```

Sort each column of the table:

```Python
np.sort(table, axis=0)
```

The output is:

```Output
array([[2, 1, 4, 0, 1, 5],
       [5, 2, 5, 4, 3, 7],
       [6, 3, 7, 4, 6, 7],
       [7, 6, 7, 4, 9, 9]])
```

Sort each row of the table:

```Python
np.sort(table, axis=1)
```

The output is:

```Output
array([[3, 4, 6, 6, 7, 9],
       [2, 3, 4, 6, 7, 7],
       [1, 2, 4, 5, 7, 7],
       [0, 1, 4, 5, 5, 9]])
```

Bear in mind that this treats each row or column as an independent array; any relationships between the row or column values will be lost doing this kind of sorting.

## Partial sorting: partitioning

Sometimes you don't need to sort an entire array, you just need to find the *k* smallest values in the array (often when looking at the distance of data points from one another). NumPy supplies this functionality through the `np.partition` function. `np.partition` takes an array and a number *k*; the result is a new array with the smallest *k* values to the left of the partition, and the remaining values to the right (in arbitrary order):

```Python
arr = np.array([7, 2, 3, 1, 6, 5, 4])
np.partition(arr, 3)
```

The output is:

```Output
array([2, 1, 3, 4, 6, 5, 7])
```

Note that the first three values in the resulting array are the three smallest in the array, and the remaining array positions contain the remaining values. Within the two partitions, the elements have arbitrary order.

Similarly to sorting, we can partition along an arbitrary axis of a multidimensional array:

```Python
np.partition(table, 2, axis=1)
```

The output is:

```Output
array([[3, 4, 6, 7, 6, 9],
       [2, 3, 4, 7, 6, 7],
       [1, 2, 4, 5, 7, 7],
       [0, 1, 4, 5, 9, 5]])
```

The result is an array where the first two slots in each row contain the smallest values from that row, with the remaining values filling the remaining slots.

Finally, just as there is an `np.argsort` that computes indices of the sort, there is an `np.argpartition` that computes indices of the partition. We'll see this in action in the following section when we discuss pandas.

>[!div class="alert is-tip"]
>### Takeaway
>
>Sorting your data is a fundamental means of exploring it and answering questions about it. The sorting algorithms in NumPy provide you with a fast, computationally efficient way of doing this on large amounts of data and with fine-grain control.

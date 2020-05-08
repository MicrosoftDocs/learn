So far, we've just accessed and modified NumPy arrays. As a data scientist, you'll also need to know how to sort array data. Sorting is often an important means of teasing out the structure in data (like outlying data points).

You could use Python's built-in `sort` and `sorted` functions, but they won't work nearly as efficiently as NumPy's `np.sort` function.

`np.sort` returns a sorted version of an array without modifying the input:

```python
a = np.array([2, 1, 4, 3, 5])
np.sort(a)
```

The output is:

```Output
array([1, 2, 3, 4, 5])
```

To sort the array in-place, use the `sort` method directly on arrays:

```python
a.sort()
print(a)
```

The output is:

```Output
[1 2 3 4 5]
```

A related function is `argsort`, which returns the *indices* of the sorted elements rather than the elements themselves:

```python
a = np.array([2, 1, 4, 3, 5])
b = np.argsort(a)
print(b)
```

The output is:

```Output
[1 0 3 2 4]
```

The first element of this result gives the index of the smallest element, the second value gives the index of the second smallest, and so on. These indices can then be used (via fancy indexing) to reconstruct the sorted array:

```python
a[b]
```

The output is:

```Output
array([1, 2, 3, 4, 5])
```

## Sorting along rows or columns

A useful feature of NumPy's sorting algorithms is the ability to sort along specific rows or columns of a multidimensional array by using the `axis` argument. For example:

```python
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

```python
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

```python
np.sort(table, axis=1)
```

The output is:

```Output
array([[3, 4, 6, 6, 7, 9],
       [2, 3, 4, 6, 7, 7],
       [1, 2, 4, 5, 7, 7],
       [0, 1, 4, 5, 5, 9]])
```

Keep in mind that this method treats each row or column as an independent array. Any relationships between the row or column values will be lost when you do this kind of sorting.

## Partial sorting: Partitioning

Sometimes you don't need to sort an entire array. Sometimes you just need to find the *k* smallest values in the array (often when you're looking at the distance of data points from one another). NumPy supplies this functionality through the `np.partition` function. `np.partition` takes an array and a number *k*. The result is a new array with the smallest *k* values to the left of the partition and the remaining values to the right (in arbitrary order):

```python
arr = np.array([7, 2, 3, 1, 6, 5, 4])
np.partition(arr, 3)
```

The output is:

```Output
array([2, 1, 3, 4, 6, 5, 7])
```

Note that the first three values in the resulting array are the three smallest in the array, and the remaining array positions contain the remaining values. Within the two partitions, the elements have an arbitrary order.

Similarly to sorting, we can partition along an arbitrary axis of a multidimensional array:

```python
np.partition(table, 2, axis=1)
```

The output is:

```Output
array([[3, 4, 6, 7, 6, 9],
       [2, 3, 4, 7, 6, 7],
       [1, 2, 4, 5, 7, 7],
       [0, 1, 4, 5, 9, 5]])
```

The result is an array where the first two slots in each row contain the smallest values from that row. The remaining values fill the remaining slots.

Finally, just as there's an `np.argsort` that computes indices of the sort, there's an `np.argpartition` that computes indices of the partition. We'll see this function in action in the following section when we discuss pandas.

>[!div class="alert is-tip"]
>### Takeaway
>
>Sorting your data is a fundamental way to explore it and answer questions about it. The sorting algorithms in NumPy provide a fast, computationally efficient way to sort large amounts of data with fine-grained control.

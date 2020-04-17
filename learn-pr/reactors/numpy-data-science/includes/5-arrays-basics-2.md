We continue with the basics of array manipulation in NumPy. Learn more about array slicing, how to reshape arrays, and about joining and splitting.

### Slices are no-copy views

It's important to know that slicing produces *views* of array data, not *copies*. This is a **huge** difference between NumPy array slicing and Python list slicing. With Python lists, slices are only shallow copies of lists; if you modify a copy, it doesn't affect the parent list. When you modify a NumPy subarray, you modify the original list. Be careful: this can have ramifications when you are trying to just work with a small part of a large dataset and you don't want to change the whole thing. Let's look more closely.

```python
print(a2)
```

```output
[[12  5  2  4]
 [ 7  6  8  8]
 [ 1  6  7  7]]
```

Extract a 2 x 2 subarray from `a2`:

```python
a2_sub = a2[:2, :2]
print(a2_sub)
```

```output
[[12  5]
 [ 7  6]]
```

Now modify this subarray:

```python
a2_sub[0, 0] = 99
print(a2_sub)
```

```output
[[99  5]
 [ 7  6]]
```

`a2` is now modified as well:

```python
print(a2)
```

```output
[[99  5  2  4]
 [ 7  6  8  8]
 [ 1  6  7  7]]
```

The fact that slicing produces views rather than copies is useful for data-science work. As you work with large datasets, you will often find that it is easier to access and manipulate pieces of those datasets rather than copying them entirely.

### Copying arrays

Instead of just creating views, sometimes it is necessary to copy the data in one array to another. When you need to do this, use the `copy()` method:

```python
a2_sub_copy = a2[:2, :2].copy()
print(a2_sub_copy)
```

```ouput
[[99  5]
 [ 7  6]]
```

If we now modify this subarray, the original array is not touched:

```python
a2_sub_copy[0, 0] = 42
print(a2_sub_copy)
```

```output
[[42  5]
 [ 7  6]]
```

```python
print(a2)
```

```output
[[99  5  2  4]
 [ 7  6  8  8]
 [ 1  6  7  7]]
```

## Reshaping arrays

Another way in which you will need to manipulate arrays is by reshaping them. This involves changing the number and size of dimensions of an array. This kind of manipulation can be important in getting your data to meet the expectations of machine learning programs or APIs.

The most flexible way of doing this kind of manipulation is with the `reshape` method. For example, if you want to put the numbers 1 through 9 in a 3 x 3 grid, you can do the following:

```python
grid = np.arange(1, 10).reshape((3, 3))
print(grid)
```

```output
[[1 2 3]
 [4 5 6]
 [7 8 9]]
```

Another common manipulation you will do in data science is converting one-dimensional arrays into two-dimensional row or column matrices. This can be a common necessity when doing linear algebra for machine learning. While you can do this by means of the `reshape` method, an easier way is to use the `newaxis` keyword in a slice operation:

Row vector via reshape:

```python
a = np.array([1, 2, 3])
a.reshape((1, 3))
```

```output
array([[1, 2, 3]])
```

Row vector via newaxis:

```python
a[np.newaxis, :]
```

```output
array([[1, 2, 3]])
```

Column vector via reshape:

```python
a.reshape((3, 1))
```

```output
array([[1],
       [2],
       [3]])
```

Column vector via newaxis:

```python
a[:, np.newaxis]
```

```output
array([[1],
       [2],
       [3]])
```

You will see this type of transformation a lot in the remainder of this course.

## Joining and splitting arrays

Another common data-manipulation need in data science is combining multiple datasets; learning first how to do this with NumPy arrays will help you in the next section (Section 4) when we do this with more complex data structures. You will many times also need to split a single array into multiple arrays.

### Joining arrays

To join arrays in NumPy, you will most often use `np.concatenate`, which is the method we will cover here. If you find yourself in the future needing to specifically join arrays in mixed dimensions (a rarer case), read the documentation on `np.vstack`, `np.hstack`, and `np.dstack`.

#### `np.concatenate()`

`np.concatenate` takes a tuple or list of arrays as its first argument:

```python
a = np.array([1, 2, 3])
b = np.array([3, 2, 1])
np.concatenate([a, b])
```

```output
array([1, 2, 3, 3, 2, 1])
```

You can also concatenate more than two arrays at once:

```python
c = [99, 99, 99]
print(np.concatenate([a, b, c]))
```

```output
[ 1  2  3  3  2  1 99 99 99]
```

`np.concatenate` can also be used for two-dimensional arrays:

```python
grid = np.array([[1, 2, 3],
                 [4, 5, 6]])
```

Concatenate along the first axis, which is the default:

```python
np.concatenate([grid, grid])
```

```output
array([[1, 2, 3],
       [4, 5, 6],
       [1, 2, 3],
       [4, 5, 6]])
```

#### Try it yourself

Recall that axes are zero-indexed in NumPy.

What do you predict np.concatenate([grid, grid], axis=1) will produce?

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  np.concatenate([grid, grid], axis=1)
  ```
  
  ```output
  array([[1, 2, 3, 1, 2, 3],
       [4, 5, 6, 4, 5, 6]])
  ```
  
</details>

### Splitting arrays

In order to split arrays into multiple smaller arrays, you can use the functions `np.split`, `np.hsplit`, `np.vsplit`, and `np.dsplit`. As above, we will only cover the most commonly used function (`np.split`) in this course.

#### `np.split()`

Let's first examine the case of a one-dimensional array:

```python
a = [1, 2, 3, 99, 99, 3, 2, 1]
a1, a2, a3 = np.split(a, [3, 5])
print(a1, a2, a3)
```

```output
[1 2 3] [99 99] [3 2 1]
```

Notice that *N* split-points produces to *N + 1* subarrays. In this case it has formed the subarray `a2` with `a[3]` and `a[4]` (the element just before position 5 [remember how Python indexing goes], the second input in the tuple) as elements. `a1` and `a3` pick up the leftover portions from the original array `a`.

#### Try it yourself

```python
grid = np.arange(16).reshape((4, 4))
grid
```

```output
array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11],
       [12, 13, 14, 15]])
```

What does `np.split(grid, [1, 2])` produce?

What about `np.split(grid, [1, 2], axis=1)`?

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  np.split(grid, [1, 2])
  ```
  
  ```output
  [array([[0, 1, 2, 3]]),
   array([[4, 5, 6, 7]]),
   array([[ 8,  9, 10, 11],
        [12, 13, 14, 15]])]
  ```

  ```python
  np.split(grid, [1, 2], axis=1)
  ```
  
  ```output
  [array([[ 0],
        [ 4],
        [ 8],
        [12]]),
   array([[ 1],
        [ 5],
        [ 9],
        [13]]),
   array([[ 2,  3],
        [ 6,  7],
        [10, 11],
        [14, 15]])]
  ```
  
</details>

>[!div class="alert is-tip"]
>### Takeaway
>
> Manipulating datasets is a fundamental part of preparing data for analysis. The skills you learned and practiced here will form building blocks for the most sophisticated data-manipulation you will learn in later sections in this course.

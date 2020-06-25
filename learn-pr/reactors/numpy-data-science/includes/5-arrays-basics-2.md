Let's continue with the basics of array manipulation in NumPy. You'll learn more about array slicing, how to reshape arrays, and about joining and splitting.

### Slices are no-copy views

It's important to know that slicing produces *views* of array data, not *copies*. This is a huge difference between NumPy array slicing and Python list slicing. With Python lists, slices are only shallow copies of lists. If you modify a copy, it doesn't affect the parent list. When you modify a NumPy subarray, you modify the original list. Be careful: this can have ramifications when you're just trying to work with a small part of a large dataset and you don't want to change the whole thing. Let's look more closely.

```python
print(a2)
```

The output is:

```Output
[[12  5  2  4]
 [ 7  6  8  8]
 [ 1  6  7  7]]
```

Extract a 2 x 2 subarray from `a2`:

```python
a2_sub = a2[:2, :2]
print(a2_sub)
```

The output is:

```Output
[[12  5]
 [ 7  6]]
```

Now modify this subarray:

```python
a2_sub[0, 0] = 99
print(a2_sub)
```

The output is:

```Output
[[99  5]
 [ 7  6]]
```

`a2` is now modified as well:

```python
print(a2)
```

The output is:

```Output
[[99  5  2  4]
 [ 7  6  8  8]
 [ 1  6  7  7]]
```

The fact that slicing produces views rather than copies is useful for data-science work. As you work with large datasets, you'll often find that it's easier to access and manipulate pieces of those datasets rather than copying them entirely.

### Copying arrays

Instead of just creating views, sometimes it's necessary to copy the data in one array to another. When you need to do this, use the `copy()` method:

```python
a2_sub_copy = a2[:2, :2].copy()
print(a2_sub_copy)
```

The output is:

```Output
[[99  5]
 [ 7  6]]
```

If we now modify this subarray, the original array isn't touched:

```python
a2_sub_copy[0, 0] = 42
print(a2_sub_copy)
```

The output is:

```Output
[[42  5]
 [ 7  6]]
```

For:

```python
print(a2)
```

The output is:

```Output
[[99  5  2  4]
 [ 7  6  8  8]
 [ 1  6  7  7]]
```

## Reshaping arrays

You'll also need to manipulate arrays by reshaping them. Reshaping involves changing the number and size of dimensions of an array. This kind of manipulation can be important to get your data to meet the expectations of machine learning programs or APIs.

The most flexible way to do this kind of manipulation is the `reshape` method. For example, if you want to put the numbers 1 through 9 in a 3 x 3 grid, you can use this code:

```python
grid = np.arange(1, 10).reshape((3, 3))
print(grid)
```

The output is:

```Output
[[1 2 3]
 [4 5 6]
 [7 8 9]]
```

Another common manipulation you'll do in data science is convert one-dimensional arrays into two-dimensional row or column matrices. This manipulation is a common necessity when you do linear algebra for machine learning. Although you can do this by using the `reshape` method, an easier way is to use the `newaxis` keyword in a slice operation.

Row vector via `reshape`:

```python
a = np.array([1, 2, 3])
a.reshape((1, 3))
```

The output is:

```Output
array([[1, 2, 3]])
```

Row vector via `newaxis`:

```python
a[np.newaxis, :]
```

The output is:

```Output
array([[1, 2, 3]])
```

Column vector via `reshape`:

```python
a.reshape((3, 1))
```

The output is:

```Output
array([[1],
       [2],
       [3]])
```

Column vector via `newaxis`:

```python
a[:, np.newaxis]
```

The output is:

```Output
array([[1],
       [2],
       [3]])
```

You'll see this type of transformation a lot in the rest of this course.

## Joining and splitting arrays

Another common data-manipulation need in data science is combining multiple datasets. Learning how to do this task with NumPy arrays will help you in the next section (Section 4) when we do the same thing with more complex data structures. You'll also frequently need to split a single array into multiple arrays.

### Joining arrays

To join arrays in NumPy, you'll most often use `np.concatenate`, which is the method we'll cover here. If you find yourself needing to specifically join arrays in mixed dimensions (a rarer case), read the documentation on `np.vstack`, `np.hstack`, and `np.dstack`.

#### `np.concatenate()`

`np.concatenate` takes a tuple or a list of arrays as its first argument:

```python
a = np.array([1, 2, 3])
b = np.array([3, 2, 1])
np.concatenate([a, b])
```

The output is:

```Output
array([1, 2, 3, 3, 2, 1])
```

You can also concatenate more than two arrays at once:

```python
c = [99, 99, 99]
print(np.concatenate([a, b, c]))
```

The output is:

```Output
[ 1  2  3  3  2  1 99 99 99]
```

You can also use `np.concatenate` for two-dimensional arrays:

```python
grid = np.array([[1, 2, 3],
                 [4, 5, 6]])
```

Concatenate along the first axis, which is the default:

```python
np.concatenate([grid, grid])
```

The output is:

```Output
array([[1, 2, 3],
       [4, 5, 6],
       [1, 2, 3],
       [4, 5, 6]])
```

### Try it yourself

Recall that axes are zero-indexed in NumPy.

What do you predict `np.concatenate([grid, grid], axis=1)` will produce?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  np.concatenate([grid, grid], axis=1)
  ```
  
  The output is:

  ```Output
  array([[1, 2, 3, 1, 2, 3],
       [4, 5, 6, 4, 5, 6]])
  ```
  
</details>

<br /><br />

***

### Splitting arrays

To split arrays into multiple smaller arrays, you can use the functions `np.split`, `np.hsplit`, `np.vsplit`, and `np.dsplit`. We'll cover only the most commonly used function (`np.split`) in this course.

#### `np.split()`

Let's first examine the case of a one-dimensional array:

```python
a = [1, 2, 3, 99, 99, 3, 2, 1]
a1, a2, a3 = np.split(a, [3, 5])
print(a1, a2, a3)
```

The output is:

```Output
[1 2 3] [99 99] [3 2 1]
```

Notice that *N* split-points produces to *N + 1* subarrays. In this case, the function has formed the subarray `a2` with `a[3]` and `a[4]` as elements. `a[4]` is the element just before position 5 (remember how Python indexing goes), the second input in the tuple. `a1` and `a3` pick up the leftover portions from the original array `a`.

### Try it yourself

```python
grid = np.arange(16).reshape((4, 4))
grid
```

The output is:

```Output
array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11],
       [12, 13, 14, 15]])
```

- What does `np.split(grid, [1, 2])` produce?

- What about `np.split(grid, [1, 2], axis=1)`?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  For:

  ```python
  np.split(grid, [1, 2])
  ```
  
  The output is:

  ```Output
  [array([[0, 1, 2, 3]]),
   array([[4, 5, 6, 7]]),
   array([[ 8,  9, 10, 11],
        [12, 13, 14, 15]])]
  ```

  And with `axis=1`:

  ```python
  np.split(grid, [1, 2], axis=1)
  ```
  
  The output is:

  ```Output
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

<br /><br />

***

>[!div class="alert is-tip"]
>### Takeaway
>
> Manipulating datasets is a fundamental part of preparing data for analysis. The skills you learned and practiced here will form building blocks for the most sophisticated data-manipulation that you'll learn in later sections in this course.

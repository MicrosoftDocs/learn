Now that you know how to create arrays in NumPy, you need to get comfortable with manipulating them, for two reasons. First, you'll work with NumPy arrays as part of your exploration of data science. Second, our other important Python data-science tool, pandas, is built around NumPy. Getting good at working with NumPy arrays will pay dividends in the next section (Section 4) and beyond. NumPy arrays are the building blocks for the `Series` and `DataFrame` data structures in the Python pandas library. You'll use them *a lot* in data science. To help you get comfortable with array manipulation, we'll cover five specific topics:

- **Arrays attributes**: Assessing the size, shape, and data types of arrays
- **Indexing arrays**: Getting and setting the value of individual array elements
- **Slicing arrays**: Getting and setting smaller subarrays within a larger array
- **Reshaping arrays**: Changing the shape of a given array
- **Joining and splitting arrays**: Combining multiple arrays into one and splitting one array into multiple arrays

## Array attributes

First, let's look at some array attributes. We'll start by defining three arrays filled with random numbers: one one-dimensional, another two-dimensional, and the last three-dimensional. Because we'll use NumPy's random number generator, we'll set a *seed* value to ensure that you get the same random arrays each time you run this code:

```python
import numpy as np
np.random.seed(0)  # Seed for reproducibility

a1 = np.random.randint(10, size=6)  # One-dimensional array
a2 = np.random.randint(10, size=(3, 4))  # Two-dimensional array
a3 = np.random.randint(10, size=(3, 4, 5))  # Three-dimensional array
```

Each array has attributes `ndim` (the number of dimensions of an array), `shape` (the size of each dimension of an array), and `size` (the total number of elements in an array):

```python
print("a1 ndim: ", a1.ndim)
print("a1 shape:", a1.shape)
print("a1 size: ", a1.size)
```

The output is:

```Output
a1 ndim:  1
a1 shape: (6,)
a1 size:  6
```

### Try it yourself

Change the values in this code snippet to look at the attributes for `a2` and `a3`:

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  For `a2`:
  
  ```python
  print("a2 ndim: ", a2.ndim)
  print("a2 shape:", a2.shape)
  print("a2 size: ", a2.size)
  ```
  
  The output is:

  ```Output
  a2 ndim:  2
  a2 shape: (3, 4)
  a2 size:  12
  ```
  
  For `a3`:

  ```python
  print("a3 ndim: ", a3.ndim)
  print("a3 shape:", a3.shape)
  print("a3 size: ", a3.size)
  ```
  
  The output is:

  ```Output
  a3 ndim:  3
  a3 shape: (3, 4, 5)
  a3 size:  60
  ```

</details>

<br /><br />

***


Another useful array attribute is `dtype`, which we already looked at earlier in this section as a way to determine the type of data in an array:

```python
print("dtype:", a3.dtype)
```

The output is:

```Output
dtype: int64
```

### Try it yourself

Explore the `dtype` values for the other arrays.

What `dtype` values do you predict them to have?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  print("dtype:", a3.dtype)
  ```

  The output is:

  ```Output
  dtype: int64
  ```

</details>

<br /><br />

***

## Indexing arrays

Indexing in NumPy is similar to indexing lists in standard Python. In fact, indices in one-dimensional arrays work exactly as they do with Python lists.

Try:

```python
a1
```

The output is:

```Output
array([5, 0, 3, 3, 7, 9])
```

Then try:

```python
a1[0]
```

The output is:

```Output
5
```

And next:

```python
a1[4]
```

The output is:

```Output
7
```

As with regular Python lists, to index from the end of the array, you can use a negative index.

For example:

```python
a1[-1]
```

The output is:

```Output
9
```

And:

```python
a1[-2]
```

The output is:

```Output
7
```

### Try it yourself

Do multidimensional NumPy arrays work like Python lists of lists?

Try a few combinations, like `a2[1][1]` or `a3[0][2][1]`, and see what comes back.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  a2[1][1]
  ```
  
  The output is:

  ```Output
  6
  ```

  When you use:

  ```python
  a3[0][2][1]
  ```
  
  The output is:

  ```Output
  0
  ```

</details>

<br /><br />

***

You might have noticed that we can treat multidimensional arrays like lists of lists. But a more common way to access items in multidimensional arrays is to use a comma-separated tuple of indices.

(Yes, we realize that these comma-separated tuples use square brackets rather than the parentheses the name might suggest. They're still referred to as tuples.)

Try:

```python
a2
```

The output is:

```Output
array([[3, 5, 2, 4],
       [7, 6, 8, 8],
       [1, 6, 7, 7]])
```

And with:

```python
a2[0, 0]
```

The output is:

```Output
3
```

Next look at:

```python
a2[2, 0]
```

The output is:

```Output
1
```

Try:

```python
a2[2, -1]
```

The output is:

```Output
7
```

You can also modify values by using this same comma-separated index notation:

```python
a2[0, 0] = 12
a2
```

The output is:

```Output
array([[12,  5,  2,  4],
       [ 7,  6,  8,  8],
       [ 1,  6,  7,  7]])
```

Remember, after they're defined, NumPy arrays have a fixed data type. So, if you try to insert a float into an integer array, the value will be silently truncated.

```python
a1[0] = 3.14159
a1
```

The output is:

```Output
array([3, 0, 3, 3, 7, 9])
```

### Try it yourself

What happens if you try to insert a string into `a1`? Try both a string like `'3'` and one like `'three'`.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  a1[1] = '3'
  a1
  ```
  
  The output is:

  ```Output
  array([3, 3, 3, 3, 7, 9])
  ```

  But when you try:

  ```python
  a1[1] = 'three'
  a1
  ```
  
  The output is:

  ```Output
  ---------------------------------------------------------------------------
  ValueError                                Traceback (most recent call last)
   in 
  ----> 1 a1[1] = 'three'
        2 a1
  
  ValueError: invalid literal for int() with base 10: 'three'
  ```

</details>

<br /><br />

***


## Slicing arrays

Similar to how you can use square brackets to access individual array elements, you can also use them to access subarrays. You do this with the *slice* notation, marked by the colon (`:`) character. NumPy slicing syntax follows that of the standard Python list. So, to access a slice of an array `a`, use this notation:

```python
a[start:stop:step]
```

If any of these elements are unspecified, they default to the values `start=0`, `stop=`*`size of dimension`*, `step=1`. Let's take a look at accessing subarrays in one dimension and in multiple dimensions.

### One-dimensional slices

If you use this code:

```python
a = np.arange(10)
a
```

The output is:

```Output
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
```

You can get the first five elements:

```python
a[:5]
```

The output is:

```Output
array([0, 1, 2, 3, 4])
```

You can return the elements after index 5:

```python
a[5:]
```

The output is:

```Output
array([5, 6, 7, 8, 9])
```

Or the middle subarray:

```python
a[4:7]
```

The output is:

```Output
array([4, 5, 6])
```

Here's how to get every other element:

```python
a[::2]
```

The output is:

```Output
array([0, 2, 4, 6, 8])
```

To get every other element, starting at index 1:

```python
a[1::2]
```

The output is:

```Output
array([1, 3, 5, 7, 9])
```

### Try it yourself

How would you access the *last* five elements of array `a`? How about every other element of the last five elements of `a`? Think back to list indexing in Python.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Try:

  ```python
  a[-5:]
  ```
  
  The output is:

  ```Output
  array([5, 6, 7, 8, 9])
  ```

  And:

  ```python
  a[-5::2]
  ```
  
  The output is:

  ```Output
  array([5, 7, 9])
  ```

</details>

<br /><br />

***


Be careful when you use negative values for `step`. When `step` has a negative value, the defaults for `start` and `stop` are swapped. You can use this functionality to reverse an array.

This code gives you all elements, reversed:

```python
a[::-1]
```

The output is:

```Output
array([9, 8, 7, 6, 5, 4, 3, 2, 1, 0])
```

And this code gives you every other element, from index 5, reversed:

```python
a[5::-2]
```

The output is:

```Output
array([5, 3, 1])
```

#### Try it yourself

How can you create a slice that contains every third element of `a`,  descending from the second-to-last element?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Try:

  ```python
  a[-2::-3]
  ```
  
  The output is:

  ```Output
  array([8, 5, 2])
  ```

</details>

<br /><br />

***

### Multidimensional slices

Multidimensional slices use the same slice notation as one-dimensional subarrays, mixed with the comma-separated notation of multidimensional arrays. Some examples will help illustrate this concept:

```python
a2
```

The output is:

```Output
array([[12,  5,  2,  4],
       [ 7,  6,  8,  8],
       [ 1,  6,  7,  7]])
```

Two rows, three columns:

```python
a2[:2, :3]
```

The output is:

```Output
array([[12,  5,  2],
       [ 7,  6,  8]])
```

All rows, every other column:

```python
a2[:3, ::2]
```

The output is:

```Output
array([[12,  2],
       [ 7,  8],
       [ 1,  7]])
```

Finally, subarray dimensions can even be reversed together:

```python
a2[::-1, ::-1]
```

The output is:

```Output
array([[ 7,  7,  6,  1],
       [ 8,  8,  6,  7],
       [ 4,  2,  5, 12]])
```

### Accessing array rows and columns

When you manipulate data, you'll often need to access a single row or column in an array. You can do so by using a combination of indexing and slicing. Specifically, you'll use an empty slice marked by a single colon (`:`). Again, some examples will help illustrate this concept.

To get the first column of `x2`:

```python
print(a2[:, 0])
```

The output is:

```Output
[12  7  1]
```

To get the first row of `x2`:

```python
print(a2[0, :])
```

The output is:

```Output
[12  5  2  4]
```

In the case of row access, you can omit the empty slice to get a more compact syntax:

```python
print(a2[0])  # Equivalent to a2[0, :]
```

The output is:

```Output
[12  5  2  4]
```

### Try it yourself

How would you access the third column of `a3`?

How about the third row of `a3`?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  a3[:,:,2]
  ```
  
  The output is:

  ```Output
  array([[5, 3, 2, 3],
       [9, 3, 0, 8],
       [8, 9, 0, 4]])
  ```

  And for:

  ```python
  a3[2,:,:]
  ```
  
  The output is:

  ```Output
  array([[4, 9, 8, 1, 1],
       [7, 9, 9, 3, 6],
       [7, 2, 0, 3, 5],
       [9, 4, 4, 6, 4]])
  ```

</details>

<br /><br />

***

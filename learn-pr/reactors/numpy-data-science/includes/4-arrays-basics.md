Now that you know how to create arrays in NumPy, you need to get comfortable manipulating them for two reasons. First, you will work with NumPy arrays as part of your exploration of data science. Second, our other important Python data-science tool, pandas, is actually built around NumPy. Getting good at working with NumPy arrays will pay dividends in the next section (Section 4) and beyond: NumPy arrays are the building blocks for the `Series` and `DataFrame` data structures in the Python pandas library and you will use them *a lot* in data science. To get comfortable with array manipulation, we will cover five specifics:

- **Arrays attributes**: Assessing the size, shape, and data types of arrays
- **Indexing arrays**: Getting and setting the value of individual array elements
- **Slicing arrays**: Getting and setting smaller subarrays within a larger array
- **Reshaping arrays**: Changing the shape of a given array
- **Joining and splitting arrays**: Combining multiple arrays into one and splitting one array into multiple arrays

## Array attributes

First, let's look at some array attributes. We'll start by defining three arrays filled with random numbers: one one-dimensional, another two-dimensional, and the last three-dimensional. Because we will be using NumPy's random number generator, we will set a *seed* value in order to ensure that you get the same random arrays each time you run this code:

```python
import numpy as np
np.random.seed(0)  # seed for reproducibility

a1 = np.random.randint(10, size=6)  # One-dimensional array
a2 = np.random.randint(10, size=(3, 4))  # Two-dimensional array
a3 = np.random.randint(10, size=(3, 4, 5))  # Three-dimensional array
```

Each array has attributes `ndim` (the number of dimensions of an array), `shape` (the size of each dimension of an array), and `size` (the total number of elements in an array).

#### Try it yourself

Change the values in this code snippet to look at the attributes for a1, a2, and a3:

> <details>
>  <summary>Sarah TBA Hint (expand to reveal)</summary>
>  
> **Sarah TBA** or remove the hint.
> </details>

```python
print("a3 ndim: ", a3.ndim)
print("a3 shape:", a3.shape)
print("a3 size: ", a3.size)
```

```output
a3 ndim:  3
a3 shape: (3, 4, 5)
a3 size:  60
```

Another useful array attribute is the `dtype`, which we already encountered earlier in this section as a means of determining the type of data in an array:

```python
print("dtype:", a3.dtype)
```

```output
dtype: int64
```

#### Try it yourself

Explore the `dtype` for the other arrays.

What `dtypes` do you predict them to have?

> <details>
>  <summary>Sarah TBA Hint (expand to reveal)</summary>
>  
> **Sarah TBA** or remove the hint.
> </details>

```python
print("dtype:", a3.dtype)
```

```output
dtype: int64
```

## Indexing arrays

Indexing in NumPy is pretty similar to indexing lists in standard Python. In fact, indices in one-dimensional arrays work exactly as they do with Python lists:

```python
a1
```

```output
array([5, 0, 3, 3, 7, 9])
```

```python
a1[0]
```

```output
5
```

```python
a1[4]
```

```output
7
```

As with regular Python lists, in order to index from the end of the array, you can use negative indices:

```python
a1[-1]
```

```output
9
```

```python
a1[-2]
```

```output
7
```

#### Try it yourself

Do multidimensional NumPy arrays work like Python lists of lists?

Try a few combinations like `a2[1][1]` or `a3[0][2][1]` and see what comes back.

> <details>
>  <summary>Sarah TBA Hint (expand to reveal)</summary>
>  
> **Sarah TBA** or remove the hint.
> </details>

You might have noticed that we can treat multidimensional arrays like lists of lists. But a more common means of accessing items in multidimensional arrays is to use a comma-separated tuple of indices.

(Yes, we realize that these comma-separated tuples use square brackets rather than the parentheses the name might suggest, but they are nevertheless referred to as tuples.)

```python
a2
```

```output
array([[3, 5, 2, 4],
       [7, 6, 8, 8],
       [1, 6, 7, 7]])
```

```python
a2[0, 0]
```

```output
3
```

```python
a2[2, 0]
```

```output
1
```

```python
a2[2, -1]
```

```output
7
```

You can also modify values by use of this same comma-separated index notation:

```python
a2[0, 0] = 12
a2
```

```output
array([[12,  5,  2,  4],
       [ 7,  6,  8,  8],
       [ 1,  6,  7,  7]])
```

Remember, once defined, NumPy arrays have a fixed data type. So, if you attempt to insert a float into an integer array, the value will be silently truncated.

```python
a1[0] = 3.14159
a1
```

```output
array([3, 0, 3, 3, 7, 9])
```

#### Try it yourself

What happens if you try to insert a string into a1?

> <details>
>  <summary>Hint (expand to reveal)</summary>
>  
> Try both a string like '3' and one like 'three'.
> </details>

## Slicing arrays

Similar to how you can use square brackets to access individual array elements, you can also use them to access subarrays. You do this with the *slice* notation, marked by the colon (`:`) character. NumPy slicing syntax follows that of the standard Python list; so, to access a slice of an array `a`, use this notation:

```python
a[start:stop:step]
```

If any of these are unspecified, they default to the values `start=0`, `stop=`*`size of dimension`*, `step=1`. Let's take a look at accessing sub-arrays in one dimension and in multiple dimensions.

### One-dimensional slices

```python
a = np.arange(10)
a
```

```output
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
```

```python
a[:5]  # first five elements
```

```output
array([0, 1, 2, 3, 4])
```

```python
a[5:]  # elements after index 5
```

```output
array([5, 6, 7, 8, 9])
```

```python
a[4:7]  # middle sub-array
```

```output
array([4, 5, 6])
```

```python
a[::2]  # every other element
```

```output
array([0, 2, 4, 6, 8])
```

```python
a[1::2]  # every other element, starting at index 1
```

```output
array([1, 3, 5, 7, 9])
```

#### Try it yourself

How would you access the *last* five elements of array a?

How about every other element of the last five elements of a?

> <details>
>  <summary>Hint (expand to reveal)</summary>
>  
> Think back to list indexing in Python.
>
> </details>

Be careful when using negative values for `step`. When `step` has a negative value, the defaults for `start` and `stop` are swapped and you can use this functionality to reverse an array:

```python
a[::-1]  # all elements, reversed
```

```output
array([9, 8, 7, 6, 5, 4, 3, 2, 1, 0])
```

```python
a[5::-2]  # reversed every other from index 5
```

```output
array([5, 3, 1])
```

##### Try it yourself

How can you create a slice that contains every third element of `a`,  descending from the second-to-last element to the second element of `a`?

> <details>
>  <summary>Sarah TBA Hint (expand to reveal)</summary>
>  
> **Sarah TBA** or remove the hint.
> </details>

### Multidimensional slices

Multidimensional slices use the same slice notation of one-dimensional subarrays mixed with the comma-separated notation of multidimensional arrays. Some examples will help illustrate this.

```python
a2
```

```output
array([[12,  5,  2,  4],
       [ 7,  6,  8,  8],
       [ 1,  6,  7,  7]])
```

```python
a2[:2, :3]  # two rows, three columns
```

```output
array([[12,  5,  2],
       [ 7,  6,  8]])
```

```python
a2[:3, ::2]  # all rows, every other column
```

```output
array([[12,  2],
       [ 7,  8],
       [ 1,  7]])
```

Finally, subarray dimensions can even be reversed together:

```python
a2[::-1, ::-1]
```

```output
array([[ 7,  7,  6,  1],
       [ 8,  8,  6,  7],
       [ 4,  2,  5, 12]])
```

#### Try it yourself

Now try to show 2 rows and 4 columns with every other element?

> <details>
>  <summary>Sarah TBA Hint (expand to reveal)</summary>
>  
> **Sarah TBA** or remove the hint.
> </details>

### Accessing array rows and columns

One thing you will often need to do in manipulating data is accessing a single row or column in an array. You can do this through a combination of indexing and slicing; specifically by using an empty slice marked by a single colon (`:`). Again, some examples will help illustrate this.

```python
print(a2[:, 0])  # first column of x2
```

```output
[12  7  1]
```

```python
print(a2[0, :])  # first row of x2
```

```output
[12  5  2  4]
```

In the case of row access, the empty slice can be omitted for a more compact syntax:

```python
print(a2[0])  # equivalent to a2[0, :]
```

```output
[12  5  2  4]
```

#### Try it yourself

How would you access the third column of a3?

How about the third row of a3?

> <details>
>  <summary>Sarah TBA Hint (expand to reveal)</summary>
>  
> **Sarah TBA** or remove the hint.
> </details>

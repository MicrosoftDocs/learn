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

#### Exercise

Change the values in this code snippet to look at the attributes for a1, a2, and a3:

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

>[!NOTE]
> **Sarah action item** : this output was copied from the file, but when I run this in vscode, the output I get is `dtype: int32`
> ** From Sarah: ** I still get int64 - it might be whether you're on a 64-bit or 32-bit machine. Let's leave as 64 for now. 

#### Exercise

Explore the dtype for the other arrays.
What dtypes do you predict them to have?

```python
print("dtype:", a3.dtype)
```

```output
dtype: int64
```

>[!NOTE]
> **Sarah action item** : this output was copied from the file, but when I run this in vscode, the output I get is `dtype: int32`
> ** From Sarah: ** I still get int64 - it might be whether you're on a 64-bit or 32-bit machine. Let's leave as 64 for now. 

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

#### Exercise

Do multidimensional NumPy arrays work like Python lists of lists?

Try a few combinations like a2[1][1] or a3[0][2][1] and see what comes back.

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

<details>
  <summary>Hint (expand to reveal)</summary>
  
Try both a string like '3' and one like 'three'.
</details>

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

#### Exercise

How would you access the *last* five elements of array a?
How about every other element of the last five elements of a?
Hint: Think back to list indexing in Python.

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

##### Exercise

How can you create a slice that contains every third element of `a`,  descending from the second-to-last element to the second element of `a`?

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

#### Exercise

Now try to show 2 rows and 4 columns with every other element?

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

#### Exercise

How would you access the third column of a3?
How about the third row of a3?

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

#### Exercise

Now try reversing the column and row order of `a2_sub`.
Does `a2` look the way you expected it would after that manipulation?

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

### Reshaping arrays

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

#### Exercise

Recall that axes are zero-indexed in NumPy.
What do you predict np.concatenate([grid, grid], axis=1) will produce?

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

#### Exercise

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

>[!div class="alert is-tip"]
>### Takeaway
>
> Manipulating datasets is a fundamental part of preparing data for analysis. The skills you learned and practiced here will form building blocks for the most sophisticated data-manipulation you will learn in later sections in this course.
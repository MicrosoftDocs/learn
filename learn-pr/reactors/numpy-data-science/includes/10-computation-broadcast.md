Another means of vectorizing operations is to use NumPy's *broadcasting* functionality: creating rules for applying binary ufuncs like addition, subtraction, or multiplication on arrays of different sizes.

Before, when we performed binary operations on arrays of the same size, those operations were performed on an element-by-element basis.

```python
first_array = np.array([3, 6, 8, 1])
second_array = np.array([4, 5, 7, 2])
first_array + second_array
```

```output
array([ 7, 11, 15,  3])
```

Broadcasting enables you to perform these types of binary operations on arrays of different sizes. Thus, you could just as easily add a scalar (which is really just a zero-dimensional array) to an array:

```python
first_array + 5
```

```output
array([ 8, 11, 13,  6])
```

Similarly, you can add a one-dimensional array to a two-dimensional array:

```python
one_dim_array = np.ones((1))
one_dim_array
```

```output
array([1.])
```

```python
two_dim_array = np.ones((2, 2))
two_dim_array
```

```output
array([[1., 1.],
       [1., 1.]])
```

```python
one_dim_array + two_dim_array
```

```output
array([[2., 2.],
       [2., 2.]])
```

So far, so easy. But you can use broadcasting on arrays in more complicated ways. Consider this example:

```python
horizontal_array = np.arange(3)
vertical_array = np.arange(3)[:, np.newaxis]

print(horizontal_array)
print(vertical_array)
```

```output
[0 1 2]
[[0]
 [1]
 [2]]
```

```python
horizontal_array + vertical_array
```

```output
array([[0, 1, 2],
       [1, 2, 3],
       [2, 3, 4]])
```

## Rules of broadcasting

Broadcasting follows a set of rules to determine the interaction between the two arrays:

- **Rule 1**: If the two arrays differ in their number of dimensions, the shape of the one with fewer dimensions is *padded* with ones on its leading (left) side.
- **Rule 2**: If the shape of the two arrays does not match in any dimension, the array with shape equal to 1 in that dimension is stretched to match the other shape.
- **Rule 3**: If, in any dimension, the sizes disagree and neither is equal to 1, NumPy raises an error.

Let's see these rules in action to better understand them.

### Broadcasting example 1

Let's look at adding a two-dimensional array to a one-dimensional array:

```python
two_dim_array = np.ones((2, 3))
one_dim_array = np.arange(3)
```

Let's consider an operation on these two arrays. The shape of the arrays are:

- `two_dim_array.shape = (2, 3)`
- `one_dim_array.shape = (3,)`

We see by rule 1 that the array `one_dim_array` has fewer dimensions, so we pad it on the left with ones:

- `two_dim_array.shape -> (2, 3)`
- `one_dim_array.shape -> (1, 3)`

By rule 2, we now see that the first dimension disagrees, so we stretch this dimension to match:

- `two_dim_array.shape -> (2, 3)`
- `one_dim_array.shape -> (2, 3)`

The shapes match, and we see that the final shape will be `(2, 3)`:

```python
two_dim_array + one_dim_array
```

```output
array([[1., 2., 3.],
       [1., 2., 3.]])
```

#### Exercise

Flip this around. Try adding these with `two_dim_array = np.ones((3, 2))`
and `one_dim_array = np.arange(3)[:, np.newaxis]`. 

What do you get?

> <details>
>  <summary>Sarah TBA Hint (expand to reveal)</summary>
>  
> **Sarah TBA** or remove the hint.
> </details>

### Broadcasting example 2

Let's examine what happens when both arrays need to be broadcast:

```python
vertical_array = np.arange(3).reshape((3, 1))
horizontal_array = np.arange(3)
```

Again, we'll start by writing out the shape of the arrays:

- `vertical_array.shape = (3, 1)`
- `horizontal_array.shape = (3,)`

Rule 1 says we must pad the shape of `horizontal_array` with ones:

- `vertical_array.shape -> (3, 1)`
- `horizontal_array.shape -> (1, 3)`

And rule 2 tells us that we upgrade each of these ones to match the corresponding size of the other array:

- `vertical_array.shape -> (3, 3)`
- `horizontal_array.shape -> (3, 3)`

Because the result matches, these shapes are compatible. We can see this here:

```python
vertical_array + horizontal_array
```

```output
array([[0, 1, 2],
       [1, 2, 3],
       [2, 3, 4]])
```

### Broadcasting example 3

Here's what happens with incompatible arrays:

```python
M = np.ones((3, 2))
i = np.arange(3)
```

This is just a slightly different situation than in the first example: the matrix `M` is transposed. How does this affect the calculation? The shape of the arrays are:

- `M.shape = (3, 2)`
- `i.shape = (3,)`

Again, rule 1 tells us that we must pad the shape of `i` with ones:

- `M.shape -> (3, 2)`
- `i.shape -> (1, 3)`

By rule 2, the first dimension of `i` is stretched to match that of `M`:

- `M.shape -> (3, 2)`
- `i.shape -> (3, 3)`

Now we hit Rule 3: the final shapes do not match and the two arrays are incompatible:

```python
M + i
```

```output
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
<ipython-input-140-90923315444d> in <module>
----> 1  M + i

ValueError: operands could not be broadcast together with shapes (3,2) (3,)
```

## Broadcasting in practice

Ufuncs enable you to avoid using slow Python loops; broadcasting builds on that.

A common data practice is to *center* an array of data. For example, if we have an array of 10 observations, each of which consists of three values (called features in this context), we might want to center that data so that we have the differences from the mean rather than the raw data itself. Doing this can help us better compare the different values.

We'll store this in a 10 x 3 array:

```python
T = np.random.random((10, 3))
T
```

```output
array([[0.90137772, 0.75292208, 0.26398243],
       [0.46383154, 0.38378661, 0.93354504],
       [0.17893062, 0.2792731 , 0.24203594],
       [0.32155001, 0.11237084, 0.9133384 ],
       [0.59296043, 0.45756963, 0.25448096],
       [0.91645837, 0.04154293, 0.02954946],
       [0.23938136, 0.13087661, 0.37177127],
       [0.34654638, 0.0745468 , 0.78676817],
       [0.33536819, 0.49004234, 0.90644125],
       [0.03382156, 0.3552458 , 0.3588655 ]])
```

Now compute the mean of each feature using the `mean` aggregate across the first dimension:

```python
Tmean = T.mean(0)
Tmean
```

```output
array([0.43302262, 0.30781767, 0.50607784])
```

Finally, center `T` by subtracting the mean. (This is a broadcasting operation.)

```python
T_centered = T - Tmean
T_centered
```

```output
array([[ 0.4683551 ,  0.4451044 , -0.24209541],
       [ 0.03080892,  0.07596894,  0.4274672 ],
       [-0.254092  , -0.02854458, -0.2640419 ],
       [-0.11147261, -0.19544684,  0.40726056],
       [ 0.15993781,  0.14975196, -0.25159688],
       [ 0.48343576, -0.26627475, -0.47652838],
       [-0.19364126, -0.17694106, -0.13430658],
       [-0.08647624, -0.23327088,  0.28069033],
       [-0.09765443,  0.18222467,  0.40036341],
       [-0.39920105,  0.04742813, -0.14721234]])
```

This is not just faster, but easier than writing a loop to do this.

>[!div class="alert is-tip"]
>### Takeaway
>
>The data you will work with in data science invariably comes in different shapes and sizes (at least in terms of the arrays in which you work with that data). The broadcasting functionality in NumPy enables you to use binary functions on irregularly fitting data in a predictable way.

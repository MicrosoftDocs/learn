So far, we have explored how to access and modify portions of arrays using simple indices like `arr[0]`) and slices like `arr[:5]`. Now it is time for fancy indexing, in which we pass an array of indices to an array in order to access or modify multiple array elements at the same time.

Let's try it out:

In [74]:

rand = np.random.RandomState(42)

arr = rand.randint(100, size=10)
print(arr)

[51 92 14 71 60 20 82 86 74 74]

Suppose you need to access three different elements. Using the tools you currently have, your code might look something like this:

In [75]:

[arr[3], arr[7], arr[2]]

Out[75]:

[71, 86, 14]

With fancy indexing, you can pass a single list or array of indices to do the same thing:

In [76]:

ind = [3, 7, 4]
arr[ind]

Out[76]:

array([71, 86, 60])

Another useful aspect of fancy indexing is that the shape of the output array reflects the shape of the *index arrays* you supply, rather than the shape of the array you are accessing. This is handy because there will be many times in a data scientist's life when they want to grab data from an array in a particular manner, such as to pass it to a machine learning API. Let's examine this property with an example:

In [77]:

ind = np.array([[3, 7],
                [4, 5]])
arr[ind]

Out[77]:

array([[71, 86],
       [60, 20]])

`arr` is a one-dimensional array, but `ind`, your index array, is a ![$2 \times 2$](https://render.githubusercontent.com/render/math?math=2%20%5Ctimes%202&mode=inline) array, and that is the shape the results comes back in.

### Exercise:

In [78]:

What happens when your index array is bigger than the target array?
Hint: you could use a large one-dimensional array or something fancier like ind = np.arange(0, 12).reshape((6, 2))

Fancy indexing also works in multiple dimensions:

In [79]:

arr2 = np.arange(12).reshape((3, 4))
arr2

Out[79]:

array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11]])

As with standard indexing, the first index refers to the row and the second to the column:

In [80]:

row = np.array([0, 1, 2])
col = np.array([2, 1, 3])
arr2[row, col]

Out[80]:

array([ 2,  5, 11])

What did you actually get as your final result here? The first value in the result array is `arr2[0, 2]`, the second one is `arr2[1, 1]`, and the third one is `arr2[2, 3]`.

The pairing of indices in fancy indexing follows all the same broadcasting rules we covered earlier. Thus, if you combine a column vector and a row vector within the indices, you get a two-dimensional result:

In [81]:

arr2[row[:, np.newaxis], col]

Out[81]:

array([[ 2,  1,  3],
       [ 6,  5,  7],
       [10,  9, 11]])

Here, each row value is matched with each column vector, exactly as we saw in broadcasting of arithmetic operations.

### Exercise:

In [82]:

Now try broadcasting this on your own.
What do you get with row[:, np.newaxis] * col?
Or row[:, np.newaxis] * row? col[:, np.newaxis] * row?
What about col[:, np.newaxis] * row?
Hint: think back to the broadcast rules

**The big takeaway:** It is always important to remember that fancy indexing returns values reflected by the *broadcasted shape of the indices*, and not the shape of the array being indexed.

## Combined indexing

You can also combine fancy indexing with the other indexing schemes you have learned. Consider `arr2` again:

In [83]:

print(arr2)

[[ 0  1  2  3]
 [ 4  5  6  7]
 [ 8  9 10 11]]

Now combine fancy and simple indices:

In [84]:

arr2[2, [2, 0, 1]]

Out[84]:

array([10,  8,  9])

What did you get back? The elements at positions 2, 0, and 1 of row 2 (the third row).

You can also combine fancy indexing with slicing:

In [85]:

arr2[1:, [2, 0, 1]]

Out[85]:

array([[ 6,  4,  5],
       [10,  8,  9]])

Again, consider what you got back as output: the elements at positions 2, 0, and 1 of each row after the first one (so the second and third rows).

Of course, you can also combine fancy indexing with masking:

In [86]:

mask = np.array([1, 0, 1, 0], dtype=bool)
arr2[row[:, np.newaxis], mask]

Out[86]:

array([[ 0,  2],
       [ 4,  6],
       [ 8, 10]])

## Modifying values using fancy indexing

Fancy indexing is, of course, not just for accessing parts of an array, but also for modifying parts of an array:

In [87]:

ind = np.arange(10)
arr = np.array([2, 1, 8, 4])
ind[arr] = 99
print(ind)

[ 0 99 99  3 99  5  6  7 99  9]

You can also use a ufunc here and subtract 10 from each element of the array:

In [88]:

ind[arr] -= 10
print(ind)

[ 0 89 89  3 89  5  6  7 89  9]

Be cautious when using repeated indices with operations like these. They might not always produce the results you expect. For example:

In [89]:

ind = np.zeros(10)
ind[[0, 0]] = [4, 6]
print(ind)

[6. 0. 0. 0. 0. 0. 0. 0. 0. 0.]

Where did the 4 go? The result of this operation is to first assign `ind[0] = 4`, followed by `ind[0] = 6`. So the result is that `ind[0]` contains the value 6.

But not every operation repeats the way you might think it should:

In [90]:

arr = [2, 3, 3, 4, 4, 4]
ind[arr] += 1
ind

Out[90]:

array([6., 0., 1., 1., 1., 0., 0., 0., 0., 0.])

We might have expected that `ind[3]` would contain the value 2 and `ind[4]` would contain the value 3. After all, that is how many times each index is repeated. So what happened?

This happened because `ind[arr] += 1` is really shorthand for `ind[arr] = ind[arr] + 1`. `ind[arr] + 1` is evaluated, and then the result is assigned to the indices in `ind`. So, similar to the previous example, this is not augmentation that happens multiple times, but an assignment, which can lead to potentially counterintuitive results.

But what if you want an operation to repeat? To do this, use the `at()` method of ufuncs:

In [91]:

ind = np.zeros(10)
np.add.at(ind, arr, 1)
print(ind)

[0. 0. 1. 2. 3. 0. 0. 0. 0. 0.]

### Exercise:

In [92]:

What does np.subtract.at(ind, arr, 1) give you?
Play around with some of the other ufuncs we have seen.

>**Takeaway:**
>
>Fancy indexing enables you to select and manipulate several array members at once. This type of programmatic data manipulation is common in data science: often what you want to do with your data you want to do on several data points at once.

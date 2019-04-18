One of the fundamental data types in Python is the *list*. A list is a collection of items of any data type — integers, strings, even other lists, and so on — and is analogous to arrays in other programming languages. Lists are mutable (they can be changed), which means items can be added and removed from them.

> [!TIP]
> The terms *mutable* and *immutable* are frequently used in programming. Mutable means the memory referenced by a variable can be changed. Immutable means the memory referenced by a variable cannot be changed. For example, strings are immutable. If you modify a string in code, a new string is created in memory to hold the modified string. Lists are mutable, meaning items can freely be added and removed.

To create a list in Python, you can wrap a sequence of values in square brackets and separate each item in the list with commas. The following example creates a list of integers:

```python
nums = [1,2,3,4,5]
```

To access an item in the list, specify its zero-based index in square brackets:

```python
print(nums[2])
```

```output
3
```

One of the most useful features that lists support is *slicing*, which allows you to easily extract a subset of the list. Slicing is performed by specifying a starting index and ending index in square brackets. The following code extracts three characters from a list and prints them to the screen. Note that the last item included in the slice is the item whose index is the ending index minus 1:

```python
nums = [1,2,3,4,5]
print(x[1:4])
```

```output
[2,3,4]
```

You can omit the starting index to specify that the slice should start with the first item in the list:

```python
nums = [1,2,3,4,5]
print(x[:4])
```

```output
[1,2,3,4]
```

And you can omit the ending index to specify that the slice should end with the final item in the list:

```python
nums = [1,2,3,4,5]
print(x[2:])
```

```output
[3,4,5]
```

Python is famous for its slicing capabilities. The ability to slice data is heavily used in Python applications, especially when performing numerically intensive tasks such as statistical analysis and machine learning.

Adding an item to the end of a list is simple:

```python
nums = [1,2,3,4,5]
nums.append(6)
print(nums) # outputs: [1,2,3,4,5,6]
```

Removing an item from the list is equally simple:

```python
nums = [1,2,3,4,5]
nums.remove(4)
print(nums) # outputs: [1,2,3,5]
```

To find the number of items in a list, use Python's built-in `len` function:

```python
nums = [1,2,3,4,5]
print(len(nums)) # outputs: 5
```

How might lists help when reading text files? The following code reads **colors.txt** line for line and adds each line to a list:

```python
colors = []
with open('colors.txt', 'r') as color_file:
    for color in color_file:
        colors.append(color)
```

Now you can use a `for-in` loop to iterate over the contents of the file:

```python
for color in colors:
    print(color)
```

And a simple `len` statement would tell you precisely how many lines the file contains.

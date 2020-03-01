A list allows you to collect data together into a single data structure.  The items in the list can be of any data type.  You can add and remove items in a number of ways.  You can reference single items or slices (sublists) of items.  You can loop through each item in a list, which we'll learn about in the next unit.  Lists are one of the most popular ways to manage related data in your applications.

In this exercise, you'll work with lists of data.  There are other similar data structures that we'll explore in other modules like the set, dictionary, tuple, and range.

### Step 1 - Create a new working folder and python code file.

Using the techniques you learned in previous modules, create a new folder for your work in this module.  For example, you might create a folder named `python-lists`.

Inside that folder, create a file for this exercise.  For example, you might create a file named `exercise1.py`.

When it's time to execute your code in the steps of the exercises, you can use the Python Tools for Visual Studio Code integration by selecting the green arrow, or you can use a command in the integrated terminal using techniques we learned about in previous modules.

### Step 2 - Add code to create a list of values.

Write code to create a list of colors, then print the list and its type to the console.  Add the code from the following code listing to your new exercise file:

```python
colors = ['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']

print(colors)
print(type(colors))
```

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
<class 'list'>
```

You define a list using a set of square brackets `[]`.  Inside, you add values separated with commas.  A single identifier (in this case, the variable `colors`) is your reference to all the items contained in the list, and in the remaining steps of this unit, you'll learn of the many ways you can retrieve items, add items, remove items, and more.

It's important to understand that you can add values of any data type to a list.  In the following code listing, we add a string, float, integer, and Boolean value into a single list.

```python
sundry = ['John', 3.14, 7, False]
print(sundry)
print(type(sundry))
```
If you execute the code, the output would be as we expect: each value in the list is unchanged, and the data type is still `list`:

```output
['John', 3.14, 7, False]
<class 'list'>
```

While it is possible to add lots of different types of data into a list, typically it's not preferable or practical.  When building real programs, you typically want to keep items collected into a list that share some common purpose or use.  For this reason, we'll be using the `colors` list throughout the remainder of this exercise.

You can create an empty list like so:

```python
my_list = []
```
Creating an empty list comes in handy when you can't initialize your list with values and must add elements using logic in your program.  We'll see how to do this in an upcoming step.


### Step 3 - Update the code example to access individual elements using an index.

First, comment out the last two lines of code that print the contents of the `colors` list, as well as the line of code that prints out the `type()` of the `colors` list.

Next, add three lines of code that use a set of square bracket symbols `[]` to access individual elements of the `colors` list.  Update your code to match the following code listing:

```python
colors = ['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']

# print(colors)
# print(type(colors))

print(f'0-based indexing into the list ... second item: {colors[1]}')

print(f'Last item of the list: {colors[-1]}')

print(f'Next to last item in the list: {colors[-2]}')
```
In this context, the square bracket symbols `[]` allow you to use a zero-based numeric value to access an individual element of the list.  So, when we use the index `[0]`, we're accessing the first element.  When we use the index `[1]`, we're accessing the second element, and so on.

We can also use negative numbers as indexes to count backwards from the end of the list.  So, when we use the index `[-1]` we're accessing the last item.  When we use the index `[-2]` we're accessing the next to last item, and so on.

When you execute the code, you should see the following output:

```output
0-based indexing into the list ... second item: green
Last item of the list: brown
Next to last item in the list: purple
```

If you attempt to access an element using an index that does not exist in your list like so:

```python
colors = ['red', 'green', 'blue']
print(colors[3])
```
You'll get an error:

```output
IndexError: list index out of range
```

### Step 3 - Comment out the code added in the previous step and add code to create a slice.

A slice defines a range of elements using a special syntax.  At first glance, it looks similar to the syntax we used to access a single element of the list using an index, but it uses a colon symbol `:` separates the beginning of the slice on the left and the end of the slide on the right.

Comment out the code that we added in the previous step, then add new code that prints several example slices.


```python
colors = ['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']

# print(f'0-based indexing into the list ... second item: {colors[1]}')

# print(f'Last item of the list: {colors[-1]}')

# print(f'Next to last item in the list: {colors[-2]}')

print('\nPrint a SLICE, starting at index 2 and excluding index 5:')
print(colors[2:5])
print(type(colors[2:5]))

print('\nPrint a slice, starting at index 0 to index 3:')
print(colors[:3])

print('\nPrint a slice, starting a index 4 to the end of the list:')
print(colors[4:])

print('\nPrint a slice, from the 4th from the end up until the last item:')
print(colors[-4:-1])
```

As mentioned in the first `print()` statement, the value on the left of the colon symbol `:` is INCLUSIVE, meaning that the slice will include the element at that index.  The value on the right side of the colon symbol `:` is EXCLUSIVE, meaning that the slice will not contain the element at that index.

If you do not define an index on the left of the colon symbol `:`, then you are stating that you want the slice to start at the beginning of the list.  If you do not define an index on the right of the colon symbol `:`, then you are stating that you want the slice to continue to the end of the list.

As you can see from the last example, you can use negative values, indicating that you want to work from the end of the list.  This can be a bit of a mind bender, however nothing changes.  When defining the slice as `[-4:-1]`, you want the slice to contain the fourth item from the end to the last item in the list.

When you execute the code, you should see the following output:

```output
Print a SLICE, starting at index 2 and excluding index 5:
['blue', 'yellow', 'orange']
<class 'list'>

Print a slice, starting at index 0 to index 3:
['red', 'green', 'blue']

Print a slice, starting a index 4 to the end of the list:
['orange', 'purple', 'brown']

Print a slice, from the 4th from the end up until the last item:
['yellow', 'orange', 'purple']
```

### Step 4 - Comment out the code added in the previous step and add code to reverse and sort the list.

Just like other data types we've worked with in previous modules, lists have several helper functions that make it easy to perform certain operations on the list itself.

Comment out the code you added in Step 3, then add the following code to reverse the order of the list and sort the list alphabetically.

```python
colors.reverse()
print(colors)

colors.sort()
print(colors)
```
Calling these functions permanently changes the order in which the elements of the list are stored in memory.

When you execute the code, you should see the following output:

```output
['brown', 'purple', 'orange', 'yellow', 'blue', 'green', 'red']
['blue', 'brown', 'green', 'orange', 'purple', 'red', 'yellow']
```


### Step 5 - Comment out the code added in the previous step and add code to treat the list like a queue.

A queue is a special term in programming that refers to a list that stores items in the order in which they were added.  Queues are useful when you need to perform some calculation logic on many items in a specific order.  Once added to the list, you remove an item for processing one by one.  A "pop" operation refers to the act of removing an item from the queue for processing.  You can remove an item from the beginning of the list ("first in, first out", or FIFO) or from the end of the list ("last in, first out", or LIFO).

The `pop()` helper function allows you to select an item from the list using its index.  So, `0` is the first item and `-1` is the last item.

Comment out the code you added in step 4, then add the following code:

```python
print(colors)

color = colors.pop(0)
print('popped', color)

print(colors)
```
The `pop()` helper function will take the item at the index you pass in as an argument, remove it from the list, and assign it to a variable for processing.  In this case, we do not perform any real processing on the item.  We merely print it.  The third line of code prints the new contents of the list, and you can see that the first item is no longer present.

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
popped red
['green', 'blue', 'yellow', 'orange', 'purple', 'brown']
```


### Step 6 - Comment out the code added in the previous step and add code to add and remove elements from an existing list.

If you simply need to manage the items in the list, you can use the `append()` and `remove()` helper functions.

Comment out the code you added in step 5, then add the following code:

```python
print(colors)

colors.append('black')
colors.append('white')

colors.remove('yellow')
colors.remove('orange')

print(colors)
```

The `append()` helper function will add an item to the list.  The `remove()` helper function removes an item from the list.  

When you execute the code, you should see the following output:

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
['red', 'green', 'blue', 'purple', 'brown', 'black', 'white']
```

If you attempt to remove an item that does not exist in the list like so:

```python
colors.remove('whatever')
```
Then you would see the following error:

```output
ValueError: list.remove(x): x not in list
```

### Step 7 - Comment out the code added in the previous step and add code to combine a new list with an existing list.

If you have a second list that you want to combine with a first list, you can use the `extend()` helper function.

Comment out the code you added in step 6, then add the following code:

```python
new_colors = ['lime', 'gray']
colors.extend(new_colors)
print(colors)
```
The `extend()` helper function operates on your list to add elements from a list you pass in as an argument.

When you execute the code, you should see the following output:

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown', 'lime', 'gray']
```

### Step 8 - Comment out the code added in the previous step and add code to clear all items from the list.

If you want to remove all items from the list, call the `clear()` function.

Comment out the code you added in step 6, then add the following code:

```python
colors.clear()
print(colors)
```
When you execute the code, you should see the following output:

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
[]
```

## Recap

- Lists are data structures that are intended to collect related data in your programs.  The data can be of any data type, but usually elements will be the same data type since they will serve a similar purpose in your programs.
- Create a list using square brackets `[]` separating each item with a comma.
- Access individual elements inside the list using square brackets and a zero-based index.  You can access the first item in the list using index `0`.  You can access the last item in the list using the index `-1`.  You can access items relative to the end of the list using other negative numbers as indices.
- Create slices using square brackets `[]` and a colon separating the beginning of the slice on the left side of the colon, and the end of the slide on the right side of the colon symbol.
- Use helper functions like `pop()`, `append()`, `remove()`, `extend()`, and `clear()` to change the items in the list.
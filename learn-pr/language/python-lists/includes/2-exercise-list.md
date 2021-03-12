A list allows you to collect data into a single structure.  The items in the list can be of any data type. By using a list, you can: 

- Add and remove items in various ways.
- Reference single items or slices of items (sublists).
- Loop through each item in a list, as you'll see in the next unit.  

Lists are a popular way to manage related data in your applications.

In this exercise, you'll work with lists of data. In other modules, we'll explore similar data structures. These data structures include the set, dictionary, tuple, and range.

## Step 1 - Create a new working folder and a Python code file

Use the techniques that you learned in previous modules to create a new folder for your work in this module.  For example, you might create a folder named *python-lists*.

Inside that folder, create a file for this exercise.  For example, you might create a file named *exercise1.py*.

To execute code in the exercises, you can use the Python tools for Visual Studio Code integration by selecting the green arrow. Or you can use a command in the integrated terminal by using techniques that you learned in previous modules.

## Step 2 - Create a list of values

Write code to create a list of colors. Then print the list and its type to the console.  Add the code from the following code listing to your new exercise file:

```python
colors = ['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']

print(colors)
print(type(colors))
```

When you execute the code, you should see the following output:

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
<class 'list'>
```

You define a list by using a set of square brackets (`[]`).  Inside the brackets, you add values. Separate the values with commas.  

A single identifier is your reference to all of the items in the list. In this case, the identifier is the variable `colors`. Later in this exercise, you'll see ways to retrieve, add, and remove items.

It's important to understand that you can add values of any data type to a list.  In the following code listing, we add a string, float, integer, and Boolean value into a single list.

```python
sundry = ['John', 3.14, 7, False]
print(sundry)
print(type(sundry))
```
If you execute the code, the output is as we expect: each value in the list is unchanged, and the data type is still `list`. Here's the output:

```output
['John', 3.14, 7, False]
<class 'list'>
```

It's possible to add lots of data types to a list, but typically it's not preferable or practical.  When building real programs, you usually want list items to share a common purpose or use.  For this reason, you'll use the `colors` list for this exercise.

You can create an empty list like so:

```python
my_list = []
```
Creating an empty list comes in handy when you can't initialize your list with values. Instead, you must add elements by using logic in your program. You'll see how to use this method later in this exercise.


## Step 3 - Use an index to access individual elements

First, comment out the last two lines of code that print the contents of the `colors` list. Also comment out the line of code that prints out the `type()` of the `colors` list.

Next, add three lines of code that use a set of square brackets to access individual elements of the `colors` list.  Update your code to match the following code listing:

```python
colors = ['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']

# print(colors)
# print(type(colors))

print(f'0-based indexing into the list ... second item: {colors[1]}')

print(f'Last item of the list: {colors[-1]}')

print(f'Next to last item in the list: {colors[-2]}')
```
In this context, the square brackets allow us to use a zero-based numeric value to access an element of the list.  So when we use the index `[0]`, we access the first element.  When we use the index `[1]`, we access the second element, and so on.

We can also use negative numbers as indexes to count backward from the end of the list.  So when we use the index `[-1]`, we access the last item.  When we use the index `[-2]`, we access the next-to-last item, and so on.

When you execute the code, you should see the following output:

```output
0-based indexing into the list ... second item: green
Last item of the list: brown
Next to last item in the list: purple
```

Here's an attempt to access an element by using an index that doesn't exist in your list:

```python
colors = ['red', 'green', 'blue']
print(colors[3])
```

This attempt yields an error:

```output
IndexError: list index out of range
```

## Step 4 - Create a slice

A *slice* defines a range of elements by using a special syntax.  At first glance, it looks similar to the syntax that uses an index to access a single element of the list. But the slice syntax uses a colon (`:`). The colon separates the beginning of the slice, on the left, and the end of the slice, on the right.

Comment out the code that you added in the previous step. Then add new code that prints several example slices.


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

print('\nPrint a slice, from the 4th from the end (but not the last item):')
print(colors[-4:-1])
```

As we saw in the first `print()` statement, the value on the left side of the colon is *inclusive*. So the slice includes the element at that index.  The value on the right side of the colon is *exclusive*. So the slice doesn't contain the element at that index.

If you don't define an index on the left side of the colon, then the slice will start at the beginning of the list.  If you don't define an index on the right side of the colon, then the slice will continue to the end of the list.

As you can see from the last example, you can use negative values. Negative values let you work from the end of the list. Using this method can be bewildering at first, but keep in mind that the same rules you learned still apply.  If you define the slice as `[-4:-1]`, then the slice contains the last three items in the list.

When you execute the code, you should see the following output:

```output

Print a slice, starting at index 0 to index 3:
['red', 'green', 'blue']

Print a slice, starting a index 4 to the end of the list:
['orange', 'purple', 'brown']

Print a slice, from the 4th from the end (but not the last item):
['yellow', 'orange', 'purple']
```

## Step 5 - Reverse and sort the list

Just like other data types that we worked with in previous modules, lists have several helper functions. These functions help you do certain operations on the list itself.

Comment out the code that you added in the previous section. Then add the following code to reverse the list's order and sort it alphabetically.

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


## Step 6 - Treat the list like a queue

A *queue* is a special term in programming that refers to a list that stores items in the order in which they were added.  Queues are useful when you need to do some calculation logic on many items in a specific order.  After you add items to the list, you remove them for processing one by one.  

A *pop* operation removes an item from the queue for processing.  You can remove an item from the beginning of the list ("first in, first out", or FIFO). Or you can remove an item from the end of the list ("last in, first out", or LIFO).

The `pop()` helper function allows you to select an item from the list by using its index.  The first item is `0`, and the last item is `-1`.

Comment out the code that you added in the previous section. Then add the following code:

```python
print(colors)

color = colors.pop(0)
print('popped', color)

print(colors)
```
The `pop()` helper function takes the item at the index that you pass in as an argument. It *removes* the item from the list and assigns it to a variable for processing.  In this case, we don't do any real processing on the item.  We merely print it.  The third line of code prints the *new* contents of the list. You can see that the first item is no longer present.

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
popped red
['green', 'blue', 'yellow', 'orange', 'purple', 'brown']
```


## Step 7 - Add and remove elements from a list

If you simply need to manage the items in the list, you can use the `append()` and `remove()` helper functions.

Comment out the code that you added in the previous section. Then add the following code:

```python
print(colors)

colors.append('black')
colors.append('white')

colors.remove('yellow')
colors.remove('orange')

print(colors)
```

The `append()` helper function adds an item to the list.  The `remove()` helper function removes an item from the list.  

When you execute the code, you should see the following output:

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
['red', 'green', 'blue', 'purple', 'brown', 'black', 'white']
```

Here, we try to remove an item that doesn't exist in the list:

```python
colors.remove('whatever')
```

This code yields the following error:

```output
ValueError: list.remove(x): x not in list
```

## Step 8 - Combine a new list with an existing list

To combine a list with the first list, you can use the `extend()` helper function.

Comment out the code that you added in the previous section. Then add the following code:

```python
new_colors = ['lime', 'gray']
colors.extend(new_colors)
print(colors)
```
The `extend()` helper function adds elements from a list that you pass in as an argument.

When you execute the code, you should see the following output:

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown', 'lime', 'gray']
```

## Step 9 - Clear all items from a list

To remove all items from a list, call the `clear()` function.

Comment out the code that you added in the previous section. Then add the following code:

```python
print(colors)
colors.clear()
print(colors)
```
When you execute the code, you should see the following output:

```output
['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'brown']
[]
```

## Recap

- Lists are data structures that are intended to collect related data in your programs.  The data can be of any type. But elements are usually of the same data type because they serve a similar purpose in your programs.
- Create a list by using square brackets. Use a comma to separate each item.
- Access individual elements inside the list by using square brackets and a zero-based index.  Access the first item in the list by using index `0`. Access the last item in the list by using index `-1`. Access items relative to the end of the list by using other negative numbers as indexes.
- Create slices by using square brackets and a colon. The colon separates the beginning of the slice, on the left, from the end of the slice, on the right.
- Use helper functions like `pop()`, `append()`, `remove()`, `extend()`, and `clear()` to change the items in a list.

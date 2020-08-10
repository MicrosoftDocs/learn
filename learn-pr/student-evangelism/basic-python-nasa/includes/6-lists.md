Lists are ways to store a lot of data in Python and are similar to variables. They are a collection of values stored in the form of a list. Lists are useful in Python because often you'll need more than one piece of data. Lists play a huge role in data science, because the goal of data science is to take large amounts of related data and analyze it. That's why the popular data science Python packages such as Pandas and NumPy have additional data structures such as dataframes and arrays, which are essentially lists with additional features.

## How to make a list

Defining lists in Python is similar to creating variables. Start by making a name for your list and then set it equal to a value. However, lists can hold multiple values. For example:

```python
# Create a list of common moon rocks
rockTypes = ["basalt", "highland", "breccia"]
rockTypes
```

```Output
['basalt', 'highland', 'breccia']
```

As you can see, you must include square brackets and then include the values you want separated by commas.

Lists can have values that come in all forms (int, float, string) and can even mix and match different types. For example:

```python
# A list with rock names and the number of that rock found
rockTypeAndCount = ["basalt", 1, "highland", 2.5, "breccia", 5]
rockTypeAndCount
```

```Output
['basalt', 1, 'highland', 2.5, 'breccia', 5]
```

## List Functions

There are many pre-made functions included in Python, which we can use to modify a list.

For example, we can add items to a list by calling the .append() function followed by the data that we want to add in parentheses. Doing this will add an item to the end of a list. Let's add a rock type to our original list.

```python
rockTypes.append("soil")
rockTypes
```

```Output
['basalt', 'highland', 'breccia', 'soil']
```

We can also delete items from the end of a list by calling the .pop() function. We'll now delete soil from the rock types list.

```python
rockTypes.pop()
rockTypes
```

```Output
['basalt', 'highland', 'breccia']
```

Finally, we can look at and change the value from anywhere within the list. To see what value is at a certain point in the list, use square brackets after the list name to look at that specific value. Everything in Python is zero-indexed, meaning that counting begins at 0, not 1. So if we look at the value in the first position in a list, we would use:  `listName[0]`.  

In our rock type example, use the following code to look at the value in the second position in the list:

```python
rockTypes[1]
```

```Output
'highland'
```

We can also change a specific value in the list at a specific point by coding:

listName[position in list to change value] = newValue.  

In our rock type example, if we wanted to change the value in the third position of the list to be "soil", we could do so as follows:

```python
rockTypes[2] = "soil"
rockTypes
```

```Output
['basalt', 'highland', 'soil']
```

Doing this will change the current value at this position in the list, so the previous value will be gone.

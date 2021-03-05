Python includes a number of handy methods that are available to all lists.

For example, use [append()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) and [extend()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) to add to the end of a list. These methods work on lists much like an augmentation ("+=") operator works on other variables.

```python
groupMembers = ['Jordan', 'Parker']
groupMembers.append('Quinn')
groupMembers
```

The output is:

```Output
['Jordan', 'Parker', 'Quinn']
```

Notice that you passed an item, not a list, to `append()`. Passing a list to `append()` gives you this result:

```python
groupMembers2 = ['Jordan', 'Parker', 'Quinn']
groupMembers2.append(['Stuart', 'Pete'])
groupMembers2
```

The output is:

```Output
['Jordan', 'Parker', 'Quinn', ['Stuart', 'Pete']]
```

To tack items from a new list onto the end of an existing list, use [extend()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) instead:

```python
groupMembers.extend(['Stuart', 'Pete'])
groupMembers
```

The output is:

```Output
['Jordan', 'Parker', 'Quinn', 'Stuart', 'Pete']
```

The [index()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) method returns the index of the first matching item in a list (if the item is present):

```python
groupMembers.index('Quinn')
```

The output is:

```Output
2
```

The [count()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) method returns the number of items in a list that match objects that you pass in:

```python
groupMembers.count('Jordan')
```

The output is:

```Output
1
```

There are two methods for removing items from a list. The first is [remove()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true), which locates the first occurrence of an item in the list and removes it (if the item is present):

```python
groupMembers.remove('Stuart')
groupMembers
```

The output is:

```Output
['Jordan', 'Parker', 'Quinn', 'Pete']
```

The other method for removing items from a list is the [pop()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) method. If you supply `pop()` with an index number, it removes the item from that location in the list and returns it. If you specify no index, `pop()` removes the last item from the list and returns that:

```python
groupMembers.pop()
```

The output is:

```Output
'Pete'
```

The [insert()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) method adds an item to a specific location in a list:

```python
groupMembers.insert(1, 'Riley')
groupMembers
```

The output is:

```Output
['Jordan', 'Riley', 'Parker', 'Quinn']
```

Unsurprisingly, the [reverse()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) method reverses the order of the items in a list:

```python
groupMembers.reverse()
groupMembers
```

The output is:

```Output
['Quinn', 'Parker', 'Riley', 'Jordan']
```

Finally, the [sort()](https://docs.python.org/3.6/tutorial/datastructures.html?azure-portal=true) method orders the items in a list:

```python
groupMembers.sort()
groupMembers
```

The output is:

```Output
['Quinn', 'Jordan', 'Parker', 'Riley']
```

### Try it yourself

- What happens if you run `groupMembers.extend(groupMembers)`?
- How about `groupMembers.append(groupMembers)`?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's the input:
  
  ```python
  groupMembers.extend(groupMembers)
  groupMembers
  ```
  
  The output is:
  
  ```Output
  ['Quinn', 'Jordan', 'Parker', 'Riley', [...]]
  ```
  
  The next input is:
  
  ```python
  groupMembers.append(groupMembers)
  groupMembers
  ```
  
  Here's the output:
  
  ```Output
  ['Quinn', 'Jordan', 'Parker', 'Riley', 'Quinn', 'Jordan', 'Parker', 'Riley']
  ```
  
</details>

<br /><br />

***

> [!NOTE]
> You can supply your own _lambda function_ for the `sort()` method, for use in comparing items in a list. We'll cover lambda functions in a later unit.

Python includes a number of handy functions that are available to all lists.

For example, [append()](https://docs.python.org/3.6/tutorial/datastructures.html) and [extend()](https://docs.python.org/3.6/tutorial/datastructures.html) enable you to add to the end of a list, much like the += operator:

```Python
groupMembers = ['Jordan', 'Parker']
groupMembers.append('Quinn')
groupMembers
```

The output is:

```Output
['Jordan', 'Parker', 'Quinn']
```

Notice that you did not actually pass a list to `append()`; passing a list to `append()` results in this behavior:

```Python
groupMembers2 = ['Jordan', 'Parker', 'Quinn']
groupMembers2.append(['Stuart', 'Pete'])
groupMembers2
```

The output is:

```Output
['Jordan', 'Parker', 'Quinn', ['Stuart', 'Pete']]
```

To tack a list on the end of an existing list, use [extend()](https://docs.python.org/3.6/tutorial/datastructures.html) instead:

```Python
groupMembers.extend(['Stuart', 'Pete'])
groupMembers
```

The output is:

```Output
['Jordan', 'Parker', 'Quinn', 'Stuart', 'Pete']
```

[index()](https://docs.python.org/3.6/tutorial/datastructures.html) returns the index of the first matching item in a list (if present):

```Python
groupMembers.index('Quinn')
```

The output is:

```Output
2
```

The [count()](https://docs.python.org/3.6/tutorial/datastructures.html) method returns the number of items in a list that match objects you pass in:

```Python
groupMembers.count('Jordan')
```

The output is:

```Output
1
```

There are two methods for removing items from a list. The first is [remove()](https://docs.python.org/3.6/tutorial/datastructures.html), which locates the first occurrence of an item in the list and removes it (if present):

```Python
groupMembers.remove('Stuart')
groupMembers
```

The output is:

```Output
['Jordan', 'Parker', 'Quinn', 'Pete']
```

The other method for removing items from lists is the [pop()](https://docs.python.org/3.6/tutorial/datastructures.html) method. If you supply `pop()` with an index number, it will remove the item from that location in the list and return it; otherwise, `pop()` removes the last item in a list and returns that:

```Python
groupMembers.pop()
```

The output is:

```Output
'Pete'
```

The [insert()](https://docs.python.org/3.6/tutorial/datastructures.html) method enables you to add an item to a specific location in a list:

```Python
groupMembers.insert(1, 'Riley')
groupMembers
```

The output is:

```Output
['Jordan', 'Riley', 'Parker', 'Quinn']
```

Unsurprisingly, the [reverse()](https://docs.python.org/3.6/tutorial/datastructures.html) method reverses the order of items in a list:

```Python
groupMembers.reverse()
groupMembers
```

The output is:

```Output
['Quinn', 'Parker', 'Riley', 'Jordan']
```

Finally, the [sort()](https://docs.python.org/3.6/tutorial/datastructures.html) method orders the items in a list:

```Python
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

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```Python
  beatles.append(beatles)
  beatles
  ```

  ```Output
  ['John', 'Paul', 'George', [...]]
  ```
  
</details>

Note that you can supply your own _lambda function _to `sort()` for use in comparing items in a list. We will cover lambda functions in a later topic.

Python includes a number of handy functions that are available to all lists.

> [!Note]
> **Sarah: Conversion feedback**
> 
> This unit has a knowledge check question at the end that's more similar to a Try it yourself block. We revised the format.
>
> **Sarah: Action items**
>
> This unit uses the "Beatles" music group name and the name of the members (John, Paul, George, Ringo).
> The CELA guidelines require all examples to use fictitious content.
> For details, see https://microsoft.sharepoint.com/sites/celaweb-copyrights-trademarks-and-patents/sitepages/trademarks-fictitious-content-faq.aspx.
>

For example, append() and extend() enable you to add to the end of a list, much like the += operator:

```Python
beatles = ['John', 'Paul']
beatles.append('George')
beatles
```

```output
['John', 'Paul', 'George']
```

Notice that you did not actually pass a list to append(); passing a list to append() results in this behavior:

```Python
beatles2 = ['John', 'Paul', 'George']
beatles2.append(['Stuart', 'Pete'])
beatles2
```

```output
['John', 'Paul', 'George', ['Stuart', 'Pete']]
```

To tack a list on the end of an existing list, use extend() instead:

```Python
beatles.extend(['Stuart', 'Pete'])
beatles
```

```output
['John', 'Paul', 'George', 'Stuart', 'Pete']
```

index() returns the index of the first matching item in a list (if present):

```Python
beatles.index('George')
```

```output
2
```

The count() method returns the number of items in a list that match objects you pass in:

```Python
beatles.count('John')
```

```output
1
```

There are two methods for removing items from a list. The first is remove(), which locates the first occurrence of an item in the list and removes it (if present):

```Python
beatles.remove('Stuart')
beatles
```

```output
['John', 'Paul', 'George', 'Pete']
```

The other method for removing items from lists is the pop() method. If you supply pop() with an index number, it will remove the item from that location in the list and return it; otherwise, pop() removes the last item in a list and returns that:

```Python
beatles.pop()
```

```output
'Pete'
```

The insert() method enables you to add an item to a specific location in a list:

```Python
beatles.insert(1, 'Ringo')
beatles
```

```output
['John', 'Ringo', 'Paul', 'George']
```

Unsurprisingly, the reverse() method reverses the order of items in a list:

```Python
beatles.reverse()
beatles
```

```output
['George', 'Paul', 'Ringo', 'John']
```

Finally, the sort() method orders the items in a list:

```Python
beatles.sort()
beatles
```

```output
['George', 'John', 'Paul', 'Ringo']
```

## Try it yourself

- What happens if you run `beatles.extend(beatles)`?
- How about `beatles.append(beatles)`?

Note that you can supply your own lambda function to `sort()` for use in comparing items in a list. We will cover lambda functions in a later topic.

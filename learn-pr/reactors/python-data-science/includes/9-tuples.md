Another immutable data type in Python is the _tuple_. 

At times, it's useful create a data structure that won't be altered later in a program. That structure might protect constant data from being overwritten by accident or improve performance for iterating over data. These situations are where tuples come in.

You create tuples in much the same way as you create lists, except that you use parentheses instead of brackets:

```python
t = (1, 2, 3)
t
```

The output is:

```Output
(1, 2, 3)
```

Because tuples are immutable, you can't change elements within them:

```python
t[1] = 2.0
```

The error output is:

```Output
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-110-823b86083d61> in <module>
----> 1 t[1] = 2.0
TypeError: 'tuple' object does not support item assignment
```

However, you can refer to elements within a tuple:

```python
t[1]
```

The output is:

```Output
2
```

You can also slice a tuple:

```python
t[:2]
```

The output is:

```Output
(1, 2)
```

You can create a tuple from a list:

```python
l = ['baked', 'beans', 'spam']
l = tuple(l)
l
```

The output is:

```Output
('baked', 'beans', 'spam')
```

Or, you can create a list from a tuple:

```python
l = list(l)
l
```

The output is:

```Output
['baked', 'beans', 'spam']
```

## Membership testing

As your Python programming becomes more complex, you'll want to test lists and tuples for the membership of specific data. You use the `in` operator to do that.

```python
tup = ('a', 'b', 'c')
'b' in tup
```

The output is:

```Output
True
```

You can also test whether something is not in a list or tuple by using `not in`:

```python
lis = ['a', 'b', 'c']
'a' not in lis
```

The output is:

```Output
False
```

### Try it yourself

- What happens if you run `lis in lis`? Is that the behavior you expected?
- If not, think about the nested lists we discussed in an earlier unit.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  lis in lis
  ```

  ```Output
  False
  ```
  
</details>

<br /><br />

***

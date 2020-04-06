Another immutable data type in Python are tuples. It can be useful at times to create a data structure that won't be altered later in a program, such as to protect constant data from being overwritten on accident or to improve performance for iterating over data. This is where tuples come in. You create tuples much as you do lists, only using parentheses instead of brackets.

> [!Note]
> **Sarah: Conversion feedback**
> 
> This unit has a knowledge check question at the end that's more similar to a Try it yourself block. We revised the format.
>

```Python
t = (1, 2, 3)
t
```

```output
(1, 2, 3)
```

Because tuples are immutable, you cannot change elements within them:

```Python
t[1] = 2.0
```

```output
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-110-823b86083d61> in <module>
----> 1 t[1] = 2.0
TypeError: 'tuple' object does not support item assignment
```

However, you can refer to elements within them:

```Python
t[1]
```

```output
2
```

You can also slice tuples:

```Python
t[:2]
```

```output
(1, 2)
```

You can also create tuples from lists:

```Python
l = ['baked', 'beans', 'spam']
l = tuple(l)
l
```

```output
('baked', 'beans', 'spam')
```

Or you can create lists from tuples:

```Python
l = list(l)
l
```

```output
['baked', 'beans', 'spam']
```

## Membership testing

As your Python programming grows more complex, you will want to test lists and tuples for the membership of specific data. The in operator enables you to do that.

```Python
tup = ('a', 'b', 'c')
'b' in tup
```

```output
True
```

You can also test to see if something is not in a list or tuple using `not in`:

```Python
lis = ['a', 'b', 'c']
'a' not in lis
```

```output
False
```

## Try it yourself

- What happens if you run `lis` in `lis`? Is that the behavior you expected?
- If not, think back to the nested lists we’ve already encountered.

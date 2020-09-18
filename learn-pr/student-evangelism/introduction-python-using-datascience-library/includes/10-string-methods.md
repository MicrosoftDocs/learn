From an existing string, related strings can be constructed using string
methods, which are functions that operate on strings. These methods are
called by placing a dot after the string, then calling the function.

For example, the following method generates an uppercased version of a
string.

``` python
"loud".upper()
```

``` output
    'LOUD'
```

Perhaps the most important method is `replace`, which replaces all
instances of a substring within the string. The `replace` method takes
two arguments, the text to be replaced and its replacement.

``` python
'hitchhiker'.replace('hi', 'ma')
```

``` output
    'matchmaker'
```

String methods can also be invoked using variable names, as long as
those names are bound to strings. So, for instance, the following
two-step process generates the word "degrade" starting from "train" by
first creating "ingrain" and then applying a second replacement.

``` python
s = "train"
t = s.replace('t', 'ing')
u = t.replace('in', 'de')
u
```

``` output
    'degrade'
```

Note that the line `t = s.replace('t', 'ing')` doesn't change the string
`s`, which is still "train". The method call `s.replace('t', 'ing')`
just has a value, which is the string "ingrain".

``` python
s
```

``` output
    'train'
```

This is the first time we've seen methods, but methods are not unique to
strings. As we will see shortly, other types of objects can have them.

## Check your knowledge

For the knowledge check below: After executing the following lines of code:
``` python
  x = 8
  y = 2
  z = x / y
 ```

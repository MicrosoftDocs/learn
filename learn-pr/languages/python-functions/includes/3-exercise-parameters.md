In the previous unit, you got your first chance to create your own functions. You created functions with multiple input parameters and input parameters with default values.

You have additional options for input parameters. These options include arbitrary arguments lists and keyword (or named) arguments.

### Step 1 - Add a new file for this exercise to your working directory

This unit assumes you're continuing from the previous unit. Use the techniques you learned in previous modules to add a new code file in the folder dedicated to this module. Name the new file exercise2.py.

### Step 2 - Add code that creates a function accepting an arbitrary arguments list

Add the following code to your new code file:

```python
def print_args(*args):
  for arg in args:
    print(f'arg = {arg}')

print_args('a')
print_args('a', 'b')
print_args('a', 'b', 'c')
```

Here you create the `print_args()` function that accepts an arbitrary arguments list as defined by the `*args` input parameter. A caller of this function can pass any number of arguments into the function. The function then uses the `args` variable to access all the arguments. That variable stores a collection of the arguments that the function can iterate through.

After the function definition, the code calls `print_args()` three times, passing in a different value each time.

When you run the code, you should see the following output:

```output
arg = a
arg = a
arg = b
arg = a
arg = b
arg = c
```

Use arbitrary arguments lists in functions when you don't know how many arguments callers will pass but want the functions to handle whatever is passed. Your code will likely need to iterate through each item in `args` and sum, concatenate, or do some other aggregate operation on those items.

But what is the data type of `args`? Comment out the iteration statement and add `print` statements that display the content and data type of `args`.

```python
def print_args(*args):
  #for arg in args:
  #  print(f'arg = {arg}')
  print(args)
  print(type(args))

print_args('a')
print_args('a', 'b')
print_args('a', 'b', 'c')
```

When you run the code, you should see the following output:

```output
('a',)
<class 'tuple'>
('a', 'b')
<class 'tuple'>
('a', 'b', 'c')
<class 'tuple'>
```

An arbitrary arguments list isn't of type **list** but rather is of type **tuple**.

What is a tuple? In short, it's just like a list with a few differences. The most notable difference is that you can't modify the contents of a tuple. In the current code sample, the function can't call **append()** or **remove()**, call **sort()** or **reverse()**, or assign a new value to an element.

For example, your code can't do this assignment:

```python
args[0] = 'z'
```

Such code produces this error:

```output
TypeError: 'tuple' object does not support item assignment
```

### Step 3 - Comment out the code from the previous step and add code that accepts keyword arguments

Keyword arguments, which are also know as named arguments, are similar to arbitrary arguments lists. Callers can pass any number of keyword arguments. Each argument must specify its name along with its value.

Comment out the code from the previous step and add the following code listing:

```python
def print_keyword_args(**kwargs):

  third = kwargs.get('third', None)
  if third != None:
    print('third arg =', third)


print_keyword_args(first='a')
print_keyword_args(first='b', second='c')
print_keyword_args(first='d', second='e', third='f')
```

In this case, the code calls the `print_keyword_args()` function three times. Each time, it passes in one or more keyword arguments like `first='a'`. The function body can access a specific existing argument by using the `kwargs.get()` method.

Each call to `kwargs.get()` passes in a name and a default value. In the current example, the function looks for a keyword named `'third'`. If `'third'` doesn't exist in `kwargs`, the variable `third` is set to the default value `None`.

When you run the code, you should see the following output:

```output
third arg = f
```

This approach provides a flexible way for a caller to pass in arguments. The downside is that you must rely on a function's documentation or source code to understand what that function expects. If you didn't already know that you could (or should) pass an argument called `third`, you might never understand how to use the function correctly.

### Step 4 - Update the code example to iterate through each keyword and value

Next, you'll learn how to iterate through each keyword and value in `kwargs`.

Update the exercise code to match the following code listing:

```python
def print_keyword_args(**kwargs):

  print('\n')

  for key, value in kwargs.items():
    print(f'{key} = {value}')

  third = kwargs.get('third', None)
  if third != None:
    print('third arg =', third)


print_keyword_args(first='a')
print_keyword_args(first='b', second='c')
print_keyword_args(first='d', second='e', third='f')

```

You added a `for` statement to iterate through the collection. If you're familiar with using a `for` statement to iterate through a **list** object, you might wonder how this code works:

```python
for key, value in kwargs.items():
```

In this case, you're working with not a **list** object but rather a **dict** object or dictionary. A dictionary is like a list, except each item has two parts: a name (or key) and a value. You'll learn more about dictionaries in another module. In your code example, `key` is set to an argument's keyword, and `value` is set to that argument's value.

When you run the code, you should see the following output:

```output
first = a 


first = b 
second = c


first = d
second = e
third = f
third arg = f
```

### Step 5 - Update the code example to print the value of kwargs and its data type

To see the data type of `kwargs`, update the exercise code to match the following code listing:

```python
def print_keyword_args(**kwargs):

  print('\n')
  print(kwargs)
  print(type(kwargs))

  for key, value in kwargs.items():
    print(f'{key} = {value}')

  third = kwargs.get('third', None)
  if third != None:
    print('third arg =', third)


print_keyword_args(first='a')
print_keyword_args(first='b', second='c')
print_keyword_args(first='d', second='e', third='f')
```

When you run the code, you should see the following output:

```output
{'first': 'a'}
<class 'dict'>
first = a


{'first': 'b', 'second': 'c'}
<class 'dict'>
first = b
second = c


{'first': 'd', 'second': 'e', 'third': 'f'}
<class 'dict'>
first = d
second = e
third = f
third arg = f
```

The dictionary is defined using braces symbols (`{}`). Each item in the dictionary follows the format `'<name>': '<value>'`. You also see that the data type of `kwargs` is `dict`.

## Recap

In this exercise, you learned a few ways to make your functions more flexible.

- You can define functions that use arbitrary arguments lists. A list lets a caller pass in any number of arguments. In the previous examples, the `args` input parameter manages the entries as **tuple** values.
- You can define functions that use keyword or named arguments. A caller can pass in any number of named arguments. In the previous examples, the `kwargs` input parameter manages the entries as **dict** values.

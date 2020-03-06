In the previous unit, we got our first chance to create our own functions.  We created functions with multiple input parameters, and even input parameters with default values.  However, you have additional options when it comes to input parameters including arbitrary argument lists and keyword arguments (also referred to as named arguments).

### Step 1 - Add a new file for this exercise to your working directory.

Assuming you're continuing from the previous unit, use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module.  For example, you might create the following file:

```dos
exercise2.py
```

### Step 2 - Add code that creates a function accepting an arbitrary arguments list.

Add the following code to your new code file:

```python
def print_args(*args):
  for arg in args:
    print(f'arg = {arg}')

print_args('a')
print_args('a', 'b')
print_args('a', 'b', 'c')
```
Here we create the `print_args()` function that accepts an arbitrary arguments list as defined by the `*args` input parameter.  This means that a caller of this function can pass any number of arguments into the function.  You can then access all of the arguments using the `args` variable.  `args` stores a collection of the arguments that you can iterate through.

Below the function definition, we call `print_args()` three times passing in different values.

When you execute the code, you should see the following output:

```output
arg = a
arg = a
arg = b
arg = a
arg = b
arg = c
```
Arbitrary argument lists are useful when you do not know how many arguments that caller will pass, but you want to be able to handle whatever they pass.  This likely means you will need to iterate through each item in the `args` and sum, concatenate, or perform some other aggregate operation on those items.

But what is the data type of `args`?  Comment out the iteration statement and add the print statements that display the content of `args` and the data type of `args`, respectively.

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
When you execute the code, you should see the following output:

```output
('a',)
<class 'tuple'>
('a', 'b')
<class 'tuple'>
('a', 'b', 'c')
<class 'tuple'>
```
The arbitrary arguments list is not of type `list`, but rather of type `tuple`.  What is a tuple?  In short, it's just like a list with a few differences.  The most notable difference is that you cannot modify the contents of the tuple.  In other words, you cannot call `append()` or `remove()`, you cannot call `sort()` or `reverse()`, and you can't assign a new value to an element.  In other words, you could not do this:

```python
args[0] = 'z'
```
Otherwise, you would get an error:

```output
TypeError: 'tuple' object does not support item assignment
```

### Step 3 - Comment out the code from the previous step and add code that accepts keyword arguments.

Similar to the arbitrary arguments list is the keyword arguments (also known as named arguments).  Callers can pass an arbitrary number of arguments and each argument must specify a name of the argument along with the value.

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

In this case, we call the `print_keyword_args()` function three times.  Each time, we pass in one or more keyword arguments, like `first='a'`.  In the body of the function, we can access a specific argument (if it exists) using the `kwargs.get()` method.  We call it passing in a name that could potentially be passed in, and a default value.  In our example, we're looking for a keyword named `'third'`.  If it doesn't exist in `kwargs`, then we set it to the default value `None`.

When you execute the code, you should see the following output:

```output
third arg = f
```
This system provides a flexible way to allow the caller to pass in.  The downside to this approach is that you need to rely on documentation or the caller needs to read the function's source code in order to understand what it expects.  If we didn't already know that we could (or should) pass an argument called `third`, then we may never understand how to use the function correctly.

### Step 4 - Update the code example to iterate through each keyword and value.

Next, we'll iterate through each keyword and value in kwargs.  Update the exercise code to match the following code listing:

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

We added a `for` statement to iterate through the collection.  If you're familiar with using `for` statement to iterate through a `list`, then you might wonder how this code works:

```python
for key, value in kwargs.items():
```

In this case, we're not working with a `list`, but rather a `dict`, or rather, a dictionary.  A dictionary is similar to a list, except each item has two parts: a name (or key) and a value.  We'll learn more about the dictionary in another module.  However, in our code example, the `key` is populated with the argument's keyword, and the `value` is populated with the argument's value.

When you execute the code, you should see the following output:

```output
first = a 


first = b 
second = c


first = d
second = e
third = f
third arg = f
```

### Step 5 - Update the code example to print the value of kwargs and its data type.

To further illustrate the data type of `kwargs`, update exercise code to match the following code listing:

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

When you execute the code, you should see the following output:

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

The dictionary is defined using a set of curly braces `{}`, and each item in the dictionary follows the format `'name': 'value'`.  We also see that the data type of `kwargs` is `dict`.

## Recap

In this exercise, we learned about a few ways to make our functions more flexible, including:

- You can define functions using arbitrary arguments list.  This allows the caller to pass in any number of arguments.  The `args` input parameter manages the entries as a `tuple`.
- You can define functions using keyword arguments (or named arguments).  This allows the caller to pass in any number of named arguments.  The `kwargs` input parameter manages the entries as a `dict`.
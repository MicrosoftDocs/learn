Beyond arguments and keyword arguments, Python allows using any number of arguments and keyword arguments without declaring each one of them. This is useful when a function may receive an unknown number of inputs. 

## Variable arguments

Arguments in functions are required. However, when using variable arguments, the function allows any number of arguments (including 0) to be passed in. The syntax for using variable arguments is prefixing a single asterisk before the arguments name `*`. 

The following function prints the arguments received:

```python
def variable_length(*args):
    print(args)
```

> [!NOTE]
> It isn't required to call variable arguments `args`. It's allowed to use any valid variable name. Although it's common to see `*args` or `*a`, you should try to use the same convention throughout a project.

In this case, `*args` is instructing the function to accept any number of arguments (including `0`). Within the function, `args` is now available as the variable that holds all arguments as a tuple. Try out the function by passing any number or type or arguments: 

```python
>>> variable_length()
()
>>> variable_length("one", "two")
('one', 'two')
>>> variable_length(None)
(None,)
```

As you can see, there's no restriction to the number (or type) of arguments passed in.

Before launching, a rocket ship launch requires going through several steps. Depending on tasks or delays, these steps may take longer in time than planned. Let's create a variable length function that can calculate how many minutes until launch given how much time each step is going to take:

```python
def sequence_time(*args):
    total_minutes = sum(args)
    if total_minutes < 60:
        return f"Total time to launch is {total_minutes} minutes"
    else:
        return f"Total time to launch is {total_minutes/60} hours"
```

Try out the function by passing any number of minutes: 

```python
>>> sequence_time(4, 14, 18)
'Total time to launch is 36 minutes' 
>>> sequence_time(4, 14, 48)
'Total time to launch is 1.1 hours'
```

> [!NOTE]
> One important aspect of using variable arguments is that each value is no longer assigned a variable name. All values are now part of the _catch-all_ variable name using the asterisk (`args` in these examples).

## Variable keyword arguments

For a function to accept any number of keyword arguments, a similar syntax is used. In this case, a double asterisk is required:

```python
def variable_length(**kwargs):
    print(kwargs)
```

Try the example function, which prints the names and values passed in as `kwargs`:

```python
>>> variable_length(tanks=1, day="Wednesday", pilots=3)
{'tanks': 1, 'day': 'Wednesday', 'pilots': 3}
```

If you're already familiar with Python dictionaries, you'll notice that variable length keyword arguments are assigned as a dictionary. To interact with the variables and values, use the same operations as a dictionary.

> [!NOTE]
> Just like variable arguments, when using variable keyword arguments it isn't required to use `kwargs`. It's allowed to use any valid variable name. Although it's common to see `**kwargs` or `**kw`, you should try to use the same convention throughout a project.

In this function, let's use variable keyword arguments to report the astronauts assigned to the mission. Since this function allows any number of keyword arguments, it can be reused regardless of the number of astronauts assigned:

```python
def crew_members(**kwargs):
    print(f"{len(kwargs)} astronauts assigned for this mission:")
    for title, name in kwargs.items():
        print(f"{title}: {name}")
```

Try it out with the crew of the Apollo 11:

```python
>>> crew_members(captain="Neil Armstrong", pilot="Buzz Aldrin", command_pilot="Michael Collins")
3 astronauts assigned for this mission:
captain: Neil Armstrong
pilot: Buzz Aldrin
command_pilot: Michael Collins
```

Since it's allowed to pass any combination of keyword arguments, make sure to avoid repeated keywords. Repeated keywords will result in an error:

```python
>>> crew_members(captain="Neil Armstrong", pilot="Buzz Aldrin", pilot="Michael Collins")
  File "<stdin>", line 1
SyntaxError: keyword argument repeated: pilot
```

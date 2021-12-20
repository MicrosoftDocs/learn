Now that you have a good understanding of tracebacks and handling exceptions, let's go through raising exceptions. When writing code, you may know already of a situation that could cause an error condition. In these situations, it's useful to raise exceptions that let other code realize what the problem is. Raising exceptions may also help in decision making for other code. As we've seen before, depending on the error, code can make smart decisions to solve, workaround, or completely ignore a problem.

Astronauts limit their water usage to about 11 liters per day. Let's create a function that depending on the number of astronauts, can calculate how much water will be left after a day or more:

```python
def water_left(astronauts, water_left, days_left):
    daily_usage = astronauts * 11
    total_usage = daily_usage * days_left
    total_water_left = water_left - total_usage
    return f"Total water left after {days_left} days is: {total_water_left} liters"
```

Try it out with 5 astronauts, 100 liters of water left, and 2 more days to go:

```python
>>> water_left(5, 100, 2)
'Total water left after 2 days is: -10 liters'
```

That's not very useful, because a deficit in liters should be an error. Then, the navigation system could use to alert the astronauts that there isn't going to be enough water left for everyone in two days. If you are an engineer programming the navigation system, you could raise an exception in the `water_left()` function to alert of the error condition:

```python
def water_left(astronauts, water_left, days_left):
    daily_usage = astronauts * 11
    total_usage = daily_usage * days_left
    total_water_left = water_left - total_usage
    if total_water_left < 0:
        raise RuntimeError(f"There is not enough water for {astronauts} astronauts after {days_left} days!")
    return f"Total water left after {days_left} days is: {total_water_left} liters"
```

Now run it again:

```python
>>> water_left(5, 100, 2)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 6, in water_left
RuntimeError: There is not enough water for 5 astronauts after 2 days!
```

In the navigation system, the code used to signal the alert can now use the `RuntimeError` to alert:

```python
try:
    water_left(5, 100, 2)
except RuntimeError as err:
    alert_navigation_system(err)
```

The `water_left()` function can also be updated to prevent passing unsupported types. Try passing arguments that aren't integers to check the error output:

```python
>>> water_left("3", "200", None)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in water_left
TypeError: can't multiply sequence by non-int of type 'NoneType'
```

The error from `TypeError` is not very friendly in the context of what the function expects. Update the function so that it uses `TypeError` but with a better message:

```python
def water_left(astronauts, water_left, days_left):
    for argument in [astronauts, water_left, days_left]:
        try:
            # if argument is an int, the following operation will work
            argument / 10
        except TypeError:
            # a TypError will only be raised if it isn't the right type. Re-raise
            # the same exception but with a better error message:
            raise TypeError(f"All arguments must be of type int, but received: '{argument}'")
    daily_usage = astronauts * 11
    total_usage = daily_usage * days_left
    total_water_left = water_left - total_usage
    if total_water_left < 0:
        raise RuntimeError(f"There is not enough water for {astronauts} astronauts after {days_left} days!")
    return f"Total water left after {days_left} days is: {total_water_left} liters"
```

Now try again to get a better error:

```python
>>> water_left("3", "200", None)
Traceback (most recent call last):
  File "<stdin>", line 5, in water_left
TypeError: unsupported operand type(s) for /: 'str' and 'int'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 9, in water_left
TypeError: All arguments must be of type int, but received: '3'
```
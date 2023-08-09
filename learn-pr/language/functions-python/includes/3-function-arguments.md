Now that you know how to create a function with no inputs, the next step is to create functions that require an argument. Using arguments makes functions more flexible, because they can do more and conditionalize what they do.

## Requiring an argument

If you're piloting a rocket ship, a function without required inputs is like a computer with a button to tell you the time. If you press the button, a computerized voice tells you the time. But a required input can be a destination to calculate travel distance. Required inputs are called _arguments_ to the function.

To require an argument, put it within the parentheses:

```python
def distance_from_earth(destination):
    if destination == "Moon":
        return "238,855"
    else:
        return "Unable to compute to that destination"
```

Try calling the `distance_from_earth()` function without any arguments:

```python
distance_from_earth()
```

```Output
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: distance_from_earth() missing 1 required positional argument: 'destination'
```

Python raises `TypeError` with an error message that says the function requires an argument named `destination`. If the rocket ship's computer is asked to compute the travel distance with a destination, it should prompt that a destination is a requirement. The example code has two paths for a response, one for the Moon and the other one for anything else. Use the Moon as input to get an answer:

```python
distance_from_earth("Moon")
```

```Output
238,855
```

Because there's a _catch-all_ condition, try using any other string as the destination to check that behavior:

```python
distance_from_earth("Saturn")
```

```Output
Unable to compute to that destination
```

## Multiple required arguments

To use multiple arguments, you must separate them by using a comma. Let's create a function that can calculate how many days it takes to reach a destination, given distance and a constant speed:

```python
def days_to_complete(distance, speed):
    hours = distance/speed
    return hours/24
```

Now use the distance from Earth to the Moon to calculate how many days it would take to get to the Moon at a speed limit of 75 miles per hour:

```python
days_to_complete(238855, 75)
```

```Output
132.69722222222222
```

## Functions as arguments

You can use the value of the `days_to_complete()` function and assign it to a variable, and then pass it to `round()` (a built-in function that rounds to the closest whole number) to get a whole number:

```python
total_days = days_to_complete(238855, 75)
round(total_days)
```

```Output
133
```

However, a useful pattern is to pass functions to other functions instead of assigning the returned value:

```python
round(days_to_complete(238855, 75))
```

```Output
133
```

> [!TIP]
> Although passing functions directly into other functions as input is useful, there is potential for reduced readability. This pattern is especially problematic when the functions require many arguments. 

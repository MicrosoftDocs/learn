Optional arguments require a default value assigned to them. These named arguments are called _keyword arguments_. Keyword argument values must be defined in the functions themselves. When you're calling a function that's defined with keyword arguments, it isn't necessary to use them at all.

The Apollo 11 mission took about 51 hours to get to the Moon. Let's create a function that returns the estimated time of arrival by using the same value as the Apollo 11 mission as the default:

```python
from datetime import timedelta, datetime

def arrival_time(hours=51):
    now = datetime.now()
    arrival = now + timedelta(hours=hours)
    return arrival.strftime("Arrival: %A %H:%M")
```

The function uses the `datetime` module to define the current time. It uses `timedelta` to allow the addition operation that results in a new time object. After computing that result, it returns the `arrival` estimation formatted as a string. Try calling it without any arguments:

```python
arrival_time()
```

```Output
Arrival: Saturday 16:42
```

Even though the function defines a keyword argument, it allows not passing one when you're calling a function. In this case, the `hours` variable defaults to `51`. To verify that the current date is correct, use `0` as the value for `hours`:

```python
arrival_time(hours=0)
```

```Output
Arrival: Thursday 13:42
```

## Mixing arguments and keyword arguments

Sometimes, a function needs a combination of arguments and keyword arguments. In Python, this combination follows a specific order. Arguments are always declared first, followed by keyword arguments.

Update the `arrival_time()` function to take a required argument, which is the name of the destination:

```python
from datetime import timedelta, datetime

def arrival_time(destination, hours=51):
    now = datetime.now()
    arrival = now + timedelta(hours=hours)
    return arrival.strftime(f"{destination} Arrival: %A %H:%M")
```

Because you added a required argument, it's no longer possible to call the function without any arguments:

```python
arrival_time()
```

```Output
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: arrival_time() missing 1 required positional argument: 'destination'
```

Use `"Moon"` as the value for `destination` to avoid the error:

```python
arrival_time("Moon")
```

```Output
Moon Arrival: Saturday 16:54
```

You can also pass more than two values, but you need to separate them with a comma. It takes about 8 minutes (0.13 hours) to get to orbit, so use that as an argument:

```python
arrival_time("Orbit", hours=0.13)
```

```Output
Orbit Arrival: Thursday 14:11
```

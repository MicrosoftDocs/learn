# Introducing for loops

Lists store any type of Python values such as strings or numbers:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
```

You can access any item in a list by putting the _index_ in square brackets after the variable name. Indexes start from 0:

```python
print("The first planet is ", planets[0])
print("The second planet is ", planets[1])
print("The third planet is ", planets[2])
```

You can also determine the number of items in a list by using `len`. So you could use a `while` loop and a counter to loop or iterate over each item in the list. Because this is such a common operation, Python provides `for` loops which can be used to iterate over lists.

> [!NOTE]
> Python has many types that can be looped over. These types are known as **iterables**.

Python lists are iterable, and can be used with a `for` loop. A `for` loop is used with iterables where you will loop a known number of times - once for each item in the iterable.

## For loops

Here is an example for-loop counting down from 4 to 0:

```python
countdown = [4, 3, 2, 1, 0]
for number in countdown:
    print(number)
print("Blast off!! 🚀")
```

The for-loop is a statement with 5 important parts:

1. The word `for` followed by a space.
1. The variable name you want to create for each value in the sequence (`number`).
1. The word `in` surrounded by spaces.
1. The name of the list (`countdown`), or iterable you want to loop over following by a colon (`:`).
1. The code you want to run for each item in the iterable, separated by nested whitespace.

Lets change that code to wait for 1 second between each number by using the `sleep()` function:

```python
from time import sleep

countdown = [4, 3, 2, 1, 0]

for number in countdown:
    print(number)
    sleep(1)  # Wait 1 second
print("Blast off!! 🚀")
```

> [!NOTE]
> Most Python code uses 4 spaces as the unit of whitespace. To save pressing space 4 times, most editors have a shortcut for the **Tab** key to insert 4 spaces.

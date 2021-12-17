Python has many builtin types, such as strings and integers. Python has a type for storing a collection of values, the list.

## Creating a list

Lists are created by assigning a sequence of values to a variable, each separated by a comma and surrounded by square brackets `[]`:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
```

The `planets` variable now stores the list of all planets.

## Accessing list items by index

You can access any item in a list by putting the _index_ in square brackets `[]` after the list variable's name. Indexes start from 0, so `planets[0]` is the first item in the list `planets`:

```python
print("The first planet is", planets[0])
print("The second planet is", planets[1])
print("The third planet is", planets[2])

# Output
# The first planet is Mercury
# The second planet is Venus
# The third planet is Earth
```

> [!NOTE]
> All indexes start from `0`, so `[1]` is the second item, `[2]` is the third and so-forth.

You can also modify values in a list with its index. You do so by assigning a new value, much in the same way you would assign a variable value. You could change the name of Mars in the list to use its nickname:

```python
planets[3] = "Red Planet"
print("Mars is also known as", planets[3])

# Output
# Mars is also known as Red Planet
```

## Determining the length of a list

To get the length of a list, use the builtin function `len()`:

```python
number_of_planets = len(planets)
print("There are", number_of_planets, "planets in the solar system.")

# Output:
# There are 8 planets in the solar system
```

This creates a new variable, `number_of_planets` and assigns it with the number of items in the list `planets` (8).

## Adding values to lists

Lists in Python are dynamic, meaning you can add and remove items after they've been created. To add an item to a list, use the method `.append(value)`.

For example, to add string `"Pluto"` to the end of the list, `planets`:

```python
planets.append("Pluto")
number_of_planets = len(planets)
print("There are actually", number_of_planets, "planets in the solar system.")

# Output:
# There are actually 9 planets in the solar system.
```

## Removing values from lists

You can remove the last item in a list by calling the `.pop()` method on the list variable:

```python
planets.pop()  # Goodbye, Pluto
number_of_planets = len(planets)
print("No, there are definitely", number_of_planets, "planets in the solar system.")
```

## Negative indexes

You saw how to use indexes to fetch an individual item in a list:

```python
print("The first planet is", planets[0])

# Output:
# The first planet is Mercury
```

Indexes start at zero and increase. Negative indexes work from the end of the list, backwards.

An index of `-1` returns the last item in a list, `-2` returns the second last, `-3` returns the third last and so on:

```python
print("The last planet is", planets[-1])
print("The penultimate planet is", planets[-2])

# Output
# The last planet is Neptune
# The penultimate planet is Uranus
```

## Finding a value in a list

You may need to determine where in a list a value is stored. You can do this by using the list's `index` method. `index` will search for the value, and return the index of that item in the list. If no match is found, `-1` is returned.

```python
jupiter_index = planets.index("Jupiter")
print("Jupiter is the", jupiter_index + 1, "planet from the sun")

# Output
# Jupiter is the 5 planet from the sun
```

> [!NOTE]
> Because indexing starts with 0, we need to add 1 to display the proper number.

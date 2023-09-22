Python has many built-in types, such as strings and integers. Python has a type for storing a collection of values: the list.

## Create a list

You create a list by assigning a sequence of values to a variable. Each value is separated by a comma and surrounded by brackets (`[]`). The following example stores the list of all planets in the `planets` variable:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
```

## Access list items by index

You can access any item in a list by putting the _index_ in brackets `[]` after the list variable's name. Indexes start from 0, so in the following code, `planets[0]` is the first item in the list `planets`:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
print("The first planet is", planets[0])
print("The second planet is", planets[1])
print("The third planet is", planets[2])
```

```Output
The first planet is Mercury
The second planet is Venus
The third planet is Earth
```

> [!NOTE]
> Because all indexes start from 0, `[1]` is the second item, `[2]` is the third, and so forth.

You can also modify values in a list by using an index. You do so by assigning a new value, in much the same way that you would assign a variable value. For example, you could change the name of Mars in the list to use its nickname:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
planets[3] = "Red Planet"
print("Mars is also known as", planets[3])
```

Output: `Mars is also known as Red Planet`

## Determine the length of a list

To get the length of a list, use the built-in function `len()`. The following code creates a new variable, `number_of_planets`. The code assigns that variable with the number of items in the list `planets` (8).

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
number_of_planets = len(planets)
print("There are", number_of_planets, "planets in the solar system.")
```

Output: `There are 8 planets in the solar system`

## Add values to lists

Lists in Python are dynamic: you can add and remove items after they're created. To add an item to a list, use the method `.append(value)`.

For example, the following code adds the string `"Pluto"` to the end of the list `planets`:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
planets.append("Pluto")
number_of_planets = len(planets)
print("There are actually", number_of_planets, "planets in the solar system.")
```

Output: `There are actually 9 planets in the solar system.`

## Remove values from lists

You can remove the last item in a list by calling the `.pop()` method on the list variable:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
planets.pop()  # Goodbye, Pluto
number_of_planets = len(planets)
print("No, there are definitely", number_of_planets, "planets in the solar system.")
```

## Use negative indexes

You saw how to use indexes to fetch an individual item in a list:

```python
print("The first planet is", planets[0])
```

Output: `The first planet is Mercury`

Indexes start at zero and increase. Negative indexes start at the end of the list and work backward.

In the following example, an index of `-1` returns the last item in a list. An index of `-2` returns the second to last. 

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
print("The last planet is", planets[-1])
print("The penultimate planet is", planets[-2])
```

```Output
The last planet is Neptune
The penultimate planet is Uranus
```

If you wanted to return the third to last, you'd use an index of `-3` (and so on).

## Find a value in a list

To determine where in a list a value is stored, you use the list's `index` method. This method searches for the value and returns the index of that item in the list. If it doesn't find a match, it returns `-1`.

The following example shows the use of `"Jupiter"` as the index value:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
jupiter_index = planets.index("Jupiter")
print("Jupiter is the", jupiter_index + 1, "planet from the sun")
```

Output: `Jupiter is the 5 planet from the sun`

> [!NOTE]
> Because indexing starts with 0, you need to add 1 to display the proper number.

Here's another:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
mercury_index = planets.index("Mercury")
print("Mercury is the", mercury_index + 1, "planet from the sun")
```

Output: `Mercury is the 1 planet from the sun`

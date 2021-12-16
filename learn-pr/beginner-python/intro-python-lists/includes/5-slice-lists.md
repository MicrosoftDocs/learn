You will often need to work with different portions of a list. For example, you may have a list with rainfall amounts for different months. To properly analyze this type of data you might need to look for rainfall in fall, or a three-month period. Or you may look to sort the list in order of most rainfall to least.

Python provides robust support for working with the data in lists. This includes slicing data, meaning you will examine just a portion, or sorting.

## Slicing lists

You can retrieve a portion of a list using a **slice**. A slice uses square brackets, but instead of a single item it has the start and end indexes. A new list will be created starting at the start index, and ending at the end index but **not** including it.

Planets is a list of 8. Earth is the third in the list. To get the planets before Earth, use a slice to get items starting at 0 and ending at 2:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
planets_before_earth = planets[0:2]
print(planets_before_earth)

# Output: ['Mercury', 'Venus']
```

Notice how Earth is not included in the list. The reason is the index ends before the ending index, but does not include it.

To get all the planets after Earth, start at the third and go to eighth:

```python
planets_after_earth = planets[3:8]
print(planets_after_earth) 

# Output
# ['Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune']
```

In this example, Neptune is displayed. The reason is the index for Neptune is `7`, because indexing starts at `0`. Because our ending index was `8`, it includes the last value. If you don't put the stop index in the slice, Python assumes you want to go to the end of the list:

```python
planets_after_earth = planets[3:]
print(planets_after_earth)

# Output
# ['Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune']
```

> [!IMPORTANT]
> A slice creates a **new** list, and does not modify the current list.

## Joining lists

You've seen how you can use slices to split up lists, but what about joining them back together?

To join two lists, you use the other operator (`+`) with two lists to return a new list.

There are 79 known moons of Jupiter. The four largest are Io, Europa, Ganymede, and Callisto. These are known as the Galilean moons as they were discovered by Galileo Galilei using his telescope in 1610. Closer to Jupiter than the Galilean group is the Amalthea Group consisting of the moons, Metis, Adrastea, Amalthea, and Thebe.

Create two lists, the first with the four Amalthea moons and a list of the Galilean moons. Join them together using `+` to make a new list:

```python
amalthea_group = ["Metis", "Adrastea", "Amalthea", "Thebe"]
galilean_moons = ["Io", "Europa", "Ganymede", "Callisto"]

regular_satellite_moons = amalthea_group + galilean_moons
print("The regular satellite moons of Jupiter are", regular_satellite_moons)

# Output
# The regular satellite moons of Jupiter are ['Metis', 'Adrastea', 'Amalthea', 'Thebe', 'Io', 'Europa', 'Ganymede', 'Callisto']
```

> [!IMPORTANT]
> Joining lists creates a **new** list, and does not modify the current list.

## Sorting lists

To sort a list, use the `.sort()` method on the list. Python will sort a list of strings in alphabetical order and a list of numbers in numeric order:

```python
regular_satellite_moons.sort()
print("The regular satellite moons of Jupiter are", regular_satellite_moons)

# Output
# The regular satellite moons of Jupiter are ['Adrastea', 'Amalthea', 'Callisto', 'Europa', 'Ganymede', 'Io', 'Metis', 'Thebe']
```

To sort a list in reverse order, call `.sort(reverse=True)` on the list:

```python
regular_satellite_moons.sort(reverse=True)
print("The regular satellite moons of Jupiter are", regular_satellite_moons)

# Output
# The regular satellite moons of Jupiter are ['Thebe', 'Metis', 'Io', 'Ganymede', 'Europa', 'Callisto', 'Amalthea', 'Adrastea']
```

> [!IMPORTANT]
> Using `sort` modifies the current list.

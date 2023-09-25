You might need to work with different portions of a list. For example, assume that you have a list with rainfall amounts for various months. To properly analyze this type of data, you might need to look for rainfall in a three-month period. Or you might want to sort the list in order of most rainfall to least.

Python provides robust support for working with the data in lists. This support includes slicing data (examining just a portion) and sorting.

## Slice lists

You can retrieve a portion of a list by using a *slice*. A slice uses brackets, but instead of a single item, it has the starting and ending indexes. When you use a slice, you create a new list that starts at the starting index and that ends before (and does *not* include) the ending index.

The list of planets has eight items. Earth is the third in the list. To get the planets before Earth, use a slice to get items starting at 0 and ending at 2:

```python
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
planets_before_earth = planets[0:2]
print(planets_before_earth)
```

Output: `['Mercury', 'Venus']`

Notice how Earth is not included in the list. The reason is that the index ends before the ending index.

To get all the planets after Earth, start at the third and go to the eighth:

```python
planets_after_earth = planets[3:8]
print(planets_after_earth) 
```

Output: `['Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune']`

In the example, Neptune is displayed. The reason is that the index for Neptune is `7`, because indexing starts at `0`. Because the ending index was `8`, it includes the last value. If you don't put the stopping index in the slice, Python assumes that you want to go to the end of the list:

```python
planets_after_earth = planets[3:]
print(planets_after_earth)
```

Output: `['Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune']`

> [!IMPORTANT]
> A slice creates a *new* list. It doesn't modify the current list.

## Join lists

You've seen how you can use slices to split up lists, but what about joining them back together?

To join two lists, you use the other operator (`+`) with two lists to return a new list.

There are 79 known moons of Jupiter. The four largest are Io, Europa, Ganymede, and Callisto. These moons are called the Galilean moons, because Galileo Galilei discovered them by using his telescope in 1610. Closer to Jupiter than the Galilean group is the Amalthea group. It consists of the moons Metis, Adrastea, Amalthea, and Thebe.

Create two lists. Populate the first list with the four Amalthea moons and the second list with the four Galilean moons. Join them together by using `+` to make a new list:

```python
amalthea_group = ["Metis", "Adrastea", "Amalthea", "Thebe"]
galilean_moons = ["Io", "Europa", "Ganymede", "Callisto"]

regular_satellite_moons = amalthea_group + galilean_moons
print("The regular satellite moons of Jupiter are", regular_satellite_moons)
```

Output: `The regular satellite moons of Jupiter are ['Metis', 'Adrastea', 'Amalthea', 'Thebe', 'Io', 'Europa', 'Ganymede', 'Callisto']`

> [!IMPORTANT]
> Joining lists creates a *new* list. It doesn't modify the current list.

## Sort lists

To sort a list, use the `.sort()` method on the list. Python sorts a list of strings in alphabetical order and a list of numbers in numeric order:

```python
amalthea_group = ["Metis", "Adrastea", "Amalthea", "Thebe"]
galilean_moons = ["Io", "Europa", "Ganymede", "Callisto"]

regular_satellite_moons = amalthea_group + galilean_moons
regular_satellite_moons.sort()
print("The regular satellite moons of Jupiter are", regular_satellite_moons)
```

Output: `The regular satellite moons of Jupiter are ['Adrastea', 'Amalthea', 'Callisto', 'Europa', 'Ganymede', 'Io', 'Metis', 'Thebe']`

To sort a list in reverse order, call `.sort(reverse=True)` on the list:

```python
amalthea_group = ["Metis", "Adrastea", "Amalthea", "Thebe"]
galilean_moons = ["Io", "Europa", "Ganymede", "Callisto"]

regular_satellite_moons = amalthea_group + galilean_moons
regular_satellite_moons.sort(reverse=True)
print("The regular satellite moons of Jupiter are", regular_satellite_moons)
```

Output: `The regular satellite moons of Jupiter are ['Thebe', 'Metis', 'Io', 'Ganymede', 'Europa', 'Callisto', 'Amalthea', 'Adrastea']`

> [!IMPORTANT]
> Using `sort` modifies the current list.

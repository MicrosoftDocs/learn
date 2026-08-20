
A **list** is an ordered collection of values, written inside square brackets `[]` with items separated by commas. Lists are one of the most commonly used data structures in Python because they can hold any type of value and can be modified after creation.

## Creating a list

```python
colors = ["red", "green", "blue"]
scores = [95, 82, 76, 91]
```

Lists can hold any data type, and can even mix types—although keeping one type per list makes your code easier to reason about.

## Accessing items by index

Each item in a list has a numbered position called an **index**, starting at `0`:

```python
colors = ["red", "green", "blue"]
print(colors[0])  # Output: red
print(colors[2])  # Output: blue
```

You can also use **negative indexes** to count from the end:

```python
print(colors[-1])  # Output: blue  (last item)
print(colors[-2])  # Output: green
```

## Common list operations

Lists can be modified after creation. Here are the operations you'll use most often:

| Operation | What it does |
|---|---|
| `len(list)` | Returns the number of items |
| `list.append(value)` | Adds an item to the end of the list |
| `list.remove(value)` | Removes the first matching item |
| `list[i] = value` | Overwrites the item at index `i` |
| `list.pop()` | Removes and returns the last item |
| `list.sort()` | Sorts the list in place |

```python
colors = ["red", "green", "blue"]

print(len(colors))        # Output: 3
colors.append("yellow")   # Adds "yellow" to the end
print(colors)             # Output: ['red', 'green', 'blue', 'yellow']

colors.remove("red")      # Removes "red"
print(colors)             # Output: ['green', 'blue', 'yellow']

colors[0] = "purple"      # Replaces "green" with "purple"
print(colors)             # Output: ['purple', 'blue', 'yellow']
```

## Iterating over a list

Lists work naturally with `for` loops:

```python
scores = [95, 82, 76, 91]

for score in scores:
    print(score)
```

Output:

```output
95
82
76
91
```
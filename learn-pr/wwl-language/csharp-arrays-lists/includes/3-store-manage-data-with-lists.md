A `List<T>` is a resizable, ordered collection of values that all share the same type. Unlike an array, a list can grow or shrink while your program runs, which makes it a good fit when you don't know the exact number of items ahead of time.

## Creating a list

The `T` in `List<T>` stands for the type of item the list holds. For example, `List<string>` holds strings, and `List<int>` holds integers.

```csharp
List<string> colors = new List<string> { "red", "green", "blue" };
List<int> scores = new List<int>();
```

The first line creates a list with three starting values. The second line creates an empty list that you can add items to later.

## Common list operations

Lists support several built-in methods for adding, removing, and updating items.

| Operation | What it does |
|---|---|
| `list.Count` | Returns the number of items |
| `list.Add(value)` | Adds an item to the end of the list |
| `list.Remove(value)` | Removes the first matching item |
| `list[i] = value` | Overwrites the item at index `i` |
| `list.RemoveAt(i)` | Removes the item at index `i` |
| `list.Sort()` | Sorts the list in place |

```csharp
List<string> colors = new List<string> { "red", "green", "blue" };

Console.WriteLine(colors.Count); // Output: 3
colors.Add("yellow");            // Adds "yellow" to the end
Console.WriteLine(colors.Count); // Output: 4

colors.Remove("red");            // Removes "red"
colors[0] = "purple";            // Replaces "green" with "purple"
```

## Iterating over a list

Like arrays, lists work naturally with `foreach` loops.

```csharp
List<int> scores = new List<int> { 95, 82, 76, 91 };

foreach (int score in scores)
{
    Console.WriteLine(score);
}
```

Output:

```output
95
82
76
91
```

> [!TIP]
> Avoid hardcoding index numbers when a loop variable already tells you the position. Reaching for `list[2]` repeatedly in your code is a sign you probably want a `foreach` loop instead.

## Choosing between an array and a `List<T>`

Choose an **array** when:

-   You know the exact number of items ahead of time, and it won't change.
-   You want the most efficient, low-overhead way to store a fixed set of values.

Choose a `List<T>` when:

-   The number of items can grow or shrink while your program runs.
-   You need built-in methods like Add, Remove, or Sort, without managing the size yourself.

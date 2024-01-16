You might find yourself in a situation where you've more than one of a certain type of data. You could create a variable for each piece of data, or you could group it all into a collection. Grouping the data gives you advantages such as the ability to carry out methods not only on individual pieces of data, but on the collection as a whole.

## Collections

The first sign that you need to use a collection is that you have multiple pieces of data that seem to be of the same data type. You might have a scenario where you have many entries, such as in the following code:

```fsharp
let logEntryMonday = "first entry"
let logEntryTuesDay = "second entry"
let logEntryWednesday = "third entry"
```

In this code, you can continue adding one similar entry after another, but at some point that approach begins to feel impractical. The separate entries aren't only related but are, in fact, of the same type. Is it a good idea to create a new variable for each entry? Probably not. Instead, consider using a collection, where you can create a logical, manageable grouping, whether it's adding or removing data or using some other operation:

```fsharp
logEntriesWeek = ["first entry"; "second entry"; "third entry"]
```

This code not only requires a lot less typing, but it also creates a sense of order, where everything that's related is grouped together.

So what can F# offer you? For starters, it gives you three types of collections, each one designed for a particular situation.

- **Lists**: A list in F# is an ordered, *immutable* set of elements of the same type. Immutable means that a list might offer better performance than an array, but you might have to be more creative if you want to change its content. For example, you might want to create a new list from an existing list. This unit focuses on using lists.

- **Arrays**: Arrays are fixed-size, *mutable* collections of data elements of the same type that are ordered consecutively with a zero-based index. Mutable means that it's easy to add and remove data elements, but there might be a performance hit.

- **Sequences**: A sequence is a logical series of elements of the same type. A sequence has a just-in-time feeling to it, because it works well with large collections of data, where you don't expect to use all elements. It also computes elements only when it's required to do so. Therefore, sequences can offer better performance than lists in certain situations.

## Lists

As we've mentioned, a list is an ordered, immutable set of elements. Here are some ways to create a list:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
```

In this code, you enclose the elements in brackets (`[]`) to define the list. The list items are separated by a semicolon (`;`).

Another way to create a list is to place each element on a new line, as shown here. This method also removes the need to use semicolons.

```fsharp
let cards = [
  "Ace"
  "King"
  "Queen"
]
```

In lists, elements must be of the same type, so the following declaration isn't permitted:

```fsharp
let cards = [ 1; "Ace"; "King" ] // not permitted
```

In this code, because the declaration mixes numbers and strings, it isn't permitted. Another way to create a list is to use a range operator (`..`). The idea is to specify the start and end elements, separated by a range operator (`..`). Doing so creates all the numbers from start to end, including the in-between elements. For example, you can create the numbers `1 2 3 4 5` by using the following code:

```fsharp
let numbers = [ 1 .. 5 ]
```

### Change a list

As we mentioned, lists are immutable, which means that they can't change. By thinking about it differently, though, you can make it seem as though you're adding an item or even a list of items to a list. What does that mean? Consider the following example:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
```

The preceding code is a list consisting of three strings. By using a double colon (`::`) operator, you can append an item to the beginning of a list. The result is a new list, and the old list is unaffected:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
let newList = "Jack" :: cards // "Jack", "Ace", "King", "Queen" 
```

You can also add an entire list by using the at sign (`@`) operator, as shown here:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
let otherCardList = ["Jack"; "10"]
let fullList = cards @ otherCardList // "Ace", "King", "Queen", "Jack", "10"
```

There's an `append()` function in the list module, and it works for both array and sequence collections. It's preferable to use `append()` if, for example, you need to switch the collection type from list to sequence or you want to avoid having to learn a new way to add items. Using the at sign (`@`) to add elements to a list works only for a list structure. Let's revisit our two examples and instead use `append()`:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
let otherCardList = ["10"; "9"]
let fullList = cards |> List.append ["Jack"] // "Jack", "Ace", "King", "Queen"
let fullList = cards |> List.append otherCardList // "10", "9", "Ace", "King", "Queen"
```

## Properties

Lists in F# are implemented as linked lists. That is, a list is a structure in which each element is connected to another element. More terms to learn are *head*, which is the first element in the list, and *tail*, which includes the elements that aren't in the head. For example, in the list `1 2 3 4`, the head would be `1` and the tail would be `2 3 4`.

By separating the elements in this way, you can quickly access the first element so that you can read, remove, or perform other actions on it. To access any specific item in the list, you can use an `Item` property, which takes a zero-based index, as shown here:

```fsharp
let list = [1; 2; 3; 4]
list.Item 1 // 2
```

The list properties are described in the following table:

| Property | Description |
|--|--|
| Head | The first element in a list |
| Empty | Returns an empty list; can be used when you want to create an empty list |
| IsEmpty | Checks to see whether the current list is empty |
| Item | Retrieves the current element at the specified position (zero-based index) |
| Length | Returns the number of items in the list |
| Tail | Returns all but the first element in the list |

You might find yourself in a situation where you have more than one of a certain type of data. Now, you could create a variable for each piece of data or you could group it all into a collection. Grouping the data gives you certain advantages, such as being able to carry out methods not only on individual pieces of data but also on the collection as a whole.

## Collections

The first sign that you need to use a collection is that you have data that's seemingly of the same data type. You might have a scenario where you have many entries, such as in the following code:

```fsharp
let logEntryMonday = "first entry"
let logEntryTuesDay = "second entry"
let logEntryWednesday = "third entry"
```

In the preceding code, you can continue adding entries, but at some point that approach begins to feel impractical. The separate entries seem related and are, in fact, of the same type, but is it a good idea to create a new variable for each entry? Probably not. Instead, you consider using a collection, where you can create a logical, manageable grouping, whether it's adding or removing data or using some other operation:

```fsharp
logEntriesWeek = ["first entry", "second entry"; "third entry"]
```

The preceding code is a lot less to type, and it creates a sense of order, where everything that's related is grouped together. 

So what can F# offer you? For starters, F# gives you three types of collections. The type to use depends on your situation.

- **Arrays**: Arrays are fixed-size, zero-based, *mutable* collections of consecutive data elements that are all of the same type. Mutable means that it's easy to add and remove data elements, but there might be a performance hit.
- **Lists**: A list in F# is an ordered, *immutable* set of elements of the same type. Immutable means that a list might offer better performance than an array, but you might have to be more creative if you want to seemingly change its content by, for example, creating new lists from other lists. This unit focuses on the benefits of using lists.
- **Sequences**: A sequence is a logical series of elements of the same type. A sequence has a just-in-time feeling to it, because it works well with large collections of data, where you don't expect to use all elements, and it computes elements only when required. Therefore, sequences can offer better performance than lists in certain situations.

## Lists

As we stated previously, a list is an ordered, immutable set of elements. Here are some ways to create a list:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
```

In the preceding code, you enclose the elements in brackets (`[]`) to define the list. The list items are separated by a semicolon (`;`). 

Another way to create a list is to place each element on a new line, as shown here. This also removes the need to use semicolons:

```fsharp
let cards = [
  "Ace"
  "King"
  "Queen"
]
```

Lists need to contain elements of the same type, so the following declaration is not permitted:

```fsharp
let cards = [ 1, "Ace", "King" ] // not permitted
```

In the preceding code, because the declaration mixes numbers and strings, it isn't permitted. Only a single type is permitted. Another way to create a list is to use a range operator (`..`). The idea is to specify the start and end elements, separated by a colon (`:`). Doing so creates all the numbers from start to end, including the in-between elements. For example, the numbers `1 2 3 4 5` are created with the following code:

```fsharp
let numbers = [ 1 .. 5 ]
```

### Changing a list

As we mentioned, lists are immutable, which means that what's there can't change. By thinking about it differently, though, you can make it seem like you're adding an item or even a list of items to a list. What does that mean? Consider the following example:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
```

It's a list consisting of three strings. By using the double colon (`::`) operator, you can append an item to this list. The result is a new list, and the old list is unaffected:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
let newList = "Jack" :: cards // "Jack", "Ace", "King", "Queen" 
```

You can also add an entire list by using the at sign (`@`) operator, as shown here:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
let otherCardList = ["Jack", "10"]
let fullList = cards @ otherCardList // "Ace", "King", "Queen", "Jack", "10"
```

However, there is a function `append()` in the list module. Here's the thing, the `append()` function exist for both sequence and array collections, so it's better to use that, should you ever need to switch the collection type for example or learn things once. Let's revisit our two examples and instead use `append()`:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
let otherCardList = ["10", "9"]
let fullList = cards |> List.append ["Jack"]
let fullList = cards |> List.append otherCardList // "Ace", "King", "Queen", "Jack", "10", "9"
```

## Properties

Lists in F# are implemented as linked lists. That is, a list is a structure in which each element is connected to another element. Additional terms to learn are *head*, which is the first element in the list, and *tail*, which includes everything that's not the head. For example, in list `1 2 3 4`, the head would be `1` and the tail would be `2 3 4`.

Separating the elements in this way lets you quickly access the first element so that you can read, remove, or perform other actions on it. To access any specific item in the list, you can use an `Item` property that takes a 0-based index, as shown here:

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
| Item | Retrieves the current element at the specified position (0-based index) |
| Length | Returns the number of items |
| Tail | Returns all but the first element in the list |

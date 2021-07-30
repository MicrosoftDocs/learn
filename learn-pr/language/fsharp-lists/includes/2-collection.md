You find yourself in a situation where you have many more than one of a certain type of data. Now, you could create a variable for each piece of data or you could group them into a collection. Doing so brings advantages like being able to carry out methods on individual pieces of data but also on the collection as a whole.

## Collections

The first sign that you need a collection is that you have similar data that's seemingly of the same data type. You might start in a scenario like so, where you have many entries:

```fsharp
let logEntryMonday = "first entry"
let logEntryTuesDay = "second entry"
let logEntryWednesday = "third entry"
```

You can keep going like the above code, for each new entry, but at some point it's starting to feel impractical. The data seem related, is of the same type and do you really want to create a new variable for each entry? Probably not, so you turn to a collection, where you can instead create a logical grouping that you can manage, whether it's adding or removing or some other operation:

```fsharp
logEntriesWeek = ["first entry", "second entry"; "third entry"]
```

The above code is a lot less to type and it also creates a sense of orders, everything related goes together. So what can F# offer us? There's three types of collections in F#:

- **Arrays**: Arrays are fixed-size, zero-based, mutable collections of consecutive data elements that are all of the same type.
- **Lists**: A list in F# is an ordered, immutable series of elements of the same type.
- **Sequences**: A sequence is a logical series of elements all of one type.

Which one you want to use depends on your situation. The fat that an array is mutable means it's easy to add and remove elements of data but there might be a performance hit as it is mutable. A list on the other hand is immutable and may offer better performance than an array but you might have to be more creative if you want to seemingly change its content, by, for example,  creating new lists from other lists. A sequence has a just-in-time feeling to it, as it's great with large collections of data, where you don't expect to use all elements, and only computes elements when required. Therefore it can offer better performance than a list in certain situations.

## Lists

As stated previously, a list is an ordered, immutable set of elements. Here's some ways to create a list:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
```

You use the  square brackets `[]` to define the list and each item in it, is separated by a semicolon `;`. Another way to create a list is by adding a newline after each element, thus removing the need to use a semicolon, `;`:

```fsharp
let cards = [
  "Ace"
  "King"
  "Queen"
]
```

Lists need to have the same type of element, so the below declaration is not permitted:

```fsharp
let cards = [ 1, "Ace", "King" ] // not permitted
```

Above you are mixing numbers and strings, you need to keep with one type. Another way to create a list is by using a range operator `..`, the idea is to define the start element and then an end element, separated by `:`. Thereby all the numbers from start, the between elements, and the end element is created. In the below example, it creates the values `1 2 3 4 5`:

```fsharp
let numbers = [ 1 .. 5 ]
```

### Changing a list

So, lists are immutable, meaning what's there can't change. However, by thinking about it differently, you can make it seem like you are adding an item or even a list of item to a list. What does that mean? Consider the below example list:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
```

It's a list consisting of three strings. By using the `::` operator you can append an item to this list, with the result being a new list, the old list is not affected:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
let newList = "Jack" :: cards // "Jack", "Ace", "King", "Queen" 
```

You can also add an entire list with the `@` operator, like so:

```fsharp
let cards = ["Ace"; "King"; "Queen"]
let otherCardList = ["Jack", "10"]
let fullList = cards |> List.append // "Ace", "King", "Queen", "Jack", "10"
```

## Properties

Lists in F# are implemented as linked lists, meaning it's a structure where each element is connected to another element. There are also concepts like "head" meaning the first element in the list, and "tail" meaning everything that's not the head. Imagine you have the following items in a list `1 2 3 4`, then you can think of the list as consisting of two parts, head and tail:

| head | tail |
|--|--|
| 1 | 2,3,4 |

What this division gives you, is the ability to quickly be able to access the first element, to read or remove it or whatever you want to do. Should you want to access a specific item in the list, there's an `Item` property that takes a 0-based index like so:

```fsharp
let list = [1; 2; 3; 4]
list.Item 1 // 2
```

Here's a full list of the properties on the list:

| Property | Description |
|--|--|
| Head | The first element |
| Empty | Returns an empty list, can be used when you want to create an empty list |
| IsEmpty | Checks if the current list is empty |
| Item | Retrieves the current element at the specified position (0-based index) |
| Length | Returns the number of items |
| Tail | Returns back the entire list, save for the first element |

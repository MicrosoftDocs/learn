When you store many items in a list, you will want to carry out operations on either the whole or part of the list. The list module, contains many useful operations that let you do just that.

## List module functions

Except for properties, there's also a List module, a module full of functions that operates on a list, capable of performing commonly used operations like finding, filtering, sorting, mathematical operations and more.

### Iteration

To iterate, means you go through each element in a list from a starting point to an end point. For iteration there are two especially interesting functions:

- `iter()`, lets you iterate over each item in a list:

    ```fsharp
    let cards = [ 1 .. 5 ]
    List.iter(fun i -> printfn "%i" i) cards // 1 2 3 4 5
    ```

    The `iter()` function takes a function, above you are providing an anonymous function using the `fun` keyword. The function takes a parameter that represents the current item as it's being iterated through. This code is the equivalent of writing the following code with a loop:

    ```fsharp
    for i in cards do printfn "%i" i
    ```

- `map()`, is similar to `iter()` but with this function you are interested in transforming what you have. Here's an example:

   ```fsharp
   type Person = { FirstName: string, LastName= string  }
   let people = [
     { FirstName="Albert"; LastName="Einstein" }
     { FirstName="Marie"; LastName="Curie" }
   ]
   let nobelPrizeWinners = people.map(fun person -> person.FirstName + person.LastName) // "Albert Einstein", "Marie Curie"
   ```

   In the above code, the list of `Person` objects is transformed to a list of strings.

### Filter

The function `filter()` also takes a function as parameter but its goal is to define what elements to keep. If the expression evaluates to `true`, the element is kept, if `false` then it won't be part of the filtered list. In the below example a list is filtered to only keep the items who's value is dividable by 2:

```fsharp
let cards = [ 1 .. 5 ]
let filteredList = List.filter(fun i-> i % 2 = 0) cards
List.iter(fun i -> printfn "item %i" i) filteredList // item 2 item 4
```

The list `filteredList` now only contains the elements that returned `true` when being evaluated by `i % 2 = 0`, which is 2 and 4.

### Sort

A thing you are likely to do is, sort. Here's three functions you might find useful, that sorts lists:

- `sort()`, sorts in ascending order. Here's an example:

   ```fsharp
   let list = [2; 1; 5; 3]
   let sortedList = List.sort list // 1 2 3 5 
   ```

- `sortBy()`, the idea is to point out a key to sort by. Let's say you have a list of people and each people record has the fields `name` and `age`, then you can point out to sort by `age` for example. This function takes a function where you point out the key. Another key could be the length of a string like in this example:

   ```fsharp
   let fruits = ["Banana", "Apple", "Pineapple"]
   let sortedFruits = List.sortBy(fun fruit -> fruit.Length) // Apple, Banana, Pineapple
   ```

- `sortWith()`. The idea with this sort is that you provide a comparator function as it might be a bit complicated, at first look to say which item should be sorted before which other item. Here's an example code:

   ```fsharp
   // assume a type like so
   type MagicCreature = { Name : string; Level: int; Attack: int }
   let creatures = [
     { Name="Dragon"; Level=2; Attack=20 }
     { Name="Orc"; Level=1; Attack=5 }
     { Name="Demon"; Level=2; Attack=10 } 
   ]
   // comparison function, -1 = less than, 1 = larger than, 0 = equal
   let compareCreatures = c1 c2
       if c1.Level < c2.Level then -1
       else if c1.Level > c2.Level then 1
       else if c1.Attack < c2.Attack then -1
       else if c1.Attack > c2.Attack then 1
       else 0

   let sorted = List.sortWidth compareCreatures creatures // { Name="Orc"; Level=1; Attack=5 }, { Name="Demon"; Level=2; Attack=10 }, { Name="Dragon"; Level=2; Attack=20 }
   ```

   The above comparison function `compareCreatures()` tries to first compare by `Level`, if that's equal, it tries to compare by `Attack`. Returning `-1` means something is considered smaller, `1` that it's larger and `0` that it's equal.

### Search

Another thing you might want to do is to find a specific element. There are a few different functions to choose from namely:

- `find()`, it finds the first element that matches a condition. To use `find()`, you need to provide it function (predicate) that expresses how to find the item. Here's an example:

   ```fsharp
   let list = [1;2;3;4]
   List.find( fun x -> x % 2 = 0) list 
   ```

- `tryFind()`, this function takes a function (predicate), that tells how to find the value and list to look into. It returns an option. Here's how you can use it:

   ```fsharp
   let findValue aValue aList =
       let found= aList |> List.tryFind(fun item -> item = aValue)
           
       match found with
       | Some value -> printfn "%i" value
       |  None -> printfn "Not found"

   findValue 1 list // 1
   findValue 5 list // Not found
   ```

   In the above code, we send in a value to compare to our list. If found, it returns `Some`, if not found, then it's a `None`.

- `tryFindIndex()`, just like `tryFind()`, it returns an option and it takes a function (predicate) that evaluates to a boolean. Here's what using it might look like:

   ```fsharp
   let found = List.tryFindIndex(fun x -> x = 4) list
   match found with
     | Some index -> printfn "%i" index
     | None -> printfn "Not found"
   ```

### Arithmetic operations

Being able to carry out mathematical operations on a list can be valuable. There are many functions to choose from in the List module API but there are three useful ones in `sum()`, `average()`, and, `sumBy()`. Here's how they work:

- `sum()`, using this function you iterate over each item sum thing up. Here's how you can use it:

   ```fsharp
   let sum - List.sum [1 .. 5] // sum = 15 
   ```

- `sumBy()`. The idea with `sumBy()` function is to point out how to sum something. A way to do so is by pointing out the fields to sum by like in the below example:

   ```fsharp
   type OrderItem = { Name: string; Cost:int }

   let orderItems = [
         { Name="XBox"; Cost=500 }
         { Name="Book"; Cost=10 }
         { Name="Movie ticket"; Cost=7 }
       ]
    
   let sum = List.sumBy(fun item -> item.Cost) orderItems
   printfn "%i" sum // 517
   ```

   In the above code, the `Cost` field is pointed out and each item adds to the total.

- `average()`. The `average()` function is similar to `sum()` in that it operates on a list of numbers. There are two differences however, the function expects the data to be floating point numbers, not integers, also it calculates an average rather than a sum. Here's an example:

   ```fsharp
   let numbers = [ 1.0; 2.5; 3.0 ]
   let avg = List.average numbers
   printfn "%f" avg // 2.166667
   ```

- `averageBy()`, just like `sumBy()` it takes a function where you specify what value you want. Here's an example:

   ```fsharp
   type WeatherMeasurement = { Date: string; Temperature: float }
   let measurements = [
      { Date="07/20/2021"; Temperature=21.3 }
      { Date="07/21/2021"; Temperature=23.2 }
      { Date="07/22/2021"; Temperature=20.7 }
   ]
    
   let avgBy = List.averageBy(fun m -> m.Temperature) measurements
   printfn "%f" avgBy
   ```

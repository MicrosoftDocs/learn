When you store many items in a list, you often carry out operations on either part or all of the list. The list module contains many useful operations that let you do just that.

## List module functions

Besides properties, there's a list module, which is full of functions that operate on a list. The functions can perform commonly used operations, such as finding, filtering, sorting, carrying out mathematical operations, and more.

### Iteration

To iterate means to go through each element in a list, from a starting point to an end point. For iteration, there are two especially interesting functions:

- `iter()`: This function lets you iterate over each item in a list, as shown here:

    ```fsharp
    let cards = [ 1 .. 5 ]
    List.iter(fun i -> printfn "%i" i) cards // 1 2 3 4 5
    ```

    The `iter()` function takes a function. In the preceding code, you're providing an anonymous function by using the `fun` keyword. This function takes a parameter that represents the current item as it's being iterated through. The following code is the equivalent of writing the following code with a loop:

    ```fsharp
    for i in cards do printfn "%i" i
    ```

- `map()`: This function is similar to `iter()`, but it lets you transform what you have. Here's an example:

   ```fsharp
   type Person = { FirstName: string; LastName: string  }
   let people = [
     { FirstName="Albert"; LastName= "Einstein" }
     { FirstName="Marie"; LastName="Curie" }
   ]
   let nobelPrizeWinners = List.map (fun person -> person.FirstName + person.LastName) people 
   printfn "%A" nobelPrizeWinners // ["Albert Einstein"; "Marie Curie"]
   ```

   In the preceding code, the list of `Person` objects is transformed into a list of strings.

### Filter

The `filter()` function also takes a function as a parameter, but its purpose is to define what elements to keep. If the expression evaluates to `true`, the element is kept. If the expression is `false`, the element won't be part of the filtered list. In the following example, a list is filtered to keep only items whose value is divisible by two:

```fsharp
let cards = [ 1 .. 5 ]
let filteredList = List.filter(fun i-> i % 2 = 0) cards
List.iter(fun i -> printfn "item %i" i) filteredList // item 2 item 4
```

The `filteredList` list now contains only the elements that return `true` when they're evaluated by `i % 2 = 0`, which is 2 and 4.

### Sort

Sorting lists is something you're likely to do often. Here are three functions that you might find useful when you sort lists:

- `sort()`, sorts in ascending order. Here's an example:

   ```fsharp
   let list = [2; 1; 5; 3]
   let sortedList = List.sort list // 1 2 3 5 
   ```

- `sortBy()`: With this function, the idea is to point out a key to sort by. Let's say you have a list of people, and each record has the fields `name` and `age`. You can then point out to sort by `age`, for example. This function takes a function where you point out the key. Another key could be the length of a string, as in this example:

   ```fsharp
   let fruits = ["Banana"; "Apple"; "Pineapple"]
   let sortedFruits = List.sortBy (fun (fruit : string) -> fruit.Length) fruits // Apple, Banana, Pineapple
   ```

- `sortWith()`: With this function, you can provide a comparator function, because it might not be apparent at first which of several items should be sorted before any other item. Here's some example code:

   ```fsharp
   // assume a type like so
   type MagicCreature = { Name : string; Level: int; Attack: int }
   let creatures = [
     { Name="Dragon"; Level=2; Attack=20 }
     { Name="Orc"; Level=1; Attack=5 }
     { Name="Demon"; Level=2; Attack=10 } 
   ]

   // comparison function, -1 = less than, 1 = larger than, 0 = equal
   let compareCreatures c1 c2 =
       if c1.Level < c2.Level then -1
       else if c1.Level > c2.Level then 1
       else if c1.Attack < c2.Attack then -1
       else if c1.Attack > c2.Attack then 1
       else 0

   let sorted = List.sortWith compareCreatures creatures // { Name="Orc"; Level=1; Attack=5 }, { Name="Demon"; Level=2; Attack=10 }, { Name="Dragon"; Level=2; Attack=20 }
   ```

   The preceding comparison function `compareCreatures()` first tries to compare by `Level`. If the level is equal, it tries to compare by using `Attack`. It returns `-1` if something is considered smaller, `1` if it's larger, and `0` if it's equal.

### Search

Another thing you might want to do is to find a specific element. To do so, you can choose from the following functions:

- `find()`: This function finds the first element that matches a certain condition. To use `find()`, you need to provide a function (predicate) that expresses how to find the item. Here's an example:

   ```fsharp
   let list = [1; 2; 3; 4]
   let found = List.find( fun x -> x % 2 = 0) list // 2 - Only the first element that matches the condition is returned.
   ```

- `tryFind()`. This function takes a function (predicate) that tells how to find the value and a list to look into. It returns an option. Here's how you can use it:

   ```fsharp
   let findValue aValue aList =
       let found = aList |> List.tryFind(fun item -> item = aValue)
           
       match found with
       | Some value -> printfn "%i" value
       | None -> printfn "Not found"

   findValue 1 list // 1
   findValue 5 list // Not found
   ```

   In the preceding code, you send in a value to compare to your list. If it's found, it returns `Some`. If it isn't found, it returns `None`.

- `tryFindIndex()`. Like `tryFind()`, this function returns an option, and it takes a function (predicate) that evaluates to a Boolean. Here's what the code might look like:

   ```fsharp
   let found = List.tryFindIndex(fun x -> x = 4) list
   match found with
     | Some index -> printfn "%i" index
     | None -> printfn "Not found"
   ```

### Arithmetic operations

Carrying out mathematical operations on a list can be valuable. Among many functions to choose from in the List API, here are the three most useful ones:

- `sum()`: By using this function, you iterate over each item to sum all values in the list. Here's how you can use it:

   ```fsharp
   let sum = List.sum [1 .. 5] // sum = 15 
   ```

- `sumBy()`: With this function, the idea is to point out how to sum the values. One way to do so is to point out which fields to sum, as in the following example:

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

   In the preceding code, the `Cost` field is pointed out, and each item in that field adds to the total.

- `average()`: This function is similar to `sum()` in that it operates on a list of numbers, but with two differences:  
  - It expects the data to be floating point numbers, not integers.
  - It calculates an average rather than a sum.

   Here's an example:

   ```fsharp
   let numbers = [ 1.0; 2.5; 3.0 ]
   let avg = List.average numbers
   printfn "%f" avg // 2.166667
   ```

- `averageBy()`: Like `sumBy()`, `averageBy()` takes a function where you specify what value you want. Here's an example:

   ```fsharp
   type WeatherMeasurement = { Date: string; Temperature: float }
   let measurements = [
      { Date="07/20/2021"; Temperature=21.3 }
      { Date="07/21/2021"; Temperature=23.2 }
      { Date="07/22/2021"; Temperature=20.7 }
   ]
    
   let avgBy = List.averageBy(fun m -> m.Temperature) measurements
   printfn "%f" avgBy // 21.733333
   ```

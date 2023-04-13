
In this exercise, focus on applying some of the functional patterns that you were taught. Also, work on the code written by your colleagues and fuse it together with a pipeline operator.

## Create an app

As mentioned, your colleagues have been busy writing code. Here it is:

```fsharp
let cards = [21; 3; 1; 7; 9; 23]
let cardFace card = 
    let no = card % 13
    if no = 1 then "Ace"
    elif no = 0 then "King"
    elif no = 12 then "Queen"
    elif no = 11 then "Jack"
    else string no

let suit card =
    let no = card / 13
    if no = 0 then "Hearts"
    elif no = 1 then "Spades"
    elif no = 2 then "Diamonds"
    else "Clubs"

let shuffle list =
    let random = System.Random()
    list |> List.sortBy (fun x -> random.Next())

let printCard card = printfn "%s of %s" (cardFace card) (suit card)

let printAll list = List.iter(fun x -> printCard(x)) list

let take (no:int) (list) = List.take no list 
```

The code consists of different parts that help you implement a card game. So, what's the task? Your task is to take a deck of cards, shuffle it, take the top three cards, and then print the results.

1. Create a new project with:

    ```bash
    dotnet new console --language F# -o Cards
    cd Cards
    ```

1. Replace the code in the _Program.fs_ file with the code you've been given.

1. Create a pipeline by adding the following line at the end:

   ```fsharp
   cards |> shuffle |> take 3 |> printAll
   ```

   This code calls the functions `shuffle()`, `take()`, and `printAll()` in a sequence from left to right. The output results vary because the `shuffle()` method introduces a random element.

1. Run the project by calling `dotnet run`.

   ```bash
   dotnet run
   ```

   You should see three cards being printed with their proper description and suit. Here's an example output of what it can look like:

    ```output
    Ace of Hearts
    9 of Hearts
    7 of Hearts
    ```

Congratulations! You and your team have built the start of a card application. You've also successfully applied a pipeline that lets you call functions in a sequence, all of which apply to a list of cards.

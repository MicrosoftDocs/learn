Your team is happy with the code you write so far for the card game. They wish you to develop it further and start implementing game rule-specific logic like calculate the value of a hand. For this exercise, you will use some of the functions in the list module.

## Calculate a hand for the game 31

As part of calculating a card hand, you have the cards, represented as a number between 0 and 51. You need to translate those numbers to something that makes sense within the domain of cards, like for example "Ace of Hearts", rather than a 0. Luckily, a colleague of yours already wrote that code:

```fsharp
// 0 = 11, 11, 12, 13 = 10, else the actual number
let cardValue card =
    let value = card % 13
    if value = 0 then 11
    elif value = 10 || value = 11 || value = 12 then 10
    else value
```

Your task is to take a card hand and calculate its value by using the `sumBy()` function.

1. Create a new project by calling `dotnet new` in an empty directory:

   ```bash
   dotnet new console --language F# -o CardGame
   cd CardGame
   ```

1. Add the code from your colleague above the main method.
1. To create your card hand, add the following code:

   ```fsharp
   let hand = [0; 25; 31]
   ```

1. You have a card hand, let's add the `sumBy()` function:

   ```fsharp
   let sum = List.sumBy(fun card -> cardValue card) hand
   printfn "%i" sum
   ```

1. Now, run the code by calling `dotnet run`:

   ```bash
   dotnet run
   ```

   You should now see the following output:

   ```output
   26 
   ```

Congratulations! You've managed to evaluate a card game for the game 31, it became 26, not quite 31, but it's pretty good sum.

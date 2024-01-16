Your team is happy with the code you've written so far for the card game. The team wants you to develop the code further and start implementing game rule-specific logic, such as calculating the value of a hand. 

For this exercise, use some of the functions in the list module.

## Calculate a hand for the game 31

In the card game "31," each of two or more players is dealt a hand consisting of three cards. The player wins whose card point total is closest to 31. Each card has its own face value, except that the jack, queen, and king are worth 10 points each, and aces are worth 11 points. A player holding, for example, a 10, a jack, and an ace, would have 31 points, and that hand would be the winner.

In an earlier unit, you created a deck of cards, each represented as a number from 0 to 51. To begin calculating a hand, you need to translate those numbers into something that makes sense within the domain of cards. For example, you would replace the number "0" with the name "Ace of Hearts." 

Fortunately, one of your colleagues has already written that code:

```fsharp
// 0 = 11, 11, 12, 13 = 10, else the actual number
let cardValue card =
    let value = card % 13
    if value = 0 then 11
    elif value = 10 || value = 11 || value = 12 then 10
    else value
```

Copy the preceding code to use in step 2 of the following instructions.

Your task is to take a card hand and calculate its value by using the `sumBy()` function.

1. Create a new project by calling `dotnet new` in an empty directory:

   ```bash
   dotnet new console --language F# -o CardGame
   cd CardGame
   ```

1. Above the main method, add your colleague's code, which you copied a moment ago.

1. To create your card hand, add the following code:

   ```fsharp
   let hand = [0; 25; 31]
   ```

1. Now that you've created the hand, add the `sumBy()` function:

   ```fsharp
   let sum = List.sumBy(fun card -> cardValue card) hand
   printfn "%i" sum
   ```

1. Run the code by calling `dotnet run`:

   ```bash
   dotnet run
   ```

   You should now see the following output:

   ```output
   26 
   ```

Congratulations! You've managed to evaluate a card game for the game 31. It became 26, which isn't quite 31, but it's a good sum.

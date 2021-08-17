In this exercise, you will learn to use `if` and `else` to implement some functionality for card game for the recreational games company you work for. You will need to write some functionality that will be used by your colleagues to implement the game Black Jack.

## Display presentable cards

As part of a player's experience, players are used to have names for certain cards like, Jack, Queen, King, and so on, whereas other cards are a mere number. You will write the logic needed to make the user experience better.

1. Scaffold an F# project by running `dotnet new`:

   ```bash
   dotnet new console --language F# -o Cards
   cd Cards
   ```

1. Locate the `Program.fs` file and the `main()` method and add the following code:

   ```fsharp
   let cardNo = 12
    
    let cardDescription = 
      if cardNo = 1 || cardNo = 14 then "Ace"
      elif cardNo = 11 then "Jack"
      elif cardNo = 12 then "Queen"
      elif cardNo = 13 then "King"
      else string cardNo
    printfn "%s" cardDescription
   ```

1. Run the project with `dotnet run`

   ```bash
   dotnet run
   ```

   Your output shows:

   ```output
   Queen
   ```

Congratulations, you've managed to create a piece of code that given a card number is apply to produce a description.

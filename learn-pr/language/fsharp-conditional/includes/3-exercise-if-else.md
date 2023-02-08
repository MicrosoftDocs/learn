In this exercise, you'll use `if` and `else` to create the code for a card game for the recreational games company you work for. Your job is to write specific functionality that your colleagues can use in the Blackjack game they're creating.

## Display playing cards users expect to see

Blackjack players typically are dealt face cards called Jack, Queen, King, and Ace. All other cards are numbers. You'll write logic that makes the user experience in a new Blackjack game your team is developing similar to a Blackjack game played in person.

1. Scaffold an F# project by running `dotnet new`:

    ```bash
    dotnet new console --language F# -o Cards
    cd Cards
    ```

1. Open the *Program.fs* file. Replace the contents with the following code:

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

1. Run the project with `dotnet run`:

   ```bash
   dotnet run
   ```

   Your output shows:

   ```output
   Queen
   ```

Congratulations, you've created a piece of code that, given a card number, produces a description.

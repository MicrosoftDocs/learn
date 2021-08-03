You are working as a developer at a casual games company. You've been asked to create some starting code that can be used for a card game. Your first assignment is to create a deck of cards and function that's able to take cards from the deck, one at a time.

## Create a deck

A deck of cards has 52 cards, we will for convenience make that five cards, so it's easier to read the console print. You can create a series of numbers using `..`.

1. Create a new project by running `dotnet new`:

   ```bash
   dotnet new console --language F# -o Cards
   cd Cards
   ```

1. Add the following code to _Program.fs_, to create the list holding the cards:

   ```fsharp
   let cards = [ 0 .. 5 ]
   ```

   This code will create a list consisting of numbers from 0 to 5.

## Draw cards

Once you have your deck, you can construct a method to draw cards. You can use the built-in properties `Head` and `Tail` to do so.

1. Next, create a function `drawCard()`:

   ```fsharp
   let drawCard (list:int list) = 
       printfn "%i" list.Head
       list.Tail 
   ```

   By using `Head`, you read the first item in the list and by returning `Tail` you simulate taking a card from the top of the list and return the remaining deck.

1. Add the following code to the `main()` method to try out your implementation:

   ```fsharp
   cards |> drawCard |> drawCard // 0 1
   ```

1. Run the project by calling `dotnet run`:

   You should now see `0` and `1` being printed at the console.

Congratulations! You've implemented a deck of cards you can draw from.

## Draw cards to a hand

So, drawing cards is great, but usually in a card game there's players that want to pick up those cards - a hand. Next, you will implement so that each card you draw will also be picked up by a hand. You will need to make some modifications to your code to support this scenario.

1. Add the following code, just where you declared the `cards` list:

   ```fsharp
   let hand = []
   ```

1. Next, modify the `drawCard()` method to accept a tuple, that consists of two lists, representing the deck and representing the hand:

   ```fsharp
   let drawCard (tuple: int list * int list) = 
       let deck = fst tuple
       let draw = snd tuple
       let firstCard = deck.Head
       printfn "%i" firstCard
   
       let hand = 
           draw
           |> List.append [firstCard]

       (deck.Tail, hand)
   ```

   The `fst()` function is used to access the first property in the tuple, that is your deck. `snd` is used to access the hand. You also modified the return type, so it returns a tuple, consisting of the deck and your hand `(deck.Tail, hand)`, but with the added card `firstCard`.

1. Modify the code in the main method to draw cards to the hand:

   ```fsharp
   let d, h = (cards, hand) |> drawCard |> drawCard

   printfn "Deck: %A Hand: %A" d h // Deck: [2; 3; 4; 5] Hand: [0; 1]
   ```

1. Run the project calling `dotnet run`:

   ```bash
   dotnet run
   ```

   You should see the following printed in the console:

   ```output
   Deck: [2; 3; 4; 5] Hand: [0; 1]
   ```

Congratulations! You've managed to simulate having a player, `hand`, for each time you draw a card.

Let's say you're a developer at a casual games company. You've been asked to write some starting code to be used for a card game. Your first assignment is to create a deck of cards and then create a function that can draw cards from the deck, one at a time.

## Create a deck of cards

A card deck has 52 cards, but to make it easier to read the console print, let's reduce the deck to five cards. You can create a number series by inserting two dots (`..`), surrounded by spaces, between the first and last numbers in the list.

1. In the console, create a new project by running `dotnet new`:

   ```bash
   dotnet new console --language F# -o Cards
   cd Cards
   ```

1. To create a list that holds the cards, in the _Program.fs_ file, add the following code:

   ```fsharp
   let cards = [ 0 .. 5 ]
   ```

   This code creates a list of numbers from 0 to 5.

## Draw cards from the deck

Now that you've created your deck, you can construct a method for drawing cards from it. To do so, you can use the built-in properties `Head` and `Tail`.

1. Next, create a function `drawCard()`:

   ```fsharp
   let drawCard (list:int list) = 
       printfn "%i" list.Head
       list.Tail 
   ```

   By using the `Head` property, you read the first item in the list, and by returning `Tail`, you simulate taking a card from the top of the list and return the remaining cards in the deck.

1. To try out your implementation, add the following code to the `main()` method:

   ```fsharp
   let result = cards |> drawCard |> drawCard // 0 1
   ```

1. Run the project by calling `dotnet run`:

   You should now see `0` and `1` being printed in the console.

Congratulations! You've implemented a deck that you can draw cards from.

## Draw cards to a hand

The ability to draw cards from the deck is a great start, but card games ordinarily need two or more players to pick up those cards. As you know, each player's collection of drawn cards is called a *hand*. Next, you need to implement code to have each drawn card added to a hand.

1. In the code where you declared the `cards` list, add the following code:

   ```fsharp
   let hand = []
   ```

1. Next, modify the `drawCard()` method to accept a tuple that consists of two lists, one representing the deck and the other representing the hand:

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

   The `fst()` function is used to access the first property in the tuple (that is, your deck). The `snd` function is used to access the hand. You also modified the return type so that it returns a tuple that consists of the deck and your hand `(deck.Tail, hand)`, but with the added card `firstCard`.

1. Modify the code in the main method to draw cards to the hand:

   ```fsharp
   let d, h = (cards, hand) |> drawCard |> drawCard

   printfn "Deck: %A Hand: %A" d h // Deck: [2; 3; 4; 5] Hand: [1; 0]
   ```

1. Run the project by calling `dotnet run`:

   ```bash
   dotnet run
   ```

   You should see the following output printed in the console:

   ```output
   Deck: [2; 3; 4; 5] Hand: [1; 0]
   ```

Congratulations! You've managed to simulate having a player, `hand`, for each time you draw a card.

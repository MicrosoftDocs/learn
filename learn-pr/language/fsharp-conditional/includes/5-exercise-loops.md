In this exercise, you'll build a deck of cards for a card game that's in development. You'll use looping constructs to iterate over the cards, and then print the card on the screen. Your colleagues also have been hard at work, and they incorporated the code you created in the first exercise into a function.

## Scaffold a project

Begin by scaffolding a new F# project in your console. Run the command `dotnet new`:

```bash
dotnet new console --language F# -o Loops
cd Loops
```

## Create a card description

Your colleagues have taken the code you wrote in the previous exercise and turned it into a function, so it's reusable. Here's what the code looks like now:

```fsharp
let cardDescription (card: int) : string =
    let cardNo: int = card % 13
    if cardNo = 1 then "Ace"
    elif cardNo = 11 then "Jack"
    elif cardNo = 12 then "Queen"
    elif cardNo = 0 then "King"
    else string cardNo
```

To create a card description:

1. In *Program.fs*, replace the contents with the following code:

    ```fsharp
    open System
        
    let cardDescription (card: int) : string =
        let cardNo: int = card % 13
        if cardNo = 1 then "Ace"
        elif cardNo = 11 then "Jack"
        elif cardNo = 12 then "Queen"
        elif cardNo = 0 then "King"
        else string cardNo
    
    [<EntryPoint>]
    let main argv =
        // implement the rest
        0 // return an integer exit code
    ```

   The function is named `cardDescription` and the input parameter is `card`. Your colleagues gave you a code snippet to work with. They want you to implement a similar function, but a function determines what suit the card is. They gave you this code snippet:

   ```fsharp
   let suit (no:int) : string = 
       let suitNo:int = no / 13
       // add implementation here 
   ```

   Now, use the knowledge you've gained about `if...else` to determine what suit a card is. The rules are: `0` is hearts, `1` is spades, `2` is diamonds, and `3` is clubs.

   > [!TIP]
   > Pause and think about how to apply your knowledge before you move on.

1. Make the following changes to the code:

    ```fsharp
    let suit (no:int) : string = 
        let suitNo:int = no / 13
        if suitNo = 0 then "Hearts"
        elif suitNo = 1 then "Spades"
        elif suitNo = 2 then "Diamonds"
        else "Clubs" 
    ```

    The code in *Program.fs* should now look like this example:

    ```fsharp
    open System

    let suit (no:int) : string = 
        let suitNo:int = no / 13
        if suitNo = 0 then "Hearts"
        elif suitNo = 1 then "Spades"
        elif suitNo = 2 then "Diamonds"
        else "Clubs" 
    
    let cardDescription (card: int) : string =
        let cardNo: int = card % 13
        if cardNo = 1 then "Ace"
        elif cardNo = 11 then "Jack"
        elif cardNo = 12 then "Queen"
        elif cardNo = 0 then "King"
        else string cardNo
    
    [<EntryPoint>]
    let main argv =
        // implement program
        0 // return an integer exit code
    ```

Congratulations, you've finished that part of the card game.

## Print the deck

Again, your colleagues have helped you create a card deck. All you have to do is print it. Here's the code for the card deck:

```fsharp
let cards = [ 1; 10; 2; 34 ]
```

To print the deck:

1. Add the `cards` definition to the `main()` method:

   ```fsharp
    [<EntryPoint>]
    let main argv =
        let cards = [ 1; 10; 2; 34 ]
        // implement program
        0 // return an integer exit code
   ```

   The deck contains only four cards. In a more realistic implementation, the code would contain all 52 cards, but this list will suffice for an example.

   Your colleagues have again written some code for you. You just have to fill in what's missing. Here's a code snippet:

   ```fsharp
   // add for loop
     printfn "%s of %s" (cardDescription(card)) (suit(card))
   ```

   The code consists of a commented-out line. Your task is to add code to implement a `for...in` loop.

1. Add the following code to the `main()` method to implement the `for...in` loop:

    ```fsharp
    for card in cards do
      printfn "%s of %s" (cardDescription(card)) (suit(card))
    ```

    The `main()` method should now look like this code:

    ```fsharp
    [<EntryPoint>]
    let main argv =
        let cards = [ 1; 10; 2; 34 ]
        for card in cards do
          printfn "%s of %s" (cardDescription(card)) (suit(card))
        0 // return an integer exit code
   ```

1. Run the project by calling `dotnet run`:

   ```bash
   dotnet run
   ```

   You should see the following output:

   ```output
   Ace of Hearts 
   10 of Hearts
   2 of Hearts
   8 of Diamonds 
   ```

Congratulations. You worked with code that you and your colleagues implemented and developed it into more of a realistic-looking program.

*Program.fs* now looks like this code:

```fsharp
open System

let suit (no:int) : string = 
    let suitNo:int = no / 13
    if suitNo = 0 then "Hearts"
    elif suitNo = 1 then "Spades"
    elif suitNo = 2 then "Diamonds"
    else "Clubs" 

let cardDescription (card: int) : string =
    let cardNo: int = card % 13
    if cardNo = 1 then "Ace"
    elif cardNo = 11 then "Jack"
    elif cardNo = 12 then "Queen"
    elif cardNo = 0 then "King"
    else string cardNo

[<EntryPoint>]
let main argv =

    let cards = [ 1; 10; 2; 34 ]

    for card in cards do
      printfn "%s of %s" (cardDescription(card)) (suit(card))
    0 // return an integer exit code
```

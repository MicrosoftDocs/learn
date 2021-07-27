In this exercise, you'll continue with your card game to build a deck of cards. You'll use looping constructs to iterate over the cards and print them to the screen. Your colleagues have been hard at work and taken what you've implemented in the first exercise and placed that code into a function.

## Scaffold a project

Start by scaffolding a new F# project in your console.

Run the command `dotnet new` like so:

```bash
dotnet run console --language F# -o Loops
cd Loops
```

## Create a card description

Your colleagues have taken the code you wrote in the last exercise and turned that into a function to make it reuseable. The code now looks like so:

```fsharp
let cardDescription (card: int) : string = 
     let cardNo: int = card % 13
     if cardNo = 1 || cardNo = 14 then "Ace"
     elif cardNo = 11 then "Jack"
     elif cardNo = 12 then "Queen"
     elif cardNo = 13 then "King"
     else string cardNo
```

1. Place the above code above the `main()` method in _Program.fs_.

   The code in _Program.fs_ should now look like so:

   ```fsharp
    open System
        
    let cardDescription (card: int) : string = 
         let cardNo: int = card % 13
         if cardNo = 1 || cardNo = 14 then "Ace"
         elif cardNo = 11 then "Jack"
         elif cardNo = 12 then "Queen"
         elif cardNo = 13 then "King"
         else string cardNo
    
    [<EntryPoint>]
    let main argv =
        // implement the rest
        0 // return an integer exit code
   ```

   The `cardDescription` is the name of the function and `card` is the input parameter. Your colleagues have given you a code snippet to work with and what they want is for you to implement a similar function but that determines what suit  card has.  They've given you the following code snippet:

   ```fsharp
   let suit (no:int) : string = 
       let suitNo:int = no / 13
       // add implementation here 
   ```

   Now, use the knowledge you've been given, around `if...else` to determine what suit something is. The rules are `0` is hearts, `1` is Spades, `2` is Diamonds, and `3` is Clubs.

   > [!TIP]
   > Think about this one for a second before moving on.

1. Change the implementation above to the following code:

    ```fsharp
    let suit (no:int) : string = 
        let suitNo:int = no / 13
        if suitNo = 0 then "Hearts"
        elif suitNo = 1 then "Spades"
        elif suitNo = 2 then "Diamonds"
        else "Clubs" 
    ```

    The code in _Program.fs_ should now look in the following way:

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
         if cardNo = 1 || cardNo = 14 then "Ace"
         elif cardNo = 11 then "Jack"
         elif cardNo = 12 then "Queen"
         elif cardNo = 13 then "King"
         else string cardNo
    
    [<EntryPoint>]
    let main argv =
        // implement program
        0 // return an integer exit code
    ```

Congratulations, you've finished that part of the card game.

## Print the deck

Again, your colleagues have helped you create a card deck so all you have to do is to print it. Here's the code for the card deck:

```fsharp
let cards = [ 1; 10; 2; 34 ]
```

1. Add the `cards` definition to the `main()` method like so:

   ```fsharp
    [<EntryPoint>]
    let main argv =
        let cards = [ 1; 10; 2; 34 ]
        // implement program
        0 // return an integer exit code
   ```

   The deck contains only four cards. In a more real implementation, it would contain all 52 cards but this list implementation should suffice. Your colleagues have again written some code for you, so you just have to fill in what's missing. Here's a code snippet:

   ```fsharp
   // add for loop
     printfn "%s of %s" (cardDescription(card)) (suit(card))
   ```

   The code above consist of a commented out line, you are supposed to add code, to implement a `for...in` loop.

1. Add the following code, to the `main()` method to implement the `for...in` loop:

    ```fsharp
    for card in cards do
      printfn "%s of %s" (cardDescription(card)) (suit(card))
    ```

    The `main()` method should now look like so:

    ```fsharp
    [<EntryPoint>]
    let main argv =
        let cards = [ 1; 10; 2; 34 ]
        for card in cards do
          printfn "%s of %s" (cardDescription(card)) (suit(card))
        0 // return an integer exit code
   ```

1. Run the project by calling `dotnet run`

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

Congratulations, you've managed to take the part you and your colleagues implemented and make that into more of a real looking program.

The full code for _Program.fs_ looks like so:

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
     if cardNo = 1 || cardNo = 14 then "Ace"
     elif cardNo = 11 then "Jack"
     elif cardNo = 12 then "Queen"
     elif cardNo = 13 then "King"
     else string cardNo

[<EntryPoint>]
let main argv =

    let cards = [ 1; 10; 2; 34 ]

    for card in cards do
      printfn "%s of %s" (cardDescription(card)) (suit(card))
    0 // return an integer exit code
```

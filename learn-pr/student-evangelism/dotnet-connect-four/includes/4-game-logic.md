In this unit, we cover concepts like how the "Connect Four" game works and what constructs of Blazor you need to know about to produce a game.

## Connect Four

The idea with the game "Connect Four" is for you to lay out four game pieces in a row horizontally, vertically or diagonally before your opponent does. Things you need to consider when implementing this game is to keep track of your current state of game pieces, your opponents and to check for a winner. It's useful when programming to think of a game loop, a set of actions you need to repeat until you can declare a winner. Something like this:

1. Start with a "reset" state, i.e a clean board with no game pieces.
1. User places a game piece.
1. Opponent places a game piece.
1. Check for winner:
    1. If there's a winner, declare winner and end game, or restart game.
    1. If no winner, repeat step 2.

## Representing state in code

First off, what is state? State in games is what's taken place in the game, how many points you have, where your game places are placed, and so on.

An important guidance when it comes to state in game development is to keep state separate from UI as it makes modifications easier and your code easier to read among other benefits.

In the context of Blazor, that means state and logic around state should be in its own C# class, like so:

```csharp
class State
{
    Player [] players;
    int gameRoundsPlayed;
    bool gameOver;

    State()
    {
        players = new Players[]
        {
            new Player() { Name= "Player", Points = 0 },
            new Player() { Name= "Opponent", Points = 0 }
        };
        gameRoundsPlayed = 0;
        gameOver = false;
    }

    void ResetGame() 
    {
        gameOver = false;
        players[0].Points = 0;
        players[1].Points = 0;
    }

    void EndGame()
    {
        gameOver = true;
        gameRoundsPlayed++;
        // award winner..
    } 
}
```

The `State` class contains information on who is playing the game, how many game rounds have been played, if the game is still active, and so on.

You can use an instance of this `State` class in your Blazor components to draw a board and carry out other actions as the game progresses.

### Reset the game state in `OnInitialized`

In Blazor, there's a method that gets called when the component is being initialized, before anything else happens. This method is a good place to place code that helps put your game in a "reset" state, like creating the board, the players, and resetting any scores if needed from previous game sessions.

The method that handles this initialization of the component is called `OnInitialized`.

An `OnInitialized` method that handles resetting the game state might look something like this:

```csharp
void OnInitialized() 
{
    state.ResetGame();
}
```

Exactly what goes in here's up to you, but this code should give you an idea.

## Handling player interactions using events

When you or your opponents make a move, you need to capture this interaction. You encode user interactions as events that your game/app should respond to.

For example, you might select a button or perform a drag n drop movement to move a game piece.

Here's what that can look like in code:

```csharp
<span title="Click to play a piece" @onclick="() => PlayPiece(0)">🔽</span>
```

In the above code, the `@onclick` directive attribute specifies a handler for the `click` event, i.e a user selected this element. The event is handled by the code `() => PlayPiece(0)` which invokes the function `PlayPiece(0)`.

### Changing the state

An action that happens in the game should affect your game state. In the preceding example where we invoke `PlayPiece()`, we should change the state to say that this piece of the board is now occupied by a piece. That means given our example `State` class, we need a way to represent game pieces, something like so:

```csharp
class State 
{
    // other code omitted
    Piece [] pieces;

    State()
    {
        pieces = new Piece[25]; // 5x5 board
    }

    void PlayPiece(int position)
    {
        pieces[position] = true; // true = occupied
    }
}
```

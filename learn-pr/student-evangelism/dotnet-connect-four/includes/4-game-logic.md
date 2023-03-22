To make learning Blazor a fun activity, we teach you to build a game of "Connect Four". In this unit, we cover concepts like how this game works and what constructs of Blazor you need to know about to produce a game.

## Connect Four

The idea with the game "Connect Four" is for you to lay out four game pieces in a row horizontally, vertically or diagonally before your opponent does. Things you need to consider when implementing this game is to keep track of your current state of game pieces, your opponents and to check for a winner. It's useful when programming to think of game loop, a set of actions you need to repeat until you can declare a winner. Something like so:

1. Start with a "reset" state, i.e a clean board with no game pieces.
1. User place game piece.
1. Opponent place game piece.
1. Check for winner: 
    1. if there's a winner, declare winner and end game, or restart game.
    1. if no winner, repeat step 2. 

## Representing "state" in code

First off, what is state? State when talking about games is what's taken place in the game, how many points you have, where your game places are placed and so on.

An important guidance when it comes to state in game development is to keep state separate from UI as it makes modifications easier and your code easier to read among some benefits.

In the context of Blazor that means state and logic around state should be in its own C# class like so:

```csharp
class State {
  State() {
    this.players = new Players[]
    {
      new Player() { Name= "Player", Points = 0 },
      new Player() { Name= "Opponent", Points = 0 }
    };
    GameRoundsPlayed = 0;
    GameOver = false; 
  }

  void ResetGame() 
  {
    this.GameOver = false;
    this.players[0].Points = 0;
    this.players[1].Points = 0;
  }

  void EndGame() 
  {
    this.GameOver = true;
    this.GameRoundsPlayed++;  
    // award winner.. 
  }
 
  Player [] players; 

  int GameRoundsPlayed;
  bool GameOver; 
}
```

In this case, there's a `State` class containing information on who plays the game and how many game rounds have been played, if the game is still active and so on.

Then when you create your Blazor components, you can use an instance of this `State` class and use it to draw a board and carry out other actions as the game progresses.

### Dealing with "reset" state -  `OnInitialized()`

In Blazor, there's a method that gets called when the component is being initialized, before anything else happens. This method is a good place to place code in that helps put your game in a "reset" state, so creating the board, the players, resetting any scores if needed (from previous game sessions).

The event that handles this initialization of the component is called `OnInitialized()`.  

Just to give you an idea, here's some pseudo code:

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

In the above code, the `@onclick` is the `click` event, i.e a user selected this element. The event is handled by this code "() => PlayPiece(0)" which invokes the function `PlayPiece()`. 

### Changing the state

An action that happens in the game should affect your game state. In the preceding example where we invoke `PlayPiece()` we should change the state to say that this piece of the board is now occupied by a piece. That means given our example `State` class, we need a way to represent game pieces, something like so:

```csharp
class State 
{
  // other code omitted
  Piece [] pieces;
  State() {
    this.pieces = new Piece[25]; // 5x5 board
  }
  
  void PlayPiece(int position) 
  {
    this.pieces[position] = true; // true = occupied
  }
}
```
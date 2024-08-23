In this exercise, we add game logic to our app to ensure we end up with a fully functioning game.

To help keep this tutorial on-topic with teaching about Blazor, we're providing a class called `GameState` that contains the logic for managing the game.

## Adding Game state

Let's add the `GameState` class to your project and then make it available to components as a singleton service through dependency injection.

1. Copy the [GameState.cs](https://raw.githubusercontent.com/dotnet/intro-to-dotnet-web-dev/main/5-blazor/1-complete/ConnectFour/GameState.cs) file into the root of your project.

1. Open the *Program.cs* file at the root of the project and add this statement that configures `GameState` as a singleton service in your app:

    ```csharp
    builder.Services.AddSingleton<GameState>();
    ```

    We can now inject an instance of the `GameState` class into our `Board` component.

1. Add the following `@inject` directive at the top of the *Board.razor* file. the directive injects the current state of the game into the component:

    ```razor
    @inject GameState State
    ```

    We can now start connecting our `Board` component to the state of the game.

## Reset state

Let's begin by resetting the state of the game when the `Board` component is first painted on screen. Add some code to reset the state of the game when the component is initialized.

1. Add an `OnInitialized` method with a call to `ResetBoard`, inside the `@code` block at the bottom of the *Board.razor* file, like so:

    ```razor
    @code {
        protected override void OnInitialized()
        {
            State.ResetBoard();
        }
    }
    ```

    When the board is first shown to a user, the state is reset to the beginning of a game.

## Create game pieces

Next, let's allocate the possible 42 game pieces that could be played. We can represent the game pieces as an array referenced by 42 HTML elements on the board. We can move and place those pieces by assigning a set of CSS classes with column and row positions.

1. To hold our game pieces, we define a string array field in the code block:

    ```razor
    private string[] pieces = new string[42];
    ```

1. Add code to the HTML section that creates 42 `span` tags, one for each game piece, in the same component:

    ```razor
    @for (var i = 0; i < 42; i++)
    {
       <span class="@pieces[i]"></span>
    }
    ```

    Your full code should look like so:

    ```razor
    <div>
        <div class="board">
        @for (var i = 0; i < 42; i++)
        {
            <span class="container">
                <span></span>
            </span>
        }
        </div>
        @for (var i = 0; i < 42; i++)
        {
           <span class="@pieces[i]"></span>
        }
    </div>
    @code {
        private string[] pieces = new string[42];
    
        protected override void OnInitialized()
        {
            State.ResetBoard();
        }
    }
    ```

    This assigns an empty string to the CSS class of each game piece span. An empty string for a CSS class prevents the game pieces from appearing on screen as no style is applied to them.

## Handle game piece placement

Let's add a method to handle when a player places a piece in a column. The `GameState` class knows how to assign the correct row for the game piece, and reports back the row that it lands in. We can use this information to assign CSS classes representing the player's color, the final location of the piece, and a CSS drop animation.

We call this method `PlayPiece`, and it accepts an input parameter that specifies the column the player chooses.

1. Add this code below the `pieces` array we defined in the previous step.

    ```csharp
    private void PlayPiece(byte col)
    {
        var player = State.PlayerTurn;
        var turn = State.CurrentTurn;
        var landingRow = State.PlayPiece(col);
        pieces[turn] = $"player{player} col{col} drop{landingRow}";
    }
    ```

Here's what the `PlayPiece` code does:

1. We tell the game state to play a piece in the submitted column called `col` and capture the row the piece landed in.
1. We can then define the three CSS classes to assign to the game piece to identify which player is currently acting, the column the piece was placed in, and the landing row.
1. The last line of the method assigns these classes to that game piece in the `pieces` array.

If you look in the supplied *Board.razor.css*, you find the CSS classes matching column, row, and player turn.

The resultant effect is that the game piece is placed in the column and animated to drop into the bottom-most row when this method is called.

## Choosing a column

We next need to place some controls that allow players to choose a column and call our new `PlayPiece` method. We use the "🔽" character to indicate that you can drop a piece in this column.

1. Above the starting `<div>` tag, add a row of clickable buttons:

    ```html
    <nav>
        @for (byte i = 0; i < 7; i++)
        {
            var col = i;
            <span title="Click to play a piece" @onclick="() => PlayPiece(col)">🔽</span>
        }
    </nav>
    ```

    The `@onclick` attribute specifies an event handler for the click event. But to handle UI events, a Blazor component needs to be rendered using an *interactive render mode*. By default, Blazor components are rendered statically from the server. We can apply an interactive render mode to a component using the `@rendermode` attribute.

1. Update the `Board` component on the `Home` page so that it uses the `InteractiveServer` render mode.

    ```razor
    <Board @rendermode="InteractiveServer" />
    ```

    The `InteractiveServer` render mode handles UI events for your components from the server over a WebSocket connection with the browser.

1. Run the app with these changes. It should look like this now:

   :::image type="content" source="../media/2-board-step-3.png" alt-text="Screenshot of Connect Four board.":::

   Even better, when we select one of the drop buttons at the top, the following behavior can be observed:

   :::image type="content" source="../media/2-board-drop.gif" alt-text="Screenshot of Connect Four animation.":::

Great progress! We can now add pieces to the board. The `GameState` object is smart enough to pivot back and forth between the two players. Go ahead and select more drop buttons and watch the results.

## Winning and error handling

If you play the game in its current configuration, you find that it raises errors when you try to put too many pieces in the same column and when one player wins the game.

Let's make the current state of our game clear by adding some error handling and indicators to our board. Add a status area above the board and below the drop buttons.

1. Insert the following markup after the `nav` element:

    ```razor  
    <article>
        @winnerMessage  <button style="@ResetStyle" @onclick="ResetGame">Reset the game</button>
        <br />
        <span class="alert-danger">@errorMessage</span>
        <span class="alert-info">@CurrentTurn</span>
    </article>
    ```

    This markup allows us to display indicators for:

    - Announcing a game winner
    - A button that allows us to restart the game
    - Error messages
    - The current player's turn

    Now let's fill in some logic that sets these values.

1. Add the following code after the pieces array:

    ```csharp
    private string[] pieces = new string[42];
    private string winnerMessage = string.Empty;
    private string errorMessage = string.Empty;
    
    private string CurrentTurn => (winnerMessage == string.Empty) ? $"Player {State.PlayerTurn}'s Turn" : "";
    private string ResetStyle => (winnerMessage == string.Empty) ? "display: none;" : "";
    ```

    - The `CurrentTurn` property is automatically calculated based on the state of the `winnerMessage` and the `PlayerTurn` property of the `GameState`.
    - The `ResetStyle` is calculated based on contents of the `WinnerMessage`. If there's a `winnerMessage`, we make the reset button appear on screen.

1. Let's handle the error message when a piece is played. Add a line to clear the error message and then wrap the code in the `PlayPiece` method with a `try...catch` block to set the `errorMessage` if an exception occurred:

    ```csharp
    errorMessage = string.Empty;
    try
    {
        var player = State.PlayerTurn;
        var turn = State.CurrentTurn;
        var landingRow = State.PlayPiece(col);
        pieces[turn] = $"player{player} col{col} drop{landingRow}";
    }
    catch (ArgumentException ex)
    {
        errorMessage = ex.Message;
    }
    ```

    Our error handler indicator is simple and uses the Bootstrap CSS framework to display an error in danger mode.

    :::image type="content" source="../media/3-board-error-handler.png" alt-text="Screenshot of Your game so far, with a board and pieces.":::

1. Next, let's add the `ResetGame` method that our button triggers to restart a game. Currently, the only way to restart a game is to refresh the page. This code allows us to stay on the same page.

    ```csharp
    void ResetGame()
    {
        State.ResetBoard();
        winnerMessage = string.Empty;
        errorMessage = string.Empty;
        pieces = new string[42];
    }
    ```

    Now our `ResetGame` method has the following logic:

    - Reset the state of the board.
    - Hide our indicators.
    - Reset the pieces array to an empty array of 42 strings.

    This update should allow us to play the game again, and now we see an indicator just above the board declaring the player's turn and eventually the completion of the game.

    :::image type="content" source="../media/3-board-step-1.png" alt-text="Screenshot displaying game over.":::

    We still have a situation where we can't select the reset button. Let's add some logic in the `PlayPiece` method that detects the end of the game.

1. Let's detect if there's a winner to the game by adding a switch expression after our `try...catch` block in `PlayPiece`.

    ```csharp
    winnerMessage = State.CheckForWin() switch
    {
        GameState.WinState.Player1_Wins => "Player 1 Wins!",
        GameState.WinState.Player2_Wins => "Player 2 Wins!",
        GameState.WinState.Tie => "It's a tie!",
        _ => ""
    };
    ```

    The `CheckForWin` method returns an enum that reports which player, if any has won the game or if the game is a tie. This switch expression will set the `winnerMessage` field appropriately if a game over state occurs.

    Now when we play and reach a game-ending scenario, these indicators appear:

    :::image type="content" source="../media/3-board-step-2.png" alt-text="Screenshot showing to Reset game.":::

## Summary

We learned a lot about Blazor and built a neat little game. Here are some of the skills we learned:

- Created a component
- Added that component to our home page
- Used dependency injection to manage the state of a game
- Made the game interactive with event handlers to place pieces and reset the game
- Wrote an error handler to report the state of the game
- Added parameters to our component

The project we built, is a simple game, and there's so much more you could do with it. Looking for some challenges to improve it?

### Challenges

Consider the following challenges:

- To make the app smaller, remove the default layout and extra pages.
- Improve the parameters to the `Board` component so that you can pass any valid CSS color value.
- Improve the indicators appearance with some CSS and HTML layout.
- Introduce sound effects.
- Add a visual indicator and prevent a drop button from being used when the column is full.
- Add networking capabilities so that you can play a friend in their browser.
- Insert the game into a .NET MAUI with Blazor application and play it on your phone or tablet.

Happy coding, and have fun!

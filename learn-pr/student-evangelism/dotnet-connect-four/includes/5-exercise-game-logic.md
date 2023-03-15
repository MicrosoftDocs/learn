In this exercise, we will add game logic to our app to ensure we end up with a fully functioning game.

To help keep this tutorial on-topic with teaching about Blazor, we are providing a class called `GameState`.cs that contains the logic for managing the game.

## Adding Game state

The *GameState.cs file* is in this [repository](https://github.com/dotnet/intro-to-dotnet-web-dev/blob/main/5-blazor/1-complete/ConnectFour/Shared/GameState.cs) and you will copy it into your version of the game.

1. Copy the *GameState.cs* file from this repository into your project in the *Shared* folder.

   We need to make an instance of the `GameState` available to any component that requests it, and only 1 instance of `GameState` should be available in our application at a time. We will address this need by registering our GameState as a Singleton in the application.
 
1. Open the *Program.cs* file at the root of the project and let's add this statement after the `builder.AddServices...` statement:

    ```csharp
    builder.Services.AddSingleton<ConnectFour.Shared.GameState>();
    ```

    We can now inject an instance of our `GameState` class into our Board component to work with.

1. Add the following directive at the top of the *Board.razor* file,  to inject the current state of the game into the component:

    ```csharp
    @inject ConnectFour.Shared.GameState State
    ```

    We can now start connecting our Board component to the state of the game.

### Reset state

Let's begin by resetting the state of the game when the Board component is first painted on screen.

Let's add some code to reset the state of the game when the component is initialized.

1. Add the method `OnInitialized()` with a call to `ResetBoard()`, inside the `@code` block at the bottom of the Board.razor file like so:

    ```csharp
    @code {
    	protected override void OnInitialized()
    	{
    		State.ResetBoard();
    	}
    }
    ```

    When the board is first shown to a user, the state will be reset to the beginning of a game.

## Create game pieces

Next, let's allocate the possible 42 game pieces that could be played. This should be an array that is referenced by 42 HTML elements that will be managed as pieces are played on the board. We can move and place those pieces by assigning a set of CSS classes with column and row positions.

1. Define an array to hold our game pieces:

    ```csharp
     @code {
      private string[] Pieces = new string[42];
    }
    ```

1. Add code to the HTML section that creates 42 `span` tags, one for each game piece, in the same component:

    ```html
    @for (var i = 0; i < 42; i++)
    {
       <span class="@Pieces[i]"></span>
    }
    ```
 
    Your full code should look like so:

    ```html
    @for (var i = 0; i < 42; i++)
    {
       <span class="@Pieces[i]"></span>
    }
     
    </div>
    @code {
      private string[] Pieces = new string[42];
      
    }
    ```
   
    By default initialization of a string array, this will assign an empty string to the CSS class of each game piece span. This will prevent the game pieces from appearing on screen as they have no contents and no style applied to them.

## Handle game piece placement

Let's add a method to handle when a player places a Piece in a column. The `GameState` class knows how to assign the correct row for the game piece, and will report back the row that it lands in. We can use this information to assign CSS classes representing the player's color, the final location of the piece, and a CSS drop animation.

We'll call this method `PlayPiece()` and it accepts an input parameter that specifies the column (1 indexed) the player has chosen. 

1. Add this code below the `Pieces` array we defined in the previous step.

    ```csharp
    private void PlayPiece(byte col) 
    {
    	var landingRow = State.PlayPiece(col);
    	var cssClass = $"player{State.PlayerTurn} col{col} drop{landingRow}";
    	Pieces[State.CurrentTurn - 1] = cssClass;
    }
    ```

    Here's what the code does:
    1. We tell the game state to play a piece in the submitted column called `col` and capture the row reported by the game state.
    1. We can then define the 3 CSS classes to assign to the game piece to identify which player is currently acting, the column the piece was placed in, and the landing row.
    1. The last line of the method chooses the next element in the `Pieces` array and assigns these classes to that game piece.

    If you look in the supplied *Board.razor.css* you'll find the CSS classes that match up to those assigned in line 2 of the method.

    The resultant effect is that the game piece is placed in the column and animated to drop into the bottom-most row when this method is called.

### Choosing a column

We next need to place some controls that allow players to choose a column and call our new `PlayPiece()` method.

1. Add a row of HTML elements above the board that will call this method when they are clicked.

    > [!TIP]
    > We could use characters to indicate "Play Here"... or we could be a little fancy and use an emote, as .NET, C#, and Blazor support using emote characters in our code. 

    Let's use this character "🔽" to indicate that you can drop a piece in this column.

    Above the starting `<div>` tag, let's add a row of buttons:

    ```html
    <nav>
    	<span title="Click to play a piece" @onclick="() => PlayPiece(0)">🔽</span>
    	<span title="Click to play a piece" @onclick="() => PlayPiece(1)">🔽</span>
    	<span title="Click to play a piece" @onclick="() => PlayPiece(2)">🔽</span>
    	<span title="Click to play a piece" @onclick="() => PlayPiece(3)">🔽</span>
    	<span title="Click to play a piece" @onclick="() => PlayPiece(4)">🔽</span>
    	<span title="Click to play a piece" @onclick="() => PlayPiece(5)">🔽</span>
    	<span title="Click to play a piece" @onclick="() => PlayPiece(6)">🔽</span>
    </nav>
    ```

    > [!NOTE]
    > We can't use a for loop for this, as we are defining an `onclick` handler for these span elements that has an assigned column number.

1. Let's review in the browser and it should look like this now:

    ![connect four board](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/2-Board-Step3.png)

   Even better... when we click one of the drop buttons at the top, this happens:

   ![connect four animation](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/2-board-drop.gif)

   That's great! We can now add pieces to the board. The GameState object is smart enough to pivot back and forth between the two players. Go ahead and click more drop buttons and watch the results.

## Winning and error handling

If you play with the game that you have configured at this point, you'll find that it will raise errors when you try to put too many pieces in the same column and it will stop when one player has won the game.

Let's add some error handling and indicators to our board to make the current state clear.

Let's add a simple status area above the board, and below the drop buttons. 

1. Insert the following markup after the closing `</nav>` element:

    ```csharp
    </nav>
    
    <article>
    	@WinnerMessage  <button style="@ResetStyle" @onclick="ResetGame">Reset the game</button>
    	<br />
    	<span class="alert-danger">@ErrorMessage</span>
    	<span class="alert-info">@CurrentTurn</span>
    </article>
    ```

    This will allow us to place indicators for:

    - Announcing a game winner
    - A button that will allow us to restart the game
    - Error messages
    - The current player's turn

    Let's fill in some logic to set these values.

1. Add the following fields after the Pieces statement in code as we need to add fields in our code for these indicators:

    ```csharp
    private string[] Pieces = new string[42];
    
    private string WinnerMessage = string.Empty;
    
    private string ErrorMessage = string.Empty;
    
    private string CurrentTurn => (WinnerMessage == string.Empty) ? $"Player {State.PlayerTurn}'s Turn" : "";
    
    private string ResetStyle => (WinnerMessage == string.Empty) ? "display: none;" : "";
    ```

    The `CurrentTurn` field will be automatically calculated based on the state of the `WinnerMessage` and the `PlayerTurn` property of the `GameState`.

    The `ResetStyle` will also be automatically calculated based on contents of the `WinnerMessage`. If there is a `WinnerMessage` we will make the reset button appear on screen.

1. Let's handle the error message when a piece is played. Add a line to clear the error message and then wrap the three lines of the `PlayPiece` method with a `try...catch` block to set the `ErrorMessage` if an exception occurred:

    ```csharp
	ErrorMessage = string.Empty;

	try
	{
		var landingRow = State.PlayPiece(col);
		var cssClass = $"player{State.PlayerTurn} col{col} drop{landingRow}";
		Pieces[State.CurrentTurn - 1] = cssClass;
	}
	catch (ArgumentException ex)
	{
		ErrorMessage = ex.Message;
	}
    ```

    Our error handler indicator is simple, and uses the Bootstrap CSS framework to display an error in danger mode.

    ![](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/3-Board-ErrorHandler.png)

1. Next, let's add the `ResetGame()` method that our button will trigger to restart a game. Currently, the only way to restart a game is to refresh the page... this will allow us to stay on the same page.

    ```csharp
    void ResetGame()
    {
    	State.ResetBoard();
    	WinnerMessage = string.Empty;
    	ErrorMessage = string.Empty;
    	Pieces = new string[42];
    }
    ```

    Now our `ResetGame()` method does the following:

    - reset the state of the board.
    - hide our indicators.
    - reset the Pieces array to an empty array of 42 strings.

    This update should allow us to play the game again, and now we will see an indicator just above the board declaring the player's turn and eventually the completion of the game.

    ![](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/3-Board-Step1.png)

    We're still left in a situation where we can't click the reset button. Let's add some logic in the `PlayPiece()` method to detect the end of the game.

1. Let's detect if there is a winner to the game by adding a switch expression after our `try...catch` block in `PlayPiece()`.

    ```csharp
    WinnerMessage = State.CheckForWin() switch
    {
    	GameState.WinState.Player1_Wins => "Player 1 Wins!",
    	GameState.WinState.Player2_Wins => "Player 2 Wins!",
    	GameState.WinState.Tie => "It's a tie!",
    	_ => ""
    };
    ```

    The `CheckForWin()` method will return an enum that reports which player, if any has won the game or if the game is a tie. This switch expression will set the WinnerMessage field appropriately if a game over state has occurred.

    Now when we play and reach a game-ending scenario, these indicators appear:

    ![](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/3-Board-Step2.png)

## Customizing the board with Parameters

The game works... but maybe you don't like our default colors. In Blazor, we can define parameters on our components that will allow us to pass in values that look like attributes on an HTML tag.

Let's add some parameters for the colors on the board, and pass in some groovy colors from the Pages/Index.razor page.

Parameters in Blazor are properties in our component that have been decorated with the Parameter attribute.

1. In Board.razor, let's define 3 properties for the board color, and each player's color. Before the OnInitialized method, let's add these lines of code:

    ```csharp
    [Parameter()]
    public Color BoardColor { get; set; } 
    	= ColorTranslator.FromHtml("yellow");
    
    [Parameter()]
    public Color Player1Color { get; set; } 
    	= ColorTranslator.FromHtml("red");
    
    [Parameter()]
    public Color Player2Color { get; set; }
    	= ColorTranslator.FromHtml("blue");
    ```

    We'll use the Color type to ensure that the values passed to our Board component are in-fact colors. Let's also add a using statement to the top of the Board.razor file to indicate we are using content from the System.Drawing namespace.

1. @using System.Drawing
Let's now interpret the parameters and place their values in the CSS block at the top of Board.razor

    ```csharp
    <HeadContent>
    	<style>
    		:root {
    			--board-bg: @ColorTranslator.ToHtml(BoardColor);
    			--player1: @ColorTranslator.ToHtml(Player1Color);
    			--player2: @ColorTranslator.ToHtml(Player2Color);
    		}
    	</style>
    </HeadContent>
    ```

    That shouldn't have changed anything in the appearance of our game board.

    Let's head back to Pages/Index.razor and add some parameters to our <Board> tag and see how they change the game

    ```csharp
    <Board 
    	BoardColor="@System.Drawing.Color.Black"
    	Player1Color="@System.Drawing.Color.Green"
    	Player2Color="@System.Drawing.Color.Purple"
    ></Board>
    ```

    That's a cool looking board now:

     ![](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/4-Board.png)

## Summary

We've learned a lot about Blazor and built a neat little game. Here are just some of the skills we learned:

- Created a component
- Added that component to our home page
- Used dependency injection to manage the state of a game
- Made the game interactive with event handlers to place pieces and reset the game
- Wrote an error handler to report the state of the game
- Added parameters to our component

This is just a simple game, and there's so much more you could do with it. Looking for some challenges to improve it? Consider the following challenges:

Remove the default layout and extra pages in the application to make it smaller
Improve the parameters to the Board component so that you can pass any valid CSS color value.
Improve the indicators appearance with some CSS and HTML layout
Introduce sound effects
Add a visual indicator and prevent a drop button from being used when the column is full
Add networking capabilities so that you can play a friend in their browser
Insert the game into a .NET MAUI with Blazor application and play it on your phone or tablet.
Happy coding and have fun!
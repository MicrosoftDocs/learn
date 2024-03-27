In this exercise, you'll write code that enables an ant to move to the next generation. You use a pre-created `GameBuffer` class and implement it by creating two Clone methods. One method will buffer an ant `IAnt`, and the other will buffer the game, `IGame`. Lastly, you make the `IAnt` clone method virtual so that you can override it in `GeneralizedAnt` and use it.

## Copy GameBuffer.cs to the project

To get started, copy `GameBuffer.cs` to your project. 

1. Copy resources\GameBuffer.cs to WPF\Game folder.
    1. Open [Starter Files](https://github.com/MicrosoftLearning/Challenge-Project-design-object-oriented-structures/tree/main/Starter).
    1. Open the `resources` folder.
    1. Select the `GameBuffer.cs` file.
    1. Press Ctrl-A while in the `GameBuffer` class to select its contents.
    1. Enter Ctrl-C to copy the contents to the clipboard.
    1. In VS Code, select the `Game` folder and select the New File icon.
    1. Enter `GameBuffer.cs` for the name of the file and press Enter.
    1. Press Ctrl-V to paste the contents of the previous `GameBuffer.cs` to this new one.
    1. Enter Ctrl-S to save your changes.  

1. Add a Clone method to the `IGame` and `IAnt` interfaces.  
    Start by adding a `Clone` method to the `IGame` and `IAnt` interfaces. You then implement the `IAnt` interface in the `Game` class and make it call the `Clone` method from `IAnt` to copy `Ant` instances.  

    1. Add the `Clone` method to the `IGame` interface, as shown here.

        ```csharp
        using System.Collections.Generic;
        namespace LangtonsAnt
        {
            public interface IGame
            {
                public int Size { get; }
                public IList<IAnt> Ants { get; set; }
                public int GenerationN { get; }
                public byte[,] Field { get; }
                public void NextGeneration();
                public IGame Clone();
            }
        
        }
        ```

    2. Open `Game.cs` and implement the `Clone` method declared in the `IGame` interface.

        ```csharp
        public IGame Clone()
        {
            var game = new Game(this.Size, this.Ants.Select(a => (IAnt)a.Clone()).ToArray())
            {
                Field = (byte[,])Field.Clone(),
                    GenerationN = this.GenerationN
                };
                return game;
        }
        ```

    3. Add `using System.Linq;` to your list of using statements at the top of the `Game.cs` file. Your file should have these using statements.

        ```csharp
        using System.Collections;
        using System.Collections.Generic;
        using System.Linq;
    
        ...
        ```

    4. Add the `Clone` method to the `IAnt` interface, as shown.

        ```csharp
        namespace LangtonsAnt
        {
            public interface IAnt
            {
                public int I { get; set; }
                public int J { get; set; }
                public AntDirection Direction { get; set; }
                public byte Act(byte oldValue);
    
                public void RotateCW();
                public void RotateCCW();
                public IAnt Clone();
            }
        }
        ```

    5. Open `Ant.cs` and implement the `Clone` method declared in `IAnt` just beneath the `Act` method.

        ```csharp
        public virtual IAnt Clone()
        {
            return new Ant(i: this.I, j: this.J, direction: this.Direction);
        }
        ```

    6. Implement the `IAnt Clone()` method in the `GeneralizedAnt.cs` file as an overridable method. Copy this method to the `GeneralizedAnt` class.

        ```csharp
        public override IAnt Clone()
        {
            return new GeneralizedAnt(i: this.I, j: this.J, direction: this.Direction)
            {
                    Rule = this.Rule
            };
        }
        ```

## Replace IGame variable declaration with GameBuffer

1. Open the `MainWindow.xaml.cs` file in the WPF folder.

1. Delete `IGame game;` statement declared near the top of your file.

1. Add a variable of type `GameBuffer` with the name `buffer`.

    ```csharp
    public partial class MainWindow : Window
    {
        GameBuffer buffer;
        DispatcherTimer gameTimer;
        PlayUIMode playUiState;
        string rule = "LR";
        const int imagesPerSecond = 25;
    
        ...
    }
    ```

## Define a utility function to create GameBuffer in a consistent way

You create a `GameBuffer` utility method so that you can easily create game buffers. It takes the initial state (as an optional field), the number of ants it holds, and the initial rule as parameters.

1. Open the `MainWindow.xaml.cs` file in the WPF folder.

1. Add the following utility method beneath the `CreateGame` method.

    ```csharp
    ...

    private GameBuffer CreateGameBuffer(IGame? initialState = null, int nGenerations = 100, string initialRule = "LR")
    {
        if (initialState == null)
        {
            initialState = CreateGame(initialRule);
        }
        return new GameBuffer(initialState, nGenerations);
    }
        
    ...
    ```

1. Create the buffer as shown, `buffer = CreateGameBuffer(null, nGenerations, rule);` in the `MainWindow` constructor.

    ```csharp
    ...
    
    public MainWindow()
    {
        InitializeComponent();
        buffer = CreateGameBuffer(null, nGenerations, rule);
        gameTimer = new DispatcherTimer();

        ...
    }
    
    ...
    ```

1. Add the constant `nGenerations` for the maximum number of ants permitted to `MainWindow.xaml.cs`.

    ```csharp
    ...
    
    public partial class MainWindow : Window
    {
        GameBuffer buffer;
        DispatcherTimer gameTimer;
        PlayUIMode playUiState;
        string rule = "LR";
        const int imagesPerSecond = 25;
        const int nGenerations = 1000;
    
        ...
    }

    ...
    ```

## Replace IGame with GameBuffer inside MainWindow constructor and other updates

You need to have your code start using your game buffer and the utility method you created for loading games. You also want to show a "Game Over" message when `MoveNext` returns false. Use `buffer.Current` instead of the `game`  instance variable in `UpdateGameView` calls.

1. Locate the `btnLoad_Click` method in `MainWindow.xaml.cs`.

1. Delete the following lines of code from the Try block of the Try...Catch blocks:

    ```csharp
        game = GameJSONSerializer.FromJson(json);
        UpdateGameView(game);
    ```

1. Replace them with your game buffer code, as shown.

    ```csharp
    try
    {
        string json = File.ReadAllText(fileName);
        IGame loadedGame = GameJSONSerializer.FromJson(json);
        buffer = CreateGameBuffer(loadedGame, nGenerations, rule);
    
        UpdateGameView(buffer.Current);
    }
    ```

1. Locate the `btnSave_Click` method.

1. Modify the input to the `GameJSONSerializer.ToJson` method so that it now takes the buffer.

    ```csharp
    try
    {
        string jsonString = GameJSONSerializer.ToJson(buffer.Current);
        File.WriteAllText(saveFileDialog.FileName, jsonString);
    }
    ```

1. Modify the old code that checks to see if there's a game. It should now check the buffer, before throwing an exception if there's no current game, as shown here.

    ```csharp
    private void btnSave_Click(object sender, RoutedEventArgs e)
    {

        if (buffer.Current == null)
            throw new InvalidOperationException("Cannot save the game when current game state is null");

        ...
    }
    ```

1. Update the `gameTimer.Tick` so that `UpdateGameView` now takes `buffer.Current!`.

    ```csharp
    ...
    
    gameTimer.Tick += (sender, args) =>
    {
        if (buffer.MoveNext(generationsPerStep))
            UpdateGameView(buffer.Current!);
        else
        { 
            MessageBox.Show("Game Over. We no longer have any ants.");
            PlayUIState = PlayUIMode.Stopped;
        }
    };
    
    ...
    ```

## Update PlayUIState property setter

You need to call `GameBuffer.Reset` instead of re-creating the Game in `PlayUIMode.Stopped` case. Again, you use `GameBuffer.Current` in the `UpdateGameView` call.

1. Find the `PlayUIState` property in `MainWindow.xaml.cs`.

1. Replace the old game code to use the buffer.

    ```csharp
    ...
    
    PlayUIMode PlayUIState
    {
        get { return playUiState; }
        set
        {
            switch (value)
            {
                ...
    
                case PlayUIMode.Stopped:
                    gameTimer.Stop();
                    buffer.Reset();
                    UpdateGameView(buffer.Current!);
                    btnPlay.Visibility = Visibility.Visible;
                    btnPause.Visibility = Visibility.Collapsed;
                    break;
    
                    ...
            }
        }
    }
    ```

## Update "Prev." and "Next" UI buttons handlers

Now that you have a buffer that contains game states from previous generations, you can implement the logic for an ant to move backward or forward. If an ant can't move forward, display an informational message to the user that briefly explains the situation. Similarly, if an ant can't move backward, display an informational message to the user.

In both the `btnStepForward_Click` and `btnStepBackward_Click` UI methods, first pause the game. After pausing, call either the `MoveNext` or `MovePrevious` method in an `if` statement. If the movement fails, display a message to the user explaining why. If the movement is successful, call the `UpdateGameView(buffer.Current!)` method to update the screen with the movement. Change each UI button method for moving forward and backward as shown.

1. Replace the "not implemented" MessageBox message with game logic and a new message in the `btnStepForward_Click` method.

    ```csharp
    private void btnStepForward_Click(object sender, RoutedEventArgs e)
    {
        PlayUIState = PlayUIMode.Paused;
    
        if (!buffer.MoveNext())
            MessageBox.Show("Game Over. We no longer have any ants.");
                
        UpdateGameView(buffer.Current!);
    }
    ```

1. Replace the "not implemented" MessageBox message with game logic and a new message in the `btnStepBackward_Click` method.

    ```csharp
    private void btnStepBackward_Click(object sender, RoutedEventArgs e)
    {
        PlayUIState = PlayUIMode.Paused;
    
        if (!buffer.MovePrevious())
            MessageBox.Show($"Cannot move back. We only store a limited number of previous generations of the game.");
    
        UpdateGameView(buffer.Current!);
    }
    ```

## Update "Load" and "Save" buttons

The last step in this exercise is to update the `btnSave_Click` and `btnLoad_Click` UI methods to use the buffer you created.

Starting with `btnSave_Click` you check to see if a game is `null` by replacing `if (game == null)` with `if (buffer.Current == null)`, then throwing an `InvalidOperationException` exception if the game is null.

1. Locate the `btnSave_Click` method.

1. Replace `if (game == null)` with `if (buffer.Current == null)`.

    ```csharp
    ...
    
    private void btnSave_Click(object sender, RoutedEventArgs e)
    {
        if (buffer.Current == null)
            throw new InvalidOperationException("Cannot save the game when current game state is null");
    
        PlayUIState = PlayUIMode.Paused;
    
        ...
    }

    ...
    ```

1. Replace statement serializing a game to serialize the game buffer instead. In the `Try` block, save JSON as the serialized string `jsonString` from `buffer.Current`, replacing `game`.

    ```csharp
    private void btnSave_Click(object sender, RoutedEventArgs e)
    {
        ...
    
        if (saveFileDialog.ShowDialog() == true)
        {
            try
            {
                string jsonString = GameJSONSerializer.ToJson(buffer.Current);
                File.WriteAllText(saveFileDialog.FileName, jsonString);
    
                ...
            }
    
            ...
        }
    
        ...
    }
    ```

1. Update the `btnLoad_Click` Try block so that it loads a game from JSON and creates a game buffer.

    Finally, load the game by passing `buffer.Current` into `UpdateViewer` as shown here: `UpdateGameView(buffer.Current)`.

    ```csharp
    ...
    
    try
    {
        string json = File.ReadAllText(fileName);
        IGame loadedGame = GameJSONSerializer.FromJson(json);
        buffer = CreateGameBuffer(loadedGame, nGenerations, rule);
    
        UpdateGameView(buffer.Current);
    }
    catch (JSONSerializationException ex)
    {
        MessageBox.Show(ex.Message);
    }
    catch (IOException ex)
    {
        MessageBox.Show($"Could not load JSON file from disk. {ex}");
    }
    
    ...
    ```

1. Save your work Ctrl-S.

## Check your work

Build and run the project. Make sure that "Play", "Stop", "Prev.", "Next", "Save" and "Load" buttons function as intended.

1. Select View --> Terminal from the menu.

1. Enter `dotnet build` and press Enter.

1. Enter `dotnet run` to run your code.

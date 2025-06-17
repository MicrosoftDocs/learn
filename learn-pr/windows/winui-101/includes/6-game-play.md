With the foundation of the app built, this section will be on building out most of the game play to allow the next section to be focused on other key Window development areas.

## Model

You'll copy/paste most the game logic. You can either copy/paste the whole Game class with the code below or you can copy/paste the new pieces:

1. In the Solution Explorer, open the `Game.cs` file
2. Update the Game class:

<details>
  <summary>Replace the whole Game class</summary>

```csharp
class Game
{
    // List of words for the game
    private readonly List<string> _wordList = new List<string> { "WINDOWS", "VIEW", "MODEL", "TASKBAR", "XAML", "CSHARP", "DEBUGGER", "GRID", "STACKPANEL", "RANDOM" };

    // Messages for winning and losing the game
    private readonly string[] _winningMessages = {
            "Incredible! You guessed the word without a single mistake! You're a true word master!",
            "Phew! That was close! You guessed the word just in time! Well done!",
            "Great job! You guessed the word!"
        };
    private readonly string[] _losingMessages = {
            "Better luck next time! The word was {0}. Keep trying, you'll get it!",
            "Don't give up! The word was {0}.",
            "Oh no! The word was {0}.",
            "Sorry, you didn't guess it. The word was {0}.",
            "You ran out of guesses. The word was {0}."
        };

    // Properties for the current game state
    private const int MaxIncorrectGuesses = 6;
    public string CurrentWord { get; private set; }
    public char[] GuessedWord { get; private set; }
    public int IncorrectGuesses { get; private set; }
    public int GuessesLeft => MaxIncorrectGuesses - IncorrectGuesses;
    public bool GameEnd { get; private set; }
    public bool GameWon { get; private set; }
    public string MessageTitle { get; private set; }
    public string MessageContent { get; private set; }

    public Game()
    {

    }

    // Starts a new game by selecting a random word and resetting the game state
    public void StartNewGame()
    {
        var random = new Random();
        CurrentWord = _wordList[random.Next(_wordList.Count)];
        GuessedWord = new string('_', CurrentWord.Length).ToCharArray();
        IncorrectGuesses = 0;
        GameEnd = false;
        GameWon = false;
    }

    // Plays the game by guessing a letter and checking the game status
    public void PlayGame(char letter)
    {
        GuessLetter(letter);
        CheckGameStatus();
    }


    // Guesses a letter and updates the guessed word and incorrect guesses count
    public void GuessLetter(char letter)
    {
        bool isCorrect = false;
        Debug.WriteLine("Incorrect Guesses: " + IncorrectGuesses);
        for (int i = 0; i < CurrentWord.Length; i++)
        {
            if (CurrentWord[i] == letter)
            {
                GuessedWord[i] = letter;
                isCorrect = true;
            }
        }
        if (!isCorrect)
        {
            IncorrectGuesses++;
        }
    }

    // Checks the game status to determine if the game is won or lost
    private void CheckGameStatus()
    {
        // User has guessed all the letters
        if (GuessedWord.All(c => c != '_'))
        {
            GameEnd = true;
            GameWon = true;
            MessageTitle = "Congratulations!";
            MessageContent = GetWinningMessage();
        }
        // User has run out of guesses
        else if (IncorrectGuesses >= MaxIncorrectGuesses)
        {
            GameEnd = true;
            MessageTitle = "Game Over!";
            MessageContent = GetLosingMessage();
        }
    }

    // Returns a winning message based on the number of guesses left
    private string GetWinningMessage()
    {
        return GuessesLeft switch
        {
            MaxIncorrectGuesses => _winningMessages[0],
            1 => _winningMessages[1],
            _ => _winningMessages[2]
        };
    }

    // Returns a random losing message
    private string GetLosingMessage()
    {
        var random = new Random();
        return string.Format(_losingMessages[random.Next(_losingMessages.Length)], CurrentWord);
    }

}
```
</details>

or

<details>
  <summary> Add each section:</summary>

3. Under  `// Messages for winning and losing the game` add:

```csharp
private readonly string[] _winningMessages = {
        "Incredible! You guessed the word without a single mistake! You're a true word master!",
        "Phew! That was close! You guessed the word just in time! Well done!",
        "Great job! You guessed the word!"
    };
private readonly string[] _losingMessages = {
        "Better luck next time! The word was {0}. Keep trying, you'll get it!",
        "Don't give up! The word was {0}.",
        "Oh no! The word was {0}.",
        "Sorry, you didn't guess it. The word was {0}.",
        "You ran out of guesses. The word was {0}."
    };

```

4. Under `// Properties for the current game state` add:
```csharp
private const int MaxIncorrectGuesses = 6;
public int IncorrectGuesses { get; private set; }
public int GuessesLeft => MaxIncorrectGuesses - IncorrectGuesses;
public bool GameEnd { get; private set; }
public bool GameWon { get; private set; }
public string MessageTitle { get; private set; }
public string MessageContent { get; private set; }

```

5. At the end of` StartNewGame()` add:

```csharp
IncorrectGuesses = 0;
GameEnd = false;
GameWon = false;
```

6. Under `// Plays the game by guessing a letter and checking` add:
```csharp
public void PlayGame(char letter)
{
    GuessLetter(letter);
    CheckGameStatus();
}


// Guesses a letter and updates the guessed word and incorrect guesses count
public void GuessLetter(char letter)
{
    bool isCorrect = false;

    for (int i = 0; i < CurrentWord.Length; i++)
    {
        if (CurrentWord[i] == letter)
        {
            GuessedWord[i] = letter;
            isCorrect = true;
        }
    }
    if (!isCorrect)
    {
        IncorrectGuesses++;
    }
}

// Checks the game status to determine if the game is won or lost
private void CheckGameStatus()
{
    // User has guessed all the letters
    if (GuessedWord.All(c => c != '_'))
    {
        GameEnd = true;
        GameWon = true;
        MessageTitle = "Congratulations!";
        MessageContent = GetWinningMessage();
    }
    // User has run out of guesses
    else if (IncorrectGuesses >= MaxIncorrectGuesses)
    {
        GameEnd = true;
        MessageTitle = "Game Over!";
        MessageContent = GetLosingMessage();
    }
}

// Returns a winning message based on the number of guesses left
private string GetWinningMessage()
{
    return GuessesLeft switch
    {
        MaxIncorrectGuesses => _winningMessages[0],
        1 => _winningMessages[1],
        _ => _winningMessages[2]
    };
}

// Returns a random losing message
private string GetLosingMessage()
{
    var random = new Random();
    return string.Format(_losingMessages[random.Next(_losingMessages.Length)], CurrentWord);
}
```
</details>

The `Game` class encapsulates the core logic for the word-guessing game. It starts with a predefined list of words and sets of messages for winning and losing scenarios. The class tracks the game's state through properties like the current word, the player's progress, incorrect guesses, and whether the game has ended or been won. Key methods include `StartNewGame`, which initializes a new game by selecting a random word and resetting the state, and `PlayGame`, which processes each guessed letter and checks the game status. The game logic is straightforward: guess a letter, update the game state, and determine if the game is won or lost based on the player's progress or the number of incorrect guesses.

## ViewModel

You'll copy/paste most the ViewModel logic. You can either copy/paste the whole `MainViewModel` class with the code below or you can copy/paste the new pieces:

1. In the Solution Explorer, open the MainViewModel.cs file
2. Update the MainViewModel class:

<details>
  <summary>Replace the whole MainViewModel class</summary>

```csharp
public partial class MainViewModel : ObservableObject
{
    private readonly Game _game;


    // Properties bound to the UI
    [ObservableProperty]
    public partial string WordDisplay { get; set; }

    [ObservableProperty]
    public partial List<GameLetter> Letters { get; set; }

    [ObservableProperty]
    public partial int IncorrectGuesses { get; set; }

    [ObservableProperty]
    public partial int GuessesLeft { get; set; }

    [ObservableProperty]
    public partial string MessageTitle { get; set; }

    [ObservableProperty]
    public partial string MessageContent { get; set; }
    [ObservableProperty]
    public partial string PopUpToDisplay { get; set; }

    // Constructor initializes the game and letters
    public MainViewModel()
    {
        PopUpToDisplay = "false";
        Letters = new List<GameLetter>();
        for (char letter = 'A'; letter <= 'Z'; letter++)
        {
            Letters.Add(new GameLetter(letter));
        }
        _game = new Game();
        StartNewGame();
    }

    // Starts a new game and updates the properties
    public void StartNewGame()
    {
        _game.StartNewGame();
        UpdateProperties();
    }

    // Command executed when a letter is guessed
    [RelayCommand]
    public void OnLetterGuessed(char LetterValue)
    {
        _game.PlayGame(LetterValue);
        if (_game.GameEnd)
        {
            EndGame();
        }
        else
        {
            UpdateProperties(LetterValue);
        }
    }

    // Ends the game, disables letters, and shows the end game message
    private void EndGame()
    {
        SetLettersIsEnabled(false);
        UpdateProperties();
        ShowEndGameMessage();

    }

    // Command executed when the popup close button is clicked
    [RelayCommand]
    private void ClosePopupClicked()
    {
        PopUpToDisplay = "false";
        SetLettersIsEnabled(true);
        StartNewGame();
    }

    // Shows the end game message in a popup
    private void ShowEndGameMessage()
    {
        MessageTitle = _game.MessageTitle;
        MessageContent = _game.MessageContent;
        PopUpToDisplay = "true";
    }

    // Updates the properties bound to the UI
    private void UpdateProperties(char LetterValue = '\0')
    {
        if (LetterValue != '\0')
        {
            GameLetter foundLetter = Letters.Find(letter => letter.Character == LetterValue);
            if (foundLetter != null)
            {
                foundLetter.IsAvailable = false;
            }
        }
        WordDisplay = string.Join(" ", _game.GuessedWord);
        IncorrectGuesses = _game.IncorrectGuesses;
        GuessesLeft = _game.GuessesLeft;

    }


    // Enables or disables the letter buttons
    private void SetLettersIsEnabled(bool status)
    {
        foreach (var letter in Letters)
        {
            letter.IsAvailable = status;
        }
    }
}

```
</details>

or

<details>
  <summary> Add each section:</summary>

3. Add properties under ` // Properties bound to the UI`:

```csharp
[ObservableProperty]
public partial int IncorrectGuesses { get; set; }

[ObservableProperty]
public partial int GuessesLeft { get; set; }

[ObservableProperty]
public partial string MessageTitle { get; set; }

[ObservableProperty]
public partial string MessageContent { get; set; }
[ObservableProperty]
public partial string PopUpToDisplay { get; set; }
```

4. add to the top of `MainViewModel()`:
```csharp
PopUpToDisplay = "false";
```

5. Update `OnLetterGuessed` the to be:

```csharp
[RelayCommand]
public void OnLetterGuessed(char LetterValue)
{
    _game.PlayGame(LetterValue);
    if (_game.GameEnd)
    {
        EndGame();
    }
    else
    {
        UpdateProperties(LetterValue);
    }
}

```

6. Under `// Ends the game, disables letters, and shows the end game message` add:

```csharp
private void EndGame()
{
    SetLettersIsEnabled(false);
    UpdateProperties();
    ShowEndGameMessage();

}

// Command executed when the popup close button is clicked
[RelayCommand]
private void ClosePopupClicked()
{
    PopUpToDisplay = "false";
    SetLettersIsEnabled(true);
    StartNewGame();
}

// Shows the end game message in a popup
private void ShowEndGameMessage()
{
    MessageTitle = _game.MessageTitle;
    MessageContent = _game.MessageContent;
    PopUpToDisplay = "true";
}
```

7. To the end of `UpdateProperties()` add:

```csharp
IncorrectGuesses = _game.IncorrectGuesses;
GuessesLeft = _game.GuessesLeft;
```

8. Under  `// Enables or disables the letter buttons` add:

```csharp
private void SetLettersIsEnabled(bool status)
{
    foreach (var letter in Letters)
    {
        letter.IsAvailable = status;
    }
}
```
</details>

The `MainViewModel` class plays a central role in the MVVM architecture of the word-guessing game, acting as the intermediary between the game logic and the user interface. It inherits from `ObservableObject`,  enabling automatic notifications to the UI when properties change. The class contains several observable properties that reflect the game's state, including the word display, available letters, game statistics, and message information. Upon initialization, the ViewModel sets up a list of alphabet letters and starts a new game. Key methods include `StartNewGame`, which resets the game state, and `OnLetterGuessed`, which processes player guesses and determines if the game should continue or end. When the game ends, the `EndGame ` method is called to display a message and disable further guesses. The` ClosePopupClicked` method resets the game for a new round after the end game message is dismissed.

## View

You'll copy/paste two sections of the View XAML. You can either copy/paste the whole Grid with the code below or you can copy/paste the new pieces:

1. In the Solution Explorer, open the GamePage.xaml file
2. Update the GamePage.xaml:


<details>
  <summary>Replace the whole Grid </summary>

```xaml
<Grid Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="50*"/>
            <ColumnDefinition Width="50*"/>
        </Grid.ColumnDefinitions>

        <!-- Title -->
        <TextBlock Text="SnowPal" Grid.ColumnSpan="2" FontSize="40" HorizontalAlignment="Center" VerticalAlignment="Top" />

        <!-- Drawing -->
        <Image x:Name="Image" Grid.Row="1" Grid.Column="0" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="10,10,10,10" Source="/Assets/Wide310x150Logo.png"/>


        <!-- Guesses Left Display -->
        <StackPanel Grid.Row="1" Grid.Column="1" Orientation="Horizontal" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="10">
            <TextBlock Text="Guesses Left: " FontSize="20"/>
            <TextBlock Text="{x:Bind ViewModel.GuessesLeft, Mode=OneWay}" FontSize="20"/>
        </StackPanel>

        <!-- Alphabet Buttons -->
        <GridView x:Name="AlphabetButtonsGridView" Grid.Row="1" Grid.Column="1" HorizontalAlignment="Center" VerticalAlignment="Center" Margin="10,50,10,10" 
          ScrollViewer.HorizontalScrollMode="Enabled"
          ScrollViewer.HorizontalScrollBarVisibility="Auto"
          ScrollViewer.VerticalScrollMode="Disabled"
          ScrollViewer.VerticalScrollBarVisibility="Hidden"
          ItemsSource="{x:Bind ViewModel.Letters}"> 
            <GridView.ItemsPanel>
                <ItemsPanelTemplate>
                    <ItemsWrapGrid Orientation="Horizontal" MaximumRowsOrColumns="5"/>
                </ItemsPanelTemplate>
            </GridView.ItemsPanel>
            <GridView.ItemTemplate>
                <DataTemplate x:DataType="local:GameLetter">
                    <Button Content="{x:Bind Character}" IsEnabled="{x:Bind IsAvailable, Mode=OneWay}" CommandParameter="{x:Bind Character}"
            Command="{Binding ViewModel.LetterGuessedCommand, ElementName=ThisPage}"/>
                </DataTemplate>
            </GridView.ItemTemplate>
        </GridView>

        <!-- Word Display Area -->
        <TextBlock x:Name="Word" Grid.Row="2" Grid.ColumnSpan="2" Text="{x:Bind ViewModel.WordDisplay, Mode=OneWay}"  FontSize="40" HorizontalAlignment="Center" VerticalAlignment="Bottom" Margin="10"/>

        <!-- Popup for message -->
        <Grid x:Name="Output" >
            <Popup x:Name="StandardPopup" IsLightDismissEnabled="False" IsOpen="{x:Bind ViewModel.PopUpToDisplay, Mode=OneWay}">
                <Border BorderBrush="{ThemeResource SurfaceStrokeColorDefaultBrush}" Background="{ThemeResource AcrylicBackgroundFillColorDefaultBrush}">
                    <StackPanel Orientation="Vertical" HorizontalAlignment="Center" VerticalAlignment="Center" Spacing="12">
                        <TextBlock Text="{x:Bind ViewModel.MessageTitle, Mode=OneWay}" />
                        <TextBlock Text="{x:Bind ViewModel.MessageContent, Mode=OneWay}" />
                        <Button Content="Close" Command="{Binding ViewModel.ClosePopupClickedCommand, ElementName=ThisPage}"/>
                    </StackPanel>
                </Border>
            </Popup>
        </Grid>
    </Grid>
</Page>
```


</details>

Or 

<details>
  <summary> Add each section:</summary>

3. In `Guesses Left Display section`, replace hardcoded “6” with `"{x:Bind ViewModel.GuessesLeft, Mode=OneWay}"`
```xaml
<StackPanel Grid.Row="1" Grid.Column="1" Orientation="Horizontal" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="10">
    <TextBlock Text="Guesses Left: " FontSize="20"/>
    <TextBlock Text="{x:Bind ViewModel.GuessesLeft, Mode=OneWay}" FontSize="20"/>
</StackPanel>
```

4. Under `<!-- Popup for message -->` add:

```xaml
<Grid x:Name="Output" Style="{StaticResource GridStyle}">
    <Popup x:Name="StandardPopup" Style="{StaticResource PopupStyle}" IsLightDismissEnabled="False" IsOpen="{x:Bind ViewModel.PopUpToDisplay, Mode=OneWay}">
        <Border Style="{StaticResource BorderStyle}" BorderBrush="{ThemeResource SurfaceStrokeColorDefaultBrush}" Background="{ThemeResource AcrylicBackgroundFillColorDefaultBrush}">
            <StackPanel Orientation="Vertical" HorizontalAlignment="Center" VerticalAlignment="Center" Spacing="12">
                <TextBlock Text="{x:Bind ViewModel.MessageTitle, Mode=OneWay}" Style="{StaticResource MessageTitlePopupTextBlockStyle}" />
                <TextBlock Text="{x:Bind ViewModel.MessageContent, Mode=OneWay}" Style="{StaticResource MessageContentPopupTextBlockStyle}"/>
                <Button Content="Close" Command="{Binding ViewModel.ClosePopupClickedCommand, ElementName=ThisPage}" Style="{StaticResource PopupButtonStyle}"/>
            </StackPanel>
        </Border>
    </Popup>
</Grid>
```
</details>

This XAML code defines the UI for the word-guessing game, with two key interactive elements: the Guesses Left Display and a message Popup. The Guesses Left Display uses a TextBlock that dynamically updates to show the remaining guesses. It achieves this through data binding, specifically `{x:Bind ViewModel.GuessesLeft, Mode=OneWay}`, which connects the TextBlock's Text property to the `GuessesLeft` property in the ViewModel. The OneWay mode ensures that changes in the ViewModel automatically update the UI. The message Popup, controlled by `IsOpen="{x:Bind ViewModel.PopUpToDisplay, Mode=OneWay}"`, appears based on the game's state to show end-game messages. Its content, including the message title and text, is also bound to ViewModel properties, allowing for dynamic updates. A close button in the Popup triggers a command in the ViewModel to reset the game. These elements demonstrate how the UI responds to the game's logic, providing real-time feedback and interaction for the player.

Now you can Run app in Debug mode by doing the following step:

5. On the title bar, **click** on **Debug**, click on **Start Debugging** OR on your keyboard press **F5** key

The app should be playable with the winning/losing message appearing on the top left.

:::image type="content" source="../media/6-game-play/game-play.png" alt-text="Screenshot of the game with the losing message on the top left.":::

In this section, you built the core game logic and the ViewModel that drives the user interface. This Game class manages the game state, while the MainViewModel class connects the game to the UI, updating the display and handling player input. These code additions provide the foundation for the word-guessing game.

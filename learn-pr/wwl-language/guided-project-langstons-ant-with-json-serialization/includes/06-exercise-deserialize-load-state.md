1. Navigate to  `WPF\JSON\GameJSONSerializer.cs` and locate the `FromJson` method.

1. Update the method to return the deserialized `Game` object and uncomment the `InterfaceConverterFactory` converter:

    ```c#
    var serializeOptions = new JsonSerializerOptions
    {
        WriteIndented = true,
        Converters = {
            new MultiDimensionalArrayConverter(),
            new InterfaceConverterFactory(typeof(GeneralizedAnt), typeof(IAnt)),
        }
    };

    if (jsonString != null)
    {
        game = JsonSerializer.Deserialize<Game>(jsonString, serializeOptions);
    }

    return game;
    ```

    In this code, you use the `JsonSerializer` class to deserialize the JSON string into a `Game` object. You use the predefined `serializeOptions` to specify the formatting and converters to use. Finally, rather than returning `null`, you return the deserialized `Game` object.

    Next, you call the `FromJson` method when the "Load" button is selected.

1. Navigate to `MainWindow.xaml.cs` and locate the `btnLoad_Click` method.

1. Update the `loadedGame` object with the following code: 

    ```c#
    if (openFileDialog.ShowDialog() == true)
    {
        fileName = openFileDialog.FileName;
        string json = await File.ReadAllTextAsync(fileName);
        
        IGame? loadedGame = GameJSONSerializer.FromJson(json);
        if (loadedGame != null) {
            game = loadedGame;
            UpdateGameView(game);
        }
    }
    ```

    Now the method calls `GameJSONSerializer.FromJson()` to deserialize the game state from a JSON string. The method then updates the game view with the loaded game state.

    Let's test the application to see how the game state is loaded and deserialized from a file.

## Check your work

1. Enter `dotnet run` in the terminal to run the Windows Presentation Foundation (WPF) application.

1. To start the simulation, select the "Play" button.

1. Allow the simulation to run for a few generations, then select the "Pause" button.

1. Select "Save" button. In the dialog, enter a file name and choose a destination that is easy to find.

1. Select the "Stop" button to clear the game view.

1. Select the "Load" button. In the dialog, select the file you saved earlier.

1. Observe that the previous game state is loaded and the game view is updated.

    You can also select the "Play" button to continue from the loaded game sate.

Now your WPF application is set up to use JSON serialization to save and load game states. You completed the guided project, congratulations!
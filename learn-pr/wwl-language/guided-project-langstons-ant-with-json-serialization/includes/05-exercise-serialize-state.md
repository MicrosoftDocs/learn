1. Navigate to  `WPF\JSON\GameJSONSerializer.cs` and locate the `ToJson` method.

1. Update the method to return the serialized JSON string and uncomment the `InterfaceConverterFactory` converter:

    ```c#
    public static string ToJson(IGame game)
    {
        var serializeOptions = new JsonSerializerOptions
        {
            WriteIndented = true,
            Converters = {
                new MultiDimensionalArrayConverter(),
                new InterfaceConverterFactory(typeof(GeneralizedAnt), typeof(IAnt)),
            }
        };
        
        // Serialize the game state to a JSON string
        return JsonSerializer.Serialize((Game) game, serializeOptions);
    }
    ```

    In this code, you use the `JsonSerializer` class to serialize the `Game` instance into a JSON string. You use the predefined `serializeOptions` to specify the formatting and converters to use. Finally, rather than returning `null`, you return the serialized JSON string.

    JSON doesn't natively support two-dimensional arrays. However the `Game` object is implemented with a two-dimensional byte array. How do we store it in JSON? The `JsonSerializerOptions` class can help you define how to serialize the data. In this case, you use the `MultiDimensionalArrayConverter` class to handle the two-dimensional array. You also use the `InterfaceConverterFactory` class to handle the `IAnt` interface.

    Next, you call the `ToJson` method when the "Save" button is selected.

1. Navigate to `MainWindow.xaml.cs` and locate the `btnSave_Click` method.

1. Update the `jsonString` object with the following code: 

    ```c#
    if (saveFileDialog.ShowDialog() == true)
    {
        string jsonString = GameJSONSerializer.ToJson(game);

        await File.WriteAllTextAsync(saveFileDialog.FileName, jsonString);
    }
    ```

    Now the method calls `GameJSONSerializer.ToJson()` to serialize the game state to a JSON string and writes the JSON string to a file.

    Let's test the application to see how the game state is serialized and saved to a file.

## Check your work

1. Enter `dotnet run` in the terminal to run the Windows Presentation Foundation (WPF) application.

1. To start the simulation, select the "Play" button.

1. Allow the simulation to run for a few generations, then select the "Pause" button.

1. Select "Save" button. In the dialog, enter a file name and choose a destination that is easy to find.

1. Open the file in a text editor.

    The file should contain a JSON string that represents the game state. The JSON string should include the generation count, grid, and the ant information.

Now that you successfully serialized the game state to a JSON file, you can move on to the next exercise to deserialize the game state.
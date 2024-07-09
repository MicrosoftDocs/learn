

In this exercise, you modify the `btnSave_Click` method in your `WPF/MainWindow.xaml.cs` file to use C#'s `async` and `await` functionality. `Async` and `await` are keywords in C# that allow developers to write asynchronous code that is easier to read and write than traditional asynchronous code.

In the discussion of threads and Tasks, to avoid UI freezes, you made your UI code asynchronous using C# Tasks. Unlike a Task, however, an `async` method runs synchronously. When an `async` method reaches its first `await` expression, it suspends the method until the awaited task is complete.

The `await` keyword pauses the execution of the rest of the method until the asynchronous operation is complete. In the meantime, control returns to the caller of the method, allowing execution of your code to continue.

## Implement async I/O for saving and loading a game

To begin, update the Game save and load functionality, making file I/O operations asynchronous. Doing so will free the UI to render updates and avoid freezes.

1. Open `WPF/MainWindow.xaml.cs`

1. Make the `btnSave_Click` method asynchronous, using the `async` keyword.

    ```csharp
    private async void btnSave_Click(object sender, RoutedEventArgs e)
    {
        ...
    }
    ```

1. Change `File.WriteAllText` to `File.WriteAllTextAsync` in `btnSave_Click`.

1. Prepend `await` to `File.WriteAllTextAsync`.

    ```csharp
    try
    {
        string jsonString = GameJSONSerializer.ToJson(buffer.Current);
        await File.WriteAllTextAsync(saveFileDialog.FileName, jsonString);
    }
    ```

1. Make the `btnLoad_Click` method asynchronous, using the `async` keyword.

    ```csharp
    private async void btnLoad_Click(object sender, RoutedEventArgs e)
    {
        ...
    }
    ```

1. Change `File.ReadAllText` to `File.ReadAllTextAsync` in `btnLoad_Click`.

1. Prepend `await` to `File.ReadAllTextAsync`.

    ```csharp
    try
    {
        string json = await File.ReadAllTextAsync(fileName);
        IGame loadedGame = GameJSONSerializer.FromJson(json);
        buffer = CreateGameBuffer(loadedGame, nGenerations, rule);

        ...
    }
    ```

## Check your work

Compile the solution and launch the application. Make sure that saving and loading a game works.

1. Open a terminal window by selecting View --> Terminal.

1. Change directories to the Starter/WPF directory, if you aren't already in it.

1. Enter `dotnet build` and press Enter.

1. Enter `dotnet run` and press Enter.

1. Try saving and then loading a game.

Congratulations on making it this far!
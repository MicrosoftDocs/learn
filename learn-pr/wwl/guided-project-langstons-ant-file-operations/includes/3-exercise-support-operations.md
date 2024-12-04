In this exercise, you add code that supports the options to read or write the game state to or from a file. Let's get started!

> [!IMPORTANT]
> You need to have completed the Setup instructions in the previous unit, Prepare, before you begin this Exercise.

1. Open the **Program.cs** file

1. Locate the `do`-`while` loop at the bottom of the file

1. Update the message in the `Console.WriteLine` statement:

    ```c#
    do
    {
        Console.WriteLine("Press Enter for a new generation, 'w' to write to file, or 'r' to read from file.");
        input = Console.ReadLine();
    ```

    Next, update the method to handle the different keys pressed by the user.

1. Add a new `if` statement to handle the <kbd>w</kbd> key:

    ```c#
    if (input == "w" || input == "W") 
    {
        // WriteToFile();
        Console.WriteLine("File written.");
    } 
    else if (String.IsNullOrEmpty(input)) 
    {
        game.NextGeneration();
        Console.WriteLine($"Generation #: {game.GenerationN}");
        Console.WriteLine("Field:");
        Print(game);
    }
    ```

    For now, use a comment to indicate where the `WriteToFile` method should be called until you implement the method.

1. Add a condition for the <kbd>r</kbd> key:

    ```c#
    if (input == "w" || input == "W") 
    {
        // WriteToFile();
        Console.WriteLine("File written.");
    } 
    else if (input == "r" || input == "R") 
    {
        //ReadFile();
        Console.WriteLine("File read.");
    } 
    else if (String.IsNullOrEmpty(input)) 
    {
        game.NextGeneration();
        Console.WriteLine($"Generation #: {game.GenerationN}");
        Console.WriteLine("Field:");
        Print(game);
    }
    ```

    For now, use a comment to indicate where the `ReadFile` method should be called until you implement the method.

1. Add conditions to the `while` statement to handle the <kbd>w</kbd> and <kbd>r</kbd> keys:

    ```c#
    while (String.IsNullOrEmpty(input) 
        || input == "w" || input == "W" 
        || input == "r" || input == "R");
    ```

    Now the `while` statement continues to loop if the user presses the <kbd>Enter</kbd> key, or the <kbd>w</kbd> or <kbd>r</kbd> keys.

## Check your work

1. Enter `dotnet run` in the terminal to run the application.

    You should see the following output:

    ```output
    Press Enter for a new generation, 'w' to write to file, or 'r' to read from file.
    ```

1. Press the <kbd>Enter</kbd> key.

    The application should display the next generation of the game.

1. Press the <kbd>w</kbd> key.

    The application should display the message "File written."

1. Press the <kbd>r</kbd> key.

    The application should display the message "File read."

> [!NOTE]
> If your code doesn't produce the output you expected, you can review the code in the **Solution** folder.

Now your application is set up to support the options to read or write a file. In the next exercise, you'll add the code to write the simulation state to a file.
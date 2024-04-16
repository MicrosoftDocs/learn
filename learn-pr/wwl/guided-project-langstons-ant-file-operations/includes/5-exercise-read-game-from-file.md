In this exercise, you add code that reads the game state file. Let's get started!

1. Open the **Program.cs** file

1. Create a new method that reads a file:

    ```c#
    string ReadFile() {
        string content = "";
        return content;
    }
    ```

    This method should return a string for the file content.

1. To access the file and read the content, add the following code:

    ```c#
    string ReadFile() {
        string filePath = Path.Combine(outputDirectory, fileName);
        string content = File.ReadAllText(filePath);
        return content;
    }
    ```

    In this code, you use the `Path.Combine` method to create the file path, and the `File.ReadAllText` method to read the file content. Next, you need to make sure that the file exists before accessing it.

1. Update your method with the following code:

    ```c#
    string ReadFile() {
        string filePath = Path.Combine(outputDirectory, fileName);
        if (!File.Exists(filePath))
        {
            return $"File ({filePath}) doesn't exist";
        }
        string content = File.ReadAllText(filePath);
        return content;
    }
    ```

    In this code, if the file doesn't exist, the method returns a message informing the user. Now you're ready to use the `ReadFile` method in the rest of the program.

1. Navigate to the `do`-`while` loop at the bottom of the **Program.cs** file

1. Update the `if` statement that handles the <kbd>r</kbd> key:

    ```c#
    else if (input == "r" || input == "R") {
        string content = ReadFile();
        Console.WriteLine(content);
    } 
    ```

    Now the `ReadFile` method is called when the user presses the <kbd>r</kbd> key and the content of the file is displayed.

## Check your work

1. Enter `dotnet run` in the terminal to run the application.

    You should see the following output:

    ```output
    Press Enter for a new generation, 'w' to write to file, or 'r' to read from file.
    ```

1. Press the <kbd>Enter</kbd> key several times.

    The application should display several generations of the game.

1. Press the <kbd>w</kbd> key.

    The application should display the message "File written." The "antPattern.txt" file should be created in the `output` directory.

1. Press the <kbd>r</kbd> key.

    The application should display the file content which is the previously generated game state.

> [!NOTE]
> If your code doesn't produce the output you expected, you can review the code in the **Solution** folder.

Now your program supports reading and writing the Langston's Ant simulation data. Great work!
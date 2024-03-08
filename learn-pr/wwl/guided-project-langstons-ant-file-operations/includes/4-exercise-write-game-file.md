In this exercise, you add code that writes the game state to a file. Let's get started!

1. Open the **Program.cs** file

1. Locate the `Game` variable at the top of the file

1. Add variables to store the file path and content:

    ```c#
    Game game = new Game(16);
    string outputDirectory = "output";
    string fileName = "antPattern.txt";
    string gameStr = "";

    ```

    Next, you modify the `Print` method so that it stores the current game state in the `gameStr` variable.

1. Locate the `Print` method

1. Add the following code at the beginning of the method:

    ```c#
    void Print(Game game)
    {
        gameStr = "";
    ```

1. Navigate to the end of the `Print` method

1. After the `fieldChar` is printed, add it to the `gameStr` variable:

    ```c#
        else
        {
            fieldChar = game.Field[i, j] == 0 ? '░' : '▓';
        }
        Console.Write($"{fieldChar}");
        gameStr += fieldChar;
    }
    ```

1. After the new line is printed, add a new line to the `gameStr` variable:

    ```c#
            else
            {
                fieldChar = game.Field[i, j] == 0 ? '░' : '▓';
            }
            Console.Write($"{fieldChar}");
            gameStr += fieldChar;
        }
        Console.WriteLine();
        gameStr += "\n";
    }
    ```

1. Create a new `WriteToFile` method to write the game state to a file:

    ```c#
    void WriteToFile() 
    {
        File.WriteAllText(fileName, gameStr);
    }
    ```

1. Modify the method to use the `outputDirectory` variable:

    ```c#
    void WriteToFile() 
    {
        string filePath = Path.Combine(outputDirectory, fileName);
        File.WriteAllText(filePath, gameStr);
    }
    ```

    In this code, the `Path.Combine` method is used to combine the `outputDirectory` and `fileName` variables to create the file path. However, you need to add code to check if the directory exists and create it if it doesn't.

1. Update the method with the following code:

    ```c#
    void WriteToFile() 
    {
        string filePath = Path.Combine(outputDirectory, fileName);
        if (!Directory.Exists(outputDirectory))
        {
            Directory.CreateDirectory(outputDirectory);
        }
        File.WriteAllText(filePath, gameStr);
    }
    ```

    Now the `WriteToFile` method checks if the `outputDirectory` exists and creates it if necessary. Then it writes the `gameStr` variable to the file.

1. Navigate to the `do`-`while` loop at the end of the **Program.cs** file

1. Update the `do-while` loop to call the `WriteToFile` method when the user presses the <kbd>w</kbd> key:

    ```c#
    if (input == "w" || input == "W") 
    {
        WriteToFile();
        Console.WriteLine("File written.");
    } 
    else if (input == "r" || input == "R") 
    {
        //ReadFile();
        Console.WriteLine("File read.");
    }
    ```

    Now the `WriteToFile` method is called when the user presses the <kbd>w</kbd> key.

## Check your work

1. Enter `dotnet run` in the terminal to run the application.

    You should see the following output:

    ```output
    Press Enter for a new generation, 'w' to write to file, or 'r' to read from file.
    ```

1. Press the <kbd>Enter</kbd> key several times

    The application should display the next generations of the game.

1. Press the <kbd>w</kbd> key.

    The application should display the message "File written." 

1. In the File Explorer, locate the **output** folder

    The folder should contain a file named **antPattern.txt**

1. Open the **antPattern.txt** file

    The file should contain the game state that was outputted in the console.

> [!NOTE]
> If your code doesn't produce the output you expected, you can review the code in the **Solution** folder.

Now your Langston's Ant simulation can write the game state to a file. Great work! In the next exercise, you'll add the code to read the simulation state from the file you generated.

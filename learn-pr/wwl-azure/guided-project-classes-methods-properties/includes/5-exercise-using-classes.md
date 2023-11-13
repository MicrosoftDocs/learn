In this last exercise, you make your game field, or grid, look a little nicer. To do that, you edit your Print method in the Program.cs file. Essentially, rather than a “0”, your method now uses this symbol '░' instead. Rather than the number “1”, you use this symbol '▓'. When an ant is present, you print the direction of the ant's current direction, for example, '►'.

## Add Game field pretty-printing

You begin by modifying the 'for' loops you created earlier in the Print method, replacing the zeros with a character. 

1. Delete the Console.Write($"{game.Field[i, j]}  ") and replace it with the following line 'char fieldChar = '░';'.

1. Now check to see if an ant exists in your collection at the current location by adding the following line, 'Ant? ant = game.Ants.FirstOrDefault(a => (i == a.I) && (j == a.J))'.

    ```csharp
    using LangtonsAnts;

    void Print(Game game)
    {
        for (int i = 0; i < game.Field.GetLength(0); i++)
        {
            for (int j = 0; j < game.Field.GetLength(1); j++)
            {
                char fieldChar = '░'; 

                // Check for an ant in your collection
                Ant? ant = game.Ants.FirstOrDefault(a => (i == a.I) && (j == a.J));
            }     
            Console.WriteLine();
        }
        Console.WriteLine();
    }
    Console.WriteLine();
    ```

    Your code should look like what you see pictured.

1. If there is an ant, print the symbol for its direction, as shown in the 'if' and Switch statements. 

    ```csharp
    using LangtonsAnts;

    void Print(Game game)
    {
        for (int i = 0; i < game.Field.GetLength(0); i++)
        {
            for (int j = 0; j < game.Field.GetLength(1); j++)
            {
                char fieldChar = '░'; 

                // If ant is at the cell, display ant direction instead of color value
                Ant? ant = game.Ants.FirstOrDefault(a => (i == a.I) && (j == a.J));

                if (ant != null)
                {
                    // Draw one of the ants
                    switch (ant.Direction)
                    {
                        case AntDirection.Up:
                            fieldChar = '▲';
                            break;
                        case AntDirection.Right:
                            fieldChar = '►';
                            break;
                        case AntDirection.Down:
                            fieldChar = '▼';
                            break;
                        case AntDirection.Left:
                            fieldChar = '◄';
                            break;
                    }
                }
            }   
            Console.WriteLine();
        }
        Console.WriteLine();
    }
    Console.WriteLine();
    ```

1. If there is no ant at that location, you flip the color of the cell from black to white as shown in the 'else' clause of the 'if' statement.

    ```csharp
    using LangtonsAnts;

    void Print(Game game)
    {
        for (int i = 0; i < game.Field.GetLength(0); i++)
        {
            for (int j = 0; j < game.Field.GetLength(1); j++)
            {
                char fieldChar = '░'; 

                // If ant is at the cell, display ant direction instead of color value
                Ant? ant = game.Ants.FirstOrDefault(a => (i == a.I) && (j == a.J));

                if (ant != null)
                {
                    // Draw one of the ants
                    switch (ant.Direction)
                    {
                        case AntDirection.Up:
                            fieldChar = '▲';
                            break;
                        case AntDirection.Right:
                            fieldChar = '►';
                            break;
                        case AntDirection.Down:
                            fieldChar = '▼';
                            break;
                        case AntDirection.Left:
                            fieldChar = '◄';
                            break;
                    }
                }
                else
                {
                    fieldChar = game.Field[i, j] == 0 ? '░' : '▓';
                }
            }     
            Console.WriteLine();
        }
        Console.WriteLine();
    }
    Console.WriteLine();
    ```

1. Finally, change the 'Console.WriteLine() after the 'else' clause to print the 'fieldChar' variable with the new grid character.

    ```csharp
    using LangtonsAnts;

    void Print(Game game)
    {
        for (int i = 0; i < game.Field.GetLength(0); i++)
        {
            for (int j = 0; j < game.Field.GetLength(1); j++)
            {
                char fieldChar = '░'; 

                // If the ant is at the cell, display ant direction instead of color value
                Ant? ant = game.Ants.FirstOrDefault(a => (i == a.I) && (j == a.J));

                if (ant != null)
                {
                    // Draw one of the ants
                    switch (ant.Direction)
                    {
                        case AntDirection.Up:
                            fieldChar = '▲';
                            break;
                        case AntDirection.Right:
                            fieldChar = '►';
                            break;
                        case AntDirection.Down:
                            fieldChar = '▼';
                            break;
                        case AntDirection.Left:
                            fieldChar = '◄';
                            break;
                    }
                }
                else
                {
                    fieldChar = game.Field[i, j] == 0 ? '░' : '▓';
            }
        }
        Console.Write($"{fieldChar}");
        }
            Console.WriteLine();
        }
    }
    Console.WriteLine();
    ```

## Modify the Game.cs file

Now make an adjustment to the creation of your ants array in the Game.cs file. As you are now getting your ants from an Ants array using what is called a 'FirstOrDefault' method on the collection (which is not a 0 based collection), the creation of an ant does not need the help of a '+ 1'. The collection from 'FirstOrDefault' starts with the number 1.

1. Open the Game.cs file.

1. In the constructor of the Game class find the line that reads:

    ```csharp
    Ants = new Ant[] {
        new Ant(i: size/2 + 1, j: size / 2 + 1, direction: AntDirection.Up)
    }
    ```

1. Remove the '+ 1's being passed in the constructor.

    ```csharp
    Ants = new Ant[] {
        new Ant(i: size/2, j: size / 2, direction: AntDirection.Up)
    }
    ```

## Read user input

The last thing on the agenda is to create a 'do...While' loop to read user input while playing the game. To do this, you will start by creating a nullable string variable called 'input' in your Program.cs file. 

The While clause in your 'do...While' loop will check the input variable to see if the user has entered anything from the keyboard. If not, the loop will execute, running the 'game.NextGeneration()' and 'Print(game)' methods, as well as prompting the user with 'Console.WriteLine' messages. Let's get started.

1. Open your Program.cs file.

1. Delete the existing 'Print(game)', which should be the last line in the file.

1. Add a nullable string variable called 'input', as indicated by the question mark after the word string, 'string? input;'.

1. Create your 'do...While' loop.

    ```csharp
    string? input;
    do
    {

    }
    while (String.IsNullOrEmpty(input));
    ```

1. Add a statement to execute the 'game.NextGeneration' method and a 'Console.WriteLine' statement indicating the generation number of the game.

    ```csharp
    string? input;
    do
    {
        game.NextGeneration();
        Console.WriteLine($"Generation #: {game.GenerationN}");
    }
    while (String.IsNullOrEmpty(input));
    ```

1. Now add a 'Console.WrieLine' statement indication that what follows is the game field and execute the 'Print(game)' method.

    ```csharp
    string? input;
    do
    {
        game.NextGeneration();
        Console.WriteLine($"Generation #: {game.GenerationN}");

        Console.WriteLine("Field:");
        Print(game);
    }
    while (String.IsNullOrEmpty(input));
    ```

1. Add a 'Console.WriteLine' method, promting the user for input.

    ```csharp
    string? input;
    do
    {
        game.NextGeneration();
        Console.WriteLine($"Generation #: {game.GenerationN}");

        Console.WriteLine("Field:");
        Print(game);

        Console.WriteLine("Press Enter for a new turn or any other key for exit");
    }
    while (String.IsNullOrEmpty(input));
    ```

1. Lastly, add a 'Console.ReadLine' statement and capture the users input in the nullable 'input' variable you created at the top of this section.

    > [!NOTE]The reason you make the 'input' variable nullable, ('string? input') indicated by the question mark, is that this variable will be empty (or null) until the user enters something through the keyboard.

    ```csharp
    string? input;
    do
    {
        game.NextGeneration();
        Console.WriteLine($"Generation #: {game.GenerationN}");

        Console.WriteLine("Field:");
        Print(game);

        Console.WriteLine("Press Enter for a new turn or any other key for exit");
        input = Console.ReadLine();
    }
    while (String.IsNullOrEmpty(input));
    ```

## Check your work

In this task, you save your work and run the code to verify the output is correct.

1. Compare your code:

    ```csharp
    TBD
    ```

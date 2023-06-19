

In this last exercise, you make your game field, or grid, look a little nicer. To do that, you edit your Print method in the Program.cs file. Essentially, rather than a “0”, your method now uses this symbol '░' instead. Rather than the number “1”, you use this symbol '▓'. When an ant is present, you print the direction of the ant's current direction, for example, '►'.

## Add Game field pretty-printing

You begin by modifying the loop you created earlier. To start, you delete the Console.Write and Console.WriteLine statements inside our loop and replace them with a default character you use for creating our grid, basically replacing the "0s." You then check to see if there are ants in the ants array. If there are ants in the array, you print the current direction of the ant. If no ants exist in the array, you flip the color of the cell from black to white.

1. Create your new character of type `char` called `fieldChar`, that is, `char fieldChar = '░';`.

1. Check for ants in the ant array. You check by accessing the Ants array property and calling the FirstOrDefault method on it, passing in the x-axis and y-axis of the ant. If it comes back null, no ant was found in the array.

    `Ant? ant = game.Ants.FirstOrDefault(a => (i == a.I) && (j == a.J));`

1. Draw ant direction using switch statements, if ant array not null.
    ```csharp
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
    ```

1. Print a dark symbol for 1, if ant array empty.

    ```csharp
    else
    {
        fieldChar = game.Field[i, j] == 0 ? '░' : '▓';
    }
    ```

1. Print your field character.

    The last thing to do here's to print your `fieldChar` to the screen, that is, `Console.Write($"{fieldChar}");`.


## Check your work

In this task, you run the code and verify the output is correct.

1. Compare your code:

    ```csharp
    TBD
    ```
    
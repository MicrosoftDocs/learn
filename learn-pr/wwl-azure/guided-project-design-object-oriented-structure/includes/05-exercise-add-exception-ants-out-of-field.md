Currently the code doesn't check for ants that leave the game field. In this exercise, you update the code to delete ants from the Game's Ant collection when they leave the field. You also handle the situation where all ants leave the field.

## Change Ants property type from array to list

Update Game class and `IGame` interface, changing `IAnt[]` type to `IList<IAnt>`.

1. Open the `Game.cs` file in the Games folder.

1. Replace the `IAnts[] Ants` property with `IList<IAnt> Ants`.

    ```csharp
    using System.Collections;
    using System.Collections.Generic;

    namespace LangtonsAnt
    {
        public class Game : IGame
        {
            protected const int defaultSize = 128;
            public int GenerationN { get; set; } = 0;
            public byte[,] Field { get; set; }
            public IList<IAnt> Ants { get; set; }

            ...
        }

        ...
    }
    ```

1. Modify `Ants` initialization in the constructor to use `IList<IAnt> Ants`.

    ```csharp
    public Game(int size, IAnt[]? initialAnts)
    {
      Field = new byte[size, size];
      Ants = new List<IAnt>(initialAnts ?? new IAnt[] { });
    }
    ```

1. Replace `Ants.Length` with `Ants.Count` in the `for` loop.

    ```csharp
    for (int index = Ants.Count - 1; index >= 0; index--)
    {
        ...
    }
    ```

1. Open the `IGame.cs` file in the `Games` folder.

1. Replace the `IAnt[] Ants { get; set; }` property with the new `IList<IAnt> Ants { get; set; }` property in the `IGame` interface, as seen here.

    ```csharp
    public interface IGame
    {
        public int Size { get; }
        public IList<IAnt> Ants { get; set; }
        public int GenerationN { get; }
        public byte[,] Field { get; }
        public void NextGeneration();
    }
    ```

## Add an exception class for the Game Over case

The code will throw an exception when there are no ants left on the field. To begin, you'll create a new file `GameOverException.cs` in the `WPF\Game` folder. In the new file, you define a `GameOverException` exception class.

1. Navigate to the `WPF\Game` folder.

1. Select New File and name the file `GameOverException.cs`, then press Enter.

1. Create the new exception class, inheriting from the .NET `Exception` class, as shown here.

    ```csharp
    using System;

    namespace LangtonsAnt
    {
        public class GameOverException : Exception
        {
            public GameOverException(string? message) : base(message) { }
        }
    }
    ```

## Throw a GameOverException when there are no ants left

The game needs to throw an exception when there are no more ants in the Ants list. You create this functionality by including `Ants.Count == 0` in the `if` header.

1. Open the `Game.cs` file in the Game folder.

1. Throw a `GameOverException`, if there are no more ants, by adding an `if` statement that checks if `Ants.Count = 0`. Add the `if` statement after `newField` in the `CalcNextgeneration` method.

    ```csharp
    namespace LangtonsAnt
    {
        public class Game : IGame
        {
            ...

            private byte[,] CalcNextGeneration()
            {
                var newField = (byte[,])Field.Clone();

                if (Ants.Count == 0)
                    throw new GameOverException("We no longer have any ants");

                ...
            }
        }
    }
    ```

## Remove ants from Ants collection when they leave the field

Add an `if` statement to remove an ant if it goes off of the game field. The `if` statement checks to see that each ant's horizontal and vertical axis coordinates (x, y) are within the grid. If they are within the grid, it means that both `I` and `J` are greater than `0` and within the size of the grid.

1. Locate the `CalcNextGeneration` method in `Game.cs` file.

1. Add the statement `Ants.RemoveAt(index);` just above `continue`.

```csharp
namespace LangtonsAnt
{
    public class Game : IGame
    {
        ...

        private byte[,] CalcNextGeneration()
        {
            ...

            for (int index = Ants.Count - 1; index >= 0; index--)
            {
                var ant = Ants[index];

                // Check if the ant is still within the field
                if (ant.I < 0 || ant.J < 0 || ant.J >= Size || ant.I >= Size)
                {
                    Ants.RemoveAt(index);
                    continue;
                }
            }

            ...
        }
    }
}
```

## Check namespaces

As the functionality of your application is largely dependent .NET namespaces you're using, it can be helpful to make sure that your code has the right ones. In this case, your code needs the `System.Collections` and the `System.Collections.Generic` namespaces for your collection of ants.

1. Verify that `Game.cs` has the following namespaces at the top of the file.

```csharp
using System.Collections;
using System.Collections.Generic;

namespace LangtonsAnt
{
    ...
}
```

## Check your work

Build the solution, launch the application, and optionally ensure that it throws th exception when the last ant leaves the field.

1. Open a terminal console by selecting View --> Terminal from the menu.

1. In the terminal window, enter `dotnet build` to see if the code builds.

1. Run the code by entering `dotnet run`.

If your code didn't build and run successfully, go through the steps of this exercise again. Build and run your code at various intervals to find where you may have gone wrong. Congratulations on making it this far!

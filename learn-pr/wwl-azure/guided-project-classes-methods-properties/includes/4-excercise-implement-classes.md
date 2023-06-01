

In this exercise, we create the Game folder in the application root and begin implementing LangtonsAnt game concepts in this folder.

##Create a game folder
1. Ensure that you have the .NET Editor open to your LangtonsAnt project.
1. Select Add, by right-clicking on the name of your project in Solution Explorer.
1. Select New Folder, then name it *Game*.


##Create Enum for ant direction
Now that we have our Game folder, we can begin adding our application files to it.

##Create AntDirection.cs
1. Right-click the Game folder and select Add.
1. Select New Item.
1. Name the new file you're creating AntDirection.cs.
1. Select Add.
1. Add your enum code.

    ```CSharp
    public enum AntDirection
    {
        Up = 0,
        Right = 1,
        Down = 2,
        Left = 3
    }
    ```

##Create Ant class
Create and Ant class and add Ant properties and a constructor.
1. Right-click the Game folder and select Add.
1. Select New Item.
1. Name the new file you're creating Ant.cs
1. Select Add.

##Add ant Act method
1. Add a method called Act that takes a byte variable called *oldValue* and returns a byte.

    ```CSharp
    public virtual byte Act(byte oldValue)
    {
        // returns the new field cell color value.
        return 0;
    }
    ```

##Add Game class and properties
You'll now create your Game class and add a few properties to it.
1. Right-click the Game folder and select Add.
1. Select New Item.
1. Name the new file you're creating Game.cs.
1. Select Add.

Add GenerationN property
1. Type the word `pro` (short for property) and press Tab
1. Enter `int`
1. Press Tab again.
1. Enter your property name `GenerationN`
1. Press Enter
1. Tab to the end of the line and add ` = 0 ;`

Add Field property
1. Type the word `pro` (short for property) and press Tab
1. Enter `byte[,]`
1. Press Tab again.
1. Enter your property name `Field`.
1. Press Enter.

Add Ants property
1. Type the word `pro` (short for property) and press Tab
1. Enter `Ants[]`
1. Press Tab again.
1. Enter your property name `Ants`.
1. Press Enter.

##Implement a constructor initializing class instances
Our next task is to initialize our Game class with default size.
1. Create a public constructor that looks like this.
    ```CSharp
    public Game(int size = 64)
    {

    }
    ```
1. Add `byte[,]` array and initialize it.
    ```CSharp
    public Game(int size = 64)
    {
        Field = new byte[size, size];
    }
    ```

1. Add `Ants[]` array and initialize it.
    ```CSharp
    public Game(int size = 64)
    {
        Field = new byte[size, size];

        Ants = new Ant[] { new Ant(i: size/2, j: size / 2, direction: AntDirection.Up) };
    }
    ```

##Implement Game methods
Now that we have created our Game class with a constructor that initializes the size of our byte array for our grid, we're ready to begin implementing our methods. You begin by creating a method called *NextGeneration* and then adding the method it calls, *CalcNextGeneration*. We're separating out our *NextGeneration* methods into two methods for clarity sake. Although it's the *CalcNextGeneration* method that does the real work of the two methods, we begin by creating the *NextGeneration* method that calls into it.

    > [!NOTE]
    > The CalcNextGeneration method calculates the next presentation of the grid, displaying the new position of the ant in the grid. It is literally calculating a new presentation (or generation) of the grid based on the ants movements.

1. Create the NextGeneration method
    ```CSharp
    public void NextGeneration()
    {
        Field = CalcNextGeneration();
        GenerationN++;
    }
    ```

1. Create a public method called `CalcNextGeneration` that looks like this.
    ```CSharp
    public void CalcNextGeneration()
    {
    
    }
    ```

Add code to `CalcNextGeneration` method

1. Create a variable called `newField` from your byte array that we can use for our new cell value.

    ```CSharp
    public void CalcNextGeneration()
    {
            var newField = (byte[,])Field.Clone();
    }
    ```

1. Create a `for` loop so we can loop through each ant and set the newField value(s).

    ```CSharp
    for (int index = Ants.Length - 1; index >= 0; index--)
    {

    }
    ```

1. Get the current ant and assign it to a variable called `ant`. 

    ```CSharp
    for (int index = Ants.Length - 1; index >= 0; index--)
    {
            var ant = Ants[index];
    }
    ```

1. Check if the ant is still within the field.
This next bit of code checks to see if the ant is still in the grid. The following `if` statement checks to see if an ant has exceeded the bound of the grid. If an ant has exceeded the bounds of the grid, the `continue` we skip processing that ants movements and begin the loop again with our next ant.
    ```CSharp
    // Check if the ant is still within the field
    if (ant.I < 0 || ant.J < 0 || ant.J >= Size || ant.I >= Size)
    {
        // TODO later we can act on ants going out of the field, 
        // for now we just exclude them from processing
        continue;
    }
    ```
The next several lines of code essentially swap out the old grid value (initially a 0) and replace it with the new one (initially a 1), now that the ant has landed on it. Thie first thing we do is take the newField variable we created which is our entire grid and grab the individual cell the ant is currently on.

5. Add the following line below the `if` statement `byte v = newField[ant.I, ant.J];`.

6. Now put the `i` and `j` integer values into their own variables for clarity sake, in preparation for updating our grid.

- `int i = ant.I;`
- `int j = ant.J;`

7. Add the following line `byte newVal = ant.Act(v);`.

8. Add the following line `newField[i, j] = newVal;`.

9. Add a return statement that returns the updated grid `return newField` (outside of `for` loop).

    ```CSharp
        private byte[,] CalcNextGeneration()
        {
            var newField = (byte[,])Field.Clone();

            for (int index = Ants.Length - 1; index >= 0; index--)
            {
                var ant = Ants[index];

                // Check if the ant is still within the field
                if (ant.I < 0 || ant.J < 0 || ant.J >= Size || ant.I >= Size)
                {
                    // TODO later we will act on ants going out of the field, 
                    //      now we just exclude them from processing
                    continue;
                }

                byte v = newField[ant.I, ant.J];
                int i = ant.I;
                int j = ant.J;
                byte newVal = ant.Act(v);
                newField[i, j] = newVal;
            }

            return newField;
        }
    ```

##Rewrite Program.cs to print game state

Our final task for this exercise is to rewrite the Program.cs file so that it prints the state of the game. To accomplish this task, we'll create a Print method and a `do…While` loop that will call our Print method. This will make our grid appear when the application starts.
1.	Open your Program.cs file.
1.	Create an instance of the Game class, i.e., `Game game = new Game(16)`.

    Make sure this is the first line in your file, beneath any using statement you might have.
1.	Create a Print method that takes a Game: `void Print(Game game)`.

    Just below the previous line, create your Print method as described.
1. Paste the `for` loop you created in the previous exercise into your Print method.
You need to replace the term `field` in your loop to use `game.Field`

##Call Game class Print method


##Check your work
1. Compare your code:

    ```csharp
    TBD
    ```
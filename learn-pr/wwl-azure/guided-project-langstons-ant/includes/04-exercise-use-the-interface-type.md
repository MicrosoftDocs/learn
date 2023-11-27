In this step, you'll update the game code to use the interface you created. You'll also modify the code to add a MirrorAnt object to the game.

## Use the IAnt interface as a type

1. In the Solution Explorer, open the **Game.cs** file located in the **Game** folder.

1. Change the `Ants` property to the `IAnt` type with the following code:

    ```c#
    public IAnt[] Ants { get; set; }
    ```

1. In the `Game` constructor, update the `Ants` initialization to use the `IAnt` interface type:

    ```c#
    public Game(int size = 64)
    {
        Field = new byte[size, size];
        Ants = new IAnt[] {
            new Ant(i: size/2, j: size / 2, direction: AntDirection.Up)
        };
    }
    ```

1. Add a new `MirrorAnt` object to the array with the following code:

    ```c#
    Ants = new IAnt[] {
        new Ant(i: size/2 + 2, j: size / 2, direction: AntDirection.Up),
        new MirrorAnt(i: size/2 - 2, j: size / 2, direction: AntDirection.Down)
    };
    ```

1. In the Solution Explorer, open the **Program.cs** file

1. Notice there is an error in the `Print` method on the following line of code:

    ```c#
    // If ant is at the cell, display ant direction instead of color value
    Ant? ant = game.Ants.FirstOrDefault(a => (i == a.I) && (j == a.J));
    ```

    The compiler assumes you want to cast `game.Ants` to the `Ant` type. Instead, you want to modify this code to use the interface type.

1. Update the line of code to the following:

    ```c#
    // If ant is at the cell, display ant direction instead of color value
    IAnt? ant = game.Ants.FirstOrDefault(a => (i == a.I) && (j == a.J));
    ```

## Check your work

In this task, you'll verify your code is working correctly.

1. Build your solution using <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd> or by selecting **Build Solution** from the **Build** menu.

1. Verify that the code builds successfully and there are no errors.

    If your code produces unexpected errors, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

1. Run the Guided Project solution and press enter a few times to see the generated ant pattern.

    You should see two ant patterns that appear to be mirrored.
     :::image type="content" source="../media/M04-04-Demo.png" alt-text="Mirrored ant patterns":::
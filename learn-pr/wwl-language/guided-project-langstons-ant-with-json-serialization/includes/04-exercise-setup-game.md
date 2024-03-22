In this exercise, you set up the Windows Presentation Foundation (WPF) application to use the Langston's Ant simulation code. You copy over the classes from the console application to the WPF application. Then you make a few modifications to the WPF application to use the Langston's Ant game code. Let's get started!

> [!IMPORTANT]
> You need to have completed the Setup instructions in the previous unit, Prepare, before you begin this Exercise.

1. Copy Ant.cs, GeneralizedAnt.cs, and Game.cs files from the `Console/Game` folder. 

1. Paste the files into the `WPF/Game` folder.

1. Update the `Game` class in the WPF application to implement the `IGame` interface:

    ```c#
    public class Game: IGame
    ```

    The `Game` class already has all the members necessary to implement the interface.

1. Right-click the WPF folder and click "Open in Integrated Terminal".

1. Run the following command to make sure the project builds correctly:

    ```sh
    dotnet build
    ```

1. Open `MainWindow.xaml.cs` and navigate to the `CreateGame` method. 

1. Uncomment the lines following the `// TODO #1` comment. 
    
    This code block creates a `Game` instance using the class we provided.

1. Navigate to the `MainWindow` constructor and uncomment the lines following the `// TODO #2` comment.  
    
    This code block sets up the timer to calculate new Game generations and update the view periodically.

## Check your work

1. Enter `dotnet run` in the terminal to run the WPF application.

    A form should appear with the options to Play and Stop the simulation.

1. Press the Play button and observe the ant begins to move on the grid.

Now your WPF application is set up to use the Langston's Ant simulation code. In the next exercise, you'll modify the WPF application to use JSON serialization.
Code challenges throughout these modules reinforce what you've learned, and help you gain some confidence before continuing on.

The focus of this challenge is to create correct methods with the proper parameters and return types.

## Dice mini-game challenge

Your challenge is to design a mini-game. The game should select a target number that is a random number between one and five (inclusive). The player must roll a six-sided die. To win, the player must roll a number greater than the target number. At the end of each round, the player should be asked if they would like to play again, and the game should continue or terminate accordingly.

In this challenge, you're given some starting code. You must determine what methods to create, their parameters, and their return types.

## Code challenge: add methods to make the game playable

In the code that you start with, there are two unavailable methods referenced:

`ShouldPlay`: This method should retrieve user input and determine if the user wants to play again
`WinOrLose`: This method should determine if the player has won or lost

There are also two uninitialized variables:

`target`: The random target number between 1 and 5
`roll`: The result of a random six-sided die roll

Your challenge is to create the `ShouldPlay` and `WinOrLose` methods, and create methods that set `target` and `roll` to random values in the correct range. When all the methods are complete, the game should run successfully.

1. Ensure that you have an empty Program.cs file open in Visual Studio Code.

    If necessary, open Visual Studio Code, and then complete the following steps to prepare a Program.cs file in the Editor:

    1. On the **File** menu, select **Open Folder**.

    1. Use the Open Folder dialog to navigate to, and then open, the **CsharpProjects** folder.

    1. In the Visual Studio Code EXPLORER panel, select **Program.cs**.

    1. On the Visual Studio Code **Selection** menu, select **Select All**, and then press the Delete key.

1. Copy and paste the following code into the Editor panel.

    ```c#
    Random random = new Random();

    Console.WriteLine("Would you like to play? (Y/N)");
    if (ShouldPlay()) 
    {
        PlayGame();
    }

    void PlayGame() 
    {
        var play = true;

        while (play) 
        {
            var target;
            var roll;

            Console.WriteLine($"Roll a number greater than {target} to win!");
            Console.WriteLine($"You rolled a {roll}");
            Console.WriteLine(WinOrLose());
            Console.WriteLine("\nPlay again? (Y/N)");

            play = ShouldPlay();
        }
    }
    ```

1. Update the code to use methods to make the game run according to the challenge specifications.

    Use what you've learned about return values and parameters to complete the update.

1. Verify that your game is working

    Your code should produce output similar to the following:

    ```Output
    Would you like to play? (Y/N)
    Y
    Roll a number greater than 1 to win!
    You rolled a 2
    You win!

    Play again? (Y/N)
    Y
    Roll a number greater than 4 to win!
    You rolled a 6
    You win!

    Play again? (Y/N)
    Y
    Roll a number greater than 1 to win!
    You rolled a 1
    You lose!

    Play again? (Y/N)
    N
    ```

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
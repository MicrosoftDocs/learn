


You'll be using Visual Studio Code to develop a small mini-game. Your application should establish the basics of the game, including updating player state, manipulating player movement, and consuming and regenerating a food object. You'll develop each of those features and run a simplified game test.

## Project specification

The Starter code project for this module includes a Program.cs file with the following code features:

```Output
- The code declares the following variables:
    - Variables to determine the size of the Terminal window.
    - Variables to track the locations of the player and food.
    - Arrays `states` and `foods` to provide available player and food appearances
    - Variables to track the current player and food appearance

- The code provides the following methods:
    - A method to determine if the Terminal window was resized.
    - A method to display a random food appearance at a random location.
    - A method that changes the player appearance to match the food consumed.
    - A method that temporarily freezes the player movement.
    - A method that moves the player according to directional input.
    - A method that sets up the initial game state.

- The code doesn't call the methods correctly to make the game playable. The following features are missing:
    - Code to determine if the player has consumed the food displayed.
    - Code to determine if the food consumed should freeze player movement.
    - Code to determine if the food consumed should increase player movement.
    - Code to increase movement speed.
    - Code to redisplay the food after it's consumed by the player.
    - Code to terminate execution if an unsupported key is entered.
    - Code to terminate execution if the terminal was resized.
```

Your goal in this challenge is to use the existing features and create the missing features to make the game playable.

## Setup

Use the following steps to prepare for the Challenge project exercises:

1. To download a zip file containing the Starter project code, select the following link: [Lab Files](https://github.com/MicrosoftLearning/Challenge-project-Create-methods-in-CSharp/archive/refs/heads/main.zip).

1. Unzip the download files.

    Unzip the files in your development environment. Consider using your PC as your development environment so that you have access to your code after completing this module. If you aren't using your PC as your development environment, you can unzip the files in a sandbox or hosted environment.

    1. On your local machine, navigate to your downloads folder.
    1. Right-click **Challenge-project-Create-methods-in-CSharp.main.zip**, and then select **Extract all**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Copy the extracted **ChallengeProject** folder to your Windows Desktop folder.

    > [!NOTE]
    > If a folder named **ChallengeProject** already exists, you can select **Replace the files in the destination** to complete the copy operation.

1. Open the new **ChallengeProject** folder in Visual Studio Code.

    1. Open Visual Studio Code in your development environment.
    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.
    1. Navigate to the Windows Desktop folder and locate the "ChallengeProject" folder.
    1. Select **ChallengeProject** and then select **Select Folder**.

        The Visual Studio Code EXPLORER view should show the **ChallengeProject** folder and two subfolders named **Final** and **Starter**.

You're now ready to begin the Challenge project exercises. Good luck!

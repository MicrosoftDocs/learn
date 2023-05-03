


Your goal is to develop a mini-game application. Currently, your mini-game has some basic gameplay capabilities! It terminates correctly, detects when the player consumes food, changes the player appearance, and displays more food. Now you want the food the player consumes to affect the player's ability to move.

## Specification

In this challenge exercise, you need to create a method that determines if the player has consumed the food that affects their movement. When the player consumes the food string with value `#####`, the appearance is updated to `(X_X)`. You'll add a feature to detect if the player appearance is `(X_X)`, and if so, temporarily prevent the player from moving.

You also want to add an optional feature that detects if the player appearance is `(^-^)` and if so, increase or decrease the right and left movement speeds by a value of `3` while that appearance is active. When the player state is `('-')`, you want the speed to return to normal. You want to make this feature optional since consuming food in this state requires more collision detection than you want to develop for now.

### Check if the player should freeze

- Create a method that checks if the current player appearance is `(X_X)` 
- The method should return a value
- Before allowing the user to move the character, call your method to determine the following:
    - Whether or not to use the existing method that freezes character movement
- Make sure the character is only frozen temporarily and the player can still move afterwards

### Add an option to increase player speed

- Modify the existing `Move` method to support an optional movement speed parameter
- Use the parameter to increase or decrease right and left movement speed by `3`
- Create a method that checks if the current player appearance is `(^-^)` 
- The method should return a value
- Call your method to determine if `Move` should use the movement speed parameter

## Check your work

To validate that your code satisfies the specified requirements, complete the following steps:

1. Enable the optional parameters.

1. Use Visual Studio Code to build and run your app.

    > [!NOTE]
    > You can exit the verification test before completing all of the verification steps if see a result that does not satisfy the specification requirements. To force an exit from the running program, in the Terminal panel, press **Ctrl-C**. After exiting the running app, complete the edits that you believe will address the issue you are working on, save your updates to the Program.cs file, and then re-build and run your code.

1. At the Terminal command prompt, press directional keys to move the player.

1. Move the player across the displayed food string.

1. Verify that a new food string is displayed.

1. Verify that the player appearance changes depending on which food string was consumed.

1. Verify that movement is temporarily stopped when the player appearance is `(X_X)`.

1. Verify that left and right movement is faster in the correct directions when the player appearance is `(^-^)`.

1. Press a nondirectional key to terminate the program.

1. Disable the optional movement speed parameter and rerun the app.

1. Verify that movement is normal when the player appearance is `(^-^)`.

Congratulations if you succeeded in this challenge!
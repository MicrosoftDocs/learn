


Your goal is to develop a mini-game application. You need the game to end if the user resized the Console window the game is running in. You also want to add an option for the game to end if the user enters any nondirectional character.

## Specification

In this challenge exercise, you need to update the existing code to support an option to terminate the gameplay if a nondirectional character is entered. You also want to terminate the game if the terminal window was resized. You need to locate the correct methods for your code to use.

### Terminate on resize

This feature must:

- Determine if the terminal was resized before allowing the game to continue
- Clear the Console and end the game if the terminal was resized
- Display the following message before ending the program:
    `Console was resized. Program exiting.`

### Add optional termination 

- Modify the existing `Move` method to support an optional parameter
- If enabled, the optional parameter should detect nondirectional key input
- If nondirectional input is detected, allow the game to terminate

## Check your work

To validate that your code satisfies the specified requirements, complete the following steps:

1. Enable the optional parameter.

1. Use Visual Studio Code to build and run your app.

    > [!NOTE]
    > You can exit the verification test before completing all of the verification steps if see a result that does not satisfy the specification requirements. To force an exit from the running program, in the Terminal panel, press **Ctrl-C**. After exiting the running app, complete the edits that you believe will address the issue you are working on, save your updates to the Program.cs file, and then re-build and run your code.

1. At the Terminal command prompt, resize the window. 

1. Enter a directional key.

1. Verify that the program ends after displaying the following message:

    ```Output
    Console was resized. Program exiting.
    ```

1. Run the app again.

1. At the Terminal command prompt, press directional keys to move the player.

1. Press a nondirectional key.

1. Verify that the program ends.

1. Disable the optional parameter, then build and run the app.

1. At the Terminal command prompt, press directional keys to move the player.

1. Press a nondirectional key.

1. Verify that the program continues.

1. Resize the Terminal window.

1. Verify that the program ends.

Once you've validated the results for this exercise, proceed to the next exercise in this challenge.
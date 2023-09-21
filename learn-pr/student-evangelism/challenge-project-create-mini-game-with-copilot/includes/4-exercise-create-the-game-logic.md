


With Codespaces configured, your goal is to develop the Python console minigame. You need to create the game logic following the specifications and use GitHub Copilot to help create the methods.

## Specification

- **Game rules:**
    - Rock beats scissors (breaking it).
    - Scissors beat paper (cutting it).
    - Paper beat rock (wrapping it).
    - The minigame is multiplayer and the computer plays the role of your opponent and chooses a random element from the list of elements

- **Interaction with the player:**
    - The console is used to interact with the player. 
    - The player can choose one of the three options: `rock`, `paper`, or `scissors`. 
    - The player can choose whether to play again.
    - The player should be warned if they enter an invalid option. 
    - The player is shown their score at the end of the game.

- **Validation of user input:**
    - At each round, the player must enter one of the options in the list and be informed if they won, lost, or tied with the opponent.
    - The minigame must handle user inputs, putting them in lowercase and informing the user if the option is invalid.
    - By the end of each round, the player must answer whether they want to play again or not.

Using Visual Studio Code in your browser and GitHub Copilot to assist you, create a minigame that meets the above specifications.

## Check your work

1. Run the minigame on the console with the `python app.py` command.
1. At the prompt, type one of the game options: `rock`, `paper`, or `scissors`.
1. The minigame should inform the player whether the player won, lost, or tied with the opponent.
1. Choose to continue playing.
1. At the prompt, type `screen`.
1. The minigame should inform the player if the option entered by the player is invalid.
1. Repeat steps 2 and 4 to play a few rounds and choose not to continue playing.
1. Check if the minigame is terminated and if it displays your score, informing you of the number of wins and rounds.

Congratulations on completing this challenge exercise! You've created a Python console minigame using GitHub Copilot.

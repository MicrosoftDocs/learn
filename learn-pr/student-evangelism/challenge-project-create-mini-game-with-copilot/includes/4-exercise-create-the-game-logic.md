You already have your Codespaces working with GitHub Copilot. In this challenge exercise, your goal is to develop the logic of the Python minigame with the help of GitHub Copilot based in the specifications bellow.

## Specification

As we learned in the introduction to this challenge, the winner of the game is determined by three simple rules:

- `Rock` beats scissors.
- `Scissors` beat paper.
- `Paper` beats rock.

### What you should consider in the game interactions

Let's add some more excitement to this challenge and make the game multiplayer, where the computer will be your opponent and can randomly choose one of the elements (`rock`, `paper`, or `scissors`) for each move, just like you. Your interaction in the game will be through the console (Terminal).

- The player can choose one of the three options `rock`, `paper`, or `scissors` and should be warned if they enter an invalid option.
- At each round, the player must enter one of the options in the list and be informed if they won, lost, or tied with the opponent.
- By the end of each round, the player can choose whether to play again.
- Display the player's score at the end of the game.
- The minigame must handle user inputs, putting them in lowercase and informing the user if the option is invalid.

In your GitHub Codespaces, use the provided specifications to create prompts that can be utilized by GitHub Copilot to assist you in developing the minigame. Remember, GitHub Copilot uses comments to understand context and provide accurate suggestions during development.

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

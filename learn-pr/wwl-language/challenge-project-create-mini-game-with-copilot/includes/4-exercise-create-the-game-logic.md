


With Codespaces configured, your goal is to develop the Python console minigame. You need to create the game logic following the specifications and use GitHub Copilot to help create the methods.

## Specification

In this challenge exercise, you need to define the elements of the minigame, create the repetition structure to allow the user to play several times, create the decision logic to determine the winner, and display the result.

### Game rules

The winner of the game is determined based in three simple rules:

- Rock beats scissors (breaking it).
- Scissors beat paper (cutting it).
- Paper beat rock (wrapping it).

### Interaction with the player

The console is used to interact with the player. The player can choose one of the three options: `rock`, `paper, or `scissors`. The player can also choose whether to play again or not, be warned if they enter an invalid option, and know their score at the end of the game.

### Definitions for the game

- Import the random module to use the `choice` function, which plays the role of our opponent.
- Create a list called `options` with the game options: `rock`, `paper` and `scissors`
- Create the variables:
    - `rounds_played` to store the number of rounds
    - `score` to store player wins
- Use `while` to create a repetition structure that allows the user to play several times.
- Create a variable called `random_choice` to store the opponent player's option, using the `choice` function of the `random` module.

### Validation of user input

- At each round, the player must enter one of the options in the list and be informed if they won, lost, or tied with the opponent.
- The minigame must handle user inputs, putting them in lowercase and informing the user if the option is invalid.
- By the end of each round, the player must answer whether they want to play again or not.

## Check your work

1. Run the minigame on the console with the `python app.py` command.
2. At the prompt, type one of the game options: `rock`, `paper, or `scissors.
3. The minigame should inform the player whether the player won, lost, or tied with the opponent.
4. Choose to continue playing.
5. At the prompt, type `screen.
5. The minigame should inform the player if the option entered by the player is invalid.
6. Repeat steps 2 and 4 to play a few rounds and choose not to continue playing.
7. Check if the minigame is terminated and if it displays your score, informing you of the number of wins and rounds.

Congratulations if you did well in this challenge exercise! You've created a Python console minigame using GitHub Copilot.

## Next steps

To continue learning, you can explore new Python learning resources on Microsoft Learn:

- [Build real world applications with Python](https://docs.microsoft.com/learn/paths/python-language/)
- [Host a web application with Azure App Service](https://docs.microsoft.com/learn/paths/host-a-web-application-with-azure-app-service/)
- [Build a machine learning model with Python](https://docs.microsoft.com/learn/paths/build-python-machine-learning-model-fundamentals/)

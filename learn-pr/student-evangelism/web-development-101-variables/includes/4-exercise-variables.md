As a newly hired game developer, you've been tasked with building recreational games for the web. Your first assignment is to start working on the card game "Texas Hold'em". You work in an ethical game company, however, so instead of betting money, you will use points to represent poker chips.

## Model the game state

You need to take what you know of Texas Hold'em and create variables to store card values. In doing so, you need to think about _starter values_ and values that will change over time.

You know that, at the core, Texas Hold'em features players, starter cards, and points. Try to scaffold a basic game structure using variables.

1. Create a file _app.js_

   ```bash
   touch app.js
   code .
   ```

   You should now have an editor open in the shell

1. Add the following code to the file:

   ```javascript
   let startingPokerChips = 100; // points
   let players = 3;
   let noOfStarterCards = 2;
   ```

   You now have three variables representing the initial state of the game.

1. Next, you will create variables that represent specific players. Add the following code:

   ```javascript
   let playerOnePoints = startingPokerChips;
   let playerTwoPoints = startingPokerChips;
   let playerThreePoints = startingPokerChips;
   ```

   You have created three players' starting points by assigning them the value of the variable `startingPokerChips`, which holds the value 100.

1. Now, show a specific game round and how a game state can be represented by an assignment. Add the following lines to the code:

   ```javascript
   playerOnePoints -= 50;
   playerTwoPoints -=25;
   playerThreePoints +=75; 
   ```

You have successfully simulated a game round in which the first and second player bet 50 and 25 points respectively. Because the third player has a better hand, they end up winning the game round and points are therefore taken from the first and second player and added to the pot of the third player.

## Refactor to constants

At this point, you have some variables that represent parts of your card game. Remember that you have constants available, which are variables that shouldn't change their value. Let's see what variables might lend themselves to be better represented as constants in your source code.

> [!TIP]
> Before you move on and see the solution, spend 1-2 minutes to think about what variables shouldn't change and what variables might having changing values. Then scroll down to see the solution.

1. At the top of the file, change the following code:

   ```javascript
   let startingPokerChips = 100; // points
   let players = 3;
   let noOfStarterCards = 2;
   ```

   to this code:

   ```javascript
   const STARTING_POKER_CHIPS = 100; // points
   const PLAYERS = 3;
   const NO_OF_STARTER_CARDS = 2;
   ```

   You've successfully identified which variables are important for the game. They also describe how the game is played. A player's starting poker chips will not change even if a specific player's pot might change as they play. The number of players is something that is also constant, unless you imagine that you could rebuild the game such that a player can join at any time. The number of starter cards is always 2 in Texas Hold'em. As the game developer, you have the power to decide ultimately what should be changeable and what should be constant.

   > [!TIP]
   > A great way to think about variables is to make all variables constant to begin with. Then, decide if a variable's value will need to change in the future. In that case, change it from `const` to `let`.  

1. Make sure to change dependent code as well, so the code still compiles:

   ```javascript
   let playerOnePoints = STARTING_POKER_CHIPS;
   let playerTwoPoints = STARTING_POKER_CHIPS;
   let playerThreePoints = STARTING_POKER_CHIPS;
   ```

Congratulations, you've managed to start working on a JavaScript code base meant to implement Texas Hold'em. In doing so, you've reasoned about what are starter values, what are values that can change, and how to change them.

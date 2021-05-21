As a newly hired game developer, you've been tasked with building recreational games for the Web. Your first assignment is start working on the card game Texas Holdem. You are an ethical game company though so instead of betting money, you will use points to represent poker chips.

## Model the game state

You need to take what you know of Texas Holdem and create variables. In doing so, you need to think about _starter values_ and values that will change over time.

You know the following information on how Texas Holdem works, it can have players, starter cards, points (you are using that over many). There is more to know of Texas Holdem works than we discussed so far, but you need to start somewhere.

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

   You now have three variables, representing the initial state of the game. 

1. Next, you will create variables that represent specific players. Add the following code:

   ```javascript
   let playerOnePoints = startingPokerChips;
   let playerTwoPoints = startingPokerChips;
   let playerThreePoints = startingPokerChips;
   ```

   What you have done is to create three players starting points by assigning them the value of the variable `startingPokerChips`, which holds the value 100.

1. Finally let's show a specific game round and how a game state can be represented by an assignment. Add the following lines to the code:

   ```javascript
   playerOnePoints -= 50;
   playerTwoPoints -=25;
   playerThreePoints +=75; 
   ```
 
   What you have done right now is to simulate a game round in which the first and second player bet 50 and 25 points respectively. Because the third player has a better hand, they end up winning the game round and points are therefore taken from the first and second player and added to the pot of the third player.

## Refactor to constants

At this point, you have some variables that represent parts of your Texas holdem game. Remember how you were taught a concept like constants, variables that shouldn't change its value. Let's see what variables might lend themselves to be better represented as constants in your source code.

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

   What you've done is to identify which variables are important for the game and describes how the game is played. A player's starting poker chips isn't going to change even if a specific players pot might change as they play. The number of players is something that is constant too, unless you imagine you rebuild the game in such a way that a player can join at any time. The number of starter cards is always 2 in Texas Holdem, that's the rules. The great part of all this is that you decide ultimately what should be changeable and what should be constant.

   > [!TIP]
   > A great way to reason about variables is to make all variables constant to begin with and reason with yourself if a variable needs changing. In that case change it from `const` to `let`.  

1. Make sure to change dependent code as well, so the code still compiles:

   ```javascript
   let playerOnePoints = STARTING_POKER_CHIPS;
   let playerTwoPoints = STARTING_POKER_CHIPS;
   let playerThreePoints = STARTING_POKER_CHIPS;
   ```

Congrats, you've managed to start working on a JavaScript code base meant to implement Texas Holdem. In doing so, you've reasoned about what are starter values, what are values that can change and how to change them.
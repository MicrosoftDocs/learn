As a newly hired game developer, you've been tasked with building recreational games for the web. Your first assignment is to start working on the card game Texas Hold'em. Instead of having players bet money, you'll use points to represent poker chips.

## Model the game state

You need to take what you know of Texas Hold'em and create variables to store card values. In doing so, you need to think about _starter values_ and values that will change over time.

You know that Texas Hold'em features players, starter cards, and points. Try to scaffold a basic game structure by using variables.

1. Create a file named _app.js_:

   ```bash
   touch app.js
   code .
   ```

   You should now have an editor open in the shell.

1. Add the following code to the file:

   ```javascript
   let startingPokerChips = 100; // points
   let players = 3;
   let noOfStarterCards = 2;
   ```

   You now have three variables to represent the initial state of the game.

1. Create variables that represent specific players. Add the following code:

   ```javascript
   let playerOnePoints = startingPokerChips;
   let playerTwoPoints = startingPokerChips;
   let playerThreePoints = startingPokerChips;
   ```

   You have created three players' starting points by assigning them the variable `startingPokerChips`, which holds the value `100`.

1. Show a specific game round and how an assignment can represent a game state. Add the following lines to the code:

   ```javascript
   playerOnePoints -= 50;
   playerTwoPoints -=25;
   playerThreePoints +=75; 
   ```

You have successfully simulated a game round in which the first and second player bet 50 and 25 points, respectively. Because the third player has a better hand, they end up winning the game round. The game takes points from the first and second player and adds them to the pot of the third player.

## Refactor to constants

At this point, you have some variables that represent parts of your card game. Remember that you have constants available, which are variables that shouldn't change their value. Let's see what variables might lend themselves to be better represented as constants in your source code.

> [!TIP]
> Spend 1 to 2 minutes thinking about what variables shouldn't change and what variables might have changing values. Then scroll down to see the solution.

1. At the top of the file, change the following code:

   ```javascript
   let startingPokerChips = 100; // points
   let players = 3;
   let noOfStarterCards = 2;
   ```

   ...to this code:

   ```javascript
   const STARTING_POKER_CHIPS = 100; // points
   const PLAYERS = 3;
   const NO_OF_STARTER_CARDS = 2;
   ```

   You've successfully identified which variables are important for the game. They also describe how the game is played. A player's starting poker chips will not change, even if a specific player's pot might change as they play. The number of players is also constant, unless you imagine that you might rebuild the game such that a player can join at any time. The number of starter cards is always two in Texas Hold'em. As the game developer, you have the power to decide ultimately what should be changeable and what should be constant.

   > [!TIP]
   > A great way to think about variables is to make all variables constant to begin with. Then, decide if a variable's value will need to change in the future. In that case, change it from `const` to `let`.  

1. Be sure to change dependent code, so the code still compiles:

   ```javascript
   let playerOnePoints = STARTING_POKER_CHIPS;
   let playerTwoPoints = STARTING_POKER_CHIPS;
   let playerThreePoints = STARTING_POKER_CHIPS;
   ```

Congratulations! You've started working on a JavaScript code base that implements Texas Hold'em. In doing so, you've reasoned through what are starter values, what values can change, and how to change values.

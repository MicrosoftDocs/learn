Your company is pleased with your earlier modeling of Texas Hold'em and wants to see you continue to work on its implementation. You've now learned more about data types, so let's put that knowledge to use.

## Add data types

Let's start by revising the following code you've built so far:

```javascript
const STARTING_POKER_CHIPS = 100; // points
const PLAYERS = 3;
const NO_OF_STARTER_CARDS = 2;

let playerOnePoints = STARTING_POKER_CHIPS;
let playerTwoPoints = STARTING_POKER_CHIPS;
let playerThreePoints = STARTING_POKER_CHIPS;

playerOnePoints -= 50;
playerTwoPoints -=25;
playerThreePoints +=75; 
```

You have certain aspects of the game represented as variables, but you're lacking some aspects, such as knowing if the game has ended. Also, wouldn't it be nice if the players had names?

1. After the three constants, add the following code:

   ```javascript
   let playerOneName = "Chloe";
   let playerTwoName = "Jasmine";
   let playerThreeName = "Jen";
   ```

1. Now you have three variables to represent the names of the players. Let's add some intro text so it feels more like a game. After the following code:

   ```javascript
   let playerOnePoints = STARTING_POKER_CHIPS;
   let playerTwoPoints = STARTING_POKER_CHIPS;
   let playerThreePoints = STARTING_POKER_CHIPS;
   ```

   ...add code to represent the game starting:

   ```javascript
   console.log(`Welcome to Texas Hold'em. The championship title will be awarded to one of these three players: ${playerOneName}, ${playerTwoName} and ${playerThreeName}. Each player has ${STARTING_POKER_CHIPS} in their pot. We have an exciting game ahead of us. May the best player win!`)
   ```

## Add an end condition

A game of Texas Hold'em can go on for many game rounds and usually finishes when one player has all the poker chips and the other players have lost theirs. You need to add code to represent such a state. This situation is where you want to rely on operators and use a Boolean data type.

1. Add the following code at the top of the file:

   ```javascript
   let gameHasEnded = false;
   ```

   Now you have a variable to represent the end of the game. Moving forward, you need to find a way to reevaluate the value of this variable and determine whether to stop the game and award a champion.

1. Add the following code to evaluate the game state:

   ```javascript
   gameHasEnded = ((playerOnePoints + playerTwoPoints) == 0) || // three has won
                  ((playerTwoPoints + playerThreePoints) == 0) ||  // one has won
                  ((playerOnePoints + playerThreePoints) == 0);  // two has won 
   console.log("Game has ended: ", gameHasEnded);
   ```

   The full code should look like this:

   ```javascript
   const STARTING_POKER_CHIPS = 100; // points
   const PLAYERS = 3;
   const NO_OF_STARTER_CARDS = 2;
   let gameHasEnded = false;

   let playerOneName = "Chloe";
   let playerTwoName = "Jasmine";
   let playerThreeName = "Jen";

   console.log(`Welcome to Texas Hold'em. The championship title will be awarded to one of these three players: ${playerOneName}, ${playerTwoName}, and ${playerThreeName}. Each player has ${STARTING_POKER_CHIPS} in their pot. We have an exciting game ahead of us. May the best player win!`);

   let playerOnePoints = STARTING_POKER_CHIPS;
   let playerTwoPoints = STARTING_POKER_CHIPS;
   let playerThreePoints = STARTING_POKER_CHIPS;

   playerOnePoints -= 50;
   playerTwoPoints -=25;
   playerThreePoints +=75; 

   gameHasEnded = ((playerOnePoints + playerTwoPoints) == 0) || // three has one
                  ((playerTwoPoints + playerThreePoints) == 0) ||  // one has won
                  ((playerOnePoints + playerThreePoints) == 0);  // two has won 

   console.log("Game has ended: ", gameHasEnded);
   ```

1. To run the game, enter the following code in the terminal:

   ```javascript
   node app.js
   ```

   You should see the following output in the terminal:

   ```output
   Welcome to Texas Hold'em. The championship title will be awarded to one of these three players: Chloe, Jasmine, and Jen. Each player has 100 in their pot. We have an exciting game ahead of us. May the best player win!
   Game has ended: false
   ```

> [!TIP]
> Try changing `playerOnePoints` and `playerTwoPoints` to `0` and rerun the app. Is there a difference in the output?

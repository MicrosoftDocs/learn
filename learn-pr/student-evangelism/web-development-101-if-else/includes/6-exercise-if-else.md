As a junior game developer of recreational games, you've been asked to start the development of a Blackjack game. Blackjack has some interesting rules on how to calculate points. You realize this game is a great opportunity to apply some Boolean logic you've learned.

## Calculate a card hand

In Blackjack, the goal of the game is to win over the bank. You win by holding a score higher than the bank but less than or equal to 21.

1. Use the Azure Cloud Shell to create a file.

   ```bash
   touch app.js
   code .
   ```

1. Press <kbd>Ctrl</kbd> + <kbd>S</kbd> to save the file. Name the file *blackjack.js*.

1. Give it the following starter code:

   ```javascript
   let cardOne = 7;
   let cardTwo = 5;
   let sum = cardOne + cardTwo; // 15
   ```

   Next, you'll add code that simulates taking one more card. Let's see what happens.

1. Add the following code:

   ```javascript
   let cardThree = 7;
   sum += cardThree;
   if (sum > 21) {
     console.log('You lost');
     process.exit(1); // exit program
   }
   console.log(`You have ${sum} points`);
   ```

1. Save your changes, press <kbd>Ctrl</kbd> + <kbd>Q</kbd> to close the file, and then run the code.

   ```bash
   node blackjack.js
   ```

   You see the following output:

   ```output
   You have 19 points
   ```

## Add an opponent

Your opponent is the bank. Remember the rules. You win if you have a better score than the bank, or if the bank has over 21. Let's implement those rules.

1. Open the *blackjack.js* file.

    ```bash
    code blackjack.js
    ```

1. Add the following variables to represent the banks cards.

   ```javascript
   let cardOneBank = 7;
   let cardTwoBank = 5;
   let cardThreeBank = 6;
   let cardFourBank = 4;
   ```

1. Next, add the following code to the end of the file.

   ```java
   let bankSum = cardOneBank + cardTwoBank + cardThreeBank + cardFourBank;
   if (bankSum > 21 || (sum <= 21 && sum > bankSum)) {
    console.log('You win');
   } else {
     console.log('Bank wins');
   }
   ```

1. Save and close the file, and then run the code.

   ```bash
   node blackjack.js
   ```

   You see the following output:

   ```output
   You have 19 points
   You win
   ```

Congratulations! You've successfully implemented some of the game rules from Blackjack by using Boolean logic and operators.

Here's the full code.

```javascript
let cardOne = 7;
let cardTwo = 5;
let sum = cardOne + cardTwo; // 15
let cardOneBank = 7;
let cardTwoBank = 5;
let cardThreeBank = 6;
let cardFourBank = 4;

let cardThree = 7;
sum += cardThree;
if (sum > 21) {
  console.log('You lost');
}
console.log(`You have ${sum} points`);

let bankSum = cardOneBank + cardTwoBank + cardThreeBank + cardFourBank;

if (bankSum > 21 || (sum <= 21 && sum > bankSum)) {
  console.log('You win');
  process.exit(1); // exit program
} else {
  console.log('Bank wins');
}
```

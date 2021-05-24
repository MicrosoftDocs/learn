As a junior game developer of recreational games you've been asked to start the development of a Black Jack game. Black Jack has some interesting rules on how to calculate points and you realize this is a great opportunity to apply some boolean logic you've learned.

## Calculate a card hand

In Black Jack, the goal of the game is to win over the bank. You win by holding a score higher than the bank but less than or equal to 21.

1. Create a file _blackjack.js_ and give it the following starter code:

   ```javascript
   let cardOne = 7;
   let cardTwo = 5;
   let sum = cardOne + cardTwo; // 15
   ```

   Next, you will add code simulating taking one more card, let's see what happens:

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

1. Run the code:

   ```javascript
   node blackjack.js
   ``` 

   You see the following output:

   ```output
   You have 19 points
   ```

## Adding an opponent

Your opponent is the bank. Remember the rules, you win if you have better score than the bank or if the bank has over 21. Let's implement those rules.

1. Add the following variables to represent the banks cards:

   ```javascript
   let cardOneBank = 7;
   let cardTwoBank = 5;
   let cardThreeBank = 6;
   let cardFourBank = 4;
   ```

1. Next, add add the following code to the end of the file:

   ```java
   let bankSum = cardOneBank + cardTwoBank + cardThreeBank + cardFourBank;
   if (bankSum > 21 || (sum <= 21 && sum > bankSum)) {
    console.log('You win');
   } else {
     console.log('Bank wins');
   }
   ```

1. Run the code:

   ```javascript
   node blackjack.js
   ```

   You see the output:

   ```output
   You have 19 points
   You win
   ```

Congrats, you've successfully implemented some of the game rules from Black Jack using boolean logic and operators.

Here's the full code:

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
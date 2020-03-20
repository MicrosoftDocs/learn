Expand the previous challenge to include additional features like hints (too low, too high) and feedback (enter numbers only).

### Step 1: Add a new code file to your working directory

Assuming you're continuing from the previous unit, use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module. For example, you might create a file named `challenge2.py`.

### Step 2: Write the code to implement an improved number guessing game

Rebuild the number guessing game, but this time:

- Display the current guess number.
- If the guess is too low, tell the user "Your guess is too low, try again!"
- If the guess is too high, tell the user "Your guess is too high, try again!"
- If the user enters a nonnumeric value, tell the user "Numbers only, please!"

Also, take note of the output. The prompts and messages have changed when compared to the original challenge.

No matter how you do it, your code should produce the following output (given the randomly generated answer and the guesses):

```output
Guess a number between 1 and 10
Enter guess #1: 5
Your guess is too low, try again!
Enter guess #2: 8
Your guess is too high, try again!
Enter guess #3: 7
Your guess is too high, try again!
Enter guess #4: 6
You guessed it in 4 tries!
```

If the user types in a value that isn't numeric, display an error message. In the following example output, the user enters a few strings and is reminded to only enter numbers:

```output
Guess a number between 1 and 10
Enter guess #1: Bob
Numbers only, please!
Enter guess #2: Beth
Numbers only, please!
Enter guess #3: 5
You guessed it in 3 tries!
```

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
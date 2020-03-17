Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

### Step 1: Add a new code file to your working directory.

Assuming you're continuing from the previous unit, use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module.  For example, you might create a file named `challenge1.py`.

### Step 2: Write the code to implement a number guessing game.

Using the techniques we learned in this module, generate a random number between 1 and 5 and allow the end user to guess.  Keep prompting the user for their guess until they guess correctly.  Then, display the number of guesses.

No matter how you do it, your code should produce similar results to the following output (given the randomly generated answer and guesses):

```output
Guess a number between 1 and 5: 3
Guess a number between 1 and 5: 4
You guessed it in 2 tries!
```

If the user doesn't enter a numeric value, there's no need to notify the user of their error.  Just keep counting each entry as a guess.  In the following example output, the end user enters strings that cannot be converted to numbers, but the program keeps running and keeps tallying the number of guesses.

```output
Guess a number between 1 and 5: Beth
Guess a number between 1 and 5: Charlee
Guess a number between 1 and 5: 3
Guess a number between 1 and 5: 4
Guess a number between 1 and 5: 2
You guessed it in 5 tries!
```

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
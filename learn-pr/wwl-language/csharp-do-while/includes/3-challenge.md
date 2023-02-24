Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

## Role playing game battle challenge

In most role playing games, the player's character battles non-player characters, which are usually monsters or the "bad guys." Usually, a battle consists of each character generating a random value using dice, and that value is subtracted from the opponent's health score. Once either character's health reaches zero, they die or lose.

In this challenge, we'll boil down that interaction to its essence. A hero and a monster start with the same health score. During the hero's turn, they'll generate a random value that will be subtracted from the monster's health. If the monster's health is greater than zero, they'll take their turn and attack the hero. As long as both the hero and the monster have health greater than zero, the battle will resume.

### Step 1 - Delete all of the code in the .NET Editor from the earlier exercise

Select all of the code in the .NET Editor, then select the <kbd>Del</kbd> or <kbd>Backspace</kbd> key to delete it.

### Step 2 - Write code in the .NET Editor to implement the game rules

Implement the following rules for the game:

**Game Rules**

- The hero and the monster will start with 10 health points
- All attacks will be a value between 1 and 10
- The hero will attack first
- Print the amount of health the monster lost and their remaining health
- If the monster's health is greater than 0, it can attack the hero
- Print the amount of health the hero lost and their remaining health
- Continue this sequence of attacking until either the monster's health or hero's health is zero or less
- Print the winner

**Most importantly:**

- You must use either the `do-while` statement, or the `while` statement.

No matter how you do it, your code should produce output similar to the following:

```output
Monster was damaged and lost 1 health and now has 9 health.
Hero was damaged and lost 1 health and now has 9 health.
Monster was damaged and lost 7 health and now has 2 health.
Hero was damaged and lost 6 health and now has 3 health.
Monster was damaged and lost 9 health and now has -7 health.
Hero wins!
```

Obviously, because of the random nature of the code, the outcome will be different each time, so your results will definitely be different that the output displayed here. However, you can use this as an example of the output your code should generate.

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.

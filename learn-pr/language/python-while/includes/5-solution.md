The following code is one possible solution for the challenge from the previous unit.

```python
import random

value = random.randint(1, 5)
count = 0
guess = 0
while guess != value:
    count += 1
    guess = input('Guess a number between 1 and 5: ')
    if guess.isnumeric():
        guess = int(guess)
else:
    print(f'You guessed it in {count} tries!')
```

This code is only *one possible solution*. If your solution produces the same result as the challenge by using the `while` statement, you were successful.

> [!IMPORTANT]
> A couple of learners have reported that the `else` should be indented so that it pairs correctly with the `if` statement. In this code example, we actually want `else` to pair with the `while` statement. We only want this code to execute after the learner guesses the value correctly. Review unit 2, step 3 for a refresher about how to use `else` and `break` with your `while` statement.

Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble finishing this challenge, maybe you should review the previous units before you continue on. All new ideas we describe in other modules will depend on your understanding of the ideas that were presented in this module.

The following code is one possible solution for the challenge from the previous unit.

```python
import random

value = random.randint(1, 10)
count = 0
guess = 0
print('Guess a number between 1 and 10')

while guess != value:
    count += 1
    guess = input(f'Enter guess #{count}: ')

    if guess.isnumeric():
        guess = int(guess)
    else:
        print('Numbers only, please!')
        continue

    if guess > value:
        print('Your guess is too high, try again!')
    elif guess < value:
        print('Your guess is too low, try again!')

else:
    print(f'You guessed it in {count} tries!')
```

This code is only *one possible solution*. You should have used the `while` statement to loop through the game logic, and used the `continue` statement to handle the case where the user doesn't enter a numeric value.

Also, you should have kept track and displayed the current guess. You should have provided helpful hints like "too high" and "too low" when the user guessed incorrectly.

```output
Guess a number between 1 and 10
Enter guess #1: 5
Your guess is too high, try again!
Enter guess #2: 3
Your guess is too high, try again!
Enter guess #3: bob
Numbers only, please!
Enter guess #4: 2
You guessed it in 4 tries!
```

If you were successful, congratulations! Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble finishing this challenge, maybe you should review the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.

In this exercise, we'll use the `while` statement to build a small game that will keep looping over a code block with the game logic required to generate and evaluate a random value.

### Step 1: Create a new working folder and Python code file

Using the techniques you learned in previous modules, create a new folder for your work in this module. For example, you might create a folder named `python-while`.

Inside that folder, create a file for this exercise. For example, you might create a file named `exercise1.py`.

When it's time to run your code in the steps of the exercises, you can use the Python Tools for Visual Studio Code integration by selecting the green arrow. Or you can use a command in the integrated terminal by using techniques you learned about in previous modules.

### Step 2: Add code to loop through a code block by using the while statement

Add the following code listing to your new file:

```python
import random 

roll = 0
count = 0

while roll != 5:
  count = count + 1
  roll = random.randint(1, 5)
  print(roll)

print(f'It took {count} rolls to roll a 5!')
```

The `while` statement has three parts:
- The `while` keyword
- A Boolean expression
- An end-of-statement colon symbol `:`

Also important is the code block beneath the `while` statement. We've looked at code blocks in other modules. This code block belongs to the while statement and will continue to be repeatedly executed until the Boolean expression evaluates to `False`.

In this case, we use the `random` module's `randint()` function to generate a random number between 1 and 5. We use the `roll` variable to hold the current value of the randomly generated number. We use the `count` variable to keep track of how many times we've called the `randint()` function.

Each time we run the code block, the value of `roll` is set to a new random number between 1 and 5. After the last line of the code block runs, the Python interpreter checks the Boolean expression again. If the new value of `roll` is still not `5`, the process is repeated in a loop until the Boolean expression evaluates to `False`. In other words, once `roll` equals `5`, the Boolean expression is `False`. The execution path exits the loop and continues with the rest of the program.

Each time we ran the code block, we incremented the value of `count` by `1`, so we know how many times our code performed the loop.

When you run the code, you should see similar output:

```output
3
1
4
2
4
1
5
It took 8 rolls to roll a 5!
```
Using a `while` statement with the `random` module could be the basis for many mini-games. Let's build a slightly more interactive version in the next step.

### Step 3: Use the optional statements break and else

In certain situations, you might want to break out of the while statement prematurely. For example, you might prompt the user for input. If they enter a certain character or term, you might want to exit the loop that circumvents the normal flow.

Update the code from the previous step to match the following code listing:

```python
import random 

roll = 0
count = 0

print('First person to roll a 5 wins!')
while roll != 5:
  
  name = input('Enter a name, or \'q\' to quit:  ' )
  if name == 'q':
    break
  
  count = count + 1
  roll = random.randint(1, 5)
  print(f'{name} rolled {roll}')
else:
    print(f'{name} Wins!!!')

print(f'You rolled the dice {count} times.')
```
In this version of our mini-game, we prompt the user for a name. Each time a new name is entered, a random value is generated (a "roll"). The first person to roll a `5` wins.

If the player continues to enter names until a `5` is rolled, the Boolean expression is no longer `True`. Then the code execution path skips to the `else` statement to print the winning message.

When you run the code and keep entering names, you should eventually see similar output:

```output
First person to roll a 5 wins!
Enter a name, or 'q' to quit:  Grant
Grant rolled 2
Enter a name, or 'q' to quit:  Charlee
Charlee rolled 5
Charlee Wins!!!
You rolled the dice 2 times.
```

We allow the player to exit the game prematurely by typing the letter `q` instead of a name. We use an `if` statement to check the value the user typed in. If they entered `q`, we call the `break` statement.

The `break` statement instructs the Python interpreter to exit the loop and continue running the code after the `while` statement's code block. In this case, the `else` statement is skipped--there's no winner.

When you run the code but enter a `q` at some point, you see similar output:

```output
First person to roll a 5 wins!
Enter a name, or 'q' to quit:  Bob
Bob rolled 4
Enter a name, or 'q' to quit:  Beth
Beth rolled 3
Enter a name, or 'q' to quit:  Conrad
Conrad rolled 1
Enter a name, or 'q' to quit:  q
You rolled the dice 3 times.
```

Both `break` and `else` are optional statements in the `while` looping structure.

### Step 4: Update the code example to handle the case where the user enters nothing by using the continue statement

Let's expand our previous example. Let's make sure that the player doesn't enter an empty string. In other words, if the user selects Enter without entering any other keystrokes (or merely selects the Spacebar), we want to ignore that entry and prompt the user again to enter a name.

```python
import random 

roll = 0
count = 0

print('First person to roll a 5 wins!')
while roll != 5:
  name = input('Enter a name, or \'q\' to quit:  ' )

  if name.strip() == '':
    continue

  if name.strip() == 'q':
      break
  
  count = count + 1
  roll = random.randint(1, 5)
  print(f'{name} rolled {roll}')
else:
    print(f'{name} Wins!!!')

print(f'You rolled the dice {count} times.')
```

In this case, we perform a gated check on the value entered by the user. After we strip out the empty spaces by using the string helper method `strip()`, the `name` variable is empty. Then we use the `continue` keyword to skip the remainder of the code block and go back to the top, where we evaluate the Boolean expression and continue looping through the code block.

By using a gated check, we can avoid the possibility that our program creates rolls when there's no name.

When you run the code and select the Enter key a few times without entering a name, you should see the similar output:

```output
First person to roll a 5 wins!
Enter a name, or 'q' to quit:  Adrian
Adrian rolled 2
Enter a name, or 'q' to quit:
Enter a name, or 'q' to quit:  
Enter a name, or 'q' to quit:  
Enter a name, or 'q' to quit:  Judy
Judy rolled 3
Enter a name, or 'q' to quit:  Ashley
Ashley rolled 5
Ashley Wins!!!
You rolled the dice 3 times.
```


## Recap

- The `while` statement allows you to create a looping structure that continues to loop through a code block until a Boolean expression evaluates to `False`.
- Add the `break` statement to exit out of a code block prematurely before the Boolean expression evaluates to `False`.
- Add the `else` statement to provide a second code block that runs after the `while` statement's Boolean expression evaluates to `False`.
- Add the `continue` statement to skip over the remainder of the code block and set the execution path back to the Boolean expression.

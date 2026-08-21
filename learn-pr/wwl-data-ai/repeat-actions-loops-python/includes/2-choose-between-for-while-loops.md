
Programs become more useful when they can automate repetitive tasks. Instead of writing the same code over and over, you can use a **loop** to repeat a block of code automatically. 

Python has two types of loops: `for` loops and `while` loops. Choosing the right one depends on whether you know how many times to repeat ahead of time.

## The for loop (known number of repetitions)

Use a `for` loop when you want to repeat an action a **known number of times**, or when you want to go through each item in a collection.

### Looping with range()

The built-in `range()` function generates a sequence of numbers to loop over:

```python
for i in range(5):
    print(i)
```

Output:

```output
0
1
2
3
4
```

Notice that `range(5)` produces the numbers 0 through 4. The loop runs 5 times, and the variable `i` takes on each value in the sequence. The `range()` function starts at 0 by default and stops **before** the number you specify (5 in this case).

You can customize the sequence by providing up to three settings: `range(start, stop, step)`. The loop will stop before it hits the stop target:

```python
for number in range(1, 10, 2):  # Start at 1, stop before 10, step by 2
    print(number)
```

Output:

```output
1
3
5
7
9
```

## The while loop

Use a `while` loop when you want to repeat something **as long as a condition remains True**. You can use this when you don't know how many times you'll need to repeat the action ahead of time.

```python
health = 3

while health > 0:
    print(f"Player is alive. Health: {health}")
    health -= 1  # Modify the condition so the loop will eventually stop
```

Output:

```output
Player is alive. Health: 3
Player is alive. Health: 2
Player is alive. Health: 1
```

### Avoid infinite loops
A `while` loop inspects its condition before each iteration. If the condition is always `True`, the loop will never stop. This behavior is called an **infinite loop** and will freeze your program.

Always ensure your code updates the condition so that it will eventually become `False`. In the example above, we subtracted 1 from `health` each time through the loop. When `health` reached 0, the condition became `False`, and the loop stopped.

## Choosing the right loop

Choose a `for` loop when:
- You know how many times you want to repeat the action.
- You want an automatic exit after a certain number of repetitions.
- You want a counter variable to keep track of how many times the loop has run.

Choose a `while` loop when:
- The total number of repetitions depends on a variable state.
- You're waiting for something specific to happen before stopping the loop (e.g., user input).
- You need control over when the loop stops, rather than a fixed number of repetitions.
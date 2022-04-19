When you write code, one common challenge is to have it perform a task an unknown number of times. In this unit, you want to allow a user to enter a list of planet names. Unfortunately, you don't know how many names the user will enter. To support looping an unknown number of times, you can use a `while` loop.

A `while` loop performs an operation *while* a certain condition is true. You could look to see if there's another line in a file, a flag has been set, a user has finished entering values, or something else has changed to indicate that the code can stop performing the operation.

> [!IMPORTANT]
> The most important thing to remember when you create `while` loops is to ensure that the condition changes. If the condition is always true, Python will continue to run your code until the program crashes.

The syntax of a `while` loop is similar to that of an `if` statement. You provide both a condition and the code you want to run while the condition is true. 

A `while` loop has three important parts:

- The word `while`, followed by a space.
- The condition you'll test. If the condition is true, the code inside the `while` loop will run.
- The code you want to run for each item in the iterable, followed by nested whitespace. For example:

    ```python
    while condition:
        # code here
    ```

Let's see how you can create code to prompt users to enter values, and then allow them to use *done* when they've finished entering the values. In our example, use the user input as the condition and then test it at the top of the `while` loop.

```python
user_input = ''

while user_input.lower() != 'done':
    user_input = input('Enter a new value, or done when done')
```

Notice that you're using `input` to prompt the users. Each time users enter a new value they're changing the condition, which means that the `while` loop will exit after they've entered *done*.

> [!NOTE]
> In our example, we've used `lower` to convert the input to lowercase, which allows for a case-insensitive comparison.

You can use the newly entered string as you would any other string that's captured with `input`. If you want to add it to a list, you could use code that's similar to the following example:

```python
# Create the variable for user input
user_input = ''
# Create the list to store the values
inputs = []

# The while loop
while user_input.lower() != 'done':
    # Check if there's a value in user_input
    if user_input:
        # Store the value in the list
        inputs.append(user_input)
    # Prompt for a new value
    user_input = input('Enter a new value, or done when done')
```

Notice the `if` statement inside the `while` loop. This statement tests for a string value inside `user_input`. If the `while` loop is running for the first time, there is no value, so there's nothing to store in `inputs`. After it runs for the first time, `user_input` always keeps the value that the user has just entered. Because `while` is testing to ensure that the value doesn't equal `done` (the word the user will enter to exit the app), you know that the current value is one that you can add to the list.

> [!NOTE]
> You might be familiar with other programming languages that support a `do` loop, which lets you perform a test at the bottom of the loop. Python doesn't provide a `do` loop.

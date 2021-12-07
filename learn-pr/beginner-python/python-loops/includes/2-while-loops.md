One common challenge when writing code is performing a task an unknown number of times. In our scenario, we want to allow a user to enter a list of planet names. Unfortunately we don't know how many names they will enter. To support looping an unknown number of times you can use a `while` loop.

## While loops

A `while` loop performs an operation **while** a condition is true. You could look to see if there's another line in a file, a flag has been set, or something has changed to indicate you can stop performing the operation.

> [!IMPORTANT]
> The most important thing to remember about `while` loops is to ensure the condition changes. If the condition is always true, Python will continue to run your code until the program crashes.

The syntax of a while loop is similar to that of an `if` statement. You provide the condition, then the code you wish to run while the condition is true. It has 3 important parts:

1. The word `while` followed by a space.
1. The condition you will test; if the condition is true the code inside the `while` loop will run.
1. The code you want to run for each item in the iterable, separated by nested whitespace.

```python
while condition:
    # code here
```

Let's see how we could create code to prompt a user for values, and allow them to use **done** as the indication they are done entering values. We will use the user input as our condition, and test it at the top of the while loop.

```python
user_input = ''

while user_input.lower() != 'done':
    user_input = input('Enter a new value, or done when done')
```

Notice we are using `input` to prompt the user. Each time the user enters a new value they are changing the condition, meaning the `while` loop will exit once the user enters the word **done**.

> [!NOTE]
> We are using `lower` to convert the input to lower case to allow for a case-insensitive comparison.

We can use the newly entered string as we would any other string captured with `input`. If we wanted to add it to a list, we could use code which resembles the following:

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

Notice the `if` statement inside the `while` loop. This is testing for a string value inside `user_input`. If it's the first time the `while` loop is running there will be no value, so we won't store it in `inputs`. After that first time `user_input` will always have the value the user just entered. Because `while` is testing to ensure it doesn't equal to `'done'` (the word the user will use to exit), we know the current value is one we can add to the list.

> [!NOTE]
> You may be familiar with other programming languages which support a `do` loop which allows you to perform a test at the bottom of the loop. Python does not provide a `do` loop.

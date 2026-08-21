

Although loops are designed to repeat a block of code, sometimes you need more granular control over how the loop executes. For example, you might want to exit a loop early, or skip certain iterations without stopping the loop entirely. 

Python gives you precise control over loop execution with two statements: `break` and `continue`.

## Break—exit the loop early

The `break` statement immediately ends the loop regardless of conditions. It tells Python to stop executing the loop and move on to the next line of code after the loop block. For example:

```python
for count in range(10):
    if count == 5:
        break
    print(count)

print("Loop ended.")
```

Output:

```output
0
1
2
3
4
Loop ended.
```

Line order matters. The `break` statement must come **after** the condition you want to check, but **before** the code you want to skip. In the example above, the loop stops before printing 5.

## Continue—skip to the next iteration

The `continue` statement tells Python to skip the rest of the code underneath it and immediately jump to the next iteration of the loop. For example, you might want to skip a certain number in a sequence:

```python
for count in range(6):
    if count == 3:
        continue
    print(count)
```

Output:

```output
0
1
2
4
5
```

In this example, the `continue` statement forces Python to abandon the `print()` line below and jump to the next iteration of the loop. This statement is useful when you want to ignore certain iterations without stopping the entire loop.

## Managing while loops with break

Both keywords work the same way in `while` loops. Combining a `while` loop with a `break` statement is a common pattern to use when handling unpredictable user input. 

For example, you might want to keep running code until the user types a specific word to exit:

```python
while True:
    user_input = input("Type 'exit' to stop the loop: ")
    if user_input.lower() == "exit":
        break
    print(f"You entered: {user_input}")

print("Goodbye!")
```

`while True` creates a loop that would run forever—`break` is the only way to exit it. This pattern allows you to prompt the user repeatedly and gracefully exit when they explicitly want to stop.

## Using continue in while loops

Using `continue` in a `while` loop requires careful attention to the loop's condition. If you use `continue` without modifying the condition, you can create an infinite loop. For example:

```python
current_slot = 0

while current_slot < 5:
    current_slot += 1  # CRUCIAL: Increment happens right at the start of the lap
    
    if current_slot == 3:
        print(f"Skipping item slot {current_slot}.")
        continue  # Aborts the rest of this lap and jumps back to the top
        
    # This processing code is skipped when current_slot is 3
    print(f"Successfully processed item in slot {current_slot}.")

print("Inventory scan complete!")
```

In this example, the loop increments `current_slot` at the start of each iteration. When it reaches 3, the `continue` statement skips the processing code and jumps back to the top of the loop. If the increment line were placed after the `continue`, the loop would never reach 5, and it would run forever.

When using `continue` in a `while` loop, always ensure to update your condition before the `continue` statement to avoid creating an infinite loop.

## Using else with loops

When a `for` or `while` loop completes normally (without hitting a `break` statement), you can use an `else` block to run code after the loop finishes. For example:

```python
color = "blue"

for i in range(3):
    user_input = input("Guess my favorite color: ")
    if user_input.lower() == color:
        print("You guessed it!")
        break
else:
    print(f"Sorry, the correct answer is {color}.")
```
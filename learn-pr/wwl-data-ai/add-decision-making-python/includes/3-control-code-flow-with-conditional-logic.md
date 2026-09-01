
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=3b52f83d-ee08-4ee5-8926-b6432594f63f]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Now that your program can evaluate conditions, you can use them to guide the paths your code can take. Python uses `if`, `elif`, and `else` statements to guide the flow of your program based on True or False results. This approach is called **conditional logic**.

## The if statement

An `if` statement runs a block of code only when a condition is `True`. The code inside must be **indented**—Python uses indentation to know which lines belong to the block:

```python
score = 85

if score >= 90:
    print("Congratulations!")
    print("Grade: A")

print("Program complete.")
```

If `score` is less than 90, the indented code inside the `if` block is skipped, and the program continues with the next line after the block.

## Indentation and colon rules

Python uses strict rules to group code blocks together:

1. **Colon (`:`):** You must place a colon at the end of a conditional statement. That tells Python that the next indented lines belong to that conditional block.

2. **Indentation:** Every line in the same block must use the same indentation. Use four spaces (or a Tab) consistently.

To complete the code block, you must **unindent** the next line after the block. This unindented line signals to Python that the block has ended. In the example above, the line `print("Program complete.")` is unindented, so it runs regardless of the `if` condition.

## Adding alternative paths with else

Use `else` to run a different block of code when the condition is `False`:

```python
score = 75

if score >= 90:
    print("Grade: A")
else:
    print("Grade: B or lower")
```

## Chaining conditions with elif

When you have more than two possible paths, you can use `elif` (short for "else if") to check extra conditions. 

### First match wins

Python checks each condition in order. When it finds the first `True` condition, it runs that block and skips the rest. If none of the conditions are `True`, it runs the `else` block (if present).

```python
score = 85

if score >= 90:
    print("Grade: A")
elif score >= 80:     # Python stops here! 85 >= 80 is True.
    print("Grade: B")
elif score >= 70:     # Skipped entirely, even though 85 >= 70 is also true.
    print("Grade: C")
else:                 # Skipped entirely.
    print("Grade: D or lower")
```

Output:
```output
Grade: B
```

Because Python exits the chain after the first `True` condition, be sure to order your conditions from most specific to least specific. Otherwise, you may never reach the conditions you expect.

::: zone-end

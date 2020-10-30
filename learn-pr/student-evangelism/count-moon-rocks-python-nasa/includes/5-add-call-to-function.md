Now that we have the function made, we'll need to include a call to it so it will be used. We'll create a for loop to go through every value in our rock list and call the function with each rock.

```python
for rock in rockList:
    countMoonRocks(rock)
```

This code will call the function that we've created for each line of text (each rock) that was reported by the rover. The function will add to the count for the corresponding type of rock and store this number in the respective variable.

Now that we have all of the rock counts in their variables, we can use some additional code to write summaries about them.

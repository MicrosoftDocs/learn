Now that we have the function made, we will need to include a call to it so it will used. To do this, we will create a for loop to go through every value in our rock list and call the function with each rock.

```python
for rock in rockList:
    countMoonRocks(rock)
```

This will call the function that we have created for each line of text (aka each rock) that was identified by the rover. The function will add to the count for the corresponding type of rock and store this number in the respective variable.

Now that we have all of the rock counts in their variables, we can use some additional code to write summaries about them.

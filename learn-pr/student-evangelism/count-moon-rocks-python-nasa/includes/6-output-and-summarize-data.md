Let's start by printing the number of each type of rock we found. For example, to do this for Basalt rocks, paste in the following code:

```python
# TODO Add a print statement for the other types of rocks: breccia, highland and regolith
print("Number of Basalt: ", basalt)
```

As you can see, we first output a string telling the user what they are going to be seeing and then we concatenate on the variable name which includes the number of how many Basalt rocks we found.

Try this for the other four types of rock variables we created.

Next, let's provide some more general data like the type of rock that was the most and least common. To do this, we will use the max() and min() functions that we learned about before.

Try to figure this out and if you get stuck, read below for the answer:

```python
# TODO Add other rock types to the "max" and "min" function calls
print("The max number of one type of rock found was:", max(basalt, ))
print("The minimum number of one type of rock found was:", min(basalt, ))
```

Solution Code:

```python
print("Number of Basalt: ", basalt)
print("Number of Breccia: ", breccia)
print("Number of Highland: ", highland)
print("Number of Regolith: ", regolith)

print("The max number of one type of rock found was:", max(basalt, breccia, highland,regolith))
print("The minimum number of one type of rock found was:", min(basalt, breccia, highland, regolith))
```

Congratulations, you have now successfully programmed Artemis to give a summary about the different types of rock data that it found.

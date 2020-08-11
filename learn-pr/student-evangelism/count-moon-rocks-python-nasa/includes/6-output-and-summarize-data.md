Let's start by printing the number of each type of rock we found. For example, to print the number of basalt rocks, copy and paste in the following code:

```python
# TODO Add a print statement for the other types of rocks: breccia, highland and regolith
print("Number of Basalt: ", basalt)
```

As you can see, we first output a string that tells the user what they'll see. Then we concatenate on the variable name that includes the number of basalt rocks we found.

Do the same thing for the four types of rock variables we created.

Next, let's provide some more general data, such as the type of rock that was the most and least common. In this case, we'll use the max() and min() functions that we learned about before.

Try to figure out what you need to do, but if you get stuck read below for the answer:

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

Congratulations, you've successfully programmed Artemis to give a summary about the different types of rock data that it found.

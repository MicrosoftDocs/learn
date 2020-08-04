The next step in our application is to add a function that will look at a line of text and tell us which type of rock it is and then increment the corresponding variable. To start, copy this code:

```python
def countMoonRocks(rockToID):
    global basalt
    global breccia
    global highland
    global regolith

    rockToID = rockToID.lower()

    if("basalt" in rockToID):
        print("Found a basalt\n")
        basalt += 1

    #TODO Add else if statements for breccia, highland and regolith

    return
```

Solution Code:

```python
def countMoonRocks(rockToID):
    global basalt
    global breccia
    global highland
    global regolith

    rockToID = rockToID.lower()

    if("basalt" in rockToID):
        print("Found a basalt\n")
        basalt += 1
    elif("breccia" in rockToID):
        print("Found a breccia\n")
        breccia += 1
    elif("highland" in rockToID):
        print("Found a highland\n")
        highland += 1
    elif("regolith" in rockToID):
        print("Found a basalt\n")
        regolith += 1

    return
```

As you recall, these lines will create a function that has a parameter of a string variable `rockToID` and does not return anything. We will be calling the function and passing in a rock name that will have one of four: Basalt, Breccia, Highland, or Regolith. To ensure that the variables will remember how many rocks they have counted, we will need to make each rock type a global variable. To increment the correct variable based upon the types of rocks that Artemis encountered, we will use if statements.

The code above checks if the string we have passed through to the function has the text "basalt". If it does, we will go into the if statement and print out that we have found a Basalt rock and then increment the variable for Basalt by one.

Note: If the line of text had "basalt" in it, with other text, it would still count it. For example, "No basalt here" would be counted as one for Basalt. This shouldn't be a problem in this case because we know where the data is coming from and what it will look like.

Add elseif statements for the remaining types of rocks.

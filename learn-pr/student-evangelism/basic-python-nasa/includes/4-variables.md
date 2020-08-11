In this unit, you'll learn about variables in Python. Variables are containers that you can store data in and use at a different time.

There are four main types of data variables that you'll encounter throughout this content:

- Integers (int): These are whole numbers like 1, 4, 10, -5.
- Floats: These are decimal numbers like 0.3, 1.6, 17.4, -3.5.
- String: These are chains of characters that are surrounded by single or double quotes like "hi", "NASA", "Space Rocks", "54321".
- Boolean: Represents either True or False.

Try copying the code below and clicking the run button to create some of your own variables:

```python
# Integer Variable
numberOfRocks = 5

# Float Variable
tempInSpace = -457.87

# String Variable
roverName = "Artemis Rover"

# Boolean Variable
rocketOn = False

```

When you have created your variables, you can view the values by writing the variable's name and clicking the run button.

```python
roverName
```

```Output
'Artemis Rover'
```

A unique aspect of Python is that you don't need to tell the program what type of variable you're making. For example, in some languages, if you want to make an integer, you must first let the computer know that you're about to create an integer. In Java, for example, you might write: `int intVar = 0;`.

Later on in our program, we'll be using variables to store the number of a certain type of rock we find. One of the main types of moon rock is called basalt. We can make a variable named `basaltRockCount` and give it a value of 0 by using the following code:

```python
# Create integer variable named basaltRockCount with value 0
basaltRockCount = 0
```

We can also change the value of the variable:

```python
basaltRockCount = 3
basaltRockCount = basaltRockCount + 1
basaltRockCount
```

```Output
4
```

This can be useful if we want to inform the computer that we've found three rocks so far and we've just found another.

An easy way to perform an operation on a variable is to use the operation you want to apply and then add an equal sign after it. This will perform the action and set the variable to the new value. For example:

```python
basaltRockCount = 5
basaltRockCount += 3 #Add 3
basaltRockCount -= 2 #Remove 2
```

Finally, you can use all of the arithmetic examples we've used so far with variables.

```python
# Find out how many miles until rocket reaches moon
distanceToMoon = 238855
distanceTraveled = 10234
distanceToMoon - distanceTraveled
```

```Output
228621
```

Although you can give a variable any name, it's recommended that you choose something that represents the data it holds. For example, you could have written the above code as:

```python
# Find out how many miles until rocket reaches moon
a = 238855
b = 10234
a - b
```

This code is likely to be confusing because `a` and `b` could represent numbers, rather than the values intended. Using `distanceToMoon` and `distanceTraveled` is clearer.

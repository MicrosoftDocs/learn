In the real world, we'll sometimes only perform an action if a certain condition is met. This is the gist of conditionals in coding. For example, we may want to launch a rocket only if the temperature is above 32 degrees. Let's start by learning about the different conditions we can check to help us decide whether to perform an action or not.

## Conditions

Conditions are what need to be met before we change tasks. We can find out if a condition is met by comparing two values. To do this we use something called logical operators. Logical operators will return either True, if the statement is true, or False, if the statement is false. Remember: True and False values are called booleans.

For example, if our condition is to check whether the temperature is above freezing (to see if a rocket launch would be delayed) our condition would be `temperature > 32`. This would give us True if the temperature is above freezing and False if the temperature is at or below freezing.

Here are some common logical operators:

- Equals: `x == y`
- Not Equals: `x != y`
- Less than: `x < y`
- Less than or equal to: `x <= y`
- Greater than: `x > y`
- Greater than or equal: `x >= y`

Try to play around with some logical operators in Jupyter Notebooks. Notice how the single equal sign and double equal signs have different meanings. The single equal assigns a value to a variable, while the double equals compares values. This difference is a common gotcha beginner programmer can face.

```python
temp = 50
print(temp >= 32)
print(temp < 32)
```

```Output
True  
False
```

You can also use these operators on other variable types.

```python
rock = "basalt"
print("highland" == rock)
print("basalt" == rock)
```

```Output
False  
True
```

For reasons that are beyond the scope of this module, sometimes when comparing variables, you must use commands like "in". This just checks whether a word is inside the variable.

```python
rock = "basaltrock"
print("highland" in rock)
print("basalt" in rock)
```

```Output
False  
True
```

Now we know how to write the conditions to determine whether we want an action to execute or not, we can begin to specify what action we want to occur.

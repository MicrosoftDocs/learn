In the real world, we sometimes will only perform some action if a certain condition is met. This is the gist of conditionals in coding. For example we may only want to launch a rocket if the temperature is above 32 degrees. Let's start by learning about the different conditions we can check to decide whether to perform an action or not.

## Conditions

Conditions are what needs to be met before we change tasks. We can find if a condition is met by comparing two values and to do this we use something called logical operators. Logical operators will return either a True, if the statement is true, or a False, if the statement is false. Remember: True and False values are called booleans.

For example if our condition is to check if the temperature is above freezing (to see if a rocket launch would be delayed) our condition would be `temperature > 32`. This would give us True if the temperature is above freezing and False if the temperature is at or below freezing.

Below are some common logical operator:

- Equals: `x == y`
- Not Equals: `x != y`
- Less than: `x < y`
- Less than or equal to: `x <= y`
- Greater than: `x > y`
- Greater than or equal: `x >= y`

Try to play around with some logical operators in Jupyter Notebooks. Notice how the single equal sign and double equal signs have very different meanings. The single equal assigns a value to a variable while the double equals compares values. This is a common gotcha beginner programmers often face.

```python
temp = 50
print(temp >= 32)
print(temp < 32)
```

>True  
>False

You can also use these operators on other variable types.

```python
rock = "basalt"
print("highland" == rock)
print("basalt" == rock)
```

>False  
>True

For reasoning that is beyond this module, sometimes when comparing variables, you must use commands like "in". This just checks if a word is inside of the variable.

```python
rock = "basaltrock"
print("highland" in rock)
print("basalt" in rock)
```

>False  
>True

After we know how to write the conditions for if we want an action to execute or not, we can begin actually specifying what action we want to occur.

We use conditional statements to tell the computer what to do if some condition is met, or is not met: do this; if not, do something else.

## If statement

The most basic of conditional statements are the if statement. The if statement will check whether a condition is true or not true. If the condition is true, the if statement will run the code inside it. If the condition is not true, it will skip over the code inside it.

Some real world examples are:

- If the temperature is above freezing, the rocket will launch
- If oxygen levels drop, grab a space suit and oxygen tank

In Python, the format for an if statement is:

```python
if(conditionToTestIsTrue):
    doSomething
```

It's crucial to include the colon at the end of the if statement and a tab on each subsequent line that should only happen if the condition evaluates to True.

Below is an example of an if statement in Python. First we check if the count of basalt rocks is 0; if it is, both statements will print. If the count of rocks is not 0, the first print statement is skipped.

```python
basalt = 0
if(basalt == 0):
    print("We have found no basalt rocks")
print("Done checking basalt rocks")
```

```Output
We have found no basalt rocks
```

```python
basalt = 1
if(basalt == 0):
    print("We have found no basalt rocks")
print("Done checking basalt rocks")
```

```Output
We have found no basalt rocks
Done checking basalt rocks
```

## Else statement

Else statements extend the if conditional and allow coders to have more control of what happens depending on the conditional. Else statements must be written after an if statement. The program will always execute what's inside the else statement if the condition in the if statement is not met.

```python
basalt = 0
if(basalt == 0):
    print("We have found no basalt rocks")
else:
    print("We found some basalt rocks")
print("Done checking basalt rocks")
```

```Output
We have found no basalt rocks
Done checking basalt rocks
```

```python
basalt = 5
if(basalt == 0):
    print("We have found no basalt rocks")
else:
    print("We found some basalt rocks")
print("Done checking basalt rocks")
```

```Output
We found some basalt rocks
Done checking basalt rocks
```

## ElseIf statement

Python also supports else-if checks, for further control on actions based on data. The else-if statement is written after an if statement and before an else statement and you can have as many as you want in between. The else-if statement is just another if statement that will check if its conditions are met after the first if statement's conditions are not met.

```python
basalt = 1
if(basalt == 0):
    print("We found no basalt rocks")
elif(basalt == 1):
    print("We found exactly 1 basalt rock")
else:
    print("We found more than 1 basalt rock")
print("Done checking basalt rocks")
```

```Output
We found exactly 1 basalt rock
Done checking basalt rocks
```

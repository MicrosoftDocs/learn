These statements are the actual programming we use to tell the computer if some condition is met, do this, if not do something else.

## If-Statement

The most basic of these statements is the if-statement. The if statement will check is some condition is true. If is it, it will run the code inside of it and if the condition is not true, it will skip over the code inside of it.

Some real world examples are:

- If the temperature is above freezing, the rocket will launch
- If oxygen levels drop, grab a space suit and oxygen tank

In Python the format for an if statement is:

```python
if(conditionToTestIsTrue):
    doSomething
```

It is crucial to include the colon at the end of the if statement and a tab on each subsequent line that should only happen if the condition evaluates to True.

Below is an example of an if statement in Python. We first check if the count of Basalt rocks is 0 and if it is, both statements will print. If the count of rocks is not 0, the first print statement is skipped.

```python
basalt = 0
if(basalt == 0):
    print("We have found no basalt rocks")
print("Done checking basalt rocks")
```

>We have found no basalt rocks

```python
basalt = 1
if(basalt == 0):
    print("We have found no basalt rocks")
print("Done checking basalt rocks")
```

>We have found no basalt rocks
>Done checking basalt rocks

## Else-Statement

Else statements extend the If conditional and allow coders to be have more control of what happens depending on the conditional. Else statements need to be written after an If-statement. The program will always execute what is inside of the else statement if the condition in the if statement is not met.

```python
basalt = 0
if(basalt == 0):
    print("We have found no basalt rocks")
else:
    print("We found some basalt rocks")
print("Done checking basalt rocks")
```

>We have found no basalt rocks
>Done checking basalt rocks

```python
basalt = 5
if(basalt == 0):
    print("We have found no basalt rocks")
else:
    print("We found some basalt rocks")
print("Done checking basalt rocks")
```

>We found some basalt rocks
>Done checking basalt rocks

## ElseIf-Statement

For further control on actions based on data, Python also supports else-if checks. This is written after if-statement and before else-statement and you can have as many as you want in between. The else-if statement is just another if statement that will check if its conditions are met after the first if-statement's conditions are not met.

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

>We found exactly 1 basalt rock
>Done checking basalt rocks

We can use functions to make our code easier to read and easier to reuse. For example, if you wrote code to count the number of basalt rocks, it would probably be almost identical to the code needed to count highland rocks. Instead of making an if statement to check the type of every single space rock, we can give a function the space rocks and it can run the same code to check which type of rock it is each time. `Print()` is an example of a function where the code to display output to the screen is the same, and the only difference is what you want to display. In this unit, you'll learn how to write your own function.

To make a function in Python, we must first tell Python that it is a function. We use the word "def" to define a function (tell Python that the following code is a function). You must then include a name for your function, parenthesis, and a colon. Finally, at the end of your function you must include the "return" key word. This tells Python the function is done and to return to the point where you called the function. Notice that all code within the function, including the `return` statement, should be indented.

```python
def NameOfFunction():

  return
```

Now let's play around with an example of making our own functions.

```python
def OutputRocketText():
  print(5)
  print(4)
  print(3)
  print(2)
  print(1)
  print("Rocket will be launching soon!")
  
  return

OutputRocketText()
```

```Output
5  
4  
3  
2  
1  
Rocket will be launching soon!
```

As you can see in the code, we start by defining a function that prints the countdown and rocket launch announcement. Then we add code that will call the function. If we had multiple rocket launches, we could just call the OutputRocketText function instead of typing out the whole print line. This would make our code much cleaner and less redundant.

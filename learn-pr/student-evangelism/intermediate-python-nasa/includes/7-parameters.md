Another interesting aspect of functions is that variables created inside them exist only inside the function. For example, this code would fail because we create the rocketNumber variable inside the function and then try to use it outside the function. Python doesn't know about that variable outside the function so it will produce an error.

```python
def OutputRocketText():
    rocketNumber = 1
    print("Rocket will launch soon!")

    return

OutputRocketText()
print(rocketNumber)

```

```Output
Rocket will launch soon!  
NameError: name 'rocketNumber' is not defined
```

Along with this, if you have variables created outside a function you can access them inside a function but you can't change them.

```python
rocketText = "We will launch in"
def OutputRocketText():
    rocketText = rocketText + " two days"

    return

OutputRocketText()
```

```Output
UnboundLocalError: local variable 'rocketText' referenced before assignment
```

As you can see, this code produces an error as well, because we are trying to modify a variable that was created outside a function.

To combat this, we can do one of two things:

- Make a variable a global variable
- Give a variable to the function, so it knows what the variable is and then return it

The easiest way to change the value of a variable inside a function is to make it a global variable. Everything in the program can modify a global variable, even if it is modified inside a function. To make something a global variable, you must make a variable before you call the function and then include a line in your function that gives the global variable name:

```python
rocketText = "We will launch in"

def OutputRocketText():
    global rocketText
    rocketText = rocketText + " two days"

    return

OutputRocketText()
print(rocketText)
```

```Output
We will launch in two days
```

Another way to modify variables inside a function is to use parameters. Parameters are when you give a function knowledge of a variable when you call it. To tell Python you want your functions to have parameters, use the following code:

```python
def OutputRocketText(textInput):

    textInput = textInput + " two days"

    return textInput

rocketText = "We will launch in"
newRocketText = OutputRocketText(rocketText)
print(newRocketText)
```

```Output
We will launch in two days
```

You can then use that variable inside the function, but it will have a new name, which is the name inside the parentheses. Also, the function will only change this new variable inside the function. To get the value from the function variable back into the code outside the function, you must return it. Do this by adding the variable name after the return keyword.

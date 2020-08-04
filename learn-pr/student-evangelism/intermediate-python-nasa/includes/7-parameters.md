Another interesting aspect of functions is that variables created inside of them only exist inside of the function. For example this code would fail because we create the rocketNumber variable in the function and then try to use it outside of the function. Python does not know about that variable outside of the function so it will produce an error.

```python
def OutputRocketText():
    rocketNumber = 1
    print("Rocket will launch soon!")

    return

OutputRocketText()
print(rocketNumber)

```

>Rocket will launch soon!  
>NameError: name 'rocketNumber' is not defined

Along with this, if you have variables created outside of a function, you can access them inside of a function, but you can not change them.

```python
rocketText = "We will launch in"
def OutputRocketText():
    rocketText = rocketText + " two days"

    return

OutputRocketText()
```

>UnboundLocalError: local variable 'rocketText' referenced before assignment

As you can see this produces an error as well because we are trying to modify a variable that was created outside of a function.

To combat this we can do one of two thing:

- Make a variable a global variable
- Give a variable to the function, so it knows that the variable is and then return it

The easiest way to change the value of a variable inside of a function is to make is a global. A global variable means that everything in the program can modify it even if it modified inside of a function. To make something a global variable, you must make a variable before you call the function and then include a line in your function that says global variable name:

```python
rocketText = "We will launch in"

def OutputRocketText():
    global rocketText
    rocketText = rocketText + " two days"

    return

OutputRocketText()
print(rocketText)
```

>We will launch in two days

The next way to modify variables inside of a function is to use something called parameters. Parameters are when you give a function knowledge of a variable when you call it. To tell Python you want your functions to have parameters use the following code:

```python
def OutputRocketText(textInput):

    textInput = textInput + " two days"

    return textInput

rocketText = "We will launch in"
newRocketText = OutputRocketText(rocketText)
print(newRocketText)
```

>We will launch in two days

You can then use that variable inside of the function, however it will have a new name which is the name inside of the parenthesis. Also, the function will only change this new variable inside of the function. To get the value from the function variable back into the code outside of the function, you must return it. Do this by adding the variable name after the return keyword.

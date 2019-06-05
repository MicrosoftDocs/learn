For reading input from the keyboard, Python provides the `input` function. `input` reads what the user types on the keyboard and returns it as a string. Here is an example that combines `input` and `print` to capture a person's name and then display it on the screen:

```python
name = input('Enter your name:')
print(name)
```

The string passed as an argument to the `input` function is the prompt that the user will see. In this example, you are asking the user to type his or her name ('Enter your name'). Once the user types a name and presses <kbd>Enter</kbd>, the `input` function will return. The function's return value is the text that the user typed, and that text is assigned to the variable named `name`. The `name` variable is then used as an input or argument to the `print` function which will output the name that the user entered.

You can also call the `input` function without a parameter:

```python
print('What is your name?')
name = input()
print(name)
```

This program will behave _almost_ the same as the first one. The difference is that `print` (by default) adds a newline to the output.

### Reading numbers as input

The `input` function always returns the typed value as a _string_ (text). This makes sense because the user can enter whatever value they like. Even if the input _is_ a valid number, it's still returned as a string type from the `input` function. For example:

```python
x = input('Enter a number: ')
print(type(x))
```

Running this code and entering the value '5' would display `<class 'str'>` even though the value itself is numeric. To turn the value into a true integer variable, you can use the `int` function:

```python
x = int(input('Enter a number: '))
print(type(x))
```

This code will output `<class 'int'>` for the value '5'. You can use the `float` function in the same way if you expect a fractional component.

> [!IMPORTANT]
> What if the input _isn't_ numeric and you pass it to the `int` function? As you might expect, this would be an error and cause a runtime failure. The program will end at this statement - you can try it yourself in the Python interactive console. We'll cover various solutions to handling these sorts of errors in future modules.

### Converting numbers to strings

You can go the other direction as well. The `str` operator will take an integer or float value and turn it into a string. This is required if you are concatenating the number into a string, for example:

```python
x = 5
print('The number is ' + str(x))
```
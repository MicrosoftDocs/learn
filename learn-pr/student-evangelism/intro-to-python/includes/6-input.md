Many programs are interactive. Supporting interactivity means you have a program that runs differently depending on the input. The person inputting data to a program is usually a user, but it can be another program. There are many ways to send input to a program; two common ways are via a graphical interface or a console. 

## User input

For reading input from the keyboard, Python provides the `input()` function. `input()` reads what the user types on the keyboard and returns it as a string. Here's an example that combines `input()` and `print()` to capture a person's name and display it on the screen:

```python
name = input('Enter your name:')
print(name)
```

The string passed as an argument to the `input` function is the prompt the user will see. In this example, you're asking the user to type their name ('Enter your name'). Once the user types a name and presses <kbd>Enter</kbd>, the `input` function will return. The function's return value is the text the user typed, and that text is assigned to the variable named `name`. The `name` variable is then used as an input or argument to the `print` function, which will output the name the user entered.

You can also call the `input` function without a parameter:

```python
print('What is your name?')
name = input()
print(name)
```

This program will behave *almost* the same as the first one. The difference is that `print` (by default) adds a newline to the output.

### Reading numbers as input

The `input` function always returns the typed value as a *string* (text). This choice makes sense because the user can enter whatever value they like. Even if the input *is* a valid number, it's still returned as a string type from the `input` function. For example:

```python
x = input('Enter a number: ')
print(type(x))
```

Running this code and entering the value '5' would display `<class 'str'>`, even though the value itself is numeric. To turn the value into a true integer variable, you can use the `int()` function:

```python
x = int(input('Enter a number: '))
print(type(x))
```

This code will output `<class 'int'>` for the value '5'. You can use the `float` function in the same way if you expect a fractional component.

> [!IMPORTANT]
> What if the input *isn't* numeric and you pass it to the `int()` function? As you might expect, this would be an error and would cause a runtime failure. The program will end at this statement; you can try it yourself in the Python interactive console. We'll cover various solutions to handling these sorts of errors in future modules.

### Converting numbers to strings

You can go the other direction as well. The `str()` method will take an integer or float value and turn it into a string. Calling the `str()` method is needed if you want the below code example to work. The conversion ensures the integer, in its string form, is concatenated to the string on the left.

```python
x = 5
print('The number is ' + str(x))
```
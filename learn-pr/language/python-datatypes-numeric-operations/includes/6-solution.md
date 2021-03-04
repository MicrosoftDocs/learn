The following code is one possible solution to the challenge presented in the preceding unit.

```python
fahrenheit = input('What is the temperature in Fahrenheit?  ')

if fahrenheit.isnumeric() == False:
    print('Input is not a number.')
    exit()

fahrenheit = int(fahrenheit)

celsius = int((fahrenheit - 32) * 5/9)
print('Temperature in celsius is ' + str(celsius))
```

This code is merely *one possible solution*, because we didn't specify what to name the variables and other small implementation details.

As long as your program works in the best case scenario, and handles the worst case scenario, you were successful.

If you were successful, congratulations!  Continue on to the next challenge!

> [!IMPORTANT]
> If you had trouble completing this challenge, it might be a good idea to review the previous units before you continue on.  All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.

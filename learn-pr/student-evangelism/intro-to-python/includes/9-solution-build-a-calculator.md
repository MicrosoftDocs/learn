Here's an example program you can use to guide your work.

1. Remember to return numbers from the `input` function you have to convert the string to a numeric value using either `int` or `float`. Here we're using `int` but either conversion would be fine.

1. Also, to _output_ the numbers in a string, you have to use the `str` function to convert them to a string so you can concatenate the results.

```python
# Read the first number
x = int(input('Enter the first number: '))

# Get the second number
y = int(input('Enter the second number: '))

# Add them together
result = x + y

# Display the results
print(str(x) + " + " + str(y) + " = " + str(result))
```
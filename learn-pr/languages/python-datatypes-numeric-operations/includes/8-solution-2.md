The following code is one possible solution for the challenge from the previous unit.

```python
print('Simple calculator!')

first_number = input('First number? ')

if first_number.isnumeric() == False:
    print('Please input a number.')
    exit()

operation = input('Operation? ')

second_number = input('Second number? ')

if second_number.isnumeric() == False:
    print('Please input a number.')
    exit()

first_number = int(first_number)
second_number = int(second_number)

result = 0
if operation == '+':
    result = first_number + second_number
    label = 'sum'
elif operation == '-':
    result = first_number - second_number
    label = 'difference'
elif operation == '*':
    result = first_number * second_number
    label = 'product'
elif operation == '/':
    result = first_number / second_number
    label = 'quotient'
elif operation == '**':
    result = first_number ** second_number
    label = 'exponent'
elif operation == '%':
    result = first_number % second_number
    label = 'modulus'
else:
    print('Operation not recognized.')
    exit()

print(label + ' of ' + str(first_number) + ' ' + operation + ' ' + str(second_number) + ' equals ' + str(result))
```

This code is merely "*one possible solution*" because we didn't specify many implementation details like the name of variables, the order in which you should perform the gated checks, and so on.

As long as your program can handle all the scenarios outlined in the challenge, you were successful!

```output
First number? 4
Operation? *
Second number? 5
product of 4 * 5 equals 20
```

If you were successful, congratulations!  Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.  All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.

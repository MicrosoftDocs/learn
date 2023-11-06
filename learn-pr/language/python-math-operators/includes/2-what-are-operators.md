Typically, math involves about four core operations: addition, subtraction, multiplication, and division. Python supports these four operators and a few others. Let's explore the most common operators you'll use in your programs.

## Addition

Python uses `+` to indicate addition. Using `+` between two numbers adds them together and provides the total.

```python
answer = 30 + 12
print(answer)
```

Output: 42

> [!NOTE]
> Operators behave the same when using literal numbers (such as `42`) or variables.

## Subtraction

Similarly, Python uses `-` for subtraction. Using `-` between two numbers subtracts the two numbers and provides the difference.

```python
difference = 30 - 12
print(difference)
```

Output: 18

## Multiplication

In Python, `*` is the multiplication operator. It provides the product of two numbers:

```python
product = 30 * 12
print(product)
```

Output: 360

## Division

Finally, `/` is used for division. It provides the quotient of two numbers:

```python
quotient = 30 / 12
print(quotient)
```
Output: 2.5

### Work with division

Imagine you need to convert a number of seconds into minutes and seconds for display.

```python
seconds = 1042
```

The first step is to determine the number of minutes in `1042` seconds. With `60` seconds in a minute, you can divide by `60` and get an answer of `17.3666667`. The number you're interested in is simply `17`. You always want to round down, by using what's known as *floor division*. To perform floor division in Python, you use `//`.

```python
seconds = 1042
display_minutes = 1042 // 60
print(display_minutes)
```

Output: 17

The next step is to determine the number of seconds. This number is the remainder of `1042` if you divide by `60`. You can find the remainder by using the [modulo](https://en.wikipedia.org/wiki/Modulo_operation) operator, which is `%` in Python. The remainder of `1042 / 60` is `22`, which is what the modulo operator will provide.

```python
seconds = 1042
display_minutes = 1042 // 60
display_seconds = 1042 % 60

print(display_minutes)
print(display_seconds)
```

```Output
17
22
```

## Order of operation

Python honors the order of operation for math. The order of operation dictates that expressions should be evaluated in the following order:

1. Parentheses
1. Exponents
1. Multiplication and division
1. Addition and subtraction

Notice how parentheses are evaluated before any other operations. Using parentheses allows you to ensure code is run in a predictable manner, and your code becomes easier to read and maintain. As a result, it's a best practice to use parentheses even if order of operation would evaluate the same way without them. In the following two lines of code, the second one is more understandable because the parentheses give a clear indication of what operation will be performed first.

```python
result_1 = 1032 + 26 * 2
print(result_1)
```

```python
result_2 = 1032 + (26 * 2)
print(result_2)
```

The answer is the same in both cases - 1084.

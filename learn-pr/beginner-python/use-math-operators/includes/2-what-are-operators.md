When we think about using math we typically think about four core operations - addition, subtraction, multiplication, and division. Python supports these four operators and a few others. We're going to explore the most common operators you'll use in your programs.

## Addition, subtraction, multiplication, and division

As highlighted earlier, there are four core operations of addition, subtraction, multiplication, and division. The operators Python uses are rather similar to what you would use in a math class or in other programming languages.

### Addition

Python uses `+` to indicate addition. Using `+` between two numbers will add them together and provide the total.

```python
answer = 30 + 12
print(answer)

# Output: 42
```

> [!NOTE] Operators behave the same when using literal numbers (such as `42`) or variables.

### Subtraction

Similarly, Python uses `-` for subtraction. `-` between two numbers will subtract the two numbers and provide the difference.

```python
difference = 30 - 12
print(difference)

# Output: 18
```

### Multiplication

In Python, `*` is the multiplication operator, and will provide the product of two numbers:

```python
product = 30 * 12
print(product)

# Output: 360
```

### Division

And finally, `/` is used for division, and provides the quotient of two numbers:

```python
quotient = 30 / 12
print(quotient)

# Output: 2.5
```

## Work with division

Imagine you need to convert a number of seconds into minutes and seconds for display.

```python
seconds = 1042
```

The first step is to determine the number of minutes in `1042` seconds. With `60` seconds in a minute, we could divide by `60`, this would provide an answer of `17.3666667`. The number we're interested in is `17` - the number of minutes. We want to always round down, or what's known as floor division. To perform floor division in Python, we use `//`.

```python
seconds = 1042
display_minutes = 1042 // 60
print(display_minutes)

# Output: 17
```

The next step is to determine the number of seconds. This is the remainder of `1042` if we divide by `60`. We can find the remainder by using the [modulo](https://en.wikipedia.org/wiki/Modulo_operation) operator, which is `%` in Python. The remainder of `1042 / 60` is `22`, which is what the modulo operator will provide.

```python
seconds = 1042
display_minutes = 1042 // 60
display_seconds = 1042 % 60

print(display_minutes)
print(display_seconds)

# Output:
# 17
# 22
```

## Order of operation

Python honors the order of operations for math. The order of operation dictates expressions should be evaluated in the following order:

1. Parenthesis
1. Exponents
1. Multiplication and division
1. Addition and subtraction

Notice how parenthesis are evaluated before any other operations. This allows you to ensure code is executed in a predictable manner, and your code becomes easier to read and maintain. As a result, it's typically a best practice to use parenthesis even if order of operation would evaluate the same way without them. If we consider the following two lines of code, the second one is more understandable because the parenthesis is a clear indication of what operation will be performed first.

```python
result_1 = 1032 + 26 * 2
result_2 = 1032 + (26 * 2)
# The answer is the same in both cases - 1084
```

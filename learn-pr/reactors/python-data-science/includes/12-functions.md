As in other programming languages, it's often essential in Python to break your program into reusable chunks. A primary means of doing that is by using functions.

For example, we could rewrite the `while` loop code example in the previous unit as a formal function:

```python
def fib(n):
    """Print a Fibonacci series up to n."""
    a, b = 0, 1
    while a < n:
        print(a, end=', ')
        a, b = b, a+b
```

Now we can call this function and compute the Fibonacci series up to some arbitrary point:

```python
fib(2000)
```

The output is:

```Output
0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597,
```

Python can also define new functions on the fly. These anonymous functions are called _lambda functions_ because you use the `lambda` keyword when you define them. Lambda functions can contain any number of arguments but only one expression.

```python
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
list(filter(lambda x: x % 2 != 0, nums))
```

The output is:

```Output
[1, 3, 5, 7, 9]
```

> [!div class="alert is-tip"]
> ### Takeaway
>
> You'll constantly use functions of all kinds to perform data science in Python. So, understanding how functions accept, work on, and return data is critical to further progress.

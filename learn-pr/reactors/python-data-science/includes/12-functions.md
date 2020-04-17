As in other programming languages, it is often essential in Python to break down your program into reusable chunks. A primary means of doing that is through functions.

For example, we could rewrite the `while` loop code snippet above as a formal function:

```Python
def fib(n):
    """Print a Fibonacci series up to n."""
    a, b = 0, 1
    while a < n:
        print(a, end=', ')
        a, b = b, a+b
```

Now we can call this function and compute the Fibonacci series up to some arbitrary point:

```Python
fib(2000)
```

The output is:

```Output
0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597,
```

Python can also define new functions on the fly. These anonymous functions are called _lambda functions_ because you define them with the lambda keyword. Lambda functions can contain any number of arguments but only one expression.

```Python
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
> You will constantly be using functions of all kind to perform data science in Python, so understanding how functions accept, work on, and return data is critical to further progress.
> 

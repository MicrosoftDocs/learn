Python has a way to put definitions in a file and use them in a script or in an interactive instance of the interpreter. Such a file is called a [Python module](https://docs.python.org/3/tutorial/modules.html?azure-portal=true). Definitions from a Python module can be imported into other programs or Python modules.

For example, the `factorial()` function is not one of the standard functions built into Python. It is part of the Python math module. So, when we run `factorial()` before importing the [math module](https://docs.python.org/3/library/math.html?azure-portal=true), we get an error:

```python
factorial(5)
```

The error output is:

```Output
---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
<ipython-input-147-637175d621a4> in <module>
----> 1 factorial(5)
NameError: name 'factorial' is not defined
```

However, the situation changes after we import the Python `math` module:

```python
import math
math.factorial(5)
```

The output is:

```Output
120
```

Notice that we still have to prepend `math` to the front of the `factorial()` function. We can use a different method to import that specific function from the Python `math` module and use it as if it were defined in our program:

```python
from math import factorial
factorial(5)
```

The output is:

```Output
120
```

You can add more cells to your notebook by clicking the **insert cell below** (+) button at the top of the window. The Python `math` module has many functions in it. Try importing some of the other `math` functions and playing around with them.

> [!div class="alert is-tip"]
> ### Takeaway
>
> There are several Python modules that you will regularly use in conducting data science in Python, so understanding how to import them will be essential (especially in this training).
> 

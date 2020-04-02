> [!div class="alert is-tip"]
> ### Learning goal
>
> By the end of this subsection, you should be comfortable importing modules in Python.

If you quit from the Python interpreter and enter it again, the definitions you have made (your functions and variables) will be lost. Similarly, you might also want to use a handy function that you’ve written in several programs without copying its definition into each program.

To support this, Python has a way to put definitions in a file and use them in a script or in an interactive instance of the interpreter. Such a file is called a module. Definitions from a module can be imported into other programs or modules.

For example, the factorial() function is not one of the standard functions built into Python. It is part of the Python math module. So, when we run factorial() before importing math, we get an error:

```input
factorial(5)
```

```output
---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
<ipython-input-147-637175d621a4> in <module>
----> 1 factorial(5)
NameError: name 'factorial' is not defined
```

However, the situation changes after we import the math module:

```input
import math
math.factorial(5)
```

```output
120
```

Notice that we still have to prepend math to the front of the factorial() function. We can use a different method to import that specific function from the math module and use it as if it were defined in our program:

```input
from math import factorial
factorial(5)
```

```output
120
```

You can add more cells to your notebook by clicking the insert cell below (+) button at the top of the window. The Python math module has many functions in it. Try importing some of the other math functions and playing around with them.

> [!div class="alert is-tip"]
> ### Takeaway
>
> There are several Python modules that you will regularly use in conducting data science in Python, so understanding how to import them will be essential (especially in this training).
> 
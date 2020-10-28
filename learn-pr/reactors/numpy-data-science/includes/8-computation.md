Some of the properties that make Python great to work with for data science (its dynamic, interpreted nature, for example) can also make it slow. This is particularly true with looping. These small performance hits can add up to minutes (or longer) when you're dealing with huge datasets.

When we first examined loops in the introduction to Python, you probably didn't notice any delay. The loops were short enough that Python's relatively slow looping wasn't an issue. Consider this function, which calculates the reciprocal for an array of numbers:

```python
import numpy as np
np.random.seed(0)

def compute_reciprocals(values):
    output = np.empty(len(values))
    for i in range(len(values)):
        output[i] = 1.0 / values[i]
    return output

values = np.random.randint(1, 10, size=5)
compute_reciprocals(values)
```

The output is:

```Output
array([0.16666667, 1.        , 0.25      , 0.25      , 0.125     ])
```

When you run this loop, it's probably difficult to notice that execution isn't instantaneous.

But let's try it on a much larger array. To empirically do this test, we'll time it by using IPython's `%timeit` magic command.

```python
big_array = np.random.randint(1, 100, size=1000000)
%timeit compute_reciprocals(big_array)
```

The output is:

```Output
2.96 s ± 130 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
```

You certainly noticed that delay. The slowness of this looping becomes noticeable when we repeat many small operations many times.

The performance bottleneck isn't the operations themselves, but the type checking and function dispatches that Python performs on each cycle of the loop. In the case of the `compute_reciprocals` function in the preceding example, each time Python computes the reciprocal, it first examines the object's type and does a dynamic lookup of the correct function to use for that type. Such is life with interpreted code. But if we were working with compiled code instead (like in C), the object-type specification would be known before the code runs, and the result could be computed much more efficiently. This is where NumPy universal functions come into play.

## Ufuncs

Universal functions in NumPy (often shortened to *ufuncs*) provide a statically typed, compiled function for many of the operations we'll need to run when we manipulate and analyze data.

Let's examine what this means in practice. Let's find the reciprocals of `big_array` again, this time by using a built-in NumPy division ufunc on the array:

```python
%timeit (1.0 / big_array)
```

The output is:

```Output
2.97 ms ± 201 µs per loop (mean ± std. dev. of 7 runs, 100 loops each)
```

That's orders of magnitude better.

You can use ufuncs between a scalar and an array and between arrays of arbitrary dimensions.

Computations vectorized by ufuncs are almost always more efficient than the same computations done with Python loops. This increased efficiency is especially apparent on large arrays. When possible, try to use ufuncs when you operate on NumPy arrays rather than using ordinary Python loops.

Ufuncs come in two flavors: *unary ufuncs*, which take a single input, and *binary ufuncs*, which operate on two inputs. The common ufuncs we'll look at here include both kinds.

### Array arithmetic

Many NumPy ufuncs use Python's native arithmetic operators. So you can use the standard addition, subtraction, multiplication, and division operators that we covered in Section 1:

```python
a = np.arange(4)
print("a     =", a)
print("a + 5 =", a + 5)
print("a - 5 =", a - 5)
print("a * 2 =", a * 2)
print("a / 2 =", a / 2)
print("a // 2 =", a // 2)  # Floor division
```

The output is:

```Output
a     = [0 1 2 3]
a + 5 = [5 6 7 8]
a - 5 = [-5 -4 -3 -2]
a * 2 = [0 2 4 6]
a / 2 = [0.  0.5 1.  1.5]
a // 2 = [0 0 1 1]
```

There are also ufuncs for negation, exponentiation, and the modulo operation:

```python
print("-a     = ", -a)
print("a ** 2 = ", a ** 2)
print("a % 2  = ", a % 2)
```

The output is:

```Output
-a     =  [ 0 -1 -2 -3]
a ** 2 =  [0 1 4 9]
a % 2  =  [0 1 0 1]
```

You can also combine these ufuncs by using the standard order of operations:

```python
-(0.5*a + 1) ** 2
```

The output is:

```Output
array([-1.  , -2.25, -4.  , -6.25])
```

The Python operators aren't actually the ufuncs but are rather wrappers around functions built into NumPy. So the `+` operator is actually a wrapper for the `add` function:

```python
np.add(a, 2)
```

The output is:

```Output
array([2, 3, 4, 5])
```

Here's a cheat sheet for the equivalencies between Python operators and NumPy ufuncs:

| Operator | Equivalent ufunc | Description |
| --- | --- | --- |
| `+` | `np.add` | Addition (for example, `1 + 1 = 2`) |
| `-` | `np.subtract` | Subtraction (for example, `3 - 2 = 1`) |
| `-` | `np.negative` | Unary negation (for example, `-2`) |
| `*` | `np.multiply` | Multiplication (for example, `2 * 3 = 6`) |
| `/` | `np.divide` | Division (for example, `3 / 2 = 1.5`) |
| `//` | `np.floor_divide` | Floor division (for example, `3 // 2 = 1`) |
| `**` | `np.power` | Exponentiation (for example, `2 ** 3 = 8`) |
| `%` | `np.mod` | Modulus/remainder (for example, `9 % 4 = 1`) |

Python Boolean operators also work. We'll explore those operators later in this section.

## Absolute value

NumPy also understands Python's built-in absolute value function:

```python
a = np.array([-2, -1, 0, 1, 2])
abs(a)
```

The output is:

```Output
array([2, 1, 0, 1, 2])
```

This function corresponds to the NumPy ufunc `np.absolute` (which is also available under the alias `np.abs`):

```python
np.absolute(a)
```

The output is:

```Output
array([2, 1, 0, 1, 2])
```

For:

```python
np.abs(a)
```

The output is the same:

```Output
array([2, 1, 0, 1, 2])
```

### Exponents and logarithms

You'll need to use exponents and logarithms a lot in data science. These data transformations are some of the most common for machine learning and statistical work.

```python
a = [1, 2, 3]
print("a     =", a)
print("e^a   =", np.exp(a))
print("2^a   =", np.exp2(a))
print("3^a   =", np.power(3, a))
```

The output is:

```Output
a     = [1, 2, 3]
e^a   = [ 2.71828183  7.3890561  20.08553692]
2^a   = [2. 4. 8.]
3^a   = [ 3  9 27]
```

The basic `np.log` computes the natural logarithm. If you need to compute base-2 or base-10 logarithms, NumPy also provides those:

```python
a = [1, 2, 4, 10]
print("a        =", a)
print("ln(a)    =", np.log(a))
print("log2(a)  =", np.log2(a))
print("log10(a) =", np.log10(a))
```

The output is:

```Output
a        = [1, 2, 4, 10]
ln(a)    = [0.         0.69314718 1.38629436 2.30258509]
log2(a)  = [0.         1.         2.         3.32192809]
log10(a) = [0.         0.30103    0.60205999 1.        ]
```

There are also some specialized versions of these ufuncs to help you maintain precision when you're dealing with very small inputs:

```python
a = [0, 0.001, 0.01, 0.1]
print("exp(a) - 1 =", np.expm1(a))
print("log(1 + a) =", np.log1p(a))
```

The output is:

```Output
exp(a) - 1 = [0.         0.0010005  0.01005017 0.10517092]
log(1 + a) = [0.         0.0009995  0.00995033 0.09531018]
```

These functions give more precise values than the raw `np.log` or `np.exp` when you use them on very small values of `a`.

### Specialized ufuncs

NumPy has many other ufuncs. Another source for specialized and obscure ufuncs is the submodule `scipy.special`. If you need to compute some specialized mathematical or statistical function on your data, chances are it's implemented in `scipy.special`.

```python
from scipy import special
```

Here are some gamma functions (generalized factorials) and a related function:

```python
a = [1, 5, 10]
print("gamma(a)     =", special.gamma(a))
print("ln|gamma(a)| =", special.gammaln(a))
print("beta(a, 2)   =", special.beta(a, 2))
```

The output is:

```Output
gamma(a)     = [1.0000e+00 2.4000e+01 3.6288e+05]
ln|gamma(a)| = [ 0.          3.17805383 12.80182748]
beta(a, 2)   = [0.5        0.03333333 0.00909091]
```

>[!div class="alert is-tip"]
>### Takeaway
>
>Universal functions in NumPy provide computational functions that are faster than regular Python functions, particularly when you're working on the large datasets that are common in data science. This speed is important because it can make you more efficient as a data scientist. It also makes a broader range of inquiries into your data tractable in terms of time and computational resources.

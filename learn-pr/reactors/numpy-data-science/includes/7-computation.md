Some of the properties that make Python great to work with for data science (its dynamic, interpreted nature, for example) can also make it slow. This is particularly true with looping. These small performance hits can add up to minutes (or longer) when dealing with truly huge datasets.

When we first examined loops in the Introduction to Pything, you probably didn't notice any delay: the loops were short enough that Python's relatively slow looping wasn't an issue. Consider this function, which calculates the reciprocal for an array of numbers:

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

```output
array([0.16666667, 1.        , 0.25      , 0.25      , 0.125     ])
```

Running this loop, it was probably difficult to even discern that execution wasn't instantaneous.

But let's try it on a much larger array. To empirically do this, we'll time this with IPython's `%timeit` magic command.

```python
big_array = np.random.randint(1, 100, size=1000000)
%timeit compute_reciprocals(big_array)
```

```output
2.96 s ± 130 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
```

You certainly noticed that delay. The slowness of this looping becomes noticeable when we repeat many small operations many times.

The performance bottleneck is not the operations themselves, but the type-checking and function dispatches that Python performs on each cycle of the loop. In the case of the `compute_reciprocals` function above, each time Python computes the reciprocal, it first examines the object's type and does a dynamic lookup of the correct function to use for that type. Such is life with interpreted code. However, were we working with compiled code instead (such as in C), the object-type specification would be known before the code executes, and the result could be computed much more efficiently. This is where NumPy universal functions come into play.

## Ufuncs

Universal functions in NumPy (often shortened to *ufuncs*) provide a statically typed, compiled function for many of the operations that we will need to run in the course of manipulating and analyzing data.

Let's examine what this means in practice. Let's find the reciprocals of `big_array` again, this time using a built-in NumPy division ufunc on the array:

In [104]:
```python
%timeit (1.0 / big_array)
```

```output
2.97 ms ± 201 µs per loop (mean ± std. dev. of 7 runs, 100 loops each)
```

That's orders of magnitude better.

Ufuncs can be used between a scalar and an array and between arrays of arbitrary dimensions.

Computations vectorized by ufuncs are almost always more efficient than doing the same computation using Python loops. This is especially true on large arrays. When possible, try to use ufuncs when operating on NumPy arrays, rather than using ordinary Python loops.

Ufuncs come in two flavors: *unary ufuncs*, which use a single input, and *binary ufuncs*, which operate on two inputs. The common ufuncs we'll look at here encompass both kinds.

### Array arithmetic

Many NumPy ufuncs use Python's native arithmetic operators, so you can use the standard addition, subtraction, multiplication, and division operators that we covered in Section 1:

```python
a = np.arange(4)
print("a     =", a)
print("a + 5 =", a + 5)
print("a - 5 =", a - 5)
print("a * 2 =", a * 2)
print("a / 2 =", a / 2)
print("a // 2 =", a // 2)  # floor division
```

```output
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

```output
-a     =  [ 0 -1 -2 -3]
a ** 2 =  [0 1 4 9]
a % 2  =  [0 1 0 1]
```

You can also combine these ufuncs using the standard order of operations:

```python
-(0.5*a + 1) ** 2
```

```output
array([-1.  , -2.25, -4.  , -6.25])
```

The Python operators are not actually the ufuncs, but are rather wrappers around functions built into NumPy. So the `+` operator is actually a wrapper for the `add` function:

```python
np.add(a, 2)
```

```output
array([2, 3, 4, 5])
```

Here is a cheat sheet for the equivalencies between Python operators and NumPy ufuncs:

| Operator | Equivalent ufunc | Description |
| --- | --- | --- |
| `+` | `np.add` | Addition (e.g., `1 + 1 = 2`) |
| `-` | `np.subtract` | Subtraction (e.g., `3 - 2 = 1`) |
| `-` | `np.negative` | Unary negation (e.g., `-2`) |
| `*` | `np.multiply` | Multiplication (e.g., `2 * 3 = 6`) |
| `/` | `np.divide` | Division (e.g., `3 / 2 = 1.5`) |
| `//` | `np.floor_divide` | Floor division (e.g., `3 // 2 = 1`) |
| `**` | `np.power` | Exponentiation (e.g., `2 ** 3 = 8`) |
| `%` | `np.mod` | Modulus/remainder (e.g., `9 % 4 = 1`) |

Python Boolean operators also work; we will explore those later in this section.

## Absolute value

NumPy also understands Python's built-in absolute value function:

```python
a = np.array([-2, -1, 0, 1, 2])
abs(a)
```

```output
array([2, 1, 0, 1, 2])
```

This corresponds to the NumPy ufunc `np.absolute` (which is also available under the alias `np.abs`):

```python
np.absolute(a)
```

```output
array([2, 1, 0, 1, 2])
```

```python
np.abs(a)
```

```output
array([2, 1, 0, 1, 2])
```

### Exponents and logarithms

You will need to use exponents and logarithms a lot in data science; these are some of the most common data transformations for machine learning and statistical work.

```python
a = [1, 2, 3]
print("a     =", a)
print("e^a   =", np.exp(a))
print("2^a   =", np.exp2(a))
print("3^a   =", np.power(3, a))
```

```output
a     = [1, 2, 3]
e^a   = [ 2.71828183  7.3890561  20.08553692]
2^a   = [2. 4. 8.]
3^a   = [ 3  9 27]
```

The basic `np.log` gives the natural logarithm; if you need to compute base-2 or base-10 logarithms, NumPy also provides those:

```python
a = [1, 2, 4, 10]
print("a        =", a)
print("ln(a)    =", np.log(a))
print("log2(a)  =", np.log2(a))
print("log10(a) =", np.log10(a))
```

```output
a        = [1, 2, 4, 10]
ln(a)    = [0.         0.69314718 1.38629436 2.30258509]
log2(a)  = [0.         1.         2.         3.32192809]
log10(a) = [0.         0.30103    0.60205999 1.        ]
```

There are also some specialized versions of these ufuncs to help maintain precision when dealing with very small inputs:

```python
a = [0, 0.001, 0.01, 0.1]
print("exp(a) - 1 =", np.expm1(a))
print("log(1 + a) =", np.log1p(a))
```

```output
exp(a) - 1 = [0.         0.0010005  0.01005017 0.10517092]
log(1 + a) = [0.         0.0009995  0.00995033 0.09531018]
```

These functions give more precise values than if you were to use the raw `np.log` or `np.exp` on very small values of `a`.

### Specialized ufuncs

NumPy has many other ufuncs. Another source for specialized and obscure ufuncs is the submodule `scipy.special`. If you need to compute some specialized mathematical or statistical function on your data, chances are it is implemented in `scipy.special`.

```python
from scipy import special
```

Gamma functions (generalized factorials) and related functions:

```python
a = [1, 5, 10]
print("gamma(a)     =", special.gamma(a))
print("ln|gamma(a)| =", special.gammaln(a))
print("beta(a, 2)   =", special.beta(a, 2))
```

```output
gamma(a)     = [1.0000e+00 2.4000e+01 3.6288e+05]
ln|gamma(a)| = [ 0.          3.17805383 12.80182748]
beta(a, 2)   = [0.5        0.03333333 0.00909091]
```

>[!div class="alert is-tip"]
>### Takeaway
>
>Universal functions in NumPy provide you with computational functions that are faster than regular Python functions, particularly when working on large datasets that are common in data science. This speed is important because it can make you more efficient as a data scientist and it makes a broader range of inquiries into your data tractable in terms of time and computational resources.

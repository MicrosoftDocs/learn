Math is used frequently in computer science and the concepts you'll learn will be great tools to add to your coding arsenal. Python has many features that allow you to perform many different mathematical computations.

## Simple calculations

As with a calculator, you can use the operators + , - , * , and / in Python to add, subtract, multiply, and divide numbers.

For example, write the following comment and code in a cell and then click the run button to see the output.

```python
# Combining two piles of space rocks
3 + 6
```

```Output
9
```

```python
# Lose three units of oxygen
15 - 3
```

```Output
12
```

```python
# Finding how far a rocket has gone by multiplying speed by time travelling
17000 * 2
```

```Output
34000
```

```python
# Number of rocks per pile if we separate 100 space rocks in 4 piles
100 / 4
```

```Output
25.0
```

Furthermore, just like on calculators, the order of operations are in play when coding with Python. You can use parentheses to combat this issue.

Try copying the code below into a Jupyter Notebook cell and running it. Notice how you get two different numbers.

```python
2 + 5 * 3
```

```Output
17
```

```python
(2 + 5) * 3
```

```Output
21
```

You get two different numbers because the order of operations computes multiplication and division before addition and subtraction.

## More advanced math

There are also more advanced calculations that Python can compute listed below:

- To calculate a remainder, use modulus (%)

```python
# How many rocks will be left when we divide 10 rocks into 3 even piles
10 % 3
```

```Output
1
```

- To calculate exponents, use **

```python
# The moon is just under 10^5.37 miles away
10 ** 5.37
```

```Output
262144
```

- To remove the remainder when dividing, use //

```python
# How many even piles of 2 we can make with 5 rocks
5 // 2
```
```Output
2
```

Math is used frequently in computer science. The concepts you'll learn in this module will be great tools to add to your coding arsenal. Python has features that allow you to do many different mathematical computations.

## Simple calculations

As with a calculator, you can use the addition `+` , subtraction `-` , multiplication `* `, and division `/` operators in Python to add, subtract, multiply, and divide numbers.

For example, write the following comment and code in a cell, then select the run button to see the output.

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

Try copying the following code into a Jupyter Notebook cell and then run it. Notice how you get two different numbers.

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

There are also more advanced calculations that Python can compute.

- To calculate a remainder value when doing division, use the modulus `%` operator (the percent sign):

   ```python
   # How many rocks will be left when we divide 10 rocks into 3 even piles
   10 % 3
   ```

   ```Output
   1
   ```

- To calculate exponents, use the exponential operator `**`, which is two asterisks:

   ```python
   # The moon is just under 10^5.37 miles away
   10 ** 5.37
   ```

   ```Output
   234422.88153199226
   ```

- To leave off the remainder value when doing division, use the remainder operator `//`, which is two forward slash marks:

   ```python
   # How many even piles of 2 we can make with 5 rocks
   5 // 2
   ```

   ```Output
   2
   ```

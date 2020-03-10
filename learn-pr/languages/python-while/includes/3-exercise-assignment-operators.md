We've been using the basic assignment operator, a single equals symbol `=` since we assigned a value to our first variable.  However, there are other assignment operators that you should also be aware of.

Incrementing a value in a looping structure is a common operation.  In this exercise, you'll learn how to utilize other assignment operators that will both perform a mathematical operation and assign a new value to a variable in a shortened form.

Beyond basic incrementing, there are several potentially useful assignment operators you can employ in your programs.

### Step 1 - Add a new code file for this exercise.

Assuming you're continuing from the previous unit, use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module.  For example, you might create a file named `exercise2.py`.

### Step 2 - Add code to use an increment and assign operator.

```python
count = 0
while count != 5:
    count += 1
    print(count)
```

Let's focus on the first line of code in the code block: `count += 1`.  The `+=` operator takes the current value of `count`, adds `1`, then assigns the new value back into `count`.  It's the equivalent of the following line of code:

```python
count = count + 1
```

When you execute the code, you should see the following output:

```output
1
2
3
4
5
```

### Step 3 - Comment out the previous code and add code to increment `count` by `3`.

You can increment by any value.  Let's increment `count` by `3` until `count` is no longer `<= 20`.

Comment out the code from the previous step and add the following code listing:

```python
count = 0
while count <= 20:
    count += 3
    print(count)
```

When you execute the code, you should see the following output:

```output
3
6
9
12
15
18
21
```

### Step 4 - Comment out the previous code and add code that decrements `count` by three.

You can use the `-=` assignment operator to subtract a value, then assign it to the variable.  What if we want to count backwards from a number until we reach `0`?

Comment out the code from the previous step and add the following code listing:

```python
count = 20
while count >= 0:
    count -= 3
    print(count)
```
When you execute the code, you should see the following output:

```output
17
14
11
8
5
2
-1
```

### Other assignment operators

Admittedly, there are several additional assignment operators, however their functionality may be less useful in real world programs.  Regardless, here's a table of some of the other assignment operators available in Python.

| Operator | Purpose |
| --- | --- |
|=|assign|
|+=|add then assign|
|-=|subtract then assign|
|*=|multiply then assign|
|/=|divide then assign|
|%=|get the modulus then assign|
|**=|perform exponent then assign|
|//=|perform floor division then assign|

## Recap

- New assignment operators `+=` and `-=` can simplify your increment and decrement operations.
- There are many additional assignment operators in Python, but they may not be as useful.
Now we'll take a closer look at `if` statements.

## If-statements

`If` statements in Python are similar to those in other programming languages like Java, and they form the backbone of the logical flow of most programs.

```python
y = 6
if y % 2 == 0:
    print('Even')
```

The output is:

```Output
Even
```

### Explore if-statement control logic

What behavior do you experience if you change `y` to be odd?

Did you notice the indentation for print under the if statement? That indentation is important because that is how Python demarks the scope of a control flow--what is contingently run or looped over--as opposed to the braces ({}) used in other languages.

To cover more contingencies without having to construct a follow-on `if` statement, you can add an else statement:

```python
y = 7
if y % 2 == 0:
    print('Even')
else:
    print('Odd')
```

The output is:

```Output
Odd
```

`elif` enables you to insert an additional logical test to an `if` statement:

```python
y = 1
if y % 2 == 0:
    print('Even')
elif y == 1:
    print('One')
else:
    print('Odd')
```

The output is:

```Output
One
```

Notice that, in the previous example, the `if` statement exited after finding the first logical test that was true. If `y = 1`, and while 1 is indeed odd, the if statement executed and exited after finding that `y == 1`, rather than continuing to the end of the statement.

### Try it yourself

Try changing the value of `y` in the snippet above. Do you get the output that you expect?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  y = 3
  if y % 2 == 0:
    print('Even')
  elif y == 1:
    print('One')
  else:
    print('Odd')
  ```

  ```Output
  Odd
  ```

  ```python
  y = 4
  if y % 2 == 0:
    print('Even')
  elif y == 1:
    print('One')
  else:
    print('Odd')
  ```

  ```Output
  Even
  ```

</details>

<br /><br />

***

## For loop: Basics

It's often necessary in programs to iterate over some set of items. This is where `for` loops prove useful. For example, they can provide a useful way to iterate over the items of a list:

```python
colors = ['red', 'yellow', 'blue']
for color in colors:
    print(color)
```

The output is:

```Output
red
yellow
blue
```

Sometimes, you'll want to iterate over a list using the list index rather than items from that list (say, when you want to access items from another list at the same time). In this case, you can combine list-object methods and `for` loops:

```python
comp_colors = ['green', 'purple', 'orange']
for i in range(len(comp_colors)):
    print(colors[i], comp_colors[i])
```

The output is:

```Output
red green
yellow purple
blue orange
```

We've met `len()` before, but [range()](https://docs.python.org/3/library/functions.html#func-range?azure-portal=true) is new to us. That function produces a sequence of integers from 0 to 1 less than the number passed into it. Hence:

```python
for j in range(5):
    print(j)
```

The output is:

```Output
0
1
2
3
4
```

In addition to `range(`_`stop`_`)`, the `range` function can take up to three parameters: `range(`_`start`_`,` _`stop`_`[,` _`step`_`])`. This odd-looking notation just means that if you pass a single argument to `range()`, it will take that argument to be the _`stop`_ value. Two arguments will be the _`start`_ and _`stop`_ values. Three values are _`star`_, _`stop`_, and _`step`_.

### Explore for loop control flow

How would you use `range` and a `for` loop to print the sequence of numbers from 10 to 20?

How about counting by threes from 17 to 41?

It can also be important to break out of a`for`  loop. Python uses the `break` statement borrowed from C to do this. To see this in action, consider two nested `for` loops:

```python
for n in range(2, 10):
    for x in range(2, n):
        if n % x == 0:
            print(n, 'equals', x, '*', n//x)
            break
    else:
        print(n, 'is a prime number')
```

The output is:

```Output
2 is a prime number
3 is a prime number
4 equals 2 * 2
5 is a prime number
6 equals 2 * 3
7 is a prime number
8 equals 2 * 4
9 equals 3 * 3
```

Note that, in the example above, the `else` statement belongs to the `for` loop, not to the if statement.

### Try it yourself

Try changing the code snippet above by removing the `break` statement. What output does it now produce?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  for n in range(2, 10):
    for x in range(2, n):
        if n % x == 0:
            print(n, 'equals', x, '*', n//x)
    else:
        print(n, 'is a prime number')
  ```

  ```Output
  2 is a prime number
  3 is a prime number
  4 equals 2 * 2
  4 is a prime number
  5 is a prime number
  6 equals 2 * 3
  6 equals 3 * 2
  6 is a prime number
  7 is a prime number
  8 equals 2 * 4
  8 equals 4 * 2
  8 is a prime number
  9 equals 3 * 3
  9 is a prime number
  ```

</details>

<br /><br />

***

## For loop: Continue
As part of the control flow of your program, you might want to continue to the next iteration of your `for` loop. The `continue` statement (also borrowed from C) can help with that:

```python
for num in range(2, 10):
    if num % 2 == 0:
        print("Found an even number:", num)
        continue
    print("Found an odd number:", num)
```

The output is:

```Output
Found an even number: 2
Found an odd number: 3
Found an even number: 4
Found an odd number: 5
Found an even number: 6
Found an odd number: 7
Found an even number: 8
Found an odd number: 9
```

### Try it yourself

What happens when you replace the `continue` statement above with a `break`?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  for num in range(2, 10):
    if num % 2 == 0:
        print("Found an even number:", num)
        break
    print("Found an odd number:", num)
  ```
  
  ```Output
  Found an even number: 2
  ```
  
</details>

<br /><br />

***

## While-loops

If we cross the functionality of the `if` statement with that of the `for` loop, we would get the `while` loop, a loop that iterates while some logical condition remains true. Consider this snippet of code to compute the initial sub-sequence of the Fibonacci sequence:

In the Fibonacci series, the sum of two elements defines the next.

```python
a, b = 0, 1

while b < 100:    
    print(b, end=', ')
    a, b = b, a+b
```

The output is:

```Output
1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89,
```

Go ahead and play with the number of iterations for the `while` loop. Notice that this snippet also uses multiple assignment for variables.

> [!div class="alert is-tip"]
> ### Takeaway
>
> Control flows are what make programs programs, as opposed to a single sequence of operations. Mastering the logical flow of information in Python will enable you to automate tasks that would be impossibly complex or time-consuming to do manually.
>

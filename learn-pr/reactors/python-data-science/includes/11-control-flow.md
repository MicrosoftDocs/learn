Now, let's take a look at `if` statements.

## The if statement

The `if` statement in Python is similar to that found in other programming languages such as Java. It's the backbone of the logical flow of most programs. Here's an example:

```python
y = 6
if y % 2 == 0:
    print('Even')
```

The output is:

```Output
Even
```

### Explore the control logic of the if statement

What do you see if you change `y` to an odd number?

Did you notice the indentation for the `print` function under the `if` statement? That indentation is important because it's how Python delimits the scope of a control flow. It indicates what is to be contingently run or looped over. Python uses indentation instead of the braces ("{}") used in other languages.

To cover more contingencies without having to construct a follow-on `if` statement, you can add an `else` statement:

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

Use `elif` to insert another logical test into an `if` statement:

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

Notice that, in the previous example, the `if` statement exited after finding the first logical test that was true. The `y` variable was set to  1, which is indeed an odd number. But, the `if` statement executed and exited after finding that `y == 1` instead of continuing to the `else` clause at the end of the statement.

### Try it yourself

Try changing the value of `y` in the preceding example. Do you get the output that you expect?

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

## The for loop: Basics

It's often necessary in programs to iterate over some set of items. A `for` loop is useful such a task. For example, it provides a way to iterate over the items of a list:

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

Sometimes, you'll want to iterate over a list by using the list index rather than items from that list. For example, you might want to access items from another list at the same time. In this case, you can combine list-object methods and `for` loops:

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

We've seen `len()` before, but [range()](https://docs.python.org/3/library/functions.html#func-range?azure-portal=true) is new to us. In its simplest form, `range(`_`stop`_`)` produces a sequence of integers from 0 up to a number that's 1 less than the number you passed into it. Here's an example:

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

The `range` function can take up to three parameters: `range(`_`start`_`,` _`stop`_`[,` _`step`_`])`. This odd-looking notation simply means that if you pass in a single argument, `range()` will take that argument to be the _`stop`_ value. It will interpret two arguments as the _`start`_ and _`stop`_ values, and three arguments as _`star`_, _`stop`_, and _`step`_.

### Explore the control flow of a for loop

How would you use `range` and a `for` loop to print the sequence of numbers from 10 to 20?

How about counting by threes from 17 to 41?

Sometimes you need to break out of a`for` loop. Python borrows the `break` statement from the C language for this purpose. To see `break` in action, consider two nested `for` loops:

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

> ![Note]
> In the preceding example, the `else` statement belongs to the `for` loop, not to the `if` statement.

### Try it yourself

Try changing the preceding code example by removing the `break` statement. What output does it now produce?

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

## The for loop: continue statement
As part of the control flow of your program, you might want to continue to the next iteration of your `for` loop. The `continue` statement (also borrowed from C) can help:

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

What happens when you replace the `continue` statement in the preceding example with a `break` statement?

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

## The while loop

If we combined the functionality of the `if` statement and the `for` loop, we'd get the `while` loop. A `while` loop iterates for as long as some logical condition remains true. Consider the following code example, which computes the initial subsequence of the Fibonacci sequence. (In the Fibonacci series, the sum of two elements defines the next.)

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

Go ahead and play with the number of iterations for the `while` loop. Notice that this example also uses Python's multiple-assignment capability for variables.

> [!div class="alert is-tip"]
> ### Takeaway
>
> Control flows are what make a program a _program_ as opposed to a single sequence of operations. Mastering the logical flow of information in Python will enable you to automate tasks that would be impossibly complex or time consuming to do manually.
>

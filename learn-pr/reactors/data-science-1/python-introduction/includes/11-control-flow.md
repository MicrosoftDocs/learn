> [!div class="alert is-tip"]
> ### Learning goal
>
> By the end of this subsection, you should be comfortable using basic control flows in Python.

Now that you have a working understanding of the fundamental data types and structures in Python, we can move on to actual programming using Python.

> [!Note]
> **Sarah: Action items**
> 
> Expand Exercise H3 headings so each heading is unique.
>

## If-statements

If statements in Python are similar to those in other programming languages like Java, and they form the backbone of the logical flow of most programs.

```Python
y = 6
if y % 2 == 0:
    print('Even')
```

```output
Even
```

### Exercise: TBD subtitle

What behavior do you experience if you change `y` to be odd?

Did you notice the indentation for print under the if statement? That indentation is important because that is how Python demarks the scope of a control flow--what is contingently run or looped over--as opposed to the braces ({}) used in other languages.

To cover more contingencies without having to construct a follow-on if statement, you can add an else statement:

```Python
y = 7
if y % 2 == 0:
    print('Even')
else:
    print('Odd')
```

```output
Odd
```

`elif` enables you to insert an additional logical test to an if statement:

```Python
y = 1
if y % 2 == 0:
    print('Even')
elif y == 1:
    print('One')
else:
    print('Odd')
```

```output
One
```

Notice that, in the previous example, the if statement exited after finding the first logical test that was true. If y = 1, and while 1 is indeed odd, the if statement executed and exited after finding that y == 1, rather than continuing to the end of the statement.

### Exercise: TBD subtitle

Try changing the value of `y` in the snippet above. Do you get the output that you expect?

## For loops

It is often necessary in programs to iterate over some set of items. This is where for loops prove useful. For example, they can provide a useful way to iterate over the items of a list:

```Python
colors = ['red', 'yellow', 'blue']
for color in colors:
    print(color)
```

```output
red
yellow
blue
```

Sometimes, you will want to iterate over a list using the list index rather than items from that list (say, when you want to access items from another list at the same time). In this case, you can combine list-object methods and for loops:

```Python
comp_colors = ['green', 'purple', 'orange']
for i in range(len(comp_colors)):
    print(colors[i], comp_colors[i])
```

```output
red green
yellow purple
blue orange
```

We've met len() before, but range() is new to us. That function produces a sequence of integers from 0 to 1 less than the number passed into it. Hence:

```Python
for j in range(5):
    print(j)
```

```output
0
1
2
3
4
```

In addition to range(stop), the range function can take up to three parameters: range(start, stop[,step]). This odd-looking notation just means that if you pass a single argument to range(), it will take that to be the stop value; two arguments will be the start and stop values; and three values are start, stop, and step.

### Exercise: TBD subtitle

How would you use `range` and a `for` loop to print the sequence of numbers from 10 to 20?

How about counting by threes from 17 to 41?

It can also be important to break out of a loop. Python uses the break statement borrowed from C to do this. To see this in action, consider two nested for loops:

```Python
for n in range(2, 10):
    for x in range(2, n):
        if n % x == 0:
            print(n, 'equals', x, '*', n//x)
            break
    else:
        print(n, 'is a prime number')
```

```output
2 is a prime number
3 is a prime number
4 equals 2 * 2
5 is a prime number
6 equals 2 * 3
7 is a prime number
8 equals 2 * 4
9 equals 3 * 3
```

Note that, in the example above, the else statement belongs to the for loop, not to the if statement.

### Exercise: TBD subtitle

Try changing the code snippet above after you remove the break statement. What output does it now produce?

As part of the control flow of your program, you might want to continue to the next iteration of your loop. The continue statement (also borrowed from C) can help with that:

```Python
for num in range(2, 10):
    if num % 2 == 0:
        print("Found an even number:", num)
        continue
    print("Found an odd number:", num)
```

```output
Found an even number: 2
Found an odd number: 3
Found an even number: 4
Found an odd number: 5
Found an even number: 6
Found an odd number: 7
Found an even number: 8
Found an odd number: 9
```

### Exercise: TBD subtitle

What happens when you replace the continue statement above with a break?

## While-loops

If we cross the functionality of the if statement with that of the for loop, we would get the while loop, a loop that iterates while some logical condition remains true. Consider this snippet of code to compute the initial sub-sequence of the Fibonacci sequence:

In the Fibonacci series, the sum of two elements defines the next.

```Python
a, b = 0, 1

while b < 100:    
    print(b, end=', ')
    a, b = b, a+b
```

```output
1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89,
```

Go ahead and play with the number of iterations for the while loop. Notice that this snippet also uses multiple assignment for variables.

> [!div class="alert is-tip"]
> ### Takeaway
>
> Control flows are what make programs programs, as opposed to a single sequence of operations. Mastering the logical flow of information in Python will enable you to automate tasks that would be impossibly complex or time-consuming to do manually.

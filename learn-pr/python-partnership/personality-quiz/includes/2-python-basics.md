Before you dive in to the full personality quiz, let's walk through the basics for commanding Python. If you already know how to use variables, functions, and conditionals, you can skip to the next unit in this module.

## Comments

First, we can write comments to ourselves that Python will ignore. On any line where we use the `#` symbol, Python ignores everything after.

Try adding the following line to your file:

```python
# this is a comment that won't be interpreted as a command
```

Press the **Run** button, and you should see the same behavior as before.

:::image type="content" source="../media/comment-demo.png" alt-text="Screenshot that shows a Python comment and the unchanged result.":::

## Variables

If you want Python to remember something, you can command it to "write it down" by using a variable.

The following command tells Python to remember the value `1990` by using a variable named `year` with the special assignment (`=`) operator. Anytime after this command, when Python sees `year`, it will substitute the current value.

```python
# use a variable named year to "remember" the value 1990
year = 1990
```

Try it out by replacing the commands in your file with the following. The `print` command can, if you put an `f` before what you want printed, use curly braces (`{}`) to surround a variable name. This will make Python print out the value of the variable.

```python
# use a variable named year to "remember" the value 1990
year = 1990

# print a message to see what year it is
print( f"The year is {year}..." )
```

Press the **Run** button, and you should see the year print out.

:::image type="content" source="../media/print-year.png" alt-text="Screenshot that shows the output to printing the value of a variable.":::

We can update the value of a variable by using the same assignment (`=`) operator. Python will figure out the right side before storing it in the variable. Because `year` already has a value, this command will ask Python to first substitute the current value of `year` (which is `1990`), add 36 to it, and then store that value in the variable `year`. This effectively overwrites the value that was written down originally. Try it out by replacing the commands in your file with the following.

```python
# use a variable named year to "remember" the value 1990
year = 1990
        
# print a message to see what year it is
print( f"The year is {year}..." )

year = year + 36

# print a message to see what year it is now
print( f"The year is now {year}..." )
```

Press the **Run** button, and you should see the years print out.

:::image type="content" source="../media/print-year-change.png" alt-text="Screenshot that shows updating a variable in Python.":::

## Conditionals

Python can perform commands depending on some condition. We're used to conditionals in the real world: "If you've been lassoed, then you're compelled to tell the truth." The keyword here is `if`, which is followed by a condition where we check whether or not the lasso of truth is around you. When the condition is met, the subsequent command must be followed. Python code expects a condition to either be met or not—it's either true or false.

To get a little more comfortable, consider the following strategy for how to spend a day. (The following is not code. It's just plain text to explain a scenario.)

```txt
if it's raining cats and dogs
    find a cat
    if the cat is hungry
        find some milk
        give the milk to the cat
    else
        pet the cat until it purrs or scratches you
else
    be happy that it's not raining animals
    frolic outside
```

How might this play out? It might be the case that:

- It's raining cats and dogs.
- The cat that you find is hungry.

In this scenario, you'll do three things:

- You find a cat.
- You find some milk.
- You give the milk to the cat.

What if instead:

- It's not raining cats and dogs.

In this scenario, you'll do two things:

- You're happy that it's not raining animals.
- You frolic outside.

There are a few more possible scenarios, but let's move on to how we can use conditionals to command Python in our year example.

## Conditionals in Python

Python expects a particular *syntax* (formulation of the commands). We won't go in depth here. Instead, just try out this example by adding the following to your file. (If you're wondering what the `==` is doing, that is how we quiz if two numbers are equal. Remember that a single `=` means assignment of a variable, so the computer would be confused.)

```python
# if we're in 1990
if year == 1990:
    print( "I left you a message on your answering machine!" )
# if we're in 2026
if year == 2026:
    print( "I sent you a text!" )
```

Press the **Run** button, and you should see state-of-the-art messaging.

:::image type="content" source="../media/conditionals-output.png" alt-text="Screenshot that shows output from the conditional statement.":::

How would you change the year so that you get a message on your answering machine instead?

### Booleans (extra)

Python puts a special meaning on the words "true" and "false," and calls them Boolean values. It turns out that Booleans are studied in computer science (and philosophy), and there's an entire subject called Boolean logic! 

You might be comfortable with arithmetic, where numbers are operated on to produce other numbers: 1 + 2 is 3. The operands are the numbers 1 and 2, and the operator is the addition operator (+). 

In Boolean logic, Boolean values (true or false) are operated on to produce other Boolean values. We might say, "If it's cold outside AND it's raining, then grab a parka." Then both conditions must be met (must be true) for us to grab a parka. Here the operands are whether or not it's cold outside and whether or not it's raining; the AND operator indicates that BOTH must be true to execute the next part. 

Similarly, we could use the OR operator to indicate that if either operand is true, the next part should execute. For example we might say, "If it's cold outside OR its raining, then grab a parka. " In this case, if it's cold outside but not raining, it's hot outside and raining, or it's cold outside and raining then you should grab a parka. 

Now that we have a handle on some of the basics, let's move on to making the quiz.

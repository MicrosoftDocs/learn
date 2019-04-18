One of the most common tasks you'll do in any programming language is to _load_ and _process_ data. That data could come from a variety of sources: files, databases, or even web services. Python supports all of these models, let's explore the commands you use to do these common tasks. In the next unit, we'll apply this knowledge in our Azure Notebook.

## Reading files in Python

Suppose you have a text file named **colors.txt** that contains the following lines:

```text
red
green
blue
```

The first step in reading the file is opening it. For this, Python provides the `open` function:

```python
color_file = open('colors.txt', 'r')
```

The `'r'` passed in the second parameter indicates that the file is being opened for reading. Other valid specifiers include `'w'` for writing and `'a'` for appending. The key difference between `'w'` and `'a'` is that the former effectively deletes the file if it already exists, while the latter does not. You can also specify `'r+'` to open the file for reading _and_ writing.

Notice that `open` returns an object representing the opened file. Here, we are storing it in a local variable named **color_file**. Once a file is opened for reading, you can read it line by line using the returned object.

```python
for color in color_file:
    print(color)
```

The `for-in` loop is the main way to loop through things in Python. In this example, the `print` statement executes once for each line of text in `color_file`. Once reading is complete, the file should be closed to conserve operating-system resources:

```python
color_file.close()
```

Python supports a handy syntax using the `with` keyword that automatically closes the file at the end of the block. Rather than write this:

```python
color_file = open('colors.txt', 'r')
for color in color_file:
    print(color)
color_file.close()
```

You can write this:

```python
with open('colors.txt', 'r') as color_file:
    for color in color_file:
        print(color)
```

This second example does exactly the same as the first, but it's more concise and you can't forget to close the file. It also ensures the file gets closed even if an error occurs as the `with` block executes.

### Looping

The previous example used a `for-in` loop to read lines from a text file. There are two kinds of loops in Python: `for-in` loops and `while` loops. The `for-in` loop iterates over each item in a collection of data. The `while` loop iterates while a conditional expression evaluates to true.

The following code creates a list of numbers 0 through 9 and prints each of them using a `for-in` loop:

```python
nums = range(10)
for x in nums:
    print(x)
```

The output is exactly what you would expect:

```output
0
1
2
3
4
5
6
7
8
9
```

Here's the same code written as a `while` loop:

```python
x = 0
while x < 10:
    print(x)
    x = x + 1
```

> [!div class="alert is-success"]
> **What about this?**
>
> If you wanted to reverse the order of the output, how would you modify the above `while` loop to do it?

### Indenting your code

The indented lines in the code samples are no accident. In most programming languages, indentations are used to make the code more readable, but have no bearing on the meaning or validity of the code. Python is different. It is one of the few programming languages in which indentations are significant.

As a rule, indentation is **required** after a line that ends with a colon. The following statement reports an indentation error if executed:

```python
for color in color_file:
print(color) # no indent!
```

These statements execute just fine, but they result in an infinite loop:

```python
x = 0
while x < 10:
    print(x)
x = x + 1
```

Consecutive lines that are indented the same signify blocks of code and are treated as a unit. If you want to include 10 lines of code in a `while` loop or `for-in` loop, make sure all 10 lines are indented by the same amount.
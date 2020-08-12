Over the course of this module, we'll be using comments in our code. Learning how to use comments efficiently will greatly improve the readability of your code and help you learn programming topics faster.

## What are comments?

In programming, comments are words that the computer will not read when running the code. Their sole purpose is to help developers who are reading and writing code. Comments are great for explaining complex code to others, helping you remember what a certain part of your code does, and reminding you of what needs to be added to your code.

## How to use comments

In Python, comments are as simple as including a # before the comment that you would like to add.

```python
# This is a comment
```

As noted previously, comments are not run by the computer. If you look at the code below, 2 + 2 is commented out so the computer will only recognize and compute 2 + 3. Try to copy this code into a cell and click the play button.

```python
# 2 + 2
2 + 3
```

```Output
5
```

> [!NOTE]
> You're not expected to know what the code below does, it is used solely for the purpose of showing comments.

Another great use of comments is to add TODOs to let you know what still needs to be done. In this example, the comment is reminding a developer to finish a piece of code at a later time.

```python
# TODO Finish analyze space rock function
def analyzeSpaceRock():

...
```

## Block comments

Block comments are many lines of comments strung together. They can be useful to help explain code to a user who might be unfamiliar with the concepts you're using or to describe what an entire program does.

```python
# This code is a function that will take in
# text and then see what type of space rock it is.
# If the rock matches a certain type of rock
# it will increase the count of that rock type by 1.
# Basalt is a common type of rock found on the moon.

def countRocks(rockText):
    if(rockText == "Basalt"):
        basalt = basalt + 1
...
```

## Inline comments

Inline comments are written on the same line as written code. Use them sparingly because they can add clutter to your code. They're good at explaining a tricky line of code.

```python
rocketSpeed = 17000 # rocket speed needed to reach orbit
```

Now that you have learned about comments, you can carry on to learn about using math in Python.

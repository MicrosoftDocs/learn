Before you can uncover the true meaning of the secret message, let's walk through the basics for commanding the Python language. If you already know how to use comments, variables, functions, and conditionals, you can skip to the [next unit](../3-ceasar-cipher-part-1.yml) in this module.

## Comments

We can write comments to ourselves that Python will ignore. On any line where we use the number (or *hash*) symbol (`#`), Python ignores everything after the symbol.

Try adding the following code to your **decrypt.py** file:

```python
# This is a comment that won't be interpreted as a command.
```

Press the **Play** button, and you should see the same behavior as before.

![Screenshot that shows that comments in Python do not change code execution.](../media/python-comments.png)
 
## Variables

Coding is essentially the movement and manipulation of data. Imagine writing a message decoder on a calculator where the only data you have access to is the last result of an equation. Though that's not impossible, it does seem unnecessarily difficult! 

In Python, we have *variables*, which are like containers that have a name and store data. You can think of variables as code names for information that we want our program to remember and have access to later.

The following command tells Python to associate the code name or variable `diana` with the information "WONDER WOMAN 1984." To do this, you use the assignment equal sign (`=`) operator. Anytime after this command, when Python sees the variable `diana`, it will substitute the value "WONDER WOMAN 1984"!

```python
# Associate variable diana with the value "WONDER WOMAN 1984"
diana = "WONDER WOMAN 1984"
```

Try it out! Replace the following commands in your **decrypt.py** file. (If you're wondering what the plus sign (`+`) is for: it "glues together" phrases into a longer phrase.)

```python
# Associate the variable diana with the value "WONDER WOMAN 1984"
diana = "WONDER WOMAN 1984"

# Print a message with the true identity of Diana
print( "I believe Diana is actually " + diana )
```

Press the green **Play** button, and you should see Diana's identity revealed.

![Screenshot of the output of the command to print the string value of the variable diana.](../media/output-string-variables.png)
 
## Functions

Similar to how variables are containers for single bits of information, functions are like containers for lines of code. Typically, programs run from top to bottom, and each line of code is run in order. However, if you write a function, you can invoke it by calling the function name whenever and however many times you want. Invoking a function means to tell the program to run the code within that function, even if it's in a different part of the file. 

You can also add data to a function as parameters. Parameters are variables that contain data that you want to use to specify the behavior of the function.

Here's how we can give Python the power to chant. In this example, given a phrase, Python can chant the phrase three times.

```python
# Define a power (function) to chant a phrase
def chant( phrase ):
    # Glue three copies together and print it as a message
    print( phrase + phrase + phrase )
```

In this code, the function is called `chant`. The parameter is a variable called `phrase`. The code within the function invokes another function that you didn't write, but which is available to you as part of the Python language `print()` capability. If you invoke this function, the value you pass in as the parameter is printed to the console three times.

Try it out! Update the commands in your **decrypt.py** file to call the power chant.

```python
# Define a power (function) to chant a phrase
def chant( phrase ):
    # Glue three copies together and print it as a message
    print( phrase + phrase + phrase )


# Invoke the power chant on the phrase "WONDER WOMAN 1984!"
chant( "WONDER WOMAN 1984!" )
```

Press the green **Play** button. You should see the chant printed in the console at the bottom of the Visual Studio Code window.

![Screenshot of the output from the call to the chant function.](../media/chant-output.png)

Great! Now that you know the basics, let's go decrypt the note.

*WONDER WOMAN 1984 TM & © DC and WBEI. RATED PG-13*

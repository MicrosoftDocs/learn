So far, your code asks one question to the user and stores their response. If the response was **A**, the code prints out a message. In this unit, you'll explore how to handle the user choosing **B** and create the rest of the questions for your quiz.

To account for the user choosing **B** instead of **A**, you can use multiple `if` statements, an `else` statement, or an `elif` statement.

## Multiple if statements

The first way you can handle the user choosing **B** is to have a second `if` statement after the one that checks for **A**:

```python
# ask the candidate a question
activity = input( "How would you like to spend your evening?\n(A) Reading a book\n(B) Attending a party\n" )

# print out which activity they chose
print( f"You chose {activity}.")

if activity == "A":
    print( "Nice choice!" )
if activity == "B":
    print( "Sounds fun!" )
```

The code will store the response to the input asking which activity the user wants in the variable called `activity`. Then, the following things will happen:

- The code will check if `activity` is `A`.
- If it is, it will print: "Nice choice!"
- The code will check if `activity` is `B`.
- If it is, it will print: "Sounds fun!"

That sounds right and does work, but it also does some unnecessary work. For example, if the user did choose **A**, the code really doesn't have to check if they chose **B** because we already know that they chose **A**!

That's where the other two methods come in.

## An else statement

You've already seen an `else` statement in the Python basics unit in this module. It was written in English and not in code. You can write `else` statements in code too:

```python
# ask the candidate a question
activity = input( "How would you like to spend your evening?\n(A) Reading a book\n(B) Attending a party\n" )

# print out which activity they chose
print( f"You chose {activity}.")

if activity == "A":
    print( "Nice choice!" )
else:
    print( "Sounds fun!" )
```

The output will look like this example:

:::image type="content" source="../media/expanded-response-output.png" alt-text="Screenshot that shows output with an expanded response to user input.":::

This approach will work the same as the two `if` statements in the previous section, if the user enters either **A** or **B**. The only difference is that now if the user chooses **A**, the code won't even check if they chose **B**. So code isn't run unnecessarily. It's an *optimization*.

The only issue here is that if the user enters **C**, the program will still print "Sounds fun!" because the code doesn't check what value `activity` has. It just prints "Sounds fun!" if `activity` is anything but `A`.

## An elif statement

The last way to handle this situation is to use an `elif` statement, also called an "else-if statement." With an `elif` statement, you get the benefit of stopping the code from running if a choice was already identified. But it also ensures that the user did enter either **A** or **B**:

```python
# ask the candidate a question
activity = input( "How would you like to spend your evening?\n(A) Reading a book\n(B) Attending a party\n" )

# print out which activity they chose
print( f"You chose {activity}.")

if activity == "A":
    print( "Nice choice!" )
elif activity == "B":
    print( "Sounds fun!" )
else:
    print("You must type A or B, let's just say you like to read.")
```

The output will look like this example:

:::image type="content" source="../media/if-else-output.png" alt-text="Screenshot of the output when neither A nor B is the user input.":::

A few things to note with `elif` statements:

- You must have an `if` at the beginning and an `else` at the end.
- You can have as many `elif` statements as you want in the middle.
- If you want to give the user a chance to choose a correct answer, it's a much more complicated solution that is beyond the scope of this module.

Now you're ready to ask all of the questions!

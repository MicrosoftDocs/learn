So far your code asks one question to the user, stores their response, and if their response was 'A' it prints out a message. In this unit, you will explore how to handle the user choosing 'B' and create the rest of the questions for your quiz.

To account for the user choosing 'B' instead of 'A', you can choose from a few possibilities; multiple if-statements, an else-statement, or an elif-statement.

## Multiple if-statements

The first way you can handle the user putting 'B' is to have a second if-statement after the one that checks for 'A':

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

What is happening here is the code will store the response to the input asking which activity the user wants in the variable called `activity`. Then, the following thing will happen:

- The code will check if `activity` is "A"
- If it is, it will print: "Nice choice!"
- The code will check if `activity` is "B"
- If it is, it will print: "Sounds fun!"

That sounds right, and does work, but it also does some unnecessary work. For example, if the user did choose "A", then the code really doesn't have to check if they chose "B" because we already know that they chose "A"!

That's where the other two methods come in.

## Else-statement

You've already seen an else-statement in the Python Basics unit in this module, it was written in English and not in code. You can write else-statements in code too:

```python
# ask the candidate a question
activity = input( "How would you like to spend your evening?\n(A) Reading a book\n(B) Attending a party\n" )

# print out which activity they chose
print( f"You chose {activity}.")

if activity == "A":
    print( "Nice choice!" )
else
    print( "Sounds fun!" )
```

This approach will work the same as the two if-statements above, if the user types either "A" or "B". The only difference is that now if the user chooses "A", then the code won't even check if they chose "B". So code doesn't get run unnecessarily. It's an *optimization*.

The only issue here is that if the user actually types "C", the program would still print "Sounds fun!" because the code doesn't check what value `activity` has, it just prints "Sound fun!" if `activity` is anything but "A".

## Elif-statement

The last way to handle this situation is to use an elif-statement. An elif-statement, also called "else-if-statement" is one where you get the benefit of stopping the code from running if a choice was already identified, but also ensures that the user did in fact type either "A" or "B":

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

A few things to note with elif-statements:

- You must have an if at the beginning and an else at the end
- You can have as many elif's in the middle
- If you wanted to give the user a chance to choose a correct answer, it is a much more complicated solution which is beyond the scope of this module

Now you're ready to ask all of the questions!

*WONDER WOMAN 1984 TM & © DC and WBEI. RATED PG-13*

Now it's time to create the outline of your quiz code!

![quiz promo](../media/ww84-edu-02-github-program-quiz.png)

To start, you will ask five questions and have only two options for each:

1. How would you prefer to spend your evening? 
    1. Reading a book
    2. Attending a party
2. What's your dream job?
    1. Curator at the Smithsonian
    2. Running a business
3. What's more important? 
    1. Money
    2. Love
4. What's your favorite decade?
    1. 1910s
    2. 1980s
5. What's your favorite way to travel?
    1. Driving
    2. Flying

We'll use these questions to determine which of the following four you are most like:

- Diana Prince / Wonder Woman
- Barbara Minerva
- Steve Trevor
- Max Lord

## Ask the quiz taker for input

You probably already know how to print text to the console from the last unit in this module on Python basics, but now you have to write code to enable a human write text *back* to the program.

Python's input command is for this exact scenario; it gives back (returns) the user's answer, which you can then store in a variable.

If you have code from the Python basics unit, you can delete them if you want so that this file is only the code for the quiz.

> [!NOTE]
> The `\n` in the text below is putting in a new line so that the question and answer choices are each on their own line. Think of it like hitting the "return" key.

```python
# ask the candidate a question
activity = input( "How would you like to spend your evening?\n(A) Reading a book\n(B) Attending a party\n" )

# print out which activity they chose
print( f"You chose {activity}.")
```

Press the **Play** button, and you should see the question print out, along with the options. Click in the TERMINAL area and try typing A then "enter" to see what happens.

> [!div class="mx-imgBorder"]
> ![Question 1 printed in the console](../media/question-1-output.png)

Notice that the activity variable simply stores whatever you typed. Try typing lion instead and see what happens…

> [!div class="mx-imgBorder"]
> ![Answering with lion instead of A or B](../media/lion-answer.png)

For now, let's assume the user understands that they should type either 'A' or 'B', whichever corresponds with their choice; and that they should capitalize it correctly.

Now, you can use a conditional statement to have execute commands depending on which option they chose. Add this if-statement to your program:

```python
# if they chose reading a book
if activity == "A":
    print( "Nice choice!" )
```

Press the **Play** button and try entering A as your choice. Be sure to type in a capital A.

> [!div class="mx-imgBorder"]
> ![Demonstrating the execution of an if-statement](../media/chosing-a.png)

What do you think will happen if you choose 'B' instead? Try writing some code to see if you can account for that and then go on to the next unit to see different ways of doing it!

*WONDER WOMAN 1984 TM & © DC and WBEI. RATED PG-13*

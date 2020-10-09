Now it's time to really score the quiz and assign your user a character from the WONDER WOMAN 1984 film!

With five questions and different choices, you'll use some variables to guide the response. You'll add and subtract points from each of the four characters, depending on what the user chose to answer. At the end, you'll tally up all the points and tell the user which character they're most like.

Add this code to the bottom of your file. Notice that this time, you can use `else` statements. The reason is that in this code you wrote in the last unit, if the user chose something other than **A** or **B**, you set each variable to `A`. 

```python
# create some variables for scoring
diana_like = 0
steve_like = 0
max_like = 0
barbara_like = 0

# update scoring variables based on the weapon choice
if activity == "A":
    diana_like = diana_like + 1
    barbara_like = barbara_like + 1
else:
    max_like = max_like + 1
    steve_like = steve_like + 1

# update scoring variables based on the job choice
if job == "A":
    diana_like = diana_like + 2
    barbara_like = barbara_like + 2
    steve_like = steve_like - 1
else:
    max_like = max_like + 2

# update scoring variables based on the value choice
if value == "A":
    diana_like = diana_like - 1
    max_like = max_like + 2
else:
    diana_like = diana_like + 1
    steve_like = steve_like + 2
    barbara_like = barbara_like + 1

# update scoring variables based on the decade choice
if decade == "A":
    steve_like = steve_like + 2
    diana_like = diana_like + 1
else:
    max_like = max_like + 1
    barbara_like = barbara_like + 2

# update scoring variables based on the travel choice
if travel == "A":
    max_like = max_like + 2
    barbara_like = barbara_like - 1
else:
    diana_like = diana_like + 1
    steve_like = steve_like + 1

# print the results depending on the score
if diana_like >= 6:
    print( "You're most like Wonder Woman!" )
elif steve_like >= 6:
    print( "You're most like Steve Trevor!" )
elif barbara_like >= 6:
    print( "You're most like Barbara Minerva!")
else:
    print( "You're most like Max Lord!")
```

Press the **Play** button and find out which WONDER WOMAN 1984 personality you're most like!

*WONDER WOMAN 1984 TM & © DC and WBEI. RATED PG-13*

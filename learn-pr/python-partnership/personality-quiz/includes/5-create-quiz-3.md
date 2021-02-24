It's finally time to ask the user all of your questions. 

For now, you'll just confirm what the user chose with print statements. In the next unit, you'll assign values to each choice and present the user with their character!

One additional piece included in this code is that when the user chose something other than **A** or **B**, you'll also assign that value so that they can still get their character.

Make sure your code matches this code:

> [!NOTE]
> You should probably make the print statements more interesting. ;)

```python
# ask the candidate a question
activity = input( "How would you like to spend your evening?\n(A) Reading a book\n(B) Attending a party\n" )
if activity == "A":
    print( "Reading a book, cice choice!" )
elif activity == "B":
    print( "Attending a party? Sounds fun!" )
else:
    print("You must type A or B, let's just say you like to read.")
    activity = "A"

# ask the candidate a second question
job = input( "What's your dream job?\n(A) Curator at the Smithsonian\n(B) Running a business\n" )
if job == "A":
    print( "Curator, nice choice!" )
elif job =="B":
    print( "Running a business? Sounds fun!" )
else:
    print("You must type A or B, let's just say you want to be a curator at the Smithsonian")
    job = "A"

# ask the candidate a third question
value = input( "What's more important?\n(A) Money\n(B) Love\n" )
if value == "A":
    print( "Money, nice choice!" )
elif value =="B":
    print( "Love? Sounds fun!" )
else:
    print("You must type A or B, let's just say money is more important to you.")
    value = "A"

# ask the candidate a fourth question
decade = input( "What's your favorite decade?\n(A) 1910s\n(B) 2010s\n" )
if decade == "A":
    print( "1910s, nice choice!" )
elif decade =="B":
    print( "2010s? Sounds fun!" )
else:
    print("You must type A or B, let's just say the 1910s is your favorite decade.")
    decade = "A"

# ask the candidate a fifth question
travel = input( "What's your favorite way to travel?\n(A) Driving\n(B) Flying\n" )
if travel == "A":
    print( "Driving, nice choice!" )
elif travel =="B":
    print( "Flying? Sound fun!" )
else:
    print("You must type A or B, let's just say your favorite way to travel is by driving")
    travel = "A"

# print out their choices
print( f"You chose {activity}, then {job}, then {value}, then {decade}, then {travel}.")
```

Press the **Run** button and make sure your responses are recorded correctly.

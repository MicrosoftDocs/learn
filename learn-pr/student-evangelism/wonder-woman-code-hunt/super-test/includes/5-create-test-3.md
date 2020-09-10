It's finally time to ask the user all of your questions. 

For now, you will just confirm what the user chose with print statements and in the next unit you will actually assign values to each choice and present them with their character!

One additional piece included in this code is that when the user chose something other than "A" or "B", you will also assign that value, so that they can still get their character.

Make sure your code matches this code:

> [!NOTE]
> You should probably make the print statements more interesting ;)

```python
# ask the candidate a question
weapon = input( "Which weapon?\n(A) Lasso\n(B) No weapon, thank you\n" )
if weapon == "A":
    print( "Lasso, Nice choice!" )
elif weapon =="B":
    print( "No weapon? You're brave!" )
else:
    print("You must type A or B, let's just say you wanted the Lasso")
    weapon = "A"


# ask the candidate a second question
job = input( "What's your dream job?\n(A) Curator at the Smithsonian\n(B) Running a business\n" )
if job == "A":
    print( "Curator, Nice choice!" )
elif job =="B":
    print( "Running a business? You're brave!" )
else:
    print("You must type A or B, let's just say you want to be a curator at the Smithsonian")
    job = "A"

# ask the candidate a third question
value = input( "What's more important?\n(A) Money\n(B) Love\n" )
if value == "A":
    print( "Money, Nice choice!" )
elif value =="B":
    print( "Love? You're brave!" )
else:
    print("You must type A or B, let's just say money is more important to you.")
    value = "A"

# ask the candidate a fourth question
decade = input( "What's your favorite decade?\n(A) 1910s\n(B) 1980s\n" )
if decade == "A":
    print( "1910s, Nice choice!" )
elif decade =="B":
    print( "1980s? You're brave!" )
else:
    print("You must type A or B, let's just say the 1910s is your favorite decade.")
    decade = "A"

# ask the candidate a fifth question
animal = input( "What's your favorite big cat?\n(A) Tiger\n(B) Cheetah\n" )
if animal == "A":
    print( "Tiger, Nice choice!" )
elif animal =="B":
    print( "Cheetah? You're brave!" )
else:
    print("You must type A or B, let's just say your favorite big cat is a Tiger")
    animal = "A"

# print out their choices
print( f"You chose {weapon}, then {job}, then {value}, then {decade}, then {animal}.")
```

Press the **Play** button and make sure your responses are recorded correctly.

*WONDER WOMAN 1984 TM & © DC and WBEI. RATED PG-13*

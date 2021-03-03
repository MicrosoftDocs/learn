Now it's time to really score the quiz and assign your user a super sleuth character!

With five questions and different choices, you'll use some variables to guide the response. You'll add and subtract points from each of the four characters, depending on what the user chose to answer. At the end, you'll tally up all the points and tell the user which character they're most like.

Add this code to the bottom of your file. Notice that this time, you can use `else` statements. The reason is that in this code you wrote in the last unit, if the user chose something other than **A** or **B**, you set each variable to `A`. 

```python
# create some variables for scoring
sam_like = 0
cam_like = 0
kai_like = 0
indy_like = 0

# update scoring variables based on the activity choice
if activity == "A":
    sam_like = sam_like + 1
    indy_like = indy_like + 1
else:
    kai_like = kai_like + 1
    cam_like = cam_like + 1

# update scoring variables based on the job choice
if job == "A":
    sam_like = sam_like + 2
    indy_like = indy_like + 2
    cam_like = cam_like - 1
else:
    kai_like = kai_like + 2

# update scoring variables based on the value choice
if value == "A":
    sam_like = sam_like - 1
    kai_like = kai_like + 2
else:
    sam_like = sam_like + 1
    cam_like = cam_like + 2
    indy_like = indy_like + 1

# update scoring variables based on the decade choice
if decade == "A":
    cam_like = cam_like + 2
    sam_like = sam_like + 1
else:
    kai_like = kai_like + 1
    indy_like = indy_like + 2

# update scoring variables based on the travel choice
if travel == "A":
    kai_like = kai_like + 2
    indy_like = indy_like - 1
else:
    sam_like = sam_like + 1
    cam_like = cam_like + 1

# print the results depending on the score
if sam_like >= 6:
    print( "You're most like Sharp-Eyed Sam!" )
elif cam_like >= 6:
    print( "You're most like Curious Cam!" )
elif indy_like >= 6:
    print( "You're most Inquisitive Indy!" )
else:
    print( "You're most like Keen Kai!" )
```

Press the **Run** button and find out which super sleuth personality you're most like!

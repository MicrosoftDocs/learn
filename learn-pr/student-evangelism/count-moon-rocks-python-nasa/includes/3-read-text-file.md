Now that we have some variables made, we can start giving these variables values. We want to count the number of times we see a certain type of rock in the rocks.txt file and add that number to the corresponding variable. For example, if there are 12 basalt rocks that Artemis saved to the text file, then we'll want the basalt variable to be set to 12.

Let's start by telling the computer to read in the rocks.txt file. To do this, copy the code below. The readline function will read the first line, which is just telling us that we are starting to read the rocks.

```python
strPath = "rocks.txt"
fileObject = open(strPath)
line = fileObject.readline()
print(line)
```

```Output
Reading Rocks
```

Now, we can call the readlines() function to put all of the lines into our rockList variable. We'll also print all of the rocks that are in the rockList and close the fileObject.

```python
rockList = fileObject.readlines()

for rock in rockList:
    print(rock)

fileObject.close()
```

Although we're only printing out each rock that we see in a file at this stage, this exercise will set us up perfectly to call a function. This function will look at each rock and add to the corresponding variable if it sees a rock of the correct type.

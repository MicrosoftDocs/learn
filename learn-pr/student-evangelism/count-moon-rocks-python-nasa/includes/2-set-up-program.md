To start creating this program make a folder somewhere on your computer that you will be able to easily access. You can call this something like SpaceRockProject. After this is created, save this [rocks.txt](../resources/rocks.txt) file in this folder. Use the `file -> save as` to save a copy in your folder. This file has all of the data about that rocks that we are going to be reading in Python.

:::image type="content" source="..\media\save-rock-file.png" alt-text="How to save the rock text file":::

Next, open Visual Studio Code and click file then new file. Once the blank file is open, click ctrl s to save it. Navigate to the folder you just created, name the file something informative like ArtemisRockClassifier and change the file type to Jupyter from the drop down menu. Now that we have everything created, we can start coding!

:::image type="content" source="..\media\create-final-project.png" alt-text="How to create the final project Jupyter Notebook":::

To start our program, we will want to let the user know that the program is beginning. To do this, we will use the print command to output a string of text.

```python
print("Artemis Rover Rock Scanner Starting")
```

>Artemis Rover Rock Scanner Starting

Next, we are going to want to create some variables which are going to represent the count of the different types of rocks that Artemis encountered on the Moon. The specific rocks that we are looking for are: Basalt: The Mare Rock, Breccia: Shocked Rock, Highland Rock: Anorthosite, and Regolith Soil/Surface Layer. These are the four main types of rocks found on the moon.

Let's make some variables with names of "basalt", "breccia", "highland", and "regolith". We can also set these variables to 0 since we have not yes counted any rocks. Finally, make a list called rockList that will store every rock the rover finds. We can make this an empty list setting it equal to brackets with nothing inside of them.

```python
basalt = 0
breccia = 0
highland = 0
regolith = 0
rockList = []
```

To start to create the program, make a folder somewhere on your computer that you can access easily. Call the folder something like SpaceRockProject. Then open the file [rocks.txt](../resources/rocks.txt) and use `file -> save as` to save a copy in your folder. This file contains all of the rocks data that we're going to be reading in Python.

:::image type="content" source="../media/save-rock-file.png" alt-text="Screenshot showing how to save the rock text file.":::

Next, open Visual Studio Code and select **File** then **New File**. Once the blank file is open, make the keystrokes "Ctrl+S" to save it. Navigate to the folder you created, name the file something informative such as ArtemisRockClassifier, and change the file type to Jupyter from the drop-down menu. Now we have everything created, we can start coding!

:::image type="content" source="../media/create-final-project.png" alt-text="Screenshot showing how to create the final project Jupyter Notebook.":::

To start our program, we'll want to let the user know that the program is beginning, by using the print command to output a string of text.

```python
print("Artemis Rover Rock Scanner Starting")
```

```Output
Artemis Rover Rock Scanner Starting
```

Next, we want to create some variables that will represent the count of the different types of rocks that Artemis found on the Moon. The specific rocks that we're looking for are: Basalt: The Mare Rock, Breccia: Shocked Rock, Highland Rock: Anorthosite, and Regolith Soil/Surface Layer. These types are the four main types of rocks found on the Moon.

Let's make some variables with names of "basalt", "breccia", "highland", and "regolith". We can also set these variables to 0 since we've not yet counted any rocks. Finally, make a list called rockList that will store the names of every rock the rover found. We can make the list empty, setting it equal to brackets with nothing inside them.

```python
basalt = 0
breccia = 0
highland = 0
regolith = 0
rockList = []
```

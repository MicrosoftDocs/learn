This is a StereoKitInk tutorial designed to teach people the fundamentals of drawing and interacting with Mixed Reality content. You'll learn how to make a core application loop radial hand menus, easy window menus with automatic layout, object-based menus with more explicit layouts, and file pickers, among other things. You'll also discover how simple it is to draw models, lines and interact with your fingers.

### Follow the below steps to develop the application on your Windows PC

* First download and install [StereoKit Templates](https://marketplace.visualstudio.com/items?itemName=NickKlingensmith.StereoKitTemplates) as mentioned in the previous chapters.
* Then download StereoKitInk sample application from this [GitHub repository](https://github.com/maluoi/StereoKit-PaintTutorial/tree/feature/sk_ink).
* Click on **Code** button & select **Download ZIP**.
* Once the download is completed click on the folder & select **StereoKitInk.sln** file.

> [!Note]
> The program will contain errors, which will be cleared at a later time during debugging.

Visual Studio, open the code for the StereoKitInk application. The solution explorer is located in the right corner and contains an assets folder and three other software files that operate the basic logic.

## 3D model assets

* Look for the assets folder in the solution explorer.
* InkBottle.glb, InkSplat.glb, and StereoKitInkLight.png are the model and image files used in the program to improve the user experience.

## Painting menu

* Painting menu is created using Painting.cs class which contains the entire concept of finger painting.
* It accepts manual input and generates three-dimensional lines out of it.
* This program takes the fingertip of the hand, translates it to local space, smooths it out to reduce any jagged noise, and converts the fingertip's coordinates into hierarchy local coordinates before it works with it.
* It includes an undo option that adds the most recent undo to the painting from the stack and a redo option that removes the most recent undo from the stack and adds it to the painting.
* In the painting menu we start drawing using two points. The first one begins at the point provided, and the second one will continuously be updated to the current fingertip location. It then estimates the current distance from the previous position as well as the hand's speed.  
* It'll add a new point if it's more than a centimeter away from our last point.
* Finally, it adds the active stroke to the painting and clears it out for the next one.
* Each line in this file is a paint stroke. Later each paint stroke in painting will be converted into a file and joins all the data together.
* This palette menu is also in charge of loading and saving painting files.

## Palette menu

* PaletteMenu.cs class was used to create the palette menu.
* This program's objective is to handle painting settings to provide a palette UI.
* The handle is attached to the pallet here so that it can be moved around as needed.
* It consists of two 3D models. The first 3D model, InkBottle.glb, is used for decoration and will display the active color, while the second, InkSplat.glb, allows users to choose colors.
* Swatches have a slider that allows the user to manually adjust the Hue, Saturation, and Value of their color.
* A slider has been added to modify the size of the brushstrokes. Then we draw the brushstroke over it to get a sense of the size.
* This application overrides the shader when loading it into the UI shader, providing a better user experience.

## Main program

* The Program.cs class was used to develop the Main Program.
* This is the main program that binds everything together.
* It contains the application logic, the hand menu, and the application menu.
* In the main program, the user needs to prepare a few options at initialization, such as the assets folder and appName. When StereoKit is given a relative folder name, it will search for assets in assetsFolder folder.
* We store quick actions in a simple radial hand menu. It's initiated by a grip motion and is ideal for quick, gesture-like menu item activation.
* Main program also controls the application's menu window. When the save button is pressed, a save file dialogue should appear. After a file name and folder have been provided, it should call the SavePainting method with the file's pathname and the.skp extension.
* The load button allows the user to choose any .skp file and execute the LoadPainting method, whereas the clear button creates a new Painting object. Finally, the quit button tells the StereoKit to finish the frame properly, break out of the loop, and end the window.

This is a StereoKitInk introduction tutorial designed to teach people the fundamentals of drawing and interacting with Mixed Reality content. You'll learn how to make a core application loop radial hand menus, easy window menus with automatic layout, object-based menus with more explicit layouts, and file pickers, among other things. You'll also discover how simple it is to draw models, lines and interact with your fingers.

* Download StereoKitInk sample application from the provided GitHub link [maluoi/ StereoKit-PaintTutorial](https://github.com/maluoi/StereoKit-PaintTutorial/tree/feature/sk_ink) & select [StereoKitInk_UWP](https://github.com/maluoi/StereoKit-PaintTutorial/tree/feature/sk_ink/StereoKitInk_UWP).
* After importing the StereoKit UWP Templates, open them in Visual Studio 2019. You may see the Solution Explorer hierarchy, which comprises Assets, Painting Menu, Palette Menu, and Main Program.
*Note*: The program will contain errors, which will be cleared at a later time during debugging.

## 3D model assets

Look for the Assets folder in the solution explorer. This folder contains InkBottle.glb, InkSplat.glb and StereoKitInkLight.png model and image files which will be used later in the application.

## Painting menu

The painting menu is created using paint.cs class which contains the entire concept of finger painting. It accepts manual input and generates three-dimensional lines out of it. It has an undo option that removes the most recent undo from the stack and adds it to the painting, and a redo option removes the most recent undo from the stack and adds it to the painting. Finally, it takes the fingertip of the hand, translates it to local space, smooths it out to reduce any jagged noise, and converts the fingertip's coordinates into hierarchy local coordinates before it works with it.

Here we start drawing using two points. The first one begins at the point provided, and the second one will continuously be updated to the current fingertip location. Next, it Calculates the current distance from the last point and the speed at which the hand is traveling. It'll add a new point if it's more than a centimeter away from our last point. Finally, it adds the active stroke to the painting and clears it out for the next one. In this file, each line is a paint stroke. Later each paint stroke in painting needs to be converted into a file and joins all the data together. It's also in charge of loading and saving painting files. This painting.cs class can be seen in the StereoKit's Hierarchy system.

## Palette menu

The palette.cs class was used to create the palette menu. This program's objective is to handle painting settings to provide a palette UI. It consists of two 3D models.The first 3D model, InkBottle.glb, is used for decoration and will display the active color, while the second, InkSplat.glb, allows users to choose colors. Swatches have a slider that allows the user to manually adjust the Hue, Saturation, and Value of their color. This application overrides the shader when loading it into the UI shader, providing a better user experience. The handle is attached to the pallet here so that it can be moved around as needed. A slider has been added to modify the size of the brushstrokes. Then we draw the brushstroke over it to get a sense of the size.

## Main program

The Program.cs class was used to develop the Main Program. This contains the application logic, the hand menu, and the application menu. This is the main program that binds everything together.

Here the user can prepare a few options at initialization, such as the assetsFolder and appName. When StereoKit is given a relative folder name, it will search for assets in assetsFolder folder.

We store quick actions in a simple radial hand menu. It's actuated by a grip motion and is ideal for quick, gesture-like menu item activation.

The main program also controls the application's menu window. When the save button is pressed, a save file dialogue should appear. After a file name and folder have been provided, it should call the SavePainting method with the file's pathname and the.skp extension. The load button allows the user to choose any .skp file and execute the LoadPainting method, whereas the clear button creates a new Painting object. Finally, the quit button tells the StereoKit to finish the frame properly, break out of the loop, and end the window.
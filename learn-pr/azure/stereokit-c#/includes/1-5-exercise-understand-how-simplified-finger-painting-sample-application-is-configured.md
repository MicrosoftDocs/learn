This is a StereoKit introduction tutorial designed to teach people the fundamentals of drawing and interacting with Mixed Reality content. You'll learn how to make a core application loop radial hand menus, easy window menus with automatic layout, object-based menus with more explicit layouts, and file pickers, among other things. You'll also discover how simple it is to draw models, lines and interact with your fingers.

* Download finger-painting sample application requirement from GitHub [maluoi/ StereoKit-PaintTutorial](https://github.com/maluoi/StereoKit-PaintTutorial) & select [StereoKitPaintTutorial_UWP](https://github.com/maluoi/StereoKit-PaintTutorial)
* After importing the StereoKit UWP Templates[StereoKitPaintTutorial_UWP], open them in Visual Studio 2019. You may see the Solution Explorer hierarchy there, which comprises Assets, Painting Menu, Palette Menu, and Main Program.
*Note*: Errors will be there in the program. It will be cleared while debugging the projects.

## 3D model assets

Look for the Assets folder in the solution explorer. This folder contains paint.glb and palette.glb model file which will be used later in the application.

## Painting Menu

This painting menu is created using painting.cs class contains the entire concept of finger painting. It takes in hand input and turns it into three-dimensional lines. It has an undo option that removes the most recent undo from the stack and adds it to the painting, and a redo option removes the most recent undo from the stack and adds it to the painting. It takes the fingertip of the hand, translates it to local space, and smooths it out to reduce any jagged noise. Here it converts the fingertip's coordinates into hierarchy local coordinates before it works with it.

Here we start drawing using two points. The first one begins at the point provided, and the second one will continuously be updated to the current fingertip location. Next, it Calculates the current distance from the last point and the speed at which the hand is traveling. It'll add a new point if it's more than a centimeter away from our last point. Finally, it adds the active stroke to the painting and clears it out for the next one. In this file, each line is a paint stroke. Later each paint stroke in painting needs to be converted into a file and join all data together. It's also in charge of loading and saving painting files. This painting.cs class can be seen in the StereoKit's Hierarchy system.

## Palette Menu

The palette.cs class was used to create this palette menu. This program's objective is to handle painting settings to provide a palette UI. It consists of two 3D models. The first is for the root object, while the second is for the paint swatches. This application overrides the shader when loading it into the UI shader, providing a better user experience for the user. The handle is attached to the pallet here so that it can be moved around as needed. A slider has been added to modify the size of the brushstrokes. Then we draw the brushstroke over it to get a sense of the size.

## Main Program

The Program.cs class was used to develop this Main Program. This contains the application logic, the hand menu, and the application menu. This is the main programme that binds everything together.
Here user can prepare a few options at initialization, such as the assetsFolder and appName. When StereoKit is given a relative folder name, it will search for assets in assetsFolder folder. It's also possible to tell settings how to construct a flatscreen app or what to do if the preferred initialization mode fails. 
We'll store some quick actions in a simple radial hand menu. It's actuated by a grip motion and is ideal for quick, gesture-like menu item activation.

This main program also controls the application's menu window. When the we presses the save button, a save file dialogue should appear. After a file name and folder have been provided, it should call SavePainting method with the file's pathname and the.skp extension. The load button allows the user to choose any .skp file and execute LoadPainting method with that file, whereas the clear button creates a new Painting object. Finally, the quit button tells the StereoKit to finish the frame properly and then break out of the Step loop and end the window.
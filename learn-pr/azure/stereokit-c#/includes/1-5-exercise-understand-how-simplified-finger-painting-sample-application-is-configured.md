This is a StereoKit introduction tutorial designed to teach people the fundamentals of drawing and interacting with Mixed Reality content. You'll learn how to make a core application loop radial hand menus, easy window menus with automatic layout, object-based menus with more explicit layouts, and file pickers, among other things. You'll also discover how simple it is to draw models, lines and interact with your fingers.

* Download finger-painting sample application requirement [StereoKitPaintTutorial_UWP](https://github.com/maluoi/StereoKit-PaintTutorial) from GitHub [maluoi/ StereoKit-PaintTutorial](https://github.com/maluoi/StereoKit-PaintTutorial)

After the download is complete, you may see the Solution Explorer hierarchy. The hierarchy includes Assets, Painting Menu, Palette Menu, and Main Program.

## 3D model assets

After importing the StereoKit UWP Templates, open them in Visual Studio 2019. In the solution explorer, look for the Assets folder. The assets folder can be used to store assets such as model files. Asset loading is usually done during the build phase rather than during the run phase.

## Painting Menu

This painting menu is created using painting.cs class contains the entire concept of finger painting. It takes in hand input and turns it into three-dimensional lines. It includes the undoing option by pushing the last stroke into the undo stack and removing it from the painting. In the redo, the most recent Undo off the stack and add it to the painting. Next, it gets the hand's fingertip, converts it to local space, and smooths out to reduce any jagged noise. Here we convert the fingertip's coordinates into hierarchy local coordinates before we can work with it. We start drawing using two points. The first one begins at the point provided, and the second one will continuously be updated to the current fingertip location. Next, it Calculates the current distance from the last point and the speed at which the hand is traveling. It'll add a new point if it's more than a centimeter away from our last point. Finally, it adds the active stroke to the painting and clears it out for the next one. In this file, each line is a paint stroke. Later each paint stroke in painting needs to be converted into a file and join all data together. It's also in charge of loading and saving painting files. This painting.cs class can be seen in the StereoKit's Hierarchy system.

## Palette Menu

The objective of the palette menu is created using palette.cs class is to handle painting settings and to give the user palette UI. It's made up of two 3D models. One is for the root object, and the other one is used for the paint swatches. It overrides the shader while loading it to the UI shader, which gives the user a better experience. Here the handle is added to the pallet so that they move it around wherever they see fit. Slider is added to adjust the brushstroke's size. Then we also draw the brushstroke above it so we can have a preview of the size as well.

## Main Program


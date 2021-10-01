This is a StereoKit introduction tutorial designed to teach people the fundamentals of drawing and interacting with Mixed Reality content. You'll learn how to make a core application loop radial hand menus, easy window menus with automatic layout, object-based menus with more explicit layouts, and file pickers, among other things. You'll also discover how simple it is to draw models, lines and interact with your fingers.

* Download finger-painting sample application requirement [StereoKitPaintTutorial_UWP](https://github.com/maluoi/StereoKit-PaintTutorial) from GitHub [maluoi/ StereoKit-PaintTutorial](https://github.com/maluoi/StereoKit-PaintTutorial)

You can see the Solution Explorer hierarchy after the download is complete. Assets, Painting Menu, Palette Menu, and Main Program may be found in the hierarchy.

## 3D model assets

Open the StereoKit UWP Templates in Visual Studio 2019 after importing them. The Assets folder can be found in solution explorer. Assets, such as model files, can be stored in the assets folder.
Loading assets is generally done during the build time rather than during the run time.

* 3D Model Assets Types

## Painting Menu

This painting menu which is created using painting.cs class contains the entire concept of finger painting. It takes in hand input and turns it into three-dimensional lines. It includes undo option by pushing the last stroke into the undo stack, and remove from the painting. In redo most recent Undo off the stack, and add it to the painting. It Get the hand's fingertip, convert it to local space, and smooth it out to reduce any jagged noise. Here we convert the fingertip's coordinates into Heirarchy local coordinates before we can work with it. We start drwaing using two points. The first one begins at the point provided and the second one will always be updated to the current fingertip location. It Calculate the current distance from the last point, as well as the speed at which the hand is traveling. If it's more than a centimeter away from our last point, it'll add a new point. It addes the active stroke to the painting, and clear it out for the next one. In this file, each line is a paint stroke. Later each paint stroke in painting needs to be convereted into file and join all data togethere. It's also in charge of loading and saving painting files. This painting.cs class can be seen in the StereoKit's Hierarchy system.

## Palette Menu

This object menu handles painting settings, and it's meant to look like a real-world painting palette. It's made up of a couple of touchable color-changing 3D models that are put in particular locations, as well as a UI slider that regulates stroke size.

The objective of painting menu which is created using painting.cs class is to handle painting settings, and to give the user palette UI. It's made up of two 3D models. One is for the root object, and the other one is used for the paint swatches. It override the shader while loading it to the UI shader which gives user the better experience. Here the handle is added to the pallet so that they move it around wherever they see fit. Slider is added to adjust the brushstroke's size. Then we also draw the brushstroke above it so we can have a preview of the size as well.

## Main Program


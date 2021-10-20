From the previous chapter, you have a basic understanding of how 3D models, hand stimulation, and UI button work in StereoKit. In this module, You'll understand how the StereoKit Ink application is developed to configure radial hand menus, easy window menus with automatic layout, and object-based menus with more explicit layouts.

> [!Important]
> Make sure you have installed ** StereoKit's Visual Studio template**.

First, download the StereoKit Ink sample application from [GitHub repository](https://github.com/maluoi/StereoKit-PaintTutorial/tree/feature/sk_ink). Then click on the **Code** button & select **Download ZIP**. Once the download is completed, click on the folder & select the **StereoKitInk.sln** file. Then **solution file** will open in Visual Studio. On the right corner of the Visual Studio, you can find **Solution Explorer**, which contains the **assets folder** and three other **program files** such as the painting menu, palette menu, and main program, which operates the main logic.

> [!Note]
> The program will contain errors, which will be cleared at a later time during debugging.

## 3D model assets

Look for the **Assets folder** in the solution explorer. This folder contains **InkBottle.glb**, **InkSplat.glb**, and **StereoKitInkLight.png** model and image files used later in the application.

## Painting menu

Under Solution Explorer, you'll find the painting menu. This painting menu is created using **Painting.cs** class, which contains the entire concept of finger painting. It accepts your manual input and generates three-dimensional lines out of it.

It has an **undo** option that removes the most recent undo from the stack and adds it to the Painting, and a **redo** option removes the most recent undo from the stack and adds it to the Painting. Finally, it takes the fingertip of the hand, translates it to local space, smooths it out to reduce any jagged noise, and converts the fingertip's coordinates into hierarchy local coordinates before it works with it.

Here you start drawing using two points. The first one begins at the point provided, and the second one will continuously be updated to the current fingertip location. Next, it calculates the current distance from the last point and the hand's speed. It will add a new point if it's more than a centimeter away from our last point. Finally, it adds the active stroke to the Painting and clears it out for the next one.

In this file, each line is a paint stroke. Later each paint stroke in Painting will be converted into a file and joins all the data together. It's also in charge of loading and saving painting files.

## Palette menu

Using **PaletteMenu.cs** class you can create the palette menu. This program's objective is to handle painting settings to provide a palette UI. It consists of two **3D models**. The first 3D model, **InkBottle.glb**, is used for decoration and displays vibrant colors, while the second, **InkSplat.glb**, allows users to choose colors. The handle is attached to the pallet here so that it can be moved around as needed.

Swatches have a **slider** that allows you to manually adjust the Hue, Saturation, and Value of their color. In addition, this application overrides the shader when loading it into the UI shader, providing a better user experience. A slider has also been added to modify the size of the brushstrokes.

## Main program

In the Main Program, you can find **Program.cs** class. This integrates the hand menu, the application menu, and the application logic. This is the main program that binds everything together.

Here you can prepare a few options at initialization, such as the **assets folder** and **appName**. When StereoKit is given a relative folder name, it will search for assets in the **assets folder** folder.

You store quick actions in a simple radial hand menu. It's activated by a grip motion and is ideal for quick, gesture-like menu item activation.

The main program also controls the application's menu window. When the **save** button is pressed, a save file dialogue should appear. After a file name and folder have been provided, it should call the SavePainting method with the file's pathname and the .skp extension. The **load** button allows the user to choose any .skp file and execute the **LoadPainting** method, whereas the **clear** button creates a new Painting object. Finally, the **quit** button tells the StereoKit to finish the frame properly, break out the loop, and end the window.

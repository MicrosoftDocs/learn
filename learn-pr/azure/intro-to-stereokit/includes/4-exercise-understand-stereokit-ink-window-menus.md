From the previous chapter, you have a basic understanding of StereoKit Ink application. In this module, how the StereoKit Ink application was developed will be covered along with its scripts.

> [!Important]
> Make sure you have installed **StereoKit's Visual Studio template**.

First, download the StereoKit Ink sample application from [GitHub repository](https://github.com/maluoi/StereoKit-PaintTutorial/tree/feature/sk_ink). Then click on the **Code** button & select **Download ZIP**. Once the file download is done, click on the folder & select the **StereoKitInk.sln** file. Then **solution file** will open in Visual Studio. On the right corner of the Visual Studio, you can find **Solution Explorer**, which contains the **assets folder** and three other **program files** such as the painting menu, palette menu, and main program, which operates the main logic.

:::image type="content" source="../media/scripts.png" alt-text="Screenshot of solution explorer with script list.” " lightbox="../media/scripts.png":::

> [!Note]
> The program will contain errors, which will clear at a later time during debugging.

The Main Program is created using **program.cs** class. This program integrates the hand menu, the application menu, and the application logic, and it is the main program that binds everything together.

The project starts with a few initializations. First, we can prepare a few settings, such as the **assets folder** and **appName**. Then, with the help of initialization, basic needs like getting hands, environment, and lighting will be present right away.

``` c#
SKSettings settings = new SKSettings
  {
   appName = "StereoKit Ink",
   assetsFolder = "Assets",
  };
  if (!SK.Initialize(settings))
  Environment.Exit(1);
```

**assetsFolder** : When StereoKit is given a relative folder name, it will look in this folder for assets. In this project, 3D models are in **.glb** extensions and image with **.png** extensions are stored.

## Ink tools window

Ink tools window contains all the drawing features such as brush properties, color properties.

  :::image type="content" source="../media/ink-tools-window.png" alt-text="Screenshot of Ink tools window.” " lightbox="../media/ink-tools-window.png":::

The Ink window is a standard window that carries all ink brush settings, and the Ink window function is invoked from the palette script. **Step()** is the method from **program.cs** script:

``` c#
UI.WindowBegin("Menu", ref menuPose, UIWin.Body);
```

**UI.WindowBegin** : Function creates a new window, where the **ink** text can be added on top of the window.

``` c#
Pose menuPose = new Pose(0.4f, 0, -0.4f, Quat.LookDir(-1,0,1));
```

**Pose** : This will add a new pose to the transform. The window's top-center is the location of the pose.

> Pose represents a location and orientation in space, excluding scale

For opened window, we will be loading InkBottle and InkSplat models from the asset folder.

```c#
Model _model       = Model.FromFile("InkBottle.glb");
Model _swatchModel = Model.FromFile("InkSplat.glb");
```

**Model Class** : A model is a visual element made up of meshes, materials, and transforms. It is an excellent technique to put together large things with several sections, and most of the model formats are constructed in this way.

```c#
UI.Model(_model, V.XY(0, UI.LineHeight*2));
```

  :::image type="content" source="../media/inkpot.png" alt-text="Screenshot of inkpot model in Ink tools window.” " lightbox="../media/inkpot.png":::

**UI.Model** : Creates a single mesh subset Model using the indicated Mesh and Material. To highlight the area's purpose, display an ink bottle. The x-axis will autofill to center the Model, and we'll make it two lines tall using the size specified here. **V.VY** Creates a Vec2. This is a straight alternative to **new Vec2(x, y)**.

### Swatches

 The bottom of the ink window has an ink model that shows a list of colors swatches that are pre-selected and displayed in the window.

  :::image type="content" source="../media/inkcolor.png" alt-text="Screenshot of ink colors in ink tools window.” " lightbox="../media/inkcolor.png":::

Check out the SwatchColor function below to see how these color swatches are applied as custom buttons.

```c#
float _hue = 0;

SwatchColor("White", _hue, 0,   1);

void SwatchColor(string id, float hue, float saturation, float value)
 {
  // Reserve a spot for this swatch!
  Bounds bounds = UI.LayoutReserve(_swatchModel.Bounds.dimensions.XY);
  bounds.dimensions.z = U.cm*4;

  // Draw the swatch model using the color it represents! We'll also
  // add some pseudo-random rotation to prevent it from looking too
  // repetitious.
  _swatchModel.Draw(Matrix.TR(bounds.center, Quat.FromAngles(0,0,bounds.center.x*70000+bounds.center.y*30000)), Color.HSV(hue, saturation, value));

  // If the users interacts with the volume the swatch model is in,
  // then we'll set the active color right here, and play some sfx!
  BtnState state = UI.VolumeAt(id, bounds, UIConfirm.Push);
  if (state.IsJustActive())
  {
   Sound.Click.Play(Hierarchy.ToWorld(bounds.center));
   SetColor(hue, saturation, value);
  }
  if (state.IsJustInactive())
   Sound.Unclick.Play(Hierarchy.ToWorld(bounds.center));
 }
```

**Matrix.TR** - In StereoKit, a matrix is a 4x4 grid. Numbers in the matrix represent a transformation for every position or vector. Here Matrix. TR is used for the rotation of the swatch.

**SwitchColor() method** : Using bound reserves the swatch and using color represents to draw the swatch model. Pseudo-random rotation keeps it shuffled.

**Bounds** : Bounds are a type of axis-aligned bounding box that can store item sizes, calculate confinement, intersections, and more.

When a user interacts with the swatch model's volume, the vibrant color will change and add some sound effects.

#### Keywords

* **U.cm** : Converts centimeters to meters.

* **BtnState** : A bit-flag represents the current state of a button input.

  * With pseudo rotation, we will position all swatches in the same line as in the swatch function.

  * To keep UI in the same line, we use:

  ```c#
  UI.SameLine();
  ```

### Slider instantiate

Swatches are not limited. Hence there is some slider to adjust HSV the color manually. Then we can have a fixed-size label and add a fixed-size slider to the same line. Fixing the sizes are aligned in the column using:

  :::image type="content" source="../media/slider.png" alt-text="Screenshot of slider in ink tools window.” " lightbox="../media/slider.png":::

```c#
UI.Label("Hue", V.XY(8*U.cm, UI.LineHeight));
    UI.SameLine();
    if (UI.HSlider("Hue", ref _hue, 0, 1, 0, 22*U.cm, UIConfirm.Pinch))
        SetColor(_hue, _saturation, _value);
```

**UI.Lable** : Adds some text to the layout.

**UI.Hslider** : Make a horizontal slider element called Hue. You can slide the value up and down.

**Set color()** : This method updates the ink model and hand color by creating a Red/Green/Blue gamma space color from Hue/Saturation/Value information. Using the same methods, we can create sliders for saturation and value.

Within the UI window, we can add on the separation by using the below method that adds the line between UI elements.

```c#
UI.HSeparator();
```

### Brush size

There are four different size swatch models in the window, similar to color swatches but more control over brush size.

  :::image type="content" source="../media/brush-size.png" alt-text="Screenshot of brush size slider.” " lightbox="../media/brush-size.png":::

 ```c#
 float _size  = 2 * U.cm;

 if (SwatchSize("Small", 1*U.cm)) _size = 1 * U.cm;

 bool SwatchSize(string id, float size)
 {
  // Reserve a spot for this swatch!
  Bounds bounds = UI.LayoutReserve(Vec2.One * 4 * U.cm);
  bounds.dimensions.z = U.cm*4;

  // Draw a swatch model using the size it represents! We'll also
  // add some pseudo-random rotation to prevent it from looking too
  // repetitious.
  _swatchModel.Draw(Matrix.TRS(bounds.center, Quat.FromAngles(0, 0, bounds.center.x * 70000 + bounds.center.y * 30000), size*(1/.04f)), Color.HSV(_hue, _saturation, _value));

  // If the users interacts with the volume the swatch model is in,
  // then we'll notify the caller by returning true.
  BtnState state = UI.VolumeAt(id, bounds, UIConfirm.Push);
  if (state.IsJustActive())
  {
   Sound.Click.Play(Hierarchy.ToWorld(bounds.center));
   return true;
  }
  if (state.IsJustInactive())
   Sound.Unclick.Play(Hierarchy.ToWorld(bounds.center));
  return false;
 }
 ```

* This method also uses bound to reserve the swatch and color represents to draw the swatch model. Pseudo-random rotation keeps it shuffled. Will notify the caller by returning true if the user interacts with the swatch model's volume.

* Using a similar method, we can create the brush sizes like medium, large, extra-large.
* We can also adjust the brush size using the slider.

  ```c#
  UI.Label("Size", V.XY(8 * U.cm, UI.LineHeight));
  UI.SameLine();
  UI.HSlider("Size", ref _size, 0.001f, 0.05f, 0, 22 * U.cm, UIConfirm.Pinch);
  ```

* In final, we always call end window function.

  ```c#
  UI.WindowEnd();
  ```

* There will be a preview of the brush size. Then, with the box to handle the brush stroke's size, preview the stroke with a cube scaled to the brush's size.

  ```c#
  Bounds linePreview = UI.LayoutReserve(V.XY(0, 0.05f));
  linePreview.dimensions.y = _size;
  linePreview.dimensions.z = U.cm;
  Mesh.Cube.Draw(Material.Unlit, Matrix.TS(linePreview.center, linePreview.dimensions), _color);
  ```

**Matrix.TS** : Translate, Scale that creates a transform Matrix using both these components.

## Ink functional window

Ink functional window contains of functional buttons such as Undo, Redo, Clear, Quit, Save, and Load.

  :::image type="content" source="../media/ink-functional-window.png" alt-text="Screenshot of On the toggle button to enable “Developer Mode.” " lightbox="../media/ink-functional-window.png":::

The function **StepMenuWindow()** in the main program(**program.cs**) script is used to initialization **Ink Functional Window**.

**Ink functional window** is started using **UI.WindowBegin** function.
This window is only with body form without the headboard since StereoKitInkLight is an excellent application picture that can be used.

```c#
static Pose menuPose = new Pose(0.4f, 0, -0.4f, Quat.LookDir(-1,0,1));

UI.WindowBegin("Menu", ref menuPose, UIWin.Body);
```

The below code adds the application logo on the window top. **V.XY** instructs StereoKit to auto-size both axes, causing this to stretch to the window's width.

```c#
UI.Image(appLogo, V.XY(UI.LayoutRemaining.x, 0));
```

Undo and Redo functional button is added using **UI.Button**.

```c#
if (UI.Button("Undo")) activePainting?.Undo();
UI.SameLine();
if (UI.Button("Redo")) activePainting?.Redo();
```
**UI.Button**  : A button that can be clicked and can extend vertically and horizontally to suit the text provided to the button.

On the same basis, all other buttons can be added, such as Save, Load, Clear, and Quit.



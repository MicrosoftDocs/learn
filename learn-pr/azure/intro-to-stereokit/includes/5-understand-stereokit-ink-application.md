From the previous chapter, you have a basic understanding of the StereoKit Ink application. In this module, we will understand the three main programs; used to build this application. The code strives to be very legible and easy to understand.

## Program.cs script

The application logic, the hand menu, and the application menu are all contained here! Because the application menu connects everything, it's a terrific place to start.

* **Initialization**: The Program.cs script starts with a few settings like the assetsFolder and appName. The assets folder is where StereoKit will look for assets, given a relative folder name is provided.

    ```c#
    SKSettings settings = new SKSettings
      {
       appName      = "StereoKit Ink",
       assetsFolder = "Assets",
      };

    if (!SK.Initialize(settings))
    Environment.Exit(1);
    ```

* **Radial hand menu**: Radial hand menus are an easy way to store actions out of the way. In addition, these menus are easily accessible to the user. Selecting any option from the menu can trigger actions or even open a series of sub-options for the users to choose.

    It's actuated by a grip motion and is ideal for quick, gesture-like menu item activation. It can also be combined with several HandRadialLayers to create sub-menus. These menus are paired up with the **Steppers** classes. Once added to the StereoKit's stepper list, they will have their **Step** method called each frame. It is a great way to add objects that need to update each frame.

    :::image type="content" source="../media/radial-menu.png" alt-text="Screenshot of radial menu.” " lightbox="../media/radial-menu.png":::

    ```c#
    SK.AddStepper(new HandMenuRadial(
       new HandRadialLayer("Root", -90,
        new HandMenuItem("Undo", null, ()=>activePainting?.Undo()),
        new HandMenuItem("Redo", null, ()=>activePainting?.Redo()))));
    ```

* **Step the application each frame**: Once the palette menu is initialized, the app logo is loaded, the application is stepped each frame until it is asked to exit. The input information required to create brush strokes is sent to painting. Later, Step the palette UI and the application's menu. Application menu stores options like save/load, clear, and quit.

    ```c#
    while (SK.Step(() =>
      {
       activePainting.Step(Handed.Right, paletteMenu.PaintColor, paletteMenu.PaintSize);

       paletteMenu.Step();

       StepMenuWindow();
      }));
    ```

* **Application's menu window**: The application's menu window is made using a nice application image instead of a head bar (body only). The logo is positioned neatly at the top of the menu window. Although the undo and redo options are present in the radial hand menu designed earlier, it is included here as it'll be easier to discover.

    The save option is also included in the window. The user on clicking the save button, let's show a file dialog where; the user is prompted to select the file name and the folder. The file is saved in **.skp** extension.

    The **Load** option allows users to load the previously created .skp files. The **Clear** option helps user to create a new painting. When the user wants to **Quit** then the Step loop is broken.

    :::image type="content" source="../media/ink-functional-window.png" alt-text="Screenshot of On the toggle button to enable “Developer Mode.” " lightbox="../media/ink-functional-window.png":::

    ```c#
    static void StepMenuWindow()
     {
  
      UI.WindowBegin("Menu", ref menuPose, UIWin.Body);

      UI.Image(appLogo, V.XY(UI.LayoutRemaining.x, 0));
  
      if (UI.Button("Undo")) activePainting?.Undo();
      UI.SameLine();
      if (UI.Button("Redo")) activePainting?.Redo();

     if (UI.Button("Save"))
      Platform.FilePicker(PickerMode.Save, SavePainting, null, ".skp");

     UI.SameLine();
      if (UI.Button("Load"))
       Platform.FilePicker(PickerMode.Open, LoadPainting, null, ".skp");

     UI.HSeparator();

      if (UI.Button("Clear"))
       activePainting = new Painting();

      UI.SameLine();
      if (UI.Button("Quit"))
       SK.Quit();
  
      UI.WindowEnd();
     }
    ```

## PaletteMenu.cs script

It is a menu that allows you to change the painting options. It's primarily made up of pre-built UI pieces, also showing how to make your own with StereoKit's layout and interaction capabilities.

* **Loading models**: Both of these models are used in the user interface! The first is a bottle that will serve as decoration and context while also displaying the active color, and the second is a "splash of ink" that will be turned into a pressable button that will allow users to select colors.

    ```c#
     Model _model       = Model.FromFile("InkBottle.glb");
     Model _swatchModel = Model.FromFile("InkSplat.glb");
     
     Pose  _pose  = new Pose(-.4f, 0, -0.4f, Quat.LookDir(1,0,1));
     Color _color = Color.White;
     
     float _size  = 2 * U.cm;
     float _hue = 0;
     float _saturation = 0;
     float _value = 1;
     ```

* **Standard window**: The standard window is used to store all the ink brush settings. The ink bottle is used to draw attention to the area's function. The size specified here will auto-fill on the x-axis, centering the model and doubling its height to two lines.

  :::image type="content" source="../media/ink-tools-window.png" alt-text="Screenshot of Ink tools window.” " lightbox="../media/ink-tools-window.png":::

    ```c#
    UI.WindowBegin("Ink", ref _pose);

    UI.Model(_model, V.XY(0, UI.LineHeight*2));
    ```

* **Color swatches**: It Shows a list of color swatches that have been pre-loaded. Then, check out the SwatchColor function below to see how these color swatches are applied as custom buttons.

  :::image type="content" source="../media/inkcolor.png" alt-text="Screenshot of ink colors in ink tools window.” " lightbox="../media/inkcolor.png":::

    ```c#
  SwatchColor("White", _hue, 0,   1);
  UI.SameLine();
  SwatchColor("Gray",  _hue, 0, .6f);
  UI.SameLine();
  SwatchColor("Blk",   _hue, 0, SK.System.displayType == Display.Additive ? 0.25f : 0);
  UI.SameLine();
  SwatchColor("Green", .33f, .9f, 1);
  UI.SameLine();
  SwatchColor("Ylw",   .14f, .9f, 1);
  UI.SameLine();
  SwatchColor("Red",   0,    .9f, 1);

  UI.Space(UI.LineHeight*0.5f);
    ```

* **Sliders**: A slider will move in increments between two values. Therefore, the function requires a reference to a float variable where the slider's state is stored. It allows you to handle the state independently, and it's perfectly acceptable to modify the slider state without affecting the UI element.

    By themselves, swatches are never enough. So here are some sliders that let the user manually HSV their color. We'll start with a fixed-size label and then add a fixed-size slider to the same line. Fixing the sizes here makes it easier for them to align in columns.

    :::image type="content" source="../media/slider.png" alt-text="Screenshot of slider in ink tools window.” " lightbox="../media/slider.png":::

    ```c#
    UI.Label("Hue", V.XY(8*U.cm, UI.LineHeight));
  UI.SameLine();
  if (UI.HSlider("Hue", ref _hue, 0, 1, 0, 22*U.cm, UIConfirm.Pinch))
   SetColor(_hue, _saturation, _value);

  UI.Label("Saturation", V.XY(8*U.cm, UI.LineHeight));
  UI.SameLine();
  if (UI.HSlider("Saturation", ref _saturation, 0, 1, 0, 22*U.cm, UIConfirm.Pinch))
   SetColor(_hue, _saturation, _value);

  UI.Label("Value", V.XY(8*U.cm, UI.LineHeight));
  UI.SameLine();
  if (UI.HSlider("Value", ref _value, 0, 1, 0, 22*U.cm, UIConfirm.Pinch))
   SetColor(_hue, _saturation, _value);

  UI.HSeparator();
  ```

* **Size swatches**: The users can also customize the sizes of brush strokes. To do so, they are provided with size swatches. These swatches are comparable to color swatches, except they have more control over the swatch size.

    Users can have a preview of the brush strokes before committing to it. We'll set aside a large box to handle the brush stroke's maximum size and preview the stroke with an unlit cube scaled to the brush's size.

    :::image type="content" source="../media/brush-size.png" alt-text="Screenshot of brush size slider.” " lightbox="../media/brush-size.png":::

    ```c#
    UI.LayoutReserve(V.XY(8*U.cm,0));

  UI.SameLine();
  if (SwatchSize("Small", 1*U.cm)) _size = 1 * U.cm;
  UI.SameLine();
  if (SwatchSize("Med",   2*U.cm)) _size = 2 * U.cm;
  UI.SameLine();
  if (SwatchSize("Lrg",   3*U.cm)) _size = 3 * U.cm;
  UI.SameLine();
  if (SwatchSize("Xtra",  4*U.cm)) _size = 4 * U.cm;

  UI.Label("Size", V.XY(8 * U.cm, UI.LineHeight));
  UI.SameLine();
  UI.HSlider("Size", ref _size, 0.001f, 0.05f, 0, 22 * U.cm, UIConfirm.Pinch);

  Bounds linePreview = UI.LayoutReserve(V.XY(0, 0.05f));
  linePreview.dimensions.y = _size;
  linePreview.dimensions.z = U.cm;
  Mesh.Cube.Draw(Material.Unlit, Matrix.TS(linePreview.center, linePreview.dimensions), _color);
    ```

* **Colorize**: It Changes the material of the ink bottle to match the current hue. In addition, you can colorize the user's hand mesh.  Input might also be used to set specific hands to a custom material using Input.HandMaterial.

    ```c#
    void SetColor(float hue, float saturation, float value)
    {
  _hue        = hue;
  _saturation = saturation;
  _value      = value;
  _color      = Color.HSV(hue,saturation,value);

  _model.RootNode.Material[MatParamName.ColorTint] = _color;

  Default.MaterialHand[MatParamName.ColorTint] = _color;
  }
  ```

## Painting.cs script

This class captures the entire concept of finger painting! It takes in hand input and turns it into three-dimensional lines. It's also in charge of loading and saving painting files. StereoKit's Hierarchy structure can be found here as well.

* **Create a child of handle**: We'll turn the entire painting into a child of a handle so that we can move it around while we work on it! Handles and Windows push a transform onto the Hierarchy stack, making all subsequent locations relative to it.

  :::image type="content" source="../media/handle.png" alt-text="Screenshot of handle.” " lightbox="../media/handle.png":::

    ```c#
    public void Step(Handed handed, Color color, float thickness)
    {
  
  UI.HandleBegin("PaintingRoot", ref _pose, new Bounds(Vec3.One * 5 * U.cm), true);

  UpdateInput(handed, color, thickness);
  Draw();
  UI.HandleEnd();
  }
  ```

* **Undo stack**: A stack is a collection of objects ordered from last in to first out. When you need last-in, first-out access to items, this is the method to utilize. For the **undo** function, you push the last stroke of the painting onto the stack and remove it from the painting. However, you pop the recent undo off the stack and add it to the painting for the **redo** function.

    ```c#
    public void Undo()
    {
        if (_strokeList.Count == 0)
        return;
         _undoStack.Push(_strokeList.Last());
         _strokeList.RemoveAt(_strokeList.Count-1);
    }
  public void Redo()
  {
      if (_undoStack.Count == 0)
      return;
      _strokeList.Add(_undoStack.Pop());
  }
   ```

* **Translate the fingertip coordinates into Hierarchy local coordinates**: To eliminate any jagged noise, get the hand's fingertip, transfer it to local space, and smooth it down. Of course, the hand position data is always provided in world space. Still, we need to convert the fingertip's coordinates into Hierarchy local coordinates before dealing with it because we're inside an Affordance that uses the Hierarchy stack.

  :::image type="content" source="../media/hand.png" alt-text="Screenshot of hand.” " lightbox="../media/hand.png":::

    ```c#
  Hand hand      = Input.Hand(handed);
  Vec3 fingertip = hand[FingerId.Index, JointId.Tip].position;
  fingertip = Hierarchy.ToLocal(fingertip);
  fingertip = Vec3.Lerp(_prevFingertip, fingertip, 0.3f);
  ```

* **Pinching motion**: The paint strokes are initiated from the user's end when performing the pinch motion, not interacting with the UI elements. Therefore, the paint strokes are continuously updated with the current Step information. When the user ceases the pinch motion, the paint stroke is considered to be completed.

    ```c#
    if (hand.IsJustPinched && !UI.IsInteracting(handed))
  { 
   BeginStroke(fingertip, color, thickness);
   _isDrawing = true;
  }

  if (_isDrawing)
   UpdateStroke(fingertip, color, thickness);
  if (_isDrawing && hand.IsJustUnpinched)
  {
   EndStroke();
   _isDrawing = false;
  }
  _prevFingertip = fingertip;
  ```

* **Popping effect**: Let's start with two points. The first starts at the specified location, while the second is updated to the current fingertip location. When we reach a particular distance from the previous point, we add additional points. Still, a naive implementation can result in a popping effect if points are merely added at distance intervals. This 'popping' artifact will be effectively prevented by the extra point that directly follows the fingertip.

    We will begin with calculating the distance between the current and the previous point and the pace at which the hand moves. Later, make a point at the current location by utilizing speed as the stroke thickness.

    We'll add a new point if we're more than a centimeter away from our previous point! This is straightforward, but it works well enough. A higher-quality implementation might include an error/change function that considers angle change. Otherwise, to avoid 'popping' while adding a new point, the last point in the stroke should always be at the current fingertip location.

    ```c#
    void UpdateStroke(Vec3 at, Color32 color, float thickness)
    {
  Vec3  prevLinePoint = _activeStroke[_activeStroke.Count - 2].pt;
  float dist  = Vec3.Distance(prevLinePoint, at);
  float speed = Vec3.Distance(at, _prevFingertip) / Time.Elapsedf;

  LinePoint here = new LinePoint(at, color, Math.Max(1 - speed * 0.5f, 0.1f) * thickness);

  if (dist > 1 * U.cm)
   _activeStroke.Add(here);
  else
   _activeStroke[_activeStroke.Count - 1] = here;
   }
   ```

* **Language Integrated Query (LINQ)**: The query expression is the most evident "language-integrated" aspect of LINQ for a developer who writes queries. Declarative query syntax is used to write query expressions. You may perform filtering, ordering, and grouping actions on data sources with a minimum of code by using query syntax.

    Linq is being used to parse a file! Linq is a functional programming language that, if learned, can be considerably useful. Linq is not a good choice for performance-critical areas, but it's fine for discrete occurrences.

    Each line in this file represents a paint stroke, with a comma between each point on that stroke. Each item within a point is separated by spaces, which LinePointFromString takes care of.

    ```c#
    public static Painting FromFile(string fileData)
    {
  Painting result = new Painting();
  result._strokeList = fileData
  .Split('\n')
  .Select( textLine => textLine
  .Split(',')
  .Select(textPoint => LinePointFromString(textPoint))
  .ToArray())
  .ToList();
  return result;
  }
  ```

* **Converting the painting file**: Converting this painting to a file is easy. We can use LinePointToString for each point, and then we need to join all of the data together. For example, '\n' separates each paint stroke on its line, and a comma separates each point on that stroke.

    ```c#
    public string ToFileData()
    {
        return string.Join('\n', _strokeList
        .Select(line => string.Join(',', line
        .Select(point => LinePointToString(point)))));
    }
    
    static string LinePointToString(LinePoint point)
    { 
        return string.Format("{0} {1} {2} {3} {4} {5} {6}",
        point.pt   .x, point.pt   .y, point.pt   .z,
        point.color.r, point.color.g, point.color.b,
        point.thickness);
    }
    
    static LinePoint LinePointFromString(string point)
    {
        string[]  values = point.Split(' ');
        LinePoint result = new LinePoint();
        result.pt   .x = float.Parse(values[0]);
        result.pt   .y = float.Parse(values[1]);
        result.pt   .z = float.Parse(values[2]);
        result.color.r = byte .Parse(values[3]);
        result.color.g = byte .Parse(values[4]);
        result.color.b = byte .Parse(values[5]);
        result.color.a = 255;
        result.thickness = float.Parse(values[6]);
        return result;
    }
    ```

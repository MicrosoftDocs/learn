From the previous chapter, you have a basic understanding of how the main program.cs class is used in the StereoKit Ink application to instantiate the palette menu, edit menu, and anchor. In this module, You'll understand how the application is developed to configure radial hand menus and hand interaction.

## Radial menu

The StereoKit Ink application uses a basic radial hand menu to keep some quick actions! It's activated by a grip motion and is ideal for quick gesture-like menu item activation. It can also be combined with several submenus.

:::image type="content" source="../media/radial-menu.png" alt-text="Screenshot of radial menu.” " lightbox="../media/radial-menu.png":::

The below function shows the simple radial menu with undo and redo buttons used in the application.

```c#
SK.AddStepper(new HandMenuRadial(
new HandRadialLayer("Root", -90,new HandMenuItem("Undo", null, ()=>activePainting?.Undo()),new HandMenuItem("Redo", null, ()=>activePainting?.Redo()))));
```

**Steppers** : these are the classes that implement the IStepper interface and will have their Step function called every frame after being added to StereoKit's stepper list! This is an excellent approach to add items or systems that need to be updated every frame.

**HandMenuRadial** : creates a hand menu from the provided array of menu layers.

**HandRadialLayer** : this class represents a single layer In the HandRadialMenu. Each item in the layer is displayed around the radial menu in the application.

**HandMenuItem** : this is a collection of data about how a single hand menu item appears and behaves.

### Undo and Redo buttons

:::image type="content" source="../media/undo-redo-buttons.png" alt-text="Screenshot of Undo and Redo buttons.” " lightbox="../media/undo-redo-buttons.png":::

* **Undo button** -  Undo method removes the last stroke from the painting by pushing it into the undo stack.

```c#
List<LinePoint[]>  _strokeList   = new List<LinePoint[]>();
Stack<LinePoint[]> _undoStack    = new Stack<LinePoint[]>();
```

```c#
_undoStack.Push(_strokeList.Last());
_strokeList.RemoveAt(_strokeList.Count-1);
```

**Stack** : A stack is a conceptual structure consisting of a collection of the same data type that works on the last in, first out principle (LIFO).

* **Redo button** - The Redo method removes the most recent undo from the stack and adds it to the painting.

```c#
_strokeList.Add(_undoStack.Pop());
```

## Painting

The **Painting.cs** class is used to create the drawing functionality in painting. The information for this painting will be provided from the main program to produce brush strokes in the drawing.

```c#
static Painting    activePainting = new Painting();
```

```c#
activePainting.Step(Handed.Right, paletteMenu.PaintColor, paletteMenu.PaintSize);
```

### 1. Use draw anchor

By making the whole painting as a child of the handle, we can move it around while working with it! Both handles and windows push a transform onto the hierarchy stack, making all subsequent locations relative to it.

:::image type="content" source="../media/handle.png" alt-text="Screenshot of handle.” " lightbox="../media/handle.png":::

```c#
Pose _pose  = new Pose(0, 0, -0.8f, Quat.Identity);
```

```c#
public void Step(Handed handed, Color color, float thickness)
{
UI.HandleBegin("PaintingRoot", ref _pose, new Bounds(Vec3.One * 5 * U.cm), true);
UpdateInput(handed, color, thickness);
Draw();
UI.HandleEnd();
}
```

**Handed** : is an enum that indicates which hand to use in the project. In this project, we're using the right hand.

**HandleBegin**: it starts a new UI group with its layout! It appears like a window, but it has a more flexible handle and no header. It returns true for every frame when a user is grabbing the handle by drawing the handle.

**HandleEnd** : It completes a handle function! It must be called after the UI. HandleBegin(), and all of the elements have been drawn.

**UpdateInput()** : this method takes the fingertip of the hand, translates it to local space, smooths it out to reduce any jagged noise, and converts the fingertip's coordinates into hierarchy local coordinates.

### 2. Hand interaction in StereoKit Ink

The hand's position data is always provided in world space. However, since we'll be inside of an Affordance that uses the Hierarchy stack, we need to convert the fingertip's coordinates into Hierarchy local coordinates before we can deal with it.

:::image type="content" source="../media/hand.png" alt-text="Screenshot of hand.” " lightbox="../media/hand.png":::

```c#
Hand hand      = Input.Hand(handed);
Vec3 fingertip = hand[FingerId.Index, JointId.Tip].position;
fingertip = Hierarchy.ToLocal(fingertip);
fingertip = Vec3.Lerp(_prevFingertip, fingertip, 0.3f);
```

**Finger ID** : Every finger has a unique index value! 0-4, from the thumb to the little finger.

**FingerId.Index** : Finger 1 is the primary index/pointer finger.

**JoinId.Tip** - Each finger's end/tip.

If the user made a pinching gesture and isn't interacting with the UI, the application starts with a paint stroke.

```c#
bool _isDrawing;
```

```c#
if (hand.IsJustPinched && !UI.IsInteracting(handed))
{ 
BeginStroke(fingertip, color, thickness);
isDrawing = true;
}
```

**Hand.IsJustPinched** : Checks whether the fingers have pinched the frame.

**BegibStroke** : The user starts to draw using two points. The first one begins at the point provided. The second one will continuously be updated to the current fingertip location.

```c#
if (_isDrawing)
    UpdateStroke(fingertip, color, thickness);
```

**UpdateStroke** : it calculates the current distance from the last point and the hand's speed. It will add a new point if it's more than a centimeter away from our last point.

```c#
if (_isDrawing && hand.IsJustUnpinched)
{
EndStroke();
_isDrawing = false;
}
```

**IsJustUnpinched** : is called when the user stops pinching. Then, the application stops doing whatever stroke it has been doing.

**Endstroke** : it adds the active stroke to the Painting and clears it out for the next one.

```c#
void Draw()
{
Lines.Add(_activeStroke.ToArray());
for (int i = 0; i < _strokeList.Count; i++)
Lines.Add(_strokeList[i]);
}
```

**Draw** : Initially, this method is used to draw the user's unfinished stroke. Each line in the app represents a paint stroke and a part of the painting.

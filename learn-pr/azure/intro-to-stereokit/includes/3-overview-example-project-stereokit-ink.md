So far, you've learned how to install and configure your visual studio, enabling the developer mode. In this module, you'll have a basic understanding of how 3D models, hand stimulation, and UI button work in StereoKit.

## Asset access

In StereoKit, it's a lot easier to load or access a **3D model**. In the solution explorer, the asset folder contains the 3D models that you have imported. The 3D model is stored in **.glb** format, and image files are stored in **.png** format.

## Hand stimulation

Hand stimulation is the interaction with your application. When it comes to user interaction, StereoKit carries a **hands-first approach**. When hand-sensors aren't available, hand data is simulated using an existing device. Say, for example, when you mice the button press causes the Windows Mixed Reality Controllers to switch between pre-recorded hand positions, which allows you to work with fully articulated hand data.

### Accessing hand with joints

Hands are the salient feature in human interaction. In your application, you can interact by choosing different colors of your choice to draw. You can access the below-defined code to find the fingertip of the right hand; if **IsTracked** is ignored, then the last known position of fully joint is given or specified.

``` c#
Hand hand = Input.Hand(Handed.Right);
if (hand.IsTracked)
{
    Vec3 fingertip = hand[FingerId.Index, JointId.Tip].position;
}
```

If you prefer the calling function instead of the operator, you can call using the below-given code.

```c#
 hand.Get(FingerId.Index, JointId.Tip)
```

**Pinching** and **gripping** are two easily accessible functions, which you can use in your StereoKit Ink application. To pinch the frame, use the **JustPinched** function. To unpinch, the frame, use the **JustUnpinched** function. The below code snippet explains the Pinching and gripping functionalities.

```c#
if (hand.IsPinched) { }
if (hand.IsJustPinched) { }
if (hand.IsJustUnpinched) { }
 
if (hand.IsGripped) { }
if (hand.IsJustGripped) { }
if (hand.IsJustUngripped) { }
```

### Hand menu

Hand menu allows you to bring up **hand-attached UI** quickly as it's accessible anytime. Suppose you want to develop a hand menu and know if the user is gazing at their palm. So here is an example for determining this using the palm's position and the dot product.

```c#
static bool HandFacingHead(Handed handed)
{
    Hand hand = Input.Hand(handed);
    if (!hand.IsTracked)
    return false;
    Vec3 palmDirection   = (hand.palm.Forward).Normalized;
    Vec3 directionToHead = (Input.Head.position - hand.palm.position).Normalized;
    return Vec3.Dot(palmDirection, directionToHead) > 0.5f;
}
```

After you've gathered the information, you've to place off a window to the side of the hand.
Different X offset values are required for each hand so that the palm points in the right direction on different sides of each hand.

```c#
public static void DrawHandMenu(Handed handed)
{
    if (!HandFacingHead(handed))
    return;
 
    // Decide the size and offset of the menu
    Vec2  size   = new Vec2(4, 16);
    float offset = handed == Handed.Left ? -2-size.x : 2+size.x;
 
    // Position the menu relative to the side of the hand
    Hand hand   = Input.Hand(handed);
    Vec3 at = hand[FingerId.Little, JointId.KnuckleMajor].position;
    Vec3 down   = hand[FingerId.Little, JointId.Root].position;
    Vec3 across = hand[FingerId.Index,  JointId.KnuckleMajor].position;
    Pose menuPose = new Pose(at, Quat.LookAt(at, across, at-down) * Quat.FromAngles(0, handed == Handed.Left ? 90 : -90, 0));
    menuPose.position += menuPose.Right * offset * U.cm;
    menuPose.position += menuPose.Up * (size.y/2) * U.cm;
    // And make a menu!
    UI.WindowBegin("HandMenu", ref menuPose, size * U.cm, UIWin.Empty);
    UI.Button("Test");
    UI.Button("That");
    UI.Button("Hand");
    UI.WindowEnd();
}
```

## UI buttons

UI buttons allow you to take **actions** and make **choices**. If you want to perform specific actions after any interaction with the objects on the scene, you can use UI buttons.

StereoKit's user interface is based on an **immediate mode approach**. The prime objective of UI APIs is to provide you with a more efficient and functional running environment. You can also define UI on each frame. Maintaining the tiny state, you may easily add, remove, and alter your UI elements using standard and straightforward code structures.

### Making a window

The toggle poses for window off to the left facing right. Float is utilized as a slider, as shown in the image below. The code will be added to the initialization section.

:::image type="content" source="../media/toggle-pose.png" alt-text="Screenshot of toggle pose for the window." lightbox="../media/toggle-pose.png":::

```c#
Pose  windowPose = new Pose(-.4f, 0, 0, Quat.LookDir(1,0,1));

bool  showHeader = true;
float slider     = 0.5f;

Sprite powerSprite = Sprite.FromFile("power.png", SpriteType.Single);
```

As a base unit, StereoKit uses meters. Consider the case of a window tilted to 20cm wide and auto resizes on the Y-axis; the U class comes in handy here because it helps you reason visually about the units you're working on.

You can toggle to turn the windows header on and off. The value from that toggle is passed via the **show header** field, as shown in the code below.

```c#
UI.WindowBegin("Window", ref windowPose, new Vec2(20, 0) * U.cm, showHeader?UIWin.Normal:UIWin.Body);
```

All visual elements are local to that window when you start a window in the StereoKit Ink application. UI uses the hierarchy class to push the window's pose into the hierarchy stack. The pose will be dropped from the hierarchy stack when you close the window, restoring everything to normal. Based on user interaction, the UI element will update the values; also, you can add the values manually if necessary.

The UI keeps the next item on the same line and starts with the label element. The slider interval is set to 0.2 with the range [0, 1]. Thus, you can step the value to 0 to slide it continuously, as shown below.

```c#
UI.Label("Slide");
UI.SameLine();
UI.HSlider("slider", ref slider, 0, 1, 0.2f, 72 * U.mm);
```

To end the window, refer to the below-mentioned code snippet.

```c#
UI.WindowEnd();
```

### Custom windows

Mixed Reality features you with the opportunity to transform the objects into **interfaces**. For example, using **handles** StereoKit allows you to develop 3D models and add UI elements to their surface instead of the traditional "window" approach.

In order to create the clipboard to attach the interface, refer to the below code snippet.

```c#
Model clipboard = Model.FromFile("Clipboard.glb");
```

Similar to the previous, here's how you can transform it into a grabbable interface. This behaves the same, except we're defining the grabbable region more precisely and drawing our model using an identity matrix instead of a plain bar. Use the **HandleBegin** function below to push the handle's pose onto the hierarchy transform stack.

```c#
UI.HandleBegin("Clip", ref clipboardPose, clipboard.Bounds);
Renderer.Add(clipboard, Matrix.Identity);
```

Similar to windows, **Handles** need an end call, as shown below.

```c#
UI.HandleEnd();
```

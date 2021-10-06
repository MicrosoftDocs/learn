First, let us have a basic understanding of 3D models, Hand Menus, and UI buttons before breaking into the stereokitink sample application.

## Import 3D models

The loading asset is a complex packing system. Here the asset is loaded during build time and in stereokit it's a lot easier to load a 3D model. The 3D model format must be in .gltf, .glb, .obj, .stl, ASCII .ply, procedural and texture format must be in .jpg, .png, .tga, .bmp, .psd, .gif, .hdr, .pic, equirectangular cubemap, procedural.

## Adding hand menu

When it comes to user interaction in StereoKitInk, it carries a hands-first approach. when hand-sensors aren’t available, hand data is simulated instead using existing devices. Consider an example, as we mice Windows Mixed Reality Controllers will switch between pre-recorded hand positions based on button pushes thus you'll get to work with fully riched articulated hand data.

## Accessing hand with joints

Hands are the salient feature in human interaction. Access the below defined code to find the finger tip of right hand, if IsTracked is ignored then the last known position of fully joint is given or specifed.

```
Hand hand = Input.Hand(Handed.Right);
if (hand.IsTracked)
{
    Vec3 fingertip = hand[FingerId.Index, JointId.Tip].position;
}
```

if you perfer calling function instead of operator you can call using the below given code.

```
 hand.Get(FingerId.Index, JointId.Tip)
```

StereoKitInk supports other easily accessible functions such as pinching and gripping, where to pinch the frame, use the JustPinched function, and unpinch the frame using the JustUnpinched function. The below code snippet explains the pinching and gripping functionalities.

```
if (hand.IsPinched) { }
if (hand.IsJustPinched) { }
if (hand.IsJustUnpinched) { }
 
if (hand.IsGripped) { }
if (hand.IsJustGripped) { }
if (hand.IsJustUngripped) { }
```

## Hand menu

Let's say you want to develop a hand menu, and you want to know if the user is gazing at their palm in stereokitInk. So here is an example of determining this using the palm's position and the dot product.

```
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

After you've gathered that information, you've to place a window off to the side of the hand.
Different X offset values are required for each hand so that the palm points in the right direction on different sides of each hand.

```
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

## Pointers

Lastly, StereoKit features a pointer system. Pointers are not constrained only to hands and will be created in the scene by the head, mouse, and other devices, respectively. In addition, you can filter pointers based on source family and device capabilities.

## Creating UI buttons

StereoKit's user interface is based on an immediate mode approach. The prime objective of UI APIs is to provide you with a more efficient and functional running environment. You can also define UI on each frame. As the little amount of state is maintained, you may easily add, remove, and alter your UI elements using simple and standard code structures. The fact that you'll have to maintain track of the state yourself is a significant drawback.

## Making a window

:::image type="content" source="../media/toggle-pose.png" alt-text="Screenshot of toggle pose for the Window." lightbox="../media/toggle-pose.png":::
The toggle pose for the window off to the left facing to the right, as well as a float that will be utilised as a slider, are shown in the image above and the code will be added to initialization section.
```
Pose  windowPose = new Pose(-.4f, 0, 0, Quat.LookDir(1,0,1));

bool  showHeader = true;
float slider     = 0.5f;

Sprite powerSprite = Sprite.FromFile("power.png", SpriteType.Single);
```

As a base unit, StereoKit uses metres. Consider the case of a window that is tilted to 20 cm wide and auto-resizes on the Y axis, the U class comes in handy here because it helps us to reason visually about the units we're working with.

We can toggle to trun the windows header on and off and the value from that toggle is passed via the showHeader field as shown in the code below.
```
UI.WindowBegin("Window", ref windowPose, new Vec2(20, 0) * U.cm, showHeader?UIWin.Normal:UIWin.Body);
```

When you start a window in StereoKitInk application, all visual elements are now local to that window. UI uses the Hierarchy class to push the window's pose into the Hierarchy stack. The pose will be dropped from the hierarchy stack when you close the window, restoring everything to normal. Based on user interaction, the UI element will update the values; also, you can add the values manually if required.

The UI keeps the next item on the same line and starts with the label element. The slider interval is set to 0.2 with the range [0,1]. Thus, you can step the value to 0 to slide it continuously as shown below.
```
UI.Label("Slide");
UI.SameLine();
UI.HSlider("slider", ref slider, 0, 1, 0.2f, 72 * U.mm);
```

To end the window refer the below mentioned code sinpet
```
UI.WindowEnd();
```

## Custom windows

Mixed Reality features us with the opportunity to transform the objects into interfaces. By using "handles" StereoKit allows you to develop 3D models and add UI elements to their surface instead of using the traditional "window" approach.

In order to create the clipboard to attach the interface refer the below code snippet.
```
Model clipboard = Model.FromFile("Clipboard.glb");
```

Similar to the pervious, heres how you can transfrom it into grabble interface. This behaves the same, except we’re defining where the grabbable region more precisely and draw our own model using an identity matrix instead of plain bar. Use HandleBegin function as shown below to push the handle’s pose onto the Hierarchy transform stack.
```
UI.HandleBegin("Clip", ref clipboardPose, clipboard.Bounds);
Renderer.Add(clipboard, Matrix.Identity);
```

Similar to windows, Handles need an end call as shown below.
```
UI.HandleEnd();
```

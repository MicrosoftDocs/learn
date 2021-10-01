First, let us have a basic understanding of 3D models, Hand Menus, and UI buttons before breaking into the finger-painting sample application.

## Import 3D models

The loading asset is a complex packing system. Here the asset is loaded during build time and in stereokit it's a lot easier to load a 3D model .
 yet to add .....

## Adding hand menu

## Using hands

When it comes to user interaction, StereoKit carries a hands-first approach. when hand-sensors aren’t available, hand data is simulated instead using existing devices. Consider an example, as we mice Windows Mixed Reality Controllers will switch between pre-recorded hand positions based on button pushes thus you'll get to work with fully riched articulated hand data.

## Accessing Joints

## Hand with joints

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

Pinching and Gripping are other easily accessible functions, where to pinch the frame, use the JustPinched function, and unpinch the frame using the JustUnpinched function. The below code snippet explains the pinching and gripping functionalities.

```
if (hand.IsPinched) { }
if (hand.IsJustPinched) { }
if (hand.IsJustUnpinched) { }
 
if (hand.IsGripped) { }
if (hand.IsJustGripped) { }
if (hand.IsJustUngripped) { }
```

## Hand menu

Let's say you want to develop a hand menu, and you want to know if the user is gazing at their palm. so here is an example of determining this using the palm's position and the dot product.

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


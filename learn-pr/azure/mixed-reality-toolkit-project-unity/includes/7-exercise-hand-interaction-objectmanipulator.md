The ObjectManipulator script supports the "direct manipulation" modality of the "hands and motion controllers" input model. When the script is attached to an object, the user can move, scale or rotate the object with their hands. In this exercise, you'll create two cubes, attach the necessary scripts to them, and then move the cubes around.

## Add and adjust the first cube

1. In the menu bar, select **GameObject** > **3D Object** > **Cube**.

    :::image type="content" source="../media/027-add-cube.png" alt-text="Screenshot of menu commands for adding the cube.":::

    The cube's default size is one square meter--this is too large for our purposes. We'll scale the size down to 20x20x20 cm.

1. Select the cube, and then in the **Inspector**, change the cube's **Tranform/Scale** values to the following:
   
   X = 0.2, Y = 0.2, Z = 0.2
   
    The cube was placed in the scene at the default position of (0,0,0). This means the cube is at the same position as the user's headset, and the user won't be able to see the cube until they move backwards. We'll change the cube's position values so it'll be in a better location for viewing.

1. In the **Inspector**, change the cube's **Tranform/Position** values to the following:
   
   X = -0.2, Y = 1.6, Z = 0.5

    :::image type="content" source="../media/028-cube-transform.png" alt-text="Screenshot of the cube's transform component after updates.":::

    We want to be able to see three sides of the cube, so we'll change the cube's rotation, too. 

1. In the **Inspector**, change the cube's **Tranform/Rotation** values to the following:
   
   X = 9, Y = 14, Z = 0

   > [!TIP]
   > To zoom in on the cube, select it, make sure cursor is hovering over the **Scene** window, and then press the F key. You can zoom in on any object this way.

## Add the scripts to the cube

In order for an object to be "grabbable" with tracked hands, it must have three components attached: 

- A Collider component (You don't need to do anything here--Unity's cube already has a Box Collider attached by default)
- Object Manipulator (Script) component

1. With the cube still selected, in the **Inspector** window, click the **Add Component** button, and then search for and select the **Object Manipulator** script.

    :::image type="content" source="../media/029-select-object-manipulator.png" alt-text="Screenshot of adding the Object Manipulator script.":::

    The ObjectManipulator script makes an object movable, scalable, and rotatable using one or two hands. When you add the Object Manipulator script, the Constraint Manager script is automatically added as well because the Object Manipulator script depends on it.

    :::image type="content" source="../media/030-constraint-manager.png" alt-text="Screenshot of the Constraint Manager script added to the cube.":::

## Update the cube's material

For performance purposes, it is recommended to use MRTK materials instead of the default Unity materials. 

1. With the cube still selected, find the "Materials" section on the Mesh Renderer component.
1. Replace the default material with the **MRTK_Standard_White** material, located under **MRTK Standard Assets** > **Materials**.

## Add a second cube

1. In the **Hierarchy**, right-click the cube, and then select **Duplicate**. The duplicated cube appears with the name "Cube (1)."
1. Right-click the original cube, select **Rename**, and then name the cube "Near Cube."
1. Right-click the duplicated cube, select **Rename**, and then name the cube "Far Cube."

    At the moment, it looks like there's only one cube in the **Scene** view. That's because Near Cube and Far Cube are in the same exact place. Let's change Far Cube's position and rotation.

1. With Far Cube still selected, change its values in its **Transform** component to the following:

    Position: X = 0.6, Y = 1.6, Z = 1.1

    Rotation: X = 27, Y = 0, Z = 0

    Now the camera should see Near cube on the left and Far Cube a little further away on the right. To confirm this, in the **Hierarchy**, select **Main Camera** (under **MRTK XR Rig** > **Camera Offset**) and then look at the **Main Camera** window in the **Scene** window.

    :::image type="content" source="../media/040-main-camera-view.png" alt-text="Screenshot of the Main Camera view in the Scene window.":::

    > [!TIP]
    > If you want the view in the **Scene** window to look more like what the camera sees, scroll around in the **Scene** window. You might have to set the Clear Flags of the camera to Skybox if it is not by default.


## Grab and move the cubes in Play mode

1. Click the Play button. When the project starts playing, the view switches to the **Game** window.

    :::image type="content" source="../media/031-game-window.png" alt-text="Screenshot of the Game window after entering Play mode.":::

    > [!NOTE]
    >  Before Playing, confirm that there is a valid Profile set under **Project Settings** > **MRTK3**.

1. Click the three-dot button above the upper-right corner of the **Game** window and then select **Maximize**.

    :::image type="content" source="../media/032-maximize-command.png" alt-text="Screenshot of Maximize command for the Game window.":::

1. Press the space bar to make the simulated right hand appear in the view.
1. Move the simulated hand closer to Near Cube until it touches the cube on the side or bottom.

    :::image type="content" source="../media/033-touch-cube.png" alt-text="Screenshot of the simulated right hand touching the Near Cube.":::

1. Click the left mouse button (this makes the hand "grab" the cube) and then drag the cube around the scene.

    :::image type="content" source="../media/move-cube.gif" alt-text="Screenshot of Move the cube." lightbox="../media/move-cube.gif":::

    To grab and move Far Cube, we'll use the far pointer attached to the simulated hand.

1. If you need to, press the space bar again to make the simulated right hand appear. Note the far pointer that extends from the end of the hand's index finger.

    :::image type="content" source="../media/034-far-pointer.png" alt-text="Screenshot of simulated hand's far pointer.":::

1. Move the hand closer to Far Cube until you can see the tip of the pointer on the cube. You may have to move the hand around in a circular motion a few times to make the tip of the pointer appear on the cube.

    :::image type="content" source="../media/035-far-pointer-touches-cube.png" alt-text="Screenshot of the far pointer touching the cube.":::

1. Click the left mouse button (this makes the hand close, taking on what we call the "pinch gesture") and then drag the cube around the scene.
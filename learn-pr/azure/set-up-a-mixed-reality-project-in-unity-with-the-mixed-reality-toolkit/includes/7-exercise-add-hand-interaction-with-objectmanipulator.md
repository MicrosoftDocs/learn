The ObjectManipulator script makes an object movable, scalable, and rotatable using one or two hands. This script supports the direct manipulation input model as the script enables the user to touch holograms directly with their hands. Here you will create a cube and use ObjectManipulator to enable hand interactions so that you can scale and rotate the cube.

## Add a Cube to the scene

1. In the **Hierarchy** window, click the **+** icon and select **3D Object** > **Cube**.

    :::image type="content" source="../media/add_cube_to_scene.png" alt-text="Add Cube to Scene":::

1. Adjust the Scene view camera using the Scene Gizmo to view the front of the cube.

    :::image type="content" source="../media/adjust_scene_view.png" alt-text="Adjust Scene view with  Scene Gizmo":::

1. Select the **Cube** object in the **Hierarchy** window. The Cube's properties will display in the **Inspector** window.

    :::image type="content" source="../media/cube_inspector_window.png" alt-text="View Cube properties in Inspector window":::

1. In the **Inspector** window, change the Cube's **Transform Scale** to **.25**, **.25**, **.25**. This will make the cube smaller.

    :::image type="content" source="../media/cube_transform_scale.png" alt-text="Change Cube Transform Scale":::

1. Change the Cube **Transform Position** to **0**, **0**, **.8**. This will move the cube object further back on the z-axis. When you later import the Mixed Reality Toolkit into your project, this change will provide a better view of the cube in the **Game** window.

    :::image type="content" source="../media/cube_transform_position.png" alt-text="Change Cube Transform Position":::

## Add a material to the Cube

1. In the **Project** window, enter **MRTK_Standard_Blue** into the search bar.

    :::image type="content" source="../media/search-mrtk-standard-blue.png" alt-text="Search for MRTK_Standard_Blue in Project window":::

1. Select the **MRTK_Standard_Blue** material and drag onto the Cube. This will change the color of the cube to blue.

    :::image type="content" source="../media/blue-cube.png" alt-text="Blue cube":::

## Add ObjectManipulator to the Cube

1. Select the **Cube** object in the **Hierarchy** window.
1. In the **Inspector** window, click **Add Component**.

    :::image type="content" source="../media/cube-add-component.png" alt-text="Click Add Component":::

1. In the **Search** window that appears, enter **Object Manipulator**.

    :::image type="content" source="../media/search-object-manipulator.png" alt-text="Enter Object Manipulator":::

1. Select the **Object Manipulator** script. This script will enable you to manipulate the cube using your hands.

    :::image type="content" source="../media/select-object-manipulator.png" alt-text="Select Object Manipulator script":::

## Add NearInteractionGrabbable to the Cube

1. Select the **Cube** object in the **Hierarchy** window.
1. In the **Inspector** window, click **Add Component**.

    :::image type="content" source="../media/cube-add-component.png" alt-text="Click Add Component":::

1. In the **Search** window that appears, enter **Near Interaction Grabbable**.

    :::image type="content" source="../media/search-near-interaction-grabbable.png" alt-text="Enter Near Interaction Grabbable":::

1. Select the **Near Interaction Grabbable** script. This script will enable you to grab the object from a close distance.

    :::image type="content" source="../media/select-near-interaction-grabbable.png" alt-text="Select Near Interaction Grabbable script":::

## Move the Cube in play mode

1. In the Unity toolbar, click the **Play** icon to enter play mode.

    :::image type="content" source="../media/play-mode.png" alt-text="Enter Play mode":::

1. Using the Unity in-editor input simulation, press the **space bar** on your keyboard to simulate hand input with the right hand.

    :::image type="content" source="../media/hand-simulation.PNG" alt-text="Hand simulation with right hand":::

1. While pressing the space bar, use your mouse scroll wheel to adjust the hand's distance to the cube. Left click the mouse to grab the cube and drag.

    :::image type="content" source="../media/grab-cube-drag.PNG" alt-text="Grab the cube and drag":::

## Rotate the Cube in play mode

1. While in Play mode, press the **space bar** on your keyboard to simulate hand input with the right hand.

    :::image type="content" source="../media/hand-simulation.PNG" alt-text="Hand simulation with right hand":::

1. While pressing the space bar, use your mouse scroll wheel to adjust the hand's distance to the cube. Left click the mouse to grab the cube.
1. While pressing the space bar, press the **CTRL** key on your keyboard and left click the mouse to rotate the hand.

    :::image type="content" source="../media/rotate-cube.png" alt-text="Rotate cube with right hand":::

## Scale the Cube in play mode

To scale an object, at least one hand needs to grab the object while the other is used to scale the object.

1. While in Play mode, press the **T** and **Y** keys on your keyboard to simulate hand input with both the left and right hands. The **T** and **Y** keys will make the hands persistent in the view.

    :::image type="content" source="../media/simulate-two-hands.png" alt-text="Simulate left and right hands":::

1. Grab the cube with the right hand by first pressing the **space bar** on your keyboard and using the mouse scroll wheel to adjust the hand's distance to the cube. Left click the mouse to grab the cube.

    :::image type="content" source="../media/grab-right-hand.png" alt-text="Grab cube with right hand":::

1. Grab the cube with the left hand by first pressing the **shift** key on your keyboard and using the mouse scroll wheel to adjust the hand's distance to the cube. Left click the mouse to grab the cube.

    :::image type="content" source="../media/grab-left-hand.png" alt-text="Grab cube with left hand":::

1. While grabbing the cube with the left hand active, left click the mouse and drag to the left to increase the size of the cube. Likewise, to decrease the size of the cube, drag the mouse to the right.

    :::image type="content" source="../media/scale-cube.png" alt-text="Scale cube to increase the size":::
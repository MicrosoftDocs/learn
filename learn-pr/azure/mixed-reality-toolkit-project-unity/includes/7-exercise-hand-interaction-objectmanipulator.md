The ObjectManipulator script makes an object movable, scalable, and rotatable using one or two hands. This script supports the direct manipulation input model as the script enables the user to touch holograms directly with their hands. Here you'll create a cube and use ObjectManipulator to enable hand interactions so that you can move, scale, and rotate the cube.

## Add a Cube to the scene

1. In the **Hierarchy** window, click the **+** icon and select **3D Object** > **Cube**.

    :::image type="content" source="../media/add-cube-scene.png" alt-text="Screenshot of the Unity Hierarchy window with the plus icon selected and 3D object, Cube selected.":::

1. Adjust the Scene view camera using the Scene Gizmo to view the front of the cube.

    :::image type="content" source="../media/adjust-scene-view.png" alt-text="Screenshot of the Unity editor with the Scene Gizmo object highlighted.":::

1. Select the **Cube** object in the **Hierarchy** window. The Cube's properties will display in the **Inspector** window.

    :::image type="content" source="../media/cube-inspector-window.png" alt-text="Screenshot of the Unity editor with the Cube object highlighted and the Inspector window highlighted.":::

1. In the **Inspector** window, change the Cube's **Transform Scale** to **.25**, **.25**, **.25**. This will make the cube smaller.

    :::image type="content" source="../media/cube-transform-scale.png" alt-text="Screenshot of the Inspector window with the Scale parameters highlighted. The value of x, y, and z are 0.25.":::

1. Change the Cube **Transform Position** to **0**, **0**, **.8**. This will move the cube object further back on the z-axis.

    :::image type="content" source="../media/cube-transform-position.png" alt-text="Screenshot of the Inspector window with the Position parameters highlighted. The value of x and y are 0. The value of z is 0.8.":::

## Add a material to the Cube

1. In the **Project** window, enter **MRTK_Standard_Blue** into the search bar.

    :::image type="content" source="../media/search-mrtk-standard-blue.png" alt-text="Screenshot of the Project window with the search bar highlighted. The phrase m r t k underscore standard underscore blue is entered into the search bar.":::

1. Select the **MRTK_Standard_Blue** material and drag onto the Cube. This will change the color of the cube to blue.

    :::image type="content" source="../media/blue-cube.png" alt-text="Screenshot of Scene window, which contains a blue cube.":::

## Add ObjectManipulator to the Cube

1. Select the **Cube** object in the **Hierarchy** window.
1. In the **Inspector** window, click **Add Component**.

    :::image type="content" source="../media/cube-add-component.png" alt-text="Screenshot of the Inspector window with the Add Component button highlighted.":::

1. In the **Search** window that appears, enter **Object Manipulator**.

    :::image type="content" source="../media/search-object-manipulator.png" alt-text="Screenshot of the Inspector window with the search bar highlighted. The phrase Object Manipulator is entered into the search bar.":::

1. Select the **Object Manipulator** script. This script will enable you to manipulate the cube using your hands.

    :::image type="content" source="../media/select-object-manipulator.png" alt-text="Screenshot of the Inspector window with the Object Manipulator script highlighted in the search results.":::

## Add NearInteractionGrabbable to the Cube

1. Select the **Cube** object in the **Hierarchy** window.
1. In the **Inspector** window, click **Add Component**.

    :::image type="content" source="../media/cube-add-component.png" alt-text="Screenshot of the Inspector window with the Add Component button highlighted.":::

1. In the **Search** window that appears, enter **Near Interaction Grabbable**.

    :::image type="content" source="../media/search-near-interaction-grabbable.png" alt-text="Screenshot of the Inspector window with the search bar highlighted. The phrase Near Interaction Grabbable is entered into the search bar.":::

1. Select the **Near Interaction Grabbable** script. This script will enable you to grab the object from a close distance.

    :::image type="content" source="../media/select-near-interaction-grabbable.png" alt-text="Screenshot of the Inspector window with the Near Interaction Grabbable script highlighted in the search results.":::

## Move the Cube in play mode

1. In the Unity toolbar, click the **Play** icon to enter play mode.

    :::image type="content" source="../media/play-mode.png" alt-text="Screenshot of the Unity editor in Play mode. The play button displays blue. A blue cube displays in the Scene and Game window. The diagnostics tools display below the cube in both windows.":::

1. Using the Unity in-editor input simulation, press the **space bar** on your keyboard to simulate hand input with the right hand.

    :::image type="content" source="../media/hand-simulation.PNG" alt-text="Screenshot of the Game window with the blue cube in the center and a right simulated hand to the right of the cube. The diagnostics tools display below the cube.":::

1. While pressing the space bar, use your mouse scroll wheel to adjust the hand's distance to the cube. Left click the mouse to grab the cube and drag.

    :::image type="content" source="../media/grab-cube-drag.png" alt-text="Screenshot of the Game window with the blue cube dragged to the right by a right simulated hand. The diagnostics tools display below the cube.":::

## Rotate the Cube in play mode

1. While in Play mode, press the **space bar** on your keyboard to simulate hand input with the right hand.

    :::image type="content" source="../media/hand-simulation.PNG" alt-text="Screenshot of the Game window with the blue cube in the center and a right simulated hand to the right of the cube. The diagnostics tools display below the cube.":::

1. While pressing the space bar, use your mouse scroll wheel to adjust the hand's distance to the cube. Left click the mouse to grab the cube.
1. While pressing the space bar, press the **CTRL** key on your keyboard and left click the mouse to rotate the hand.

    :::image type="content" source="../media/rotate-cube.png" alt-text="Screenshot of the Game window with the blue cube in the middle lifted up and rotated to the left by the right simulated hand. The diagnostics tools display below the cube.":::

## Scale the Cube in play mode

To scale an object, at least one hand needs to grab the object while the other is used to scale the object.

1. While in Play mode, press the **T** and **Y** keys on your keyboard to simulate hand input with both the left and right hands. The **T** and **Y** keys will make the hands persistent in the view.

    :::image type="content" source="../media/simulate-two-hands.png" alt-text="Screenshot of the Game window with the blue cube in the center. A left and right simulated hand is on top of the cube. The diagnostics tools display below the cube.":::

1. Grab the cube with the right hand by first pressing the **space bar** on your keyboard and using the mouse scroll wheel to adjust the hand's distance to the cube. Left click the mouse to grab the cube.

    :::image type="content" source="../media/grab-right-hand.png" alt-text="Screenshot of the Game window with the blue cube in the center. The right simulated hand is grabbing the right middle side of the cube. The left simulated hand is inactive on top of the cube. The diagnostics tools display below the cube.":::

1. Grab the cube with the left hand by first pressing the **shift** key on your keyboard and using the mouse scroll wheel to adjust the hand's distance to the cube. Left click the mouse to grab the cube.

    :::image type="content" source="../media/grab-left-hand.png" alt-text="Screenshot of the Game window with the blue cube in the center slightly lifted on the left side. The right simulated hand is grabbing the right middle side of the cube. The left simulated hand is grabbing the left middle side of the cube. The diagnostics tools display below the cube.":::

1. While grabbing the cube with the left hand active, left click the mouse and drag to the left to increase the size of the cube. Likewise, to decrease the size of the cube, drag the mouse to the right.

    :::image type="content" source="../media/scale-cube.png" alt-text="Screenshot of the Game window with the blue cube slightly dragged to the left and larger in size. The right simulated hand is grabbing the right middle side of the cube. The left simulated hand is grabbing the lower left side of the cube. The diagnostics tools display below the cube.":::

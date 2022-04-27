The ObjectManipulator script makes an object movable, scalable, and rotatable using one or two hands. This script supports the direct manipulation input model because it enables the user to touch holograms directly with their hands. Here, use ObjectManipulator to enable hand interactions so that you can move, scale, and rotate the rover explorer.

1. Additionally, you'll configure the Rover Explorer so that you can place the rover parts onto the Rover to make it a complete rover assembly. In the Hierarchy pane, expand the RoverExplorer > **RoverParts** object and select all its child rover part objects and the **RoverAssembly** object, then in the Inspector pane, use the **Add Component** button to add the following components to all the selected objects:
    * **Object Manipulator (Script)** component
    * **NearInteractionGrabbable** component
    * **Part Assembly Controller (Script)** component

    :::image type="content" source="../media/rover-assembly.png" alt-text="Screenshot of RoverAssembly with all rover part objects selected and components added." lightbox="../media/rover-assembly.png":::

2. With all the rover part objects and the RoverAssembly object still selected, in the Inspector pane, configure the **Object Manipulator (Script)** component as follows:
    * From the **Two Handed Manipulation Type** dropdown list, clear the Scale checkbox, so only **Move** and **Rotate** are enabled:

    :::image type="content" source="../media/two-handed-manipulation.png" alt-text="Screenshot of Unity with Two Handed Manipulation Type configured." lightbox="../media/two-handed-manipulation.png":::

3. In the Project pane, navigate to **Packages** > **Mixed Reality Toolkit Standard Assets** > **Audio** folder to locate the audio clips:

    :::image type="content" source="../media/audio-folder-selected.png" alt-text="Screenshot of Unity Project window with Audio folder selected." lightbox="../media/audio-folder-selected.png":::

4. In the Hierarchy pane, reselect all the **rover part objects**, then in the Inspector pane, select **Add Component** to add the **Audio Sources** component and configure it as follows:
    * Assign the **MRTK_Scale_Start** audio clip to the **AudioClip** field
    * Uncheck the **Play On Awake** checkbox
    * Change **Spatial Blend** to **1**

    :::image type="content" source="../media/rover-parts-selected.png" alt-text="Screenshot of Unity with all rover parts selected and Audio Source component added and configured." lightbox="../media/rover-parts-selected.png":::

5. In the Hierarchy pane, expand the RoverAssembly > RoverModel_PlacementHints_XRay > **Parts_PlacementHints** object to reveal all of the placement hint objects, then select the first rover part, RoverParts > **Camera_Part**, and configure the **Part Assembly Controller (Script)** component as follows:
    * Assign the **Camera_PlacementHint** object to the **Location To Place** field

    :::image type="content" source="../media/camera-part.png" alt-text="Screenshot of Unity with Camera_Part PartAssemblyController component configured." lightbox="../media/camera-part.png":::

6. **Repeat** step 5 for each of the remaining rover part objects and the RoverAssembly object to configure the **Part Assembly Controller (Script)** component as follows:
    * For the **Generator_Part**, assign the **Generator_PlacementHint object** to the **Location To Place** field
    * For the **Lights_Part**, assign the **Lights_PlacementHint object** to the **Location To Place** field
    * For the **UHFAntenna_Part**, assign the **UHFAntenna_PlacementHint object** to the **Location To Place** field
    * For the **Spectrometer_Part**, assign the **Spectrometer_PlacementHint** object to the Location To Place field
    * For the **RoverAssembly**, assign the object itself, that is, the same **RoverAssembly object**, to the **Location To Place** field

7. In the Hierarchy pane, select the RoverExplorer > Buttons > **Reset** button object, then in the Inspector pane, configure the Interactable **OnClick ()** event as follows:
    * Assign the **RoverAssembly** object to the **None (Object)** field
    * From the **No Function** dropdown list, select **PartAssemblyController** > **ResetPlacement ()** to set this function as the action to be run when the event is triggered

    :::image type="content" source="../media/on-click-event.png" alt-text="Screenshot of Unity with Reset button object OnClick event configured." lightbox="../media/on-click-event.png":::

8. If you now enter Game mode, you can use near or far interaction to place the rover parts onto the Rover. Once the part is close to the corresponding placement hint, it will snap into place and become part of the Rover. To reset the placements, you can press the Reset button:

    :::image type="content" source="../media/reset-button.png" alt-text="Screenshot of Unity Play mode split view with Reset button being pressed." lightbox="../media/reset-button.png":::

## Add bounds control

1. In the Hierarchy window, select the **RoverExplorer** object, then in the Inspector window, use the **Add Component** button to add the following components:
    * **BoundsControl** component
    * **Object Manipulator (Script)** component
    Then **uncheck** the checkbox next to all the components to make them **disabled** by default:

    :::image type="content" source="../media/rover-explorer-object-selected.png" alt-text="Screenshot of Unity with RoverExplorer object selected and components added and disabled." lightbox="../media/rover-explorer-object-selected.png":::

2. In the Hierarchy pane, expand the Menu > **ButtonCollection** object to reveal the four buttons, rename the third button to **BoundsControl_Enable**, and then in the Inspector pane, configure the **Button Config Helper (Script)** component as follows:
    * Change the **Main Label Text** to **Enable**
    * Assign the **RoverExplorer** object to the **None (Object)** field
    * From the **No Function** dropdown list, select **BoundsControl** > **bool Enabled** to update this property value when the event is triggered
    * Verify that the argument checkbox is **checked**
    * Select the small **+** icon to add another event
    * Assign the **RoverExplorer** object to the **None (Object)** field
    * From the **No Function** dropdown list, select **ObjectManipulator** > **bool Enabled** to update this property value when the event is triggered
    * Verify that the argument checkbox is **checked**
    * Leave the **Icon** as the 'cube with bounds control' icon

    :::image type="content" source="../media/bounds-control-enable.png" alt-text="Screenshot of Unity with BoundsControl_Enable button object selected and Button Config Helper component configured." lightbox="../media/bounds-control-enable.png":::

3. Rename the forth and last button to **BoundsControl_Disable**, and then in the Inspector pane, configure the **Button Config Helper (Script)** component as follows:
    * Change the **Main Label Text** to **Disable**
    * Assign the **RoverExplorer** object to the **None (Object)** field
    * From the **No Function** dropdown list, select **BoundsControl** > **bool Enabled** to update this property value when the event is triggered
    * Verify that the argument checkbox is **unchecked**
    * Select the small **+** icon to add another event
    * Assign the **RoverExplorer** object to the **None (Object)** field
    * From the **No Function** dropdown list, select **ObjectManipulator** > **bool Enabled** to update this property value when the event is triggered
    * Verify that the argument checkbox is **unchecked**
    * Change the **Icon** to the 'cube with bounds control" icon

    :::image type="content" source="../media/bounds-control-disable.png" alt-text="Screenshot of Unity with BoundsControl_Disable button object selected and Button Config Helper component configured." lightbox="../media/bounds-control-disable.png":::

4. If you now enter Game mode and select **Enable** to enable Bounds Control, you can use near or far interaction to move, rotate, and scale Bounds Control, and select **Disable** to disable the Bounds Control again:

    :::image type="content" source="../media/bounds-control-manipulated.png" alt-text="Screenshot of Unity Play mode split view with Bounds Control being manipulated." lightbox="../media/bounds-control-manipulated.png":::

In this exercise, you'll learn how to enable eye-tracking for HoloLens 2 and add eye-tracking to objects to trigger actions when the user looks at the objects.

## Ensure the eye gaze input capability is enabled

* In the Unity menu, select Edit > Project Settings and then in the **OpenXR** of XR Plugin-in Management section, make sure that the Eye Gaze Interaction Profile has been added to the Interaction Profiles

    :::image type="content" source="../media/mrtk-interaction-profile.png" alt-text="Screenshot of interaction profile." lightbox="../media/mrtk-interaction-profile.png":::

## Enable simulated eye-tracking for the Unity editor

* From the [previous module](/training/modules/get-started-with-object-interaction), you should already have the MRTK XR Rig in your scene. Gaze input is included in this prefab, so you don’t need to add any extra components.

    :::image type="content" source="../media/mrtk-xr-rig-prefab.png" alt-text="Screenshot of MRTK XR Rig prefab for gaze controller." lightbox="../media/mrtk-xr-rig-prefab.png":::

## Add eye-tracking to objects

1. In the Hierarchy window, expand **RoverExplorer** > **Buttons** > **Hints**. Right click on the **Hints** gameobject, and then select **3D Object** > **Text - TextMeshpro**. Rename the newly created gameobject to **ButtonText**.

:::image type="content" source="../media/create-buttontext-object.png" alt-text="Screenshot of Unity with Hints Button text object selected and EyeTrackingTarget component configured." lightbox="../media/create-buttontext-object.png":::

2. In the Hierarchy window, select **RoverExplorer** > **Buttons** > **Hints** > **ButtonText**. Change its text to "Hints", font size to 2, Pos X to 9.75, Pos Y to -1.50 and Pos Z to -0.3

:::image type="content" source="../media/configure-buttontext-object.png" alt-text="Screenshot of Unity with Hints Button text object configuration and EyeTrackingTarget component configured." lightbox="../media/configure-buttontext-object.png":::

3. In the Hierarchy window, expand **RoverExplorer** > **Buttons** > **Hints** > **ButtonText**. Then in the Hierarchy window, select the **Hints** button object, and configure the **PressableButton** component as follows:

    * Under **XRI Interactable Events**, in the Hover Entered section
        1) Click the small + icon to add another event
        2) Assign the **ButtonText** object from the **Hints** button to the **None (Object)** field
        3) From the **No Function** dropdown, select **TextMeshPro** > **float fontSize** to update this property value when the event is triggered
        4) Set the argument to **3** to increase the current font size to 3.

    * In the Hover Exited section
        1) Click the small + icon to add another event
        2) Assign the  **ButtonText** object from the **Hints** button to the **None (Object)** field
        3) From the **No Function** dropdown, select **TextMeshPro** > **float fontSize** to update this property value when the event is triggered
        4) Set the argument to **2** to reset the font size back 2.

    :::image type="content" source="../media/text-mesh-pro-object.png" alt-text="Screenshot of Unity with Hints TextMeshPro object selected and EyeTrackingTarget component configured." lightbox="../media/text-mesh-pro-object.png":::

4. Repeat the above steps for the **Explode** and **Reset** button objects to configure eye tracking for remaining buttons. If you now enter Game mode and then press-and-hold the right mouse button while moving your mouse until the gaze hit's one of the buttons, you'll see the text font size increase and reset back to its original size when looking away.

  :::image type="content" source="../media/all-buttontext-object.png" alt-text="Screenshot of Unity with all button text and EyeTrackingTarget component configured." lightbox="../media/all-buttontext-object.png":::
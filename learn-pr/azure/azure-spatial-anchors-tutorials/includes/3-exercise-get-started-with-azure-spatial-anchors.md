In this unit, you'll explore the steps required to:

- Start and stop an Azure Spatial Anchors session.
- Create, upload, and download spatial anchors on a single device.

As a result of completing the prerequisites for this learn module, you should already have a Unity project that's set up and configured for OpenXR and MRTK2. Open that project and continue on with the steps below.

## Choose configuration options

There's one configuration option that we need to change: occlusion. MRTK2 bases its various configurations on a series of default profiles which can't be altered. In order to change an option, you must clone an existing default profile and change the option in the clone. We'll do that next.

1. In the **Hierarchy**, select the **Mixed Reality Toolit** object. This causes the Mixed Reality Toolkit (MRTK) profile to appear in the **Inspector.**
1. In the **Inspector**, at the top of the **MixedReality Toolkit** component, click the drop-down that displays **DefaultMixedRealityToolkitConfigurationProfile** and change that setting to **DefaultHoloLens2ConfigurationProfile**.

    We need to change an option in the Spatial Awareness subsystem, but you'll notice that it's grayed out. To make it available, you must clone the default profile.

1. Click the **Clone** button.
1. In the **Clone Profile** window, note that in the **Profile Name** field., Unity provides a default name of **New MixedRealityToolkitconfigurationProfile**. You can change the name to anything you want, but for this learn module we'll stay with the name provided by Unity.

    :::image type="content" source="../media/001-clone-profile-window.png" alt-text="Screen shot of the Clone Profile window and default clone name provided by Unity.":::

1. Click the **Clone** button in the **Clone Profile** window. 
1. Note that the **Enable Spatial Awareness System** option is now available. 

    :::image type="content" source="../media/001-clone-profile-window.png" alt-text="Screen of the Enable Spatial Awareness System option now being available.":::

    Select this option.

1. The Spatial Awareness system has its own default profile (1). Like the earlier default profile, it can't be altered, so the **Add Spatial Observer** section is grayed out (2).

    :::image type="content" source="../media/003-spatial-awareness-profile.png" alt-text="Screen of the default Spatial profile and its options grayed out.":::

    You must clone this profile, too. 

1. Click the **Clone** button to the right of the default profile name.
1. In the **Clone Profile** window, click the **Clone** button to accept the clone name provided by Unity.
1. There are now three Spatial Observers available as drop-downs. Click the first one, **XR SDK Windows Mixed Reality Spatial Mesh Observer**, to reveal its contents.
1. This spatial observer also has its own default profile that must be cloned. Click the **Clone** button, and then in the **Clone Profile** window, click **Clone** to accept the name provided by Unity and clone the default profile.
1. Scroll down to the last section in the profile, **Display Settings**, and then click the **Display Option** drop-down and select **Occlusion**.

    :::image type="content" source="../media/004-display-options-occlusion.png" alt-text="Screen of the Spatial Observer section Display Settings with Occlusion selected.":::

## Install in-built Unity packages and import the tutorial assets

[!INCLUDE[](includes/switch-platform.md)]

## Prepare the scene

In this section, you'll prepare the scene by adding some of the tutorial prefabs.

1. On the **Project** pane, go to the **Assets** > **MRTK.Tutorials.AzureSpatialAnchors** > **Prefabs** folder. Then drag the following prefabs to the **Hierarchy** pane to add them to your scene:

    * **ButtonParent** prefabs
    * **DebugWindow** prefabs
    * **Instructions** prefabs
    * **ParentAnchor** prefabs

    :::image type="content" source="../media/prefabs.png" alt-text="Screenshot of prefabs added to the Hierarchy pane." lightbox="../media/prefabs.png":::

    > [!Tip]
    > If you find the large icons in your scene (for example, the large framed "T" icons) distracting, you can hide them by [switching the Gizmos toggle](https://docs.unity3d.com/2019.1/Documentation/Manual/GizmosMenu.html) to the off position, as shown in the preceding image.

1. In the **Hierarchy** pane, select the **MixedRealityToolkit** object.
1. In the **Inspector** pane, use the **Add Component** button to add the following components:

    * **AR Anchor Manager (Script)**
    * **DisableDiagnosticsSystem (Script)**

    > [!Note]
    > When you add the **AR Anchor Manager (Script)** component, the **AR Session Origin (Script)** component is automatically added, because the **AR Anchor Manager (Script)** component requires it.

## Configure the buttons to operate the scene

In this section, you'll add scripts to the scene to create a series of button events that demonstrate the fundamentals of how both local anchors and spatial anchors behave in an app.

1. In the **Hierarchy** pane, expand the **ButtonParent** object and then select the first child object, **StartAzureSession**. 
1. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component. Note that it has an **On Click ()** event.
1. In the **Hierarchy**, click the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
1. Click the **No Function** drop-down and then select **AnchorModuleScript** > **StartAzureSession ()**. This function will be executed when the event is triggered.

    :::image type="content" source="../media/add-component.png" alt-text="Unity with the StartAzureSession button's OnClick event configured." lightbox="../media/add-component.png":::

1. In the **Hierarchy** pane in the **ButtonParent** child list, select **StopAzureSession**
1. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component.
1. In the **Hierarchy**, click the the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
1. Click the **No Function** drop-down and then select **AnchorModuleScript** > **StopAzureSession ()**.


    :::image type="content" source="../media/start-azure-session.png" alt-text="Screenshot of Unity with the StopAzureSession button's OnClick event configured." lightbox="../media/start-azure-session.png":::

    :::image type="content" source="../media/stop-azure-session.png" alt-text="Screenshot of Unity with the StopAzureSession button's OnClick event configured." lightbox="../media/stop-azure-session.png":::

1. In the **Hierarchy** pane in the **ButtonParent** child list, select **CreateAzureAnchor**.
1. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component.
1. In the **Hierarchy**, click the the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
1. Click the **No Function** drop-down and then select **AnchorModuleScript** > **CreateAzureAnchor (GameObject)**.


    * Assign the **ParentAnchor** object to the empty **None (Game Object)** field to make it the argument for the **CreateAzureAnchor ()** function.

    :::image type="content" source="../media/create-azure-anchor.png" alt-text="Screenshot of Unity with the CreateAzureAnchor button's OnClick event configured." lightbox="../media/create-azure-anchor.png":::

1. In the **Hierarchy** pane in the **ButtonParent** child list, select **RemoveLocalAnchor**.
1. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component.
1. In the **Hierarchy**, click the the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
1. Click the **No Function** drop-down and then select **AnchorModuleScript** > **CreateAzureAnchor (GameObject)**.


1. On the **Hierarchy** pane, select the **RemoveLocalAnchor** button. Then on the **Inspector** pane, configure the **Button Config Helper (Script)** component's **On Click ()** event as follows:

    :::image type="content" source="../media/remove-local-anchor.png" alt-text="Screenshot of Unity with the RemoveLocalAnchor button's OnClick event configured." lightbox="../media/remove-local-anchor.png":::

1. In the **Hierarchy** pane, select the **FindAzureAnchor** button. Then on the **Inspector** pane, configure the **Button Config Helper (Script)** component's **On Click ()** event as follows:

    * Assign the **ParentAnchor** object to the **None (Object)** field.
    * From the **No Function** dropdown list, select **AnchorModuleScript** > **FindAzureAnchor ()** to set this function as the action to be executed when the event is triggered.

     :::image type="content" source="../media/find-azure-anchor.png" alt-text="Screenshot of Unity with the FindAzureAnchor button's OnClick event configured." lightbox="../media/find-azure-anchor.png":::

6. On the **Hierarchy** pane, select the **DeleteAzureAnchor** button. Then on the **Inspector** pane, configure the **Button Config Helper (Script)** component's **On Click** () event as follows:

    * Assign the **ParentAnchor** object to the **None (Object)** field.
    * From the **No Function** dropdown list, select **AnchorModuleScript** > **DeleteAzureAnchor ()** to set this function as the action to be executed when the event is triggered.

    :::image type="content" source="../media/delete-azure-anchor.png" alt-text="Screenshot of Unity with the DeleteAzureAnchor button's OnClick event configured." lightbox="../media/delete-azure-anchor.png":::

## Connect the scene to the Azure resource

1. On the **Hierarchy** pane, select the **ParentAnchor** object. Then on the **Inspector** pane, locate the **Spatial Anchor Manager** (Script) component. 

1. Configure the **Credentials** section with the credentials from the Azure Spatial Anchors account that you created as part of the prerequisites for this tutorial series:

   * In the **Spatial Anchors Account ID** field, paste the **Account ID** value from your Azure Spatial Anchors account.
   * In the **Spatial Anchors Account Key** field, paste the primary or secondary **Access Key** value from your Azure Spatial Anchors account.
   * In the **Spatial Anchors Account Domain** field, paste the **Account Domain** value from your Azure Spatial Anchors account.

   :::image type="content" source="../media/spatial-anchor-manager.png" alt-text="Screenshot of Unity with Spatial Anchor Manager configured." lightbox="../media/spatial-anchor-manager.png":::

## Try the basic behaviors of Azure Spatial Anchors

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. You can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a HoloLens device. You can purchase devices at [HoloLens.com](http://hololens.com/).

Azure Spatial Anchors can't run in Unity. To test the Azure Spatial Anchors functionality, you need to build the project and deploy the app to your device.

> [!Tip]
> For a reminder on how to build and deploy your Unity project to HoloLens 2, see the [Building your application to HoloLens 2](/learn/modules/learn-mrtk-tutorials/1-7-exercise-hand-interaction-with-objectmanipulator?ns-enrollment-type=LearningPath&ns-enrollment-id=learn.azure.beginner-hololens-2-tutorials) instructions.

When the app runs on your device, follow the on-screen instructions displayed on the **Azure Spatial Anchor Tutorial Instructions** panel:

1. Move the cube to a different location.
2. Start an Azure session.
3. Create an Azure anchor at the location of the cube.
4. Stop the Azure session.
5. Remove the local anchor to allow the user to move the cube.
6. Move the cube to somewhere else.
7. Start an Azure session.
8. Find the Azure anchor to position the cube at the location from step 3.
9. Delete the Azure anchor.
10. Stop the Azure session.

>[!Caution]
>Azure Spatial Anchors uses the internet to save and load the anchor data. Make sure your device is connected to the internet.

## Anchor an experience

In the previous sections, you learned the fundamentals of Azure Spatial Anchors. You used a cube to represent and visualize the parent game object with the attached anchor. In this section, you'll anchor an entire experience by placing it as a child of the **ParentAnchor** object.

1. On the **Hierarchy** pane, select the **ParentAnchor** object. Then on the **Inspector** pane, configure the **Transform** components as follows:

    * Change **Scale X** to **1.1**.
    * Change **Scale Z** to **1.1**.

    :::image type="content" source="../media/parent-anchor.png" alt-text="Screenshot of positioning the parent anchor." lightbox="../media/parent-anchor.png":::

2. On the **Project** pane, go to the **Assets** > **MRTK.Tutorials.GettingStarted** > **Prefabs** > **Rover** folder. Then drag the **RoverExplorer_Complete** prefab onto the **Hierarchy** pane to add it to the scene.

    :::image type="content" source="../media/add-object.png" alt-text="Screenshot of adding an object to the scene." lightbox="../media/add-object.png":::

3. With the newly added **RoverModule_Complete** object still selected on the **Hierarchy** pane, drag it to the **ParentAnchor** object to make it a child of the **ParentAnchor** object.

    :::image type="content" source="../media/rover-explorer.png" alt-text="Screenshot of Unity with the RoverExplorer_Complete object set as a child of ParentAnchor." lightbox="../media/rover-explorer.png":::

    If you rebuild the project and deploy the app to your device, you can reposition the entire Rover Explorer experience by moving the resized cube.

    >[!Tip]
    >There's a variety of user-experience flows for repositioning. Flows include the use of a repositioning object (such as the cube used in this tutorial), the use of a button to toggle a bounds control that surrounds the experience, and the use of position and rotation gizmos.

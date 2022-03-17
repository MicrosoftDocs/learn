In this unit, you'll explore the steps required to:

- Start and stop an Azure Spatial Anchors session.
- Create, upload, and download spatial anchors on a single device.

## Create and prepare the Unity project

In this section, you'll create a new Unity project and get it ready for Mixed Reality Toolkit (MRTK) development.

First, follow the steps in [Initializing your project and deploying your first application](/learn/paths/beginner-hololens-2-tutorials/) in the HoloLens 2 introduction module, excluding the "Build your application to HoloLens 2" instructions in unit 7. The steps that you'll follow include:

1. Create the Unity project and give it a suitable name, like **MRTK Tutorials**.
2. Switch the build platform.
3. Import the TextMeshPro Essential Resources.
4. Import the Mixed Reality Toolkit and configure the Unity project.
5. Create and configure the scene and give the scene a suitable name, like **AzureSpatialAnchors**.

Then, change the display options for spatial awareness to ensure that the MRTK configuration profile for your scene is **DefaultHoloLens2ConfigurationProfile**. Change the display options for the spatial awareness mesh to **Occlusion**.

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

2. Select the **MixedRealityToolkit** object on the **Hierarchy** pane. Then use the **Add Component** button on the **Inspector** pane to add the following components:

    * **AR Anchor Manager (Script)**
    * **DisableDiagnosticsSystem (Script)**

    :::image type="content" source="../media/add-component.png" alt-text="Screenshot of adding components to the MixedRealityToolkit object." lightbox="../media/add-component.png":::

    > [!Warning]
    > There's a known issue with Azure Spatial Anchors v2.9.0 and v2.10.0-preview.1 that requires two additional objects to be placed in the scene. Use the **Add Component** button on the **Inspector** pane to add **AR Camera Manager (Script)** and **AR Session (Script)** to the **MixedRealityToolkit** object. Be sure to disable the camera that's created automatically when you add **AR Camera Manager (Script)**, by clearing the checkbox next to the **Camera** object on the **Inspector** pane.
    
    > [!Note]
    > When you add the **AR Anchor Manager (Script)** component, the **AR Session Origin (Script)** component is automatically added, because the **AR Anchor Manager (Script)** component requires it.

## Configure the buttons to operate the scene

In this section, you'll add scripts to the scene to create a series of button events that demonstrate the fundamentals of how both local anchors and spatial anchors behave in an app.

1. On the **Hierarchy** pane, expand the **ButtonParent** object and select the first child object named **StartAzureSession**. On the **Inspector** pane, configure the **Button Config Helper (Script)** component's **On Click ()** event as follows:

    * Assign the **ParentAnchor** object to the **None (Object)** field.
    * From the **No Function** dropdown list, select **AnchorModuleScript** > **StartAzureSession ()** to set this function as the action to be executed when the event is triggered.

    :::image type="content" source="../media/start-azure-session.png" alt-text="Screenshot of Unity with the StartAzureSession button's OnClick event configured." lightbox="../media/start-azure-session.png":::

2. On the **Hierarchy** pane, select the next button named **StopAzureSession**. Then on the **Inspector** pane, configure the **Button Config Helper (Script)** component's **On Click ()** event as follows:

    * Assign the **ParentAnchor** object to the **None (Object)** field.
    * From the **No Function** dropdown list, select **AnchorModuleScript** > **StopAzureSession ()** to set this function as the action to be executed when the event is triggered.

    :::image type="content" source="../media/stop-azure-session.png" alt-text="Screenshot of Unity with the StopAzureSession button's OnClick event configured." lightbox="../media/stop-azure-session.png":::

3. On the **Hierarchy** pane, select the **CreateAzureAnchor** button. Then on the **Inspector** pane, configure the **Button Config Helper(Script)** component's **On Click ()** event as follows:

    * Assign the **ParentAnchor** object to the **None (Object)** field.
    * From the **No Function** dropdown list, select **AnchorModuleScript** > **CreateAzureAnchor ()** to set this function as the action to be executed when the event is triggered.
    * Assign the **ParentAnchor** object to the empty **None (Game Object)** field to make it the argument for the **CreateAzureAnchor ()** function.

    :::image type="content" source="../media/create-azure-anchor.png" alt-text="Screenshot of Unity with the CreateAzureAnchor button's OnClick event configured." lightbox="../media/create-azure-anchor.png":::

4. On the **Hierarchy** pane, select the **RemoveLocalAnchor** button. Then on the **Inspector** pane, configure the **Button Config Helper (Script)** component's **On Click ()** event as follows:

    * Assign the **ParentAnchor** object to the **None (Object)** field.
    * From the **No Function** dropdown list, select **AnchorModuleScript** > **RemoveLocalAnchor ()** to set this function as the action to be executed when the event is triggered.
    * Assign the **ParentAnchor** object to the empty **None (Game Object)** field to make it the argument for the **RemoveLocalAnchor ()** function.
    
    :::image type="content" source="../media/remove-local-anchor.png" alt-text="Screenshot of Unity with the RemoveLocalAnchor button's OnClick event configured." lightbox="../media/remove-local-anchor.png":::

5. On the **Hierarchy** pane, select the **FindAzureAnchor** button. Then on the **Inspector** pane, configure the **Button Config Helper (Script)** component's **On Click ()** event as follows:

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

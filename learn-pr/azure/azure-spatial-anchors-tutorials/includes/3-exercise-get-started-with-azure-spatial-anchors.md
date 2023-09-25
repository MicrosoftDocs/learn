In this unit, you'll explore the steps required to:

- Start and stop an Azure Spatial Anchors session.
- Create, upload, and download spatial anchors on a single device.

As a result of completing the prerequisites for this learn module, you should already have a Unity project that's set up and configured for OpenXR and MRTK3. Open that project and then check to ensure that you have the proper capabilities selected:

1. Navigate to **Edit > Project Settings > Player > Publishing Settings**.
1. Scroll down to the **Capabilities** section and select the following if they're not already selected:

- **SpatialPerception**
- **InternetClient**
- **PrivateNetworkClientServer**

When you're finished, close the **Project Settings** window and continue on with the next steps.

## Install built-in Unity packages and import the tutorial assets

1. On the menu bar, select **Window** > **Package Manager**. 

1. Verify that AR Foundation version 5.0.3 or latest version is installed.

    :::image type="content" source="../media/ar-foundation-package-manager.png" alt-text="Screenshot of selections for verifying the A R Foundation version for Package Manager." :::

## Import the tutorial assets

1. Add Azure Spatial Anchors SDK V2.12, or the latest version, to your project by following [this tutorial](/azure/spatial-anchors/how-tos/setup-unity-project?tabs=UPMPackage).

2. Download and import the following Unity custom packages in this order:

    * [MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.3.0.0.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/getting-started-v3.0.0/MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.3.0.0.unitypackage)
    * [MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpatialAnchors.3.0.0.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-spatial-anchors-v3.0.0/MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpatialAnchors.3.0.0.unitypackage)

    > [!Note]
    > Importing both MRTK3 and ASA may cause errors when the ARFoundation package version doesn't match the imported ARSubsystems version. Until this is fixed, you can manually add com.unity.xr.arsubsystems version 5.0.2 to the project's Package Manager as a [workaround](/windows/mixed-reality/develop/unity/known-issues). 
    >
    > You'll get a warning that ARSubsystems has been deprecated, but it can be ignored. If you see any CS0618 warnings that say "WorldAnchor.SetNativeSpatialAnchorPtr(IntPtr)" is obsolete, you can also ignore these.

## Prepare the scene

In this section, you'll prepare the scene by adding some of the tutorial prefabs.

1. On the **Project** pane, go to the **Assets** > **MRTK.Tutorials.AzureSpatialAnchors** > **Prefabs** folder. Then drag the following prefabs to the **Hierarchy** pane to add them to your scene:

    * **ButtonParent** prefabs
    * **Instructions** prefabs
    * **ParentAnchor** prefabs
    * Change ButtonParent's  **Tranform/Position** values to the following: X = 0.0, Y = 1.6, Z = 0.6
    * Change Instructions's  **Tranform/Position** values to the following: X = -0.8, Y = 2.0, Z = 2.0
    * Change ParentAnchor's  **Tranform/Position** values to the following: X = -0.3, Y = 1.5, Z = 0.6
    :::image type="content" source="../media/007-prefabs.png" alt-text="Screenshot of prefabs added to the Hierarchy pane." :::

    > [!Tip]
    > If you find the large icons in your scene (for example, the large framed "T" icons) distracting, you can hide them by [opening the Gizmos drop-down](https://docs.unity3d.com/2019.1/Documentation/Manual/GizmosMenu.html) and turning off the display of icons for individual objects.

1. In the **Hierarchy** window, select **MRTK XR Rig** > **Camera Offset** 
1. In the **Inspector** pane, use the **Add Component** button to add the following components:

    * **AR Anchor Manager (Script)**
    * **DisableDiagnosticsSystem (Script)**

    > [!Note]
    > When you add the **AR Anchor Manager (Script)** component, the **XR Origin** component is automatically added, because the **AR Anchor Manager (Script)** component requires it.

    :::image type="content" source="../media/ar-manager-gameobject.png" alt-text="Screenshot of adding AR Anchor Manager." :::

## Configure the buttons to operate the scene

In this section, you'll add scripts to the scene to create a series of button events that demonstrate the fundamentals of how both local anchors and spatial anchors behave in an app.

1. In the **Hierarchy** pane, expand the **ButtonParent** object and then select the first child object, **StartAzureSession**. 
1. In the **Inspector** pane, navigate to the **Pressable Button** component. It has an **On Clicked ()** event.
1. In the **Hierarchy**, select the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Clicked()** event's **None (Object)** field.
1. Select the **No Function** drop-down and then select **AnchorModuleScript** > **StartAzureSession ()**. This function will be executed when the event is triggered.

    :::image type="content" source="../media/008-a-start-azure-session.png" alt-text="Screenshot that shows Unity with the StartAzureSession button's OnClick event configured." :::

1. In the **Hierarchy** pane in the **ButtonParent** child list, select **StopAzureSession**
1. In the **Inspector** pane, navigate to the **Pressable Button** component.
2. In the **Hierarchy**, select the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Clicked()** event's **None (Object)** field.
3. Select the **No Function** drop-down and then select **AnchorModuleScript** > **StopAzureSession ()**.


    :::image type="content" source="../media/009-stop-azure-session.png" alt-text="Screenshot of Unity with the StopAzureSession button's OnClick event configured." :::

1. In the **Hierarchy** pane in the **ButtonParent** child list, select **CreateAzureAnchor**.
1. In the **Inspector** pane, navigate to the **Pressable Button** component.
2. In the **Hierarchy**, select the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Clicked()** event's **None (Object)** field.
3. Select the **No Function** drop-down and then select **AnchorModuleScript** > **CreateAzureAnchor**.
4. Select the **ParentAnchor** object again, and then drag it to the **Inspector** and drop it in the parameter of **AnchorModuleScript.CreateAzureAnchor**.

    :::image type="content" source="../media/010-create-azure-anchor.png" alt-text="Screenshot of Unity with the CreateAzureAnchor button's OnClick event configured." :::

4. In the **Hierarchy** pane in the **ButtonParent** child list, select **RemoveLocalAnchor**.
5. In the **Inspector** pane, navigate to the **Pressable Button** component.
6. In the **Hierarchy**, select the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Clicked()** event's **None (Object)** field.
7. Select the **No Function** drop-down and then select **AnchorModuleScript** > **RemoveLocalAnchor**.
8. Select the **ParentAnchor** object again, and then drag it to the **Inspector** and drop it in the parameter of **AnchorModuleScript.RemoveLocalAnchor**.


    :::image type="content" source="../media/011-remove-local-anchor.png" alt-text="Screenshot of Unity with the RemoveLocalAnchor button's OnClick event configured." :::


1. In the **Hierarchy** pane in the **ButtonParent** child list, select **FindAzureAnchor**.
1. In the **Inspector** pane, navigate to the **Pressable Button** component.
2. In the **Hierarchy**, select the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Clicked()** event's **None (Object)** field.
3. Select the **No Function** drop-down and then select **AnchorModuleScript** > **FindAzureAnchor**.

     :::image type="content" source="../media/012-find-azure-anchor.png" alt-text="Screenshot of Unity with the FindAzureAnchor button's OnClick event configured." :::

4. In the **Hierarchy** pane in the **ButtonParent** child list, select **DeleteAzureAnchor**.
5. In the **Inspector** pane, navigate to the **Pressable Button** component.
6. In the **Hierarchy**, select the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Clicked()** event's **None (Object)** field.
7. Select the **No Function** drop-down and then select **AnchorModuleScript** > **DeleteAzureAnchor**.

    :::image type="content" source="../media/013-delete-azure-anchor.png" alt-text="Screenshot of Unity with the DeleteAzureAnchor button's OnClick event configured." :::

## Connect the scene to the Azure resource

1. In the **Hierarchy** pane, select the **ParentAnchor** object. 
1. In the **Inspector** pane, locate the **Spatial Anchor Manager** (Script) component. 
1. Configure the **Credentials** section with the credentials from the Azure Spatial Anchors account that you created as part of the prerequisites for this tutorial series:

   * In the **Spatial Anchors Account ID** field, paste the **Account ID** value from your Azure Spatial Anchors account.
   * In the **Spatial Anchors Account Key** field, paste the primary or secondary **Access Key** value from your Azure Spatial Anchors account.
   * In the **Spatial Anchors Account Domain** field, paste the **Account Domain** value from your Azure Spatial Anchors account.

   :::image type="content" source="../media/015-spatial-anchor-manager.png" alt-text="Screenshot of Unity with the Spatial Anchor Manager configured." :::

## Try the basic behaviors of Azure Spatial Anchors

Azure Spatial Anchors can't run in Unity. To test the Azure Spatial Anchors functionality, you need to build the project and deploy the app to your device.

> [!Tip]
> For a reminder on how to build and deploy your Unity project to HoloLens 2, see the [Building your application to HoloLens 2](/learn/modules/learn-mrtk-tutorials/1-7-exercise-hand-interaction-with-objectmanipulator?ns-enrollment-type=LearningPath&ns-enrollment-id=learn.azure.beginner-hololens-2-tutorials) article starting at the section named "(Optional) Build and deploy the application."

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
> Azure Spatial Anchors uses the internet to save and load the anchor data. Make sure your device is connected to the internet.


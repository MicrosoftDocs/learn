In this unit, you'll explore the steps required to:

- Start and stop an Azure Spatial Anchors session.
- Create, upload, and download spatial anchors on a single device.

As a result of completing the prerequisites for this learn module, you should already have a Unity project that's set up and configured for OpenXR and MRTK2. Open that project and then check to ensure that you have the proper capabilities selected:

1. Navigate to **Edit > Project Settings > Player > Publishing Settings**.
1. Scroll down to the **Capabilities** section and select the following if they're not already selected:

- **SpatialPerception**
- **InternetClient**
- **PrivateNetworkClientServer**

When you're finished, close the **Project Settings** window and continue on with the steps below.

## Choose configuration options

There's one configuration option that we need to change: occlusion. MRTK2 bases its various configurations on a series of default profiles that can't be altered. In order to change an option, you must clone an existing default profile and change the option in the clone. We'll do that next.

1. In the **Hierarchy**, select the **Mixed Reality Toolkit** object. This causes the Mixed Reality Toolkit (MRTK) profile to appear in the **Inspector.**
1. In the **Inspector**, at the top of the **MixedReality Toolkit** component, click the drop-down that displays **DefaultMixedRealityToolkitConfigurationProfile** and change that setting to **DefaultHoloLens2ConfigurationProfile**.
1. In the vertical column of subsystems along the left side of the **Inspector**, select **Spatial Awareness**.

    We need to change an option in the Spatial Awareness subsystem, but it's currently grayed out.

    :::image type="content" source="../media/005-spatial-awareness-grayed-out.png" alt-text="Screenshot that shows the MRTK Spatial Awareness subsystem selected but grayed out.":::

    To make it available, you must clone the default profile.

1. Click the **Clone** button.
1. In the **Clone Profile** window, note that in the **Profile Name** field, Unity provides a default name of **New MixedRealityToolkitconfigurationProfile**. You can change the name to anything you want, but for this learn module we'll stay with the name provided by Unity.

    :::image type="content" source="../media/001-clone-profile-window.png" alt-text="Screenshot that shows the Clone Profile window and default clone name provided by Unity.":::

1. Click the **Clone** button in the **Clone Profile** window. 
1. Note that the **Enable Spatial Awareness System** option is now available. 

    :::image type="content" source="../media/002-enable-spatial-awareness.png" alt-text="Screenshot that shows the Enable Spatial Awareness System option now being available.":::

    Select this option.

2. The Spatial Awareness system has its own default profile (see "1" in the image below). Like the earlier default profile, it can't be altered, so the **Add Spatial Observer** section is grayed out (see "2" in the image below).

    :::image type="content" source="../media/003-spatial-awareness-profile.png" alt-text="Screenshot that shows the default Spatial profile and its options grayed out.":::

    You must clone this profile, too.

3. Click the **Clone** button to the right of the default profile name.
4. In the **Clone Profile** window, click the **Clone** button to accept the clone name provided by Unity.
5. There are now three Spatial Observers available as drop-downs. Click the first one, **XR SDK Windows Mixed Reality Spatial Mesh Observer**, to reveal its contents.
6. This spatial observer also has its own default profile that must be cloned. Click the **Clone** button, and then in the **Clone Profile** window, click **Clone** to accept the name provided by Unity and clone the default profile.
7. Scroll down to the last section in the profile, **Display Settings**, then click the **Display Option** drop-down, and then select **Occlusion**.

    :::image type="content" source="../media/004-display-options-occlusion.png" alt-text="Screenshot that shows the Spatial Observer section Display Settings with Occlusion selected.":::

## Install in-built Unity packages and import the tutorial assets

1. On the menu bar, select **Window** > **Package Manager**. 

1. Verify that AR Foundation version 4.1.7 is installed.

    :::image type="content" source="../media/006-install-package.png" alt-text="Screenshot of selections for verifying the A R Foundation version for Package Manager." :::

## Import the tutorial assets

1. Add AzurespatialAnchors SDK V2.12, or the latest version, to your project by following [this tutorial](/azure/spatial-anchors/how-tos/setup-unity-project?tabs=UPMPackage).

2. Download and import the following Unity custom packages in this order:

    * [MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.2.7.2.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/tag/getting-started-v2.7.2)
    * [MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpatialAnchors.2.12.0.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/tag/azure-spatial-anchors-v2.12.0)

    > [!Note]
    > If you see any CS0618 warnings that say "WorldAnchor.SetNativeSpatialAnchorPtr(IntPtr)" is obsolete, you can ignore them.

## Prepare the scene

In this section, you'll prepare the scene by adding some of the tutorial prefabs.

1. On the **Project** pane, go to the **Assets** > **MRTK.Tutorials.AzureSpatialAnchors** > **Prefabs** folder. Then drag the following prefabs to the **Hierarchy** pane to add them to your scene:

    * **ButtonParent** prefabs
    * **DebugWindow** prefabs
    * **Instructions** prefabs
    * **ParentAnchor** prefabs

    :::image type="content" source="../media/007-prefabs.png" alt-text="Screenshot of prefabs added to the Hierarchy pane." :::

    > [!Tip]
    > If you find the large icons in your scene (for example, the large framed "T" icons) distracting, you can hide them by [opening the Gizmos drop-down](https://docs.unity3d.com/2019.1/Documentation/Manual/GizmosMenu.html) and turning off the display of icons for individual objects.

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

    :::image type="content" source="../media/008-a-start-azure-session.png" alt-text="Screenshot that shows Unity with the StartAzureSession button's OnClick event configured." :::

1. In the **Hierarchy** pane in the **ButtonParent** child list, select **StopAzureSession**
1. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component.
2. In the **Hierarchy**, click the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
3. Click the **No Function** drop-down and then select **AnchorModuleScript** > **StopAzureSession ()**.


    :::image type="content" source="../media/009-stop-azure-session.png" alt-text="Screenshot of Unity with the StopAzureSession button's OnClick event configured." :::

1. In the **Hierarchy** pane in the **ButtonParent** child list, select **CreateAzureAnchor**.
1. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component.
2. In the **Hierarchy**, click the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
3. Click the **No Function** drop-down and then select **AnchorModuleScript** > **CreateAzureAnchor (GameObject)**.

    :::image type="content" source="../media/010-create-azure-anchor.png" alt-text="Screenshot of Unity with the CreateAzureAnchor button's OnClick event configured." :::

4. In the **Hierarchy** pane in the **ButtonParent** child list, select **RemoveLocalAnchor**.
5. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component.
6. In the **Hierarchy**, click the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
7. Click the **No Function** drop-down and then select **AnchorModuleScript** > **RemoveLocalAnchor (GameObject)**.

    :::image type="content" source="../media/011-remove-local-anchor.png" alt-text="Screenshot of Unity with the RemoveLocalAnchor button's OnClick event configured." :::


1. In the **Hierarchy** pane in the **ButtonParent** child list, select **FindAzureAnchor**.
1. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component.
2. In the **Hierarchy**, click the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
3. Click the **No Function** drop-down and then select **AnchorModuleScript** > **FindAzureAnchor (GameObject)**.

     :::image type="content" source="../media/012-find-azure-anchor.png" alt-text="Screenshot of Unity with the FindAzureAnchor button's OnClick event configured." :::

4. In the **Hierarchy** pane in the **ButtonParent** child list, select **DeleteAzureAnchor**.
5. In the **Inspector** pane, navigate to the **Button Config Helper (Script)** component.
6. In the **Hierarchy**, click the **ParentAnchor** object, and then drag it to the **Inspector** and drop it in the **On Click()** event's **None (Object)** field.
7. Click the **No Function** drop-down and then select **AnchorModuleScript** > **DeleteAzureAnchor (GameObject)**.

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


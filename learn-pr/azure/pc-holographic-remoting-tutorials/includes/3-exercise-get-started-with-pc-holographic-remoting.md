Welcome to the HoloLens 2 tutorials. In this tutorial, you'll learn how to create a Mixed Reality experience that features UI elements, 3D model manipulation, model clipping and eye-tracking features. In the second tutorial, you'll learn how to create a PC app for Holographic Remoting that lets you connect to the HoloLens 2 at any time and visualize your app in 3D.

To complete this tutorial successfully, you should've some basic knowledge of Unity and MRTK. If you don't, we recommend that you complete the Getting started tutorials before continuing.

>[!Important]
>This tutorial series supports Unity 2020 LTS (currently 2020.3.x) if you're using Open XR and Unity 2019 LTS (currently 2019.4.x) if you're using Legacy WSA. This supersedes any Unity version requirements stated in the prerequisites linked above.

## Create and prepare the Unity project

In this section, you'll create a new Unity project and get it ready for MRTK development.

Go to the [Initializing your project and deploying your first application](/windows/mixed-reality/develop/unity/tutorials/mr-learning-base-02?tabs=openxr) article and follow the instructions there, but stop when you reach the section titled "Building your application to your HoloLens 2." As a result of completing those instructions, you'll have done the following:

1. Created the Unity project and gave it a suitable name--for example, *PC Holographic Remoting*
2. Switched the build platform.
3. Imported the TextMeshPro Essential Resources.
4. Imported the Mixed Reality Toolkit and configured the Unity project.
5. Created and set the scene and gave it a suitable name--for example, *PC Holographic Remoting*.

Go to the Configuring the MRTK profiles article and follow the instructions in the "Changing the Spatial Awareness Display Option" section to change the MRTK configuration profile for your scene to the **DefaultHoloLens2ConfigurationProfile**. Change the display options for the spatial awareness mesh to **Occlusion**.

## Import the tutorial assets

[!INCLUDE[](includes/import-package.md)]

## Configure and prepare the scene

In this section, you'll prepare the scene by adding some of the tutorial prefabs.

1. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.PCHolograhicRemoting** > **Prefabs** folder. While holding down the CTRL button, select the following six prefabs.

    * ButtonParent
    * ClippingObjects
    * HandSpatialMapButton
    * Instructions
    * ModelParent
    * Platform

    :::image type="content" source="../media/add-prefab-1.png" alt-text="Screenshot of Adding prefabs 1." lightbox="../media/add-prefab-1.png":::

2. Drag these models from the prefabs folder into the **Hierarchy** window.

    :::image type="content" source="../media/add-prefab-2.png" alt-text="Screenshot of Adding prefabs 2." lightbox="../media/add-prefab-2.png":::

    To focus on the objects in the scene, you can double-click the ModelParent object and then zoom in:

    :::image type="content" source="../media/focus-objects-scene.png" alt-text="Screenshot of Focus objects on scene." lightbox="../media/focus-objects-scene.png":::

    >[!Tip]
    >If you feel that the large icons in your scene are distracting (for example, the large framed 'T' icons), you can hide them by [toggling the Gizmos](https://docs.unity3d.com/2019.1/Documentation/Manual/GizmosMenu.html) to the "off" position.

## Configure the buttons to operate the scene

In this section, you'll add scripts to the scene and create button events that demonstrate the fundamentals of model switching and clipping functionality.

### Configure the interactable (script) component

1. In the Hierarchy window, expand the **ButtonParent** object and select the next button. In the Inspector window, locate the **Interactable (Script)** component and click on plus sign icon ("+") under **OnClick ()** event.

    :::image type="content" source="../media/add-interactable.png" alt-text="Screenshot of expanding the Interactable script." lightbox="../media/add-interactable.png":::

2. With the **NextButton** object still selected in the Hierarchy window, drag the **ButtonParent** object from the Hierarchy window into the empty **None (Object)** field of the event you just added to make the ButtonParent object listen for the button click event from this button:

    :::image type="content" source="../media/add-button-parent.png" alt-text="Screenshot of Adding ButtonParent to the None Object." lightbox="../media/add-button-parent.png":::

3. Click the **No Function**  dropdown of the same event and then select ViewButtonControl > NextModel () to set the NextModel () function as the action that is triggered when the button is pressed:

    :::image type="content" source="../media/event-to-next-model.png" alt-text="Screenshot of SelectingViewButtonControl and NextModel." lightbox="../media/event-to-next-model.png":::

### Configure the remaining buttons

* For each of the remaining buttons, complete the process outlined above to assign functions to the **OnClick ()** events:

    * For the PreviousButton object, assign the **ViewButtonControl** > **PreviousModel ()** function.
    * For ClippingButton, select the **ToggleButton** > **ToggleClipping ()** function.

## Configure the view button control (script) and toggle button (script) components

At this point, your buttons are configured to demonstrate the model switching and clipping functionality. Next, you'll add 3D models to the scene and the clipping objects to the script.

We've provided six different 3D models for demonstration. Expand the **ModelParentobject** to expose these models.

1. With the ButtonParent object still selected in the Hierarchy window, in the Inspector window, locate the **View Button Control (Script)** component and expand the **Models** variable.

    In the **Size** field, enter the number of 3D models you would like to have in your scene--in this case, six. This creates fields for adding new 3D models.

    :::image type="content" source="../media/3d-models.png" alt-text="Screenshot of Enter the number of 3D models." lightbox="../media/3d-models.png":::

2. Drag each child object of ModelParent Object into these fields.

    :::image type="content" source="../media/child-object.png" alt-text="Screenshot of Drag and drop each child object." lightbox="../media/child-object.png":::

3. Drag the **ClippingObjects** object from the Hierarchy window to the **Toggle Button (Script)** component's **Clipping Object** field.

    > [!Note]
    > Stay in button parent object only.

    :::image type="content" source="../media/clip-object.png" alt-text="Screenshot of Drag and drop clipping object." lightbox="../media/clip-object.png":::

4. In the Hierarchy window, select the ClippingObjects prefab and enable it in the Inspector window to turn on the **Clipping objects**.

## Configure the clipping objects to enable clipping feature

In this section, you'll add MarsCuriosityRover object's child objects renderer into an individual **clipping object** to demonstrate the clipping of the MarsCuriosityRover model.

In the Hierarchy window, expand the **ClippingObjects** object to expose the three different clipping objects you'll use in this project.

1. To configure the **ClippingSphere** object, select it, and then in the Inspector window, locate the **Clipping Sphere (Script)** component. Next, enter the number of renderers in the **size** field that you need to add for your 3D model. In this case, add 10 for MarsCuriosityRover child objects. It will create fields for adding renderers. Next, drag the MarsCuriosityRover object's child model objects into these fields.

    :::image type="content" source="../media/enable-clip-feature.png" alt-text="Screenshot of Configure Clipping Objects to enable clipping feature." lightbox="../media/enable-clip-feature.png":::

2. Make sure the Clipping objects are turned on by enabling the ClippingObjects prefab in the Hierarchy window.

## Configure eye-tracking to highlight tooltips

In this section, you'll explore how to enable eye tracking in your project. For example, you'll implement the functionality to highlight tooltips attached to MarsCuriosityRover's parts while you're looking at them and hide them while you're looking away from them.

### Identify target objects and associated tooltips

In the Hierarchy window, select the ModelParent object. Next, expand the **MarsCuriosity** -> **Rover** to find five main parts of the MarsCuriosityRover: **POI-Camera, POI-Wheels, POI-Antena, POI-Spectrometer, POI-RUHF Antenna**.

* Observe five corresponding tooltip objects associated with MarsCuriosityRover parts in the Hierarchy window.

    :::image type="content" source="../media/target-objects.png" alt-text="Screenshot of Target Objects." lightbox="../media/target-objects.png":::

### Implement while looking at target() & on look away() events

In the Hierarchy window, select the **POI-Camera** object. Then, in the Inspector window, locate the Eye Tracking Target (Script) component and configure the **While Looking At Target() & On Look Away()** events as follows:

1. In the **None (Object)** field, assign the **POI-Camera ToolTip** object.
2. In the**No Function** dropdown of the **While Looking At Target ()** event, select **GameObject > SetActive (bool)**. Select the check box under it to highlight the tooltip as the triggered action when looking at the target object.

    :::image type="content" source="../media/looking-at-target.png" alt-text="Screenshot of Configure While Looking At Target ()." lightbox="../media/looking-at-target.png":::

3. Click the **No Function** dropdown of the **On Look Away ()** event listener. Next, select **GameObject > SetActive (bool)** and leave the check box empty so that hiding the tooltip is the action triggered when you look away from the target object.

    :::image type="content" source="../media/looking-at-away.png" alt-text="Screenshot of Configure On Look Away ()." lightbox="../media/looking-at-away.png":::

Follow the same process and assign respective tooltip objects to their same MarsCuriosityRover parts' While Looking At Target() & On Look Away() events.

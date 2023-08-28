Welcome to the HoloLens 2 tutorials. In this tutorial, you'll learn how to create a Mixed Reality experience that features UI elements, 3D model manipulation, model clipping and eye-tracking features. In the second tutorial, you'll learn how to create a PC app for Holographic Remoting that lets you connect to the HoloLens 2 at any time and visualize your app in 3D.

To complete this tutorial successfully, you should've some basic knowledge of Unity and MRTK. If you don't, we recommend that you complete the Getting started tutorials before continuing.

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

1. First, since some of the models are in glTF format that is not natively supported by Unity, we need to install a
package that allows them to be imported.

    To install the open source glTFast library, download and run this file:
    https://package-installer.glitch.me/v1/installer/OpenUPM/com.atteneder.gltfast?registry=https%3A%2F%2Fpackage.openupm.com&scope=com.atteneder

    :::image type="content" source="../media/import-gltfast.png" alt-text="Screenshot of importing glTFast." lightbox="../media/import-gltfast.png":::

    Select import.

    :::image type="content" source="../media/new-scoped-registry.png" alt-text="Screenshot of new scope registry imported." lightbox="../media/new-scoped-registry.png":::

    Select close.

2. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.PCHolograhicRemoting** > **Prefabs** folder. Select the 'SceneContent' prefab and drag it to the bottom of the **Hierarchy** window.

    :::image type="content" source="../media/add-prefab-2.png" alt-text="Screenshot of Adding prefabs 2." lightbox="../media/add-prefab-2.png":::

    To view the scene from the camera's point of view, right-click the Main Camera object in the **Hierarchy** window, and select 'Align view to selected'.

    :::image type="content" source="../media/focus-objects-scene.png" alt-text="Screenshot of Focus objects on scene." lightbox="../media/focus-objects-scene.png":::

    >[!Tip]
    >If you feel that the large icons in your scene are distracting (for example, the large framed 'T' icons), you can hide them by [toggling the Gizmos](https://docs.unity3d.com/2019.1/Documentation/Manual/GizmosMenu.html) to the "off" position.

## Configure the buttons to operate the scene

In this section, you'll add scripts to the scene and create button events that demonstrate the fundamentals of model switching and clipping functionality.

### Configure the Pressable Button (script) component

1. In the Hierarchy window, expand the **SceneContent** and **ButtonParent** objects and select the next button. In the Inspector window, locate the **Pressable Button** component and select the plus sign icon ("+") under **OnClick ()** event.

    :::image type="content" source="../media/add-interactable.png" alt-text="Screenshot of expanding the Interactable script." lightbox="../media/add-interactable.png":::

2. With the **NextButton** object still selected in the Hierarchy window, drag the **ButtonParent** object from the Hierarchy window into the empty **None (Object)** field of the event you just added to make the ButtonParent object listen for the button click event from this button:

    :::image type="content" source="../media/add-button-parent.png" alt-text="Screenshot of Adding ButtonParent to the None Object." lightbox="../media/add-button-parent.png":::

3. Click the **No Function** dropdown of the same event and then select ViewButtonControl > NextModel () to set the NextModel () function as the action that is triggered when the button is pressed:

    :::image type="content" source="../media/event-to-next-model.png" alt-text="Screenshot of SelectingViewButtonControl and NextModel." lightbox="../media/event-to-next-model.png":::

### Configure the remaining buttons

* For each of the remaining buttons, complete the process outlined above to assign functions to the **OnClick ()** events:

    * For the PreviousButton object, assign the **ViewButtonControl** > **PreviousModel ()** function.
    * For ClippingButton, select the **ToggleButton** > **ToggleClipping ()** function.

## Configure the view button control (script) and toggle button (script) components

At this point, your buttons are configured to demonstrate the model switching and clipping functionality. Next, you'll add 3D models to the scene and the clipping objects to the script.

We've provided six different 3D models for demonstration. Expand the **ModelParent** object to expose these models.

1. With the ButtonParent object still selected in the Hierarchy window, in the Inspector window, locate the **View Button Control (Script)** component and expand the **Models** variable.

    In the **Size** field, enter the number of 3D models you would like to have in your scene--in this case, six. This creates fields for adding new 3D models.

    :::image type="content" source="../media/3d-models.png" alt-text="Screenshot of Enter the number of 3D models." lightbox="../media/3d-models.png":::

2. Drag each child object of ModelParent object into these fields.

    :::image type="content" source="../media/child-object.png" alt-text="Screenshot of Drag and drop each child object." lightbox="../media/child-object.png":::

3. Drag the **ClippingObjects** object from the Hierarchy window to the **Toggle Button (Script)** component's **Clipping Object** field.

    > [!Note]
    > Stay in button parent object only.

    :::image type="content" source="../media/clip-object.png" alt-text="Screenshot of Drag and drop clipping object." lightbox="../media/clip-object.png":::

4. In the Hierarchy window, select the ClippingObjects prefab and enable it in the Inspector window to turn on the **Clipping objects**.

## Configure the clipping objects to enable clipping feature

In this section, you'll add MarsCuriosityRover object's child objects renderer into an individual **clipping object** to demonstrate the clipping of the MarsCuriosityRover model.

In the Hierarchy window, expand the **ClippingObjects** object to expose the three different clipping objects you'll use in this project.

1. To configure the **ClippingSphere** object, select it, and then in the Inspector window, add a **Clipping Sphere** component. Next, enter the number of renderers in the **size** field that you need to add for your 3D model. In this case, add 10 for MarsCuriosityRover child objects. It will create fields for adding renderers. Next, drag the MarsCuriosityRover object's child model objects into these fields.

    :::image type="content" source="../media/enable-clip-feature.png" alt-text="Screenshot of Configure Clipping Objects to enable clipping feature." lightbox="../media/enable-clip-feature.png":::

2. Make sure the Clipping objects are turned on by enabling the ClippingObjects prefab in the Hierarchy window.

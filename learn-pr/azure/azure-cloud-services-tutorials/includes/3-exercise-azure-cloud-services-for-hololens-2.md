With each consecutive chapter, you'll add new **Azure Cloud** services to expand the application features and user experience, while teaching you the fundamentals of each **Azure Cloud** service.

> [!NOTE]
> This module series will focus on the **HoloLens 2**, but due the cross-platform nature of Unity, most of these lessons will also apply for desktop and mobile applications.

## Application goals

In this module series, you'll build a **HoloLens 2** application that can detect objects from images and find its spatial location. We'll refer to these objects as **Tracked Objects**.

The user can create a **Tracked Object** to associate a set of images via computer vision, a spatial location, or both. All data must be persisted into the cloud. 

### Features

* Basic managing of data and images
* Image training and detection
* Storing a spatial location and guidance to it

## Azure Cloud Services

You'll use the following **Azure Cloud** services to implement the above features:

### Azure Storage

You will use [Azure Storage](https://azure.microsoft.com/services/storage/) to persist data. Azure Storage allows you to store data in a table and upload large binaries like images.

### Azure Custom Vision

With [Azure Custom Vision](https://azure.microsoft.com/services/cognitive-services/custom-vision-service/) (part of the [Azure Cognitive Services](https://azure.microsoft.com/services/cognitive-services/)) you can associate a set of images to *Tracked Objects*, train a machine learning model on the set you created, and detect the *Tracked Objects*.

### Azure Spatial Anchors

To store a *Tracked Object* location and give guided directions to find it, you'll use [Azure Spatial Anchors](https://azure.microsoft.com/services/spatial-anchors/).

## Create and prepare the Unity project

In this section, you'll' create a new Unity project and get it ready for MRTK development.

First, follow the steps in [Initializing your project and first application](/training/paths/beginner-hololens-2-tutorials/), excluding the Build your application to your device instructions, which includes the following steps:

1. Creating the Unity project and giving it a suitable name, for example, *Azure Cloud Tutorials*
2. Switching the build platform
3. Importing the TextMeshPro Essential Resources
4. Importing the Mixed Reality Toolkit
5. Configuring the Unity project
6. Creating and configuring the scene and give the scene a suitable name, for example, *AzureCloudServices*

## Import the tutorial assets

1) Add AzurespatialAnchors SDK to your project. To add the packages, please follow this [tutorial.](/azure/spatial-anchors/how-tos/setup-unity-project?tabs=UPMPackage)

2) Download and **import** the following Unity custom packages **in the order they are listed**:

    * [AzureStorageForUnity.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v3.0.0/AzureStorageForUnity.unitypackage)
    * [MRTK.HoloLens2.Unity.Tutorials.Assets.AzureCloudServices.3.0.0](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v3.0.0/MRTK.HoloLens2.Unity.Tutorials.Assets.AzureCloudServices.3.0.0.unitypackage)

    After you have imported the tutorial assets your Project window should look similar to this:

    :::image type="content" source="../media/after-import-legacy-xr.png" alt-text="Screenshot of Unity Hierarchy, Scene, and Project windows after importing the tutorial assets." lightbox="../media/after-import-legacy-xr.png":::

## Prepare the scene

In this section, you'll prepare the scene by adding some of the tutorial prefabs.

1. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.AzureCloudServices** > **Prefabs** > **Manager** folder. While holding down the CTRL button, select **SceneController**, **RootMenu** and **DataManager** to select the three prefabs:

    :::image type="content" source="../media/select-prefab.png" alt-text="Screenshot of Unity with SceneController, RootMenu, and DataManager prefabs selected." lightbox="../media/select-prefab.png":::

    The **SceneController (prefab)** contains two scripts, **SceneController (script)** and **UnityDispatcher (script)**. The **SceneController** script component contains several UX functions and facilitates the photo-capture functionality, while **UnityDispatcher** is a helper class to allow execute actions on the Unity main thread.

    The **RootMenu (prefab)** is the primary UI prefab that holds all UI windows connected to each other through various small script components and control the general UX flow of the application.

    The **DataManager (prefab)** is responsible for talking to Azure storage, and will be explained further in the next tutorial.

2. Now with the three prefabs still selected, drag them into the Hierarchy window to add them to the scene:

    :::image type="content" source="../media/drag-hierarchy.png" alt-text="Screenshot of Unity with newly added SceneController, RootMenu and DataManager prefabs still selected." lightbox="../media/drag-hierarchy.png":::

3. To focus in on the objects in the scene, you can double-click the **RootMenu** object, then zoom slightly out again. With the **RootMenu** object still selected, change its values in its **Transform** component to the following:

    Position: X = 0.0, Y = 1.6, Z = 0.6

    :::image type="content" source="../media/root-menu-object.png" alt-text="Screenshot of Unity with RootMenu object selected." lightbox="../media/root-menu-object.png":::

    > [!TIP]
    > If you find the large icons in your scene, (for example, the large framed 'T' icons) distracting, you can hide these by [toggling the Gizmos](https://docs.unity3d.com/2021.3/Documentation/Manual/GizmosMenu.html) to the off position.

## Configuring the scene

In this section, you'll connect *SceneManager*, *DataManager*, and *RootMenu* together to have a working scene for the next Integrating Azure storage tutorial.

### Connect the objects

1. In the Hierarchy window, select the **DataManager** object:

    :::image type="content" source="../media/data-manager-object.png" alt-text="Screenshot of Unity with DataManager object selected." lightbox="../media/data-manager-object.png":::

2. In the Inspector window, locate the **DataManager (Script)** component and you'll see an empty slot on the **On Data Manager Ready ()** event. Drag the **SceneController** object from the Hierarchy window to the **On Data Manager Ready ()** event.

    :::image type="content" source="../media/data-manager-event-listener.png" alt-text="Screenshot of Unity with DataManager event listener added." lightbox="../media/data-manager-event-listener.png":::

3. The event's dropdown menu is now active. Select the dropdown menu and navigate to **SceneController** and select the **Init ()** option in the submenu:

    :::image type="content" source="../media/data-manager-event-action.png" alt-text="Screenshot of Unity with DataManager event action added." lightbox="../media/data-manager-event-action.png":::

4. From the Hierarchy window, select the **SceneController** object. You will find the **SceneController** (script) component in the Inspector.

    :::image type="content" source="../media/scene-controller-select.png" alt-text="Screenshot of Unity with SceneController selected." lightbox="../media/scene-controller-select.png":::

5. There are now several unpopulated fields; let's change that. Move the **DataManager** object from the Hierarchy into the *Data Manager* field, then move the **RootMenu**>**MainMenu** GameObject from the Hierarchy into the *Main Menu* field.

    :::image type="content" source="../media/scene-controller.png" alt-text="Screenshot of Unity with SceneController configured." lightbox="../media/scene-controller.png":::

6. In the Hierarchy window, select the **MRTK XR Rig** object. Ensure that the **MRTK Speech** child object is enabled. This will allow you to open the menu by saying 'Open Menu'. 

7. Now your scene is ready for the upcoming tutorials. Don't forget to save it to your project.

## Prepare project build pipeline

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. You can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a HoloLens device. You can purchase devices at [HoloLens.com](http://hololens.com/).

Before we finish the scene, let's prepare the project to be built for **HoloLens 2**.

### 1. Add other required capabilities

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:

    :::image type="content" source="../media/open-project-setting.png" alt-text="Screenshot of Unity open Project Settings." lightbox="../media/open-project-setting.png":::

2. In the Project Settings window, select **Player** and then **Publishing Settings**:

    :::image type="content" source="../media/publish-settings.png" alt-text="Screenshot of Unity Publishing Settings." lightbox="../media/publish-settings.png":::

3. In  **Publishing Settings**, scroll down to the **Capabilities** section and double-check that the **InternetClient**, **Microphone**, and **SpatialPerception** capabilities (which you enabled when you created the project at the beginning of the tutorial) are enabled. Then, enable the **InternetClientServer**, **PrivateNetworkClientServer**, and **Webcam** capabilities:

    :::image type="content" source="../media/capability.png" alt-text="Screenshot of Unity Capabilities" lightbox="../media/capability.png":::

### 2. Deploy the app to your HoloLens 2

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. You can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a HoloLens device. You can purchase devices at [HoloLens.com](http://hololens.com/).

You won't be able to run all the features that you'll use in this tutorial series inside the Unity editor. Therefore, you need to be familiar with deploying the application to your HoloLens 2 device.

> [!TIP]
> For a reminder on how to build and deploy your Unity project to HoloLens 2, you can refer to the [Getting started tutorials - Build your application to your device](/training/modules/learn-mrtk-tutorials/1-7-exercise-hand-interaction-with-objectmanipulator?ns-enrollment-type=LearningPath&ns-enrollment-id=learn.azure.beginner-hololens-2-tutorials/) instructions.

### 3. Run the app on your HoloLens 2 and follow the in-app instructions

> [!CAUTION]
> All Azure Services uses the internet, so make sure your device is connected to the internet.

When the application is running on your device, grant access to the following requested capabilities:

* Microphone
* Camera

These capabilities are required for services like *Custom Vision* to function properly.

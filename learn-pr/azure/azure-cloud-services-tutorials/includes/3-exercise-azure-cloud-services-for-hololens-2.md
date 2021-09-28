With each consecutive chapter, you will add new **Azure Cloud** services to expand the application features and user experience, while teaching you the fundamentals of each **Azure Cloud** service.

> [!NOTE]
> This module series will focus on the **HoloLens 2** but due the cross-platform nature of Unity, most of your learnings will also apply for Desktop and Smartphone applications.

## Application goals

In this module series, you will build a **HoloLens 2** application that can detect objects from images and find its spatial location. To set a domain language, you call such entities from now **Tracked Object**.
The user can create a **Tracked Object** to either or both associate a set of images via computer vision and/or a spatial location. All data must be persisted into the cloud. Furthermore some aspects of the application will be optionally controlled by natural language assisted through a bot.

### Features

* Basic managing of data and images
* Image training and detection
* Storing a spatial location and guidance to it
* Bot assistant to use some features via natural language

## Azure Cloud Services

You'll use the following **Azure Cloud** services to implement the above features:

### Azure Storage

You will use [Azure Storage](https://azure.microsoft.com/services/storage/) for the persistence solution. It allows you to store data on a table and upload large binaries like images.

### Azure Custom Vision

With [Azure Custom Vision](https://azure.microsoft.com/services/cognitive-services/custom-vision-service/) (part of the [Azure Cognitive Services](https://azure.microsoft.com/services/cognitive-services/)) you can associate to *Tracked Objects* a set of images, train a machine learning model on the set and detect the *Tracked Object*.

### Azure Spatial Anchors

To store a *Tracked Object* location and give a guided directions to find it, you use [Azure Spatial Anchors](https://azure.microsoft.com/services/spatial-anchors/).

### Azure Bot Service

The application is mainly driven by traditional UI, so you use the [Azure Bot Service](https://azure.microsoft.com/services/bot-service/) to add some personality and act as a new interaction method.

## Create and prepare the Unity project

In this section, you will create a new Unity project and get it ready for MRTK development.

First, follow the Initializing your project and first application, excluding the Build your application to your device instructions, which includes the following steps:

1. Creating the Unity project and give it a suitable name, for example, *Azure Cloud Tutorials*
2. Switching the build platform
3. Importing the TextMeshPro Essential Resources
4. Importing the Mixed Reality Toolkit
5. Configuring the Unity project
6. Creating and configuring the scene and give the scene a suitable name, for example, *AzureCloudServices*

Then follow the Changing the Spatial Awareness Display Option instructions to ensure the MRTK configuration profile for your scene is **DefaultXRSDKConfigurationProfile** and change the display options for the spatial awareness mesh to **Occlusion**.

## Install in-built Unity packages

[!INCLUDE[](includes/install-packages.md)]

## Prepare the scene

In this section, you will prepare the scene by adding some of the tutorial prefabs.

1. In the Project window, navigate to **Assets** > **MRTK.Tutorials.AzureCloudServices** > **Prefabs** > **Manager** folder. While holding down the CTRL button, click on **SceneController**, **RootMenu** and **DataManager** to select the three prefabs:

    :::image type="content" source="../media/select-prefab.png" alt-text="Screenshot of Unity with SceneController, RootMenu and DataManager prefabs selected." lightbox="../media/select-prefab.png":::

2. The **SceneController (prefab)** contains two scripts, **SceneController (script)** and **UnityDispatcher (script)**. The **SceneController** script component contains several UX functions and facilitates the photo capture functionality while **UnityDispatcher** is a helper class to allow execute actions on the Unity main thread.

    The **RootMenu (prefab)** is the primary UI prefab that holds all UI windows that are connected to each other through various small script components and control the general UX flow of the application.

    The **DataManager (prefab)** is responsible for talking to Azure storage and will be explained further in the next tutorial.

3. Now with the three prefabs still selected, drag them into the Hierarchy window to add them to the scene:

    :::image type="content" source="../media/drag-hierarchy.png" alt-text="Screenshot of Unity with newly added SceneController, RootMenu and DataManager prefabs still selected." lightbox="../media/drag-hierarchy.png":::

4. To focus in on the objects in the scene, you can double-click on the **RootMenu** object, and then zoom slightly out again:

    :::image type="content" source="../media/root-menu-object.png" alt-text="Screenshot of Unity with RootMenu object selected." lightbox="../media/root-menu-object.png":::

    > [!TIP]
    > If you find the large icons in your scene, for example, the large framed 'T' icons distracting, you can hide these by [toggling the Gizmos](https://docs.unity3d.com/2019.1/Documentation/Manual/GizmosMenu.html) toggling the Gizmos to the off position.

## Configuring the scene

In this section, you will connect *SceneManager*, *DataManager* and *RootMenu* together to have a working scene to be ready for the following Integrating Azure storage tutorial.

### Connect the objects

1. In the Hierarchy window, select the **DataManager** object:

    :::image type="content" source="../media/data-manager-object.png" alt-text="Screenshot of Unity with DataManager object selected." lightbox="../media/data-manager-object.png":::

2. In the Inspector window, locate the **DataManager (Script)** component and you will see an empty slot on the **On Data Manager Ready ()** event. Now from the Hierarchy window drag the **SceneController** object into the **On Data Manager Ready ()** event.

    :::image type="content" source="../media/data-manager-event-listener.png" alt-text="Screenshot of Unity with DataManager event listener added." lightbox="../media/data-manager-event-listener.png":::

3. You will notice that the dropdown menu of the event became active, click on the dropdown menu and navigate to **SceneController** and in the sub menu select the **Init ()** option:

    :::image type="content" source="../media/data-manager-event-action.png" alt-text="Screenshot of Unity with DataManager event action added." lightbox="../media/data-manager-event-action.png":::

4. From the Hierarchy window, select the **SceneController** object, there in the Inspector you will find the **SceneController** (script) component.

    :::image type="content" source="../media/scene-controller-select.png" alt-text="Screenshot of Unity with SceneController selected." lightbox="../media/scene-controller-select.png":::

5. You will see that there are several unpopulated fields, let's change that. Move the **DataManager** object from the Hierarchy into the *Data Manager* field and move the **RootMenu** GameObject from the Hierarchy into the *Main Menu* field.

    :::image type="content" source="../media/scene-controller.png" alt-text="Screenshot of Unity with SceneController configured." lightbox="../media/scene-controller.png":::

6. Now your scene is ready for the upcoming tutorials. Don't forget to save it into your project.

## Prepare project build pipeline

While the project yet has to be filled with content, you have to perform some preparations, so the project is ready for building for **HoloLens 2**.

### 1. Add additional required capabilities

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:

    :::image type="content" source="../media/open-project-setting.png" alt-text="Screenshot of Unity open Project Settings." lightbox="../media/open-project-setting.png":::

2. In the Project Settings window, select **Player** and then **Publishing Settings**:

    :::image type="content" source="../media/publish-settings.png" alt-text="Screenshot of Unity Publishing Settings." lightbox="../media/publish-settings.png":::

3. In the  **Publishing Settings**, scroll down to the **Capabilities** section and double-check that the **InternetClient**, **Microphone** and **SpatialPerception** capabilities, which you enabled when you created the project at the beginning of the tutorial, are enabled. Then, enable the **InternetClientServer**, **PrivateNetworkClientServer**, and **Webcam** capabilities:

    :::image type="content" source="../media/capabilty.png" alt-text="Screenshot of Unity Capabilities" lightbox="../media/capabilty.png":::

### 2. Deploy the app to your HoloLens 2

Not all features that you will use in this tutorial series can run inside the Unity editor, this means that you need to be familiar with deploying the application to your HoloLens 2 device.

> [!TIP]
> For a reminder on how to build and deploy your Unity project to HoloLens 2, you can refer to the Getting started tutorials - Build your application to your device instructions.

### 3. Run the app on your HoloLens 2 and follow the in-app instructions

> [!CAUTION]
> All Azure Services uses the internet, so make sure your device is connected to the internet.

When the application is running on your device, accept access to the following requested capabilities:

* Microphone
* Camera

These capabilities are required for services like *Chat Bot* and *Custom Vision* to function properly.

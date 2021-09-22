In this module, you will learn how to use **Azure Custom Vision**.You will upload a set of photos to associate it with a *Tracked Object*, upload them to the **Custom Vision** service and start the training process. Then you will use the service to detect the *Tracked Object* by capturing photos from the webcam feed.

## Understand Azure Custom Vision

**Azure Custom Vision** is part of the **Cognitive Services** family and is used to train image classifiers. The image classifier is an AI service that uses the trained model to apply matching tags. This classification feature will be used by our application to detect *Tracked Objects*.

Learn more about [Azure Custom Vision](/azure/cognitive-services/custom-vision-service/home).

## Prepare Azure Custom Vision

Before you can start, you have to create a custom vision project, the fastest way is by using the web portal.

Follow this [quickstart tutorial](/azure/cognitive-services/custom-vision-service/getting-started-build-a-classifier) to setup your account and project until section *Upload and tag images*.

> [!WARNING]
> To train a model you need to have at least 2 tags and 5 images per tag. To use this application you should at least create one tag with 5 images, so that the training process later won't fail.

## Prepare the scene

1. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.AzureCloudServices** > **Prefabs** > **Manager** folder.

    :::image type="content" source="../media/object-detection-manager-prefab.png" alt-text="Screenshot of Unity with Project window showing path to ObjectDetectionManager prefab." lightbox="../media/object-detection-manager-prefab.png":::

2. From there drag the prefab **ObjectDetectionManager** into the scene Hierarchy.

    :::image type="content" source="../media/object-detection-manager-configure.png" alt-text="Screenshot of Unity with ObjectDetectionManager script component configuration fields shown in Inspector." lightbox="../media/object-detection-manager-configure.png":::

3. In the Hierarchy window, locate the **ObjectDetectionManager** object and select it.
The **ObjectDetectionManager** prefab contains the **ObjectDetectionManager (script)** component and as you can see from the Inspector window it depends on Azure settings and Project settings.

## Retrieve Azure API resource credentials

The necessary credentials for the **ObjectDetectionManager (script)** settings can be retrieve from the Azure portal and the custom vision portal.

## Retrieve Azure settings credentials

Find and locate the custom vision resource of type **Cognitive Services** you have created in the *Preparing the scene* section of this tutorial (select custom vision resources name followed by *-Prediction*). There click on *Overview* or *Keys and Endpoint* to retrieve the necessary credentials.

## Retrieve project settings credentials

In the [custom vision](https://www.customvision.ai/projects) dashboard, open the project you have created for this tutorial and click on the top-right corner of the page on the gear icon to open the settings page. Here on the right-hand *Resources* section you will find the necessary credentials.

1. Now with the **ObjectDetectionManager (script)** setup correctly, find the **SceneController** object in your scene Hierarchy and select it.

    :::image type="content" source="../media/configure-scene-contoller.png" alt-text="Screenshot of Unity with SceneController script component configuration fields shown in Inspector." lightbox="../media/configure-scene-contoller.png":::

2. You see *Object Detection Manager* field in the **SceneController** component is empty, drag the **ObjectDetectionManager** from the Hierarchy into that field and save the scene.

    :::image type="content" source="../media/configure-scene.png" alt-text="Screenshot of Unity with SceneController script component configured." lightbox="../media/configure-scene.png":::

## Take and upload images

1. Run the scene and click on **Set Object**, type in the name for one of the **Tracked Objects** you have created in the previous lesson. Now click on **Computer Vision** button you can find at the bottom of the **Object Card**.

2. A new window will open where you have to take six photos to train the model for image recognition. Click on the **Camera** button and perform an AirTap when you look on the object you like to track, do this six times.

    > [!TIP]
    > To improve the model training try to take each image from different angles and lighting conditions.

3. Once you have enough images click on the **Train** button to start the model training process in the cloud. Activating the training will upload all images and then start the training, this process can take up to a minute or more. A message inside the menu indicates the current progress and once it indicates the completion you can stop the application

    > [!TIP]
    > The **ObjectDetectionManager (script)** directly uploads taken images into the Custom Vision service. As an alternative the custom vision API accepts URLs to the images, as an exercise you can modify the **ObjectDetectionManager (script)** to upload the images to a Blob storage instead.

## Detect objects

1. Before detecting the objects, we have to change the API-key present in  **ObjectDetectionManager (script)** under project settings that already assign with custom vision key.

2. Find and locate the custom vision resource in Azure portal. There click on *Keys and Endpoint* to retrieve the API-key and replace with old API-key under project settings.

3. You can now put the trained model to the test, run the application and from the *main menu* click on **Search Object** and type the name of the **Tracked Object** in question. The **Object Card** will appear and click on the **Custom Vision** button. From here the **ObjectDetectionManager** will start taking image captures in the background from the camera and the progress will be indicated on the menu. Point the camera to the object you used to train the model and you will see that after a short while it will detect the object.

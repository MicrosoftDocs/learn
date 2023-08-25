In this module, you'll learn how to use **Azure Custom Vision**. You'll upload a set of photos to associate it with a *Tracked Object*, upload them to the **Custom Vision** service, and start the training process. Then you'll use the service to detect the *Tracked Object* by capturing photos from the webcam feed.

## Understand Azure Custom Vision

**Azure Custom Vision** is part of the **Cognitive Services** family, and is used to train image classifiers. The image classifier is an AI service that uses the trained model to apply matching tags. Our application will use this classification feature to detect *Tracked Objects*.

Learn more about [Azure Custom Vision](/azure/ai-services/custom-vision-service/overview).

## Prepare Azure Custom Vision

Before you can start, you need to create a custom vision project. The fastest way to create your custom project is using the web portal.

Follow this [quickstart tutorial](/azure/ai-services/custom-vision-service/getting-started-build-a-classifier) to set up your account and project. Follow the steps up to the *Upload and tag images* section.

> [!WARNING]
> To train a model, you need to have at least two tags and five images per tag. To use this application, you should at least create one tag with five images so that the training process won't fail later.

## Prepare the scene

1. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.AzureCloudServices** > **Prefabs** > **Manager** folder.

    :::image type="content" source="../media/object-detection-manager-prefab.png" alt-text="Screenshot of Unity with Project window showing path to ObjectDetectionManager prefab." lightbox="../media/object-detection-manager-prefab.png":::

2. From there, drag the prefab **ObjectDetectionManager** into the scene Hierarchy.

    :::image type="content" source="../media/object-detection-manager-configure.png" alt-text="Screenshot of Unity with ObjectDetectionManager script component configuration fields shown in Inspector." lightbox="../media/object-detection-manager-configure.png":::

3. In the Hierarchy window, locate the **ObjectDetectionManager** object and select it.
The **ObjectDetectionManager** prefab contains the **ObjectDetectionManager (script)** component and, as you can see from the Inspector window, it depends on Azure settings and Project settings.

## Retrieve Azure API resource credentials

You can retrieve the necessary credentials for the **ObjectDetectionManager (script)** settings from the Azure portal and the custom vision portal.

## Retrieve Azure settings credentials

Find and locate the custom vision resource of the **Cognitive Services** type you created in the *Preparing the scene* section of this tutorial (select custom vision resources name followed by *-Prediction*). There, select *Overview* or *Keys and Endpoint* to retrieve the necessary credentials.

## Retrieve project settings credentials

In the [custom vision](https://www.customvision.ai/projects) dashboard, open the project you created for this tutorial, then select the gear icon on the top-right corner of the page to open the settings page. You will find the necessary credentials in the *Resources* section on the right-hand side.

1. Now with the **ObjectDetectionManager (script)** set up correctly, find the **SceneController** object in your scene Hierarchy and select it.

    :::image type="content" source="../media/configure-scene-contoller.png" alt-text="Screenshot of Unity with SceneController script component configuration fields shown in Inspector." lightbox="../media/configure-scene-contoller.png":::

2. The *Object Detection Manager* field in the **SceneController** component is empty. Drag the **ObjectDetectionManager** from the Hierarchy into the **SceneController** component and save the scene.

    :::image type="content" source="../media/configure-scene.png" alt-text="Screenshot of Unity with SceneController script component configured." lightbox="../media/configure-scene.png":::

## Take and upload images

1. Run the scene and select **Set Object**. Enter the name for one of the **Tracked Objects** you created in the previous lesson. Select the **Computer Vision** button at the bottom of the **Object Card**.

2. A new window will open. You will take six photos to train the model for image recognition. Select the **Camera** button and perform an AirTap see the object you like to track. Do this six times.

    > [!TIP]
    > To improve the model training try to take each image from different angles and lighting conditions.

3. Once you have enough images, select the **Train** button to start the model-training process in the cloud. This will upload all images and then start the training. The process can take up to a minute or more. A message inside the menu indicates the current progress. Once it indicates the process is complete, you can stop the application.

    > [!TIP]
    > The **ObjectDetectionManager (script)** directly uploads taken images into the Custom Vision service. As an alternative the custom vision API accepts URLs to the images, as an exercise you can modify the **ObjectDetectionManager (script)** to upload the images to a Blob storage instead.

## Detect objects

1. Before detecting the objects, you have to change the API-key present in  **ObjectDetectionManager (script)** in the Project Settings.

2. Find and locate the custom vision resource in Azure portal. There, select *Keys and Endpoint* to retrieve the API key. Replace the old API key with the new one in the Project Settings.

3. You can now put the trained model to the test. Run the application. From the *Main menu*, select **Search Object** and enter the name of the **Tracked Object** in question. The **Object Card** will appear. Next, select the **Custom Vision** button. The **ObjectDetectionManager** will start taking image captures in the background from the camera. The menu will indicate the application progress. Point the camera to the object you used to train the model. Soon, it should detect the object.

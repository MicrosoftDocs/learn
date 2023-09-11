In this module, you'll learn how to use **Azure Spatial Anchors**. You'll store the location of a **Tracked Object** as an Azure Spatial Anchor. Once you query for the anchor, an arrow will appear to guide you toward the location.

## Understand Azure Spatial Anchors

**Azure Spatial Anchors** is part of the Azure Cloud Services family and is used to save anchor locations. The saved anchor locations can be retrieved based on the *anchor ID* from the cloud. This anchor location can be shared and accessed by multi-platform devices like HoloLens, iOS, and Android devices.

Learn more about [Azure Spatial Anchors](/azure/spatial-anchors/overview).

## Prepare Azure Spatial Anchors

Before you can start, you have to create a spatial anchor resource in your Azure portal.
Learn how to make a [spatial anchor resource](/azure/spatial-anchors/quickstarts/get-started-hololens#create-a-spatial-anchors-resource).

## Prepare the scene

In this section, you'll learn how to configure the scene and make the necessary changes.

1. Select **MRTK XR Rig > Camera Offset** object in the Hierarchy window and use the **Add Component** button in the Inspector window to add the **AR Anchor Manager (Script)**

    :::image type="content" source="../media/add-anchor-manager-script-new.png" alt-text="Screenshot of Unity with AR AnchorManager script selected." lightbox="../media/add-anchor-manager-script.png":::

2. In the Project window, navigate to **Assets > MRTK.Tutorials.AzureCloudServices > Prefabs > Manager**.

    :::image type="content" source="../media/anchor-manager-prefab.png" alt-text="Screenshot of Unity with AnchorManager prefab selected." lightbox="../media/anchor-manager-prefab.png":::

3. From the **Manager** folder, drag and drop the prefab **Anchor Manager** into the scene Hierarchy.

4. Select the **Anchor Manager** GameObject in the Hierarchy, and in the Inspector section, you'll find the **Spatial Anchor Manager** (Script). Find the account ID and key field and add the credentials that you created in the earlier lesson.

    :::image type="content" source="../media/add-anchor-manager-prefab.png" alt-text="Screenshot of Unity with newly added AnchorManager prefab still selected." lightbox="../media/add-anchor-manager-prefab.png":::

5. Now find the **Scene Controller** object in your scene Hierarchy and select it. You will see the **Scene Controller** Inspector.

    :::image type="content" source="../media/scene-controller-inspector.png" alt-text="Screenshot of Unity with SceneController script component configured." lightbox="../media/scene-controller-inspector.png":::

6. The **Anchor Manager** field in the **Scene Controller** component is empty. Drag and drop the **Anchor Manager** from the Hierarchy in the scene into that field, then save the scene.

## Build and deploy the app to your HoloLens 2

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. You can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a HoloLens device. You can purchase devices at [HoloLens.com](http://hololens.com/).

Azure Spatial Anchors can't run in Unity, so to test the Azure Spatial Anchors functionality, you need to deploy the project to your device.

> [!TIP]
> For a reminder on how to build and deploy your Unity project to HoloLens 2, you can refer to the [Building your application to your HoloLens 2](/training/modules/learn-mrtk-tutorials/1-7-exercise-hand-interaction-with-objectmanipulator?ns-enrollment-type=LearningPath&ns-enrollment-id=learn.azure.beginner-hololens-2-tutorials) instructions.

## Run the app on your HoloLens 2 and follow the in-app instructions

### Create an anchor to store a location

In this section, you'll save the object location.

1. Run the application and select **Set Object** in the main menu.

2. Enter the **Name** of the object you want to save and select **Set Object** to continue. To add more information about the object, select the **Image**, then describe the object.

3. To save the location, select **Save Location**

4. You will see an **anchor pointer** that you can move and place on the location you want to save. After that, you'll get a confirmation popup. If you want to confirm and save the location, select **Yes**; otherwise, you can change the location by selecting **No** and selecting the location again.

5. Once you confirm the location by selecting **Yes**, the location and the Anchor ID will be saved in Azure Cloud Storage. Once it's saved, you'll see the **Object tag**  in the anchor with the object's name.

### Query for finding an anchor location

1. Once after you successfully save the anchor location, you can find the anchor location by selecting **Search Object** in the main menu.

2. After selecting **Search Object**, enter the name of the object for which you wish to search in the pop-up window.

3. Select **Search Object**. If the object was saved previously and is found in the database, you'll get the object card with all the details of the object.

4. Select **Show Location** to find the object. The system will query the object address from the cloud storage.

5. After successfully retrieving the location, an **arrow** will direct you towards the location of the object. Follow the arrow until you find the location of the object.

6. Once you find the object, the object name will appear at the top, and the arrow mark will disappear. Select the **object tag** to see the details of the object.

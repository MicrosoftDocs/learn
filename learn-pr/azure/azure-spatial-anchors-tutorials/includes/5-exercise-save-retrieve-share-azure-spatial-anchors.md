In this unit, you'll learn how to save spatial anchors across multiple app sessions by saving the anchor ID to the HoloLens 2 storage. You'll also learn how to share this anchor ID with other devices for a multiple-device anchor alignment.

## Prepare the scene

1. On the **Hierarchy** pane, expand the **ButtonParent** object. Select the last four child button objects. On the **Inspector** pane, select the checkbox next to the **Name** field to make all the objects active.

    :::image type="content" source="../media/activate-object.png" alt-text="Screenshot of activating objects." lightbox="../media/activate-object.png":::

2. On the **Hierarchy** pane, select the **ButtonParent** object. On the **Inspector** pane, locate the **GridObjectCollection** component and select the **Update Collection** button to update the position of all the **ButtonParent** object's child objects.

    :::image type="content" source="../media/update-position.png" alt-text="Screenshot of updating the position of ButtonParent child objects." lightbox="../media/update-position.png":::

## Persist Azure Spatial Anchors between app sessions

In this section, you'll save and retrieve the anchor ID to and from the HoloLens local disk. This procedure will let you query Azure for the same anchor ID between different app sessions. It will enable the anchored holograms to be positioned at the same location as in the previous app session.

1. On the **Hierarchy** pane, expand the **ButtonParent** object. Locate the two buttons named **SaveAzureAnchorIdToDisk** and **GetAzureAnchorIdFromDisk**.

    :::image type="content" source="../media/locate.png" alt-text="Screenshot that shows the location of buttons for saving and getting the anchor ID." lightbox="../media/locate.png":::

2. Follow the same steps as in the "Configure the buttons to operate the scene" instructions from unit 3 to configure the **Interactable (Script)** component on each of the two buttons:

    * For the **SaveAzureAnchorIdToDisk** button object, assign the **AnchorModuleScript** > **SaveAzureAnchorIdToDisk ()** function.
    * For the **GetAzureAnchorIdFromDisk** button object, assign the **AnchorModuleScript** > **GetAzureAnchorIdFromDisk ()** function.

    > [!Note]
    > Building and testing on HoloLens 2 is not mandatory. You can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a HoloLens device. You can purchase devices at [HoloLens.com](http://hololens.com/).

    If you build the updated app to HoloLens, you can now persist spatial anchors between app sessions by saving the anchor ID. Follow these steps to test:

    1. Move the Rover Explorer to the desired location.
    2. Start an Azure session.
    3. Create an anchor at the location of the Rover Explorer.
    4. Save the anchor ID to disk.
    5. Restart the app.
    6. Get the anchor from disk to load the anchor ID that you just saved.
    7. Start an Azure session.
    8. Find the anchor to position the Rover Explorer at the location from step 3.

    > [!Note]
    > To fully restart the app, close the app window in the mixed reality home after you close the immersive app view. You can then reopen the app from the **Start** menu. For more information, see [Using apps on HoloLens](https://github.com/MicrosoftDocs/Hololens/blob/public/hololens/holographic-home.md#using-apps-on-hololens).

## Share Azure Spatial Anchors between devices

In this section, you'll share an anchor ID between devices. This procedure will allow multiple devices to query Azure for the same anchor ID, spatially aligning the anchored holograms. *Spatial alignment* is seeing the same holograms in the same physical location between multiple devices. It's key to local shared experiences in HoloLens 2.

There are many ways to transfer anchor IDs between devices. In this example, you'll use a simple web service to upload and download anchor IDs between devices.

1. On the **Hierarchy** pane, expand the **ButtonParent** object. Locate the two buttons named **ShareAzureAnchorIdToNetwork** and **GetAzureAnchorIdFromNetwork**.

     :::image type="content" source="../media/share-get-azure.png" alt-text="Screenshot that shows the buttons for saving and getting the anchor ID." lightbox="../media/share-get-azure.png":::

2. Follow the same steps as in the "Configure the buttons to operate the scene" instructions from unit 3 to configure the **Interactable (Script)** component on each of the two buttons:

    * For the **ShareAzureAnchorIdToNetwork** object, assign the **AnchorModuleScript** > **ShareAzureAnchorIdToNetwork ()** function.
    * For the **GetAzureAnchorIdFromNetwork** object, assign the **AnchorModuleScript** > **GetAzureAnchorIdFromNetwork ()** function.

    > [!Note]
    > Building and testing on HoloLens 2 is not mandatory. You can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a HoloLens device. You can purchase devices at [HoloLens.com](http://hololens.com/).

    If you build the updated app to two HoloLens devices, you can  achieve spatial alignment by sharing the anchor ID. Follow these steps to test:

    1. On HoloLens device 1: Move the Rover Explorer to the desired location.
    2. On HoloLens device 1: Start an Azure session.
    3. On HoloLens device 1: Create an anchor at the location of the Rover Explorer.
    4. On HoloLens device 1: Share the anchor ID to the network.
    5. On HoloLens device 2: Start the app.
    6. On HoloLens device 2: Get the shared anchor ID from the network (the anchor ID just shared from HoloLens device 1).
    7. On HoloLens device 2: Start an Azure session.
    8. On HoloLens device 2: Find the anchor to position the Rover Explorer at the location from step 3.

    > [!Tip]
    > If you have only one HoloLens device, you can still test the functionality by restarting the app instead of using a second HoloLens device.

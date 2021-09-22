In this module, you'll learn how to save entity data to Azure Table storage and thumbnail images to Azure Blob storage. This feature will allow us to store and retrieve *Tracked Objects* with data like ID, Name, Thumbnail Image, etc. across sessions and devices to the cloud.

## Understand Azure Storage

**Azure storage** is a Microsoft storage solution on the cloud that can cover many scenarios and requirements. It can scale massively and is easily approachable by developers. All services can be consumed under the umbrella of an **Azure storage Account**. For our use case, we will use *Table storage* and *Blob storage*.

Learn more about [Azure storage services](/azure/storage/blobs/storage-blobs-overview).

### Azure Table Storage

This service allows us to store data in a NoSQL fashion, in this project we will use it to store information about the *Tracked Object* such as: name, description, spatial anchor ID, and more.

In context of the demo application, you need two Tables, one to store information about the project with information about the state of trained models more about that in the (Integrating Azure Custom Vision) tutorial and a second table to store information about *Tracked Objects*.

Learn more about [Azure Table storage](/azure/storage/tables/table-storage-overview).

### Azure Blob Storage

This service allows you to store large binary files, you'll use this to store photos taken for *Tracked Objects* as thumbnail.
For of the demo application, you need one Blob Container to store the images.

Learn more about [Azure Blob storage](/azure/storage/blobs/storage-blobs-introduction).

## Prepare Azure Storage

To consume the Azure storage services, you'll need an Azure storage account. To create a storage account, see [Create a storage account](/azure/storage/common/storage-account-create). To learn more about storage accounts, see [Azure storage account overview](/azure/storage/common/storage-account-overview).

Once you've a storage account, you can retrieve the connection string from the **Azure portal** which will be needed in the next section of this lesson.

### Optional Azure Storage Explorer

While you can see and verify all data changes from the UI inside the application, we recommend installing [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/). This tool allows you to visually see the data in the Azure storage and is of great help when debugging and learning.

> [!TIP]
> For testing from inside the Unity editor you can use a local emulator:
>
> * on Windows 10 you can use [Azure Storage Emulator](/azure/storage/common/storage-use-emulator)
> * on MacOS/Linux you can use [Azurite Docker Image](https://hub.docker.com/_/microsoft-azure-storage-azurite) for Docker

## Prepare the scene

1. In the Hierarchy window, locate the **DataManager** object and select it.

    :::image type="content" source="../media/data-manager-configure.png" alt-text="Screenshot of Unity with DataManager script component configuration fields shown in Inspector." lightbox="../media/data-manager-configure.png":::

    From the Inspector window, you'll see that the **DataManager (script)** component is where all **Azure storage** related settings are kept. All relevant settings are already set, you just need to replace the *Connection String* field with the one you can retrieve from the Azure portal. If you're using a local Azure storage emulator solution, then you can keep the already provided *Connection String*.

    The **DataManager (script)** is responsible for talking to the **Table storage** and **Blob storage** which is consumed by other controller scripts on the UI components.

## Write and read data from Azure Table Storage

With everything prepared, it's time to create a *Tracked Object*.

1. Open the application on your HoloLens, click on the **Set Object** and you'll see how the *EnterObjectName* object will become active in the hierarchy. In this menu click on the *search bar* and type in the name, you want to give the *Tracked Object*. After providing a name click on the **Set object** button. This will create the *Tracked Object* on the Azure Table storage and you'll see now the **Object Card**.

    This **Object Card** is a UI representation of the *Tracked Object* and will have an important role several times in this tutorial series.

2. Now click on the description *text box* and type in "Car", after that click on the **Save** button to save the changes. Stop the application and rerun it.

3. Now this time click  **Search Object** and type in the *search bar* the name you've used before when creating the *Tracked Object*. You'll see that the **Object Card** with all the data is retrieved from the **Azure Table storage**.

4. Feel free to close the **Object Card** and create new *Tracked Objects* and edit their data.

    > [!TIP]
    > If you've installed the [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/) then look into the *objects* table and you'll see there the created *Tracked Object*.

## Upload and download image from Azure Blob Storage

In this section, you'll use the Azure Blob storage to upload and download images that will be used as thumbnails for *Tracked Objects*.

> [!NOTE]
> In this tutorial the application will take photos to upload images to the Blob storage. If you're running this locally from the Unity editor, then make sure that you've a webcam connected to your computer.

1. Open the application on your HoloLens, click on **Set Object** and type in the *search bar* the name "Car". Now you should see the **Object Card**, click on the **Camera** button and you'll be instructed to do an AirTap to take a photo. After taking a photo, you'll see a message that informs you about the active upload and after a while the image should appear where the placeholder was before.

2. Now rerun the application and search for the *Tracked Object* and the previously uploaded image should appear as thumbnail.

## Delete image from Azure Blob Storage

In the previous section you uploaded new images to Azure Blob storage, in this section you'll delete an image thumbnail for *Tracked Objects*.

1. Open the application on your HoloLens, click on **Set Object** and type in the *search bar* the name "Car". Now you should see the **Object Card** with the thumbnail image, click on the **Delete** button. You'll notice that the thumbnail image is replaced by the placeholder image.

2. Now rerun the application and search for the *Tracked Object* of the previously deleted thumbnail, you should only see the placeholder image.

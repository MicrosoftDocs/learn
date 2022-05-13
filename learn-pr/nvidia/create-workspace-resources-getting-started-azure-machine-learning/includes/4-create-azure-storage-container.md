Now that we have an Azure Storage Account, we'll create a container that will allow us to store unstructured blob data.  This format is ideal for storing and serving image data in a distributed fashion.  We'll reference this data in upcoming steps when we create a Datastore in Azure Machine Learning studio.  

## Create an Azure Storage Container

1. In the Azure portal, navigate to the Azure Storage Account that was created in the previous unit.

1. In the left menu, scroll to the **Data Storage** section, then select **Containers**.

    :::image type="content" source="../media/4-containers-section.png" alt-text="The Containers Section of the Storage Account Overview is shown highlighted." lightbox="../media/4-containers-section.png":::

1. Select the **+ Container+** Button, you'll be prompted to provide a name for your container.  You'll want to keep track of this name is a secure and accessible document as it will be referenced later in the module.  The container name must be lowercase, must start with a letter or number, and can include only letters, numbers, and the dash (-) character.

    Set the level of public access to the container. The default level is **Private (no anonymous access)**.

    Select **Create** to create the container:
 
    :::image type="content" source="../media/4-create-container.png" alt-text="A screenshot is displayed showing that the Container is ready to be created." lightbox="../media/4-create-container.png":::

1. Once the container is created, select **Access Keys** under the **Security + networking** section of the left-side panel.

    :::image type="content" source="../media/4-access-keys-section.png" alt-text="A screenshot is displayed showing the Access Keys section highlighted." lightbox="../media/4-access-keys-section.png":::

1. This will bring up the following screen. Select the **Show keys** icon and copy the key to the clipboard and then record it somewhere safe and accessible. This key will be needed later.

    :::image type="content" source="../media/4-show-keys.png" alt-text="A screenshot displays the Show Keys section as highlighted." lightbox="../media/4-show-keys.png":::

1. Select the **Containers** section on the left-side panel and select the newly created container as highlighted below:

    :::image type="content" source="../media/4-container-select.png" alt-text="A screenshot displays the container select section as shown highlighted" lightbox="../media/4-container-select.png":::

1. Download and extract the following provided [image data](https://github.com/microsoft/Develop-Custom-Object-Detection-Models-with-NVIDIA-and-Azure-ML-Studio/raw/main/soda_data_compressed.zip).  You'll need to decompress the included _soda_data_compressed.zip_ file, then follow the steps in the image below to upload the contents of the _soda_data\train_img\_ directory as shown.  Once you have selected these files for inclusion, select the now highlighted **Upload** button to begin the transfer from your machine to the Azure Storage Container..

    :::image type="content" source="../media/4-upload-image-data.png" alt-text="The steps to upload the image data into a storage container are shown in a screenshot." lightbox="../media/4-upload-image-data.png":::

1. Once completed, you should see that 245 images have been added to the Azure Storage Container (0.jpg - 244.jpg).  _Note that at a minimum you'll need at least 10 images to train an AutoML for Images model in Azure Machine Learning studio_

    :::image type="content" source="../media/4-uploaded-image-data.png" alt-text="A screenshot shows the uploaded image data in the Azure Storage Container." lightbox="../media/4-uploaded-image-data.png":::

1. At this point, you should have noted the Storage Account Name, Blob Container Name, and Access Key.  These values will be used in the next section when we create the Azure Machine Learning Workspace.
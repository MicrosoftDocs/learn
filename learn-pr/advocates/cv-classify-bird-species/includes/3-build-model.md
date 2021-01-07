Let's build our model! We'll download the dataset, create our Azure service, upload the data, and then train the model.

> [!NOTE]
> The sandbox sign-in process runs outside the learning module. You're automatically returned to the module after you sign in.
>
> To sign in to the sandbox:
>
> 1. Select **Sign in to activate Sandbox**.
> 1. Enter your credentials and provide authentication as prompted.
> 1. After you authenticate, if prompted, select **Review permissions**.
>     :::image type="content" source="../media/sandbox-review-permission.png" alt-text="Screenshot that shows the Review Permissions button selected.":::
> 
> 1. Select the permission settings you want to use, and then select **Accept**.
> 
>    :::image type="content" source="../media/sandbox-accept-permissions.png" alt-text="Screenshot that shows permissions details and the Accept button selected.":::
>
>The message **Sandbox activated!** is shown, and you can continue with the learning module.
>

## Download the data

The first thing we need to create our model is data! To train our model, we'll use a subset of the NABirds dataset from the CLO. 

Download the zip file that contains the dataset:

1. In your web browser, go to the [dataset](https://github.com/MicrosoftDocs/mslearn-cv-classify-bird-species/blob/master/bird_photos.zip?azure-portal=true) in GitHub.
1. Select **Download**. 
   :::image type="content" source="../media/download-dataset-from-github.png" alt-text="Screenshot that shows the dataset zip file in GitHub, with the Download button selected.":::   

   The zip file is copied to your computer and stored in your default location for downloaded files. 
1. When the download is finished, unzip the file. Note the folder location because you’ll need it in a later step.

## Create a Custom Vision API resource

Next, we'll create an API resource in Azure Cognitive Services Custom Vision:

1. In the [Azure portal](https://portal.azure.com/?azure-portal=true), select **Create a resource**.
1. Search for **custom vision**. In the **Custom Vision** card in the search results, select **Create**.
   :::image type="content" source="../media/create-new-custom-vision-resource.png" alt-text="Screenshot that shows searching for Custom Vision resource templates in the Azure portal."::: 
1. On the **Basics** tab, enter or select the required values:
   1. Select your Azure subscription.
   1. Create a new resource group:
      1. Beside **Resource group**, select the **Create new** link. 
      1. In the dialog box, enter *BirdResourceGroup*, and then select **OK**.
   1. Enter a name for your new Custom Vision service resource, (for example, *BirdCustomVisionService*).
   1. Set **Training location** and **Prediction location** to *(US) South Central US*.
      1. Set **Training pricing tier** and **Prediction pricing tier** to *Free F0 (2 Transactions per second…)*.
      1. Select **Review + create**.
          :::image type="content" source="../media/create-custom-vision-resource-details.png" alt-text="Screenshot that shows elements to select in the Azure portal to create a new Custom Vision resource.":::
1. On the next page, select **Create**.

When the deployment finishes, select **Go to resource**.

![An animated image file that demonstrates how to create a Custom Vision project.](../media/create-custom-vision-service.gif)

## Upload data

Now, it's time to upload the data that we'll use to train the machine learning model. There are two ways to upload data:
- You can use the UI to browse to, upload, and then tag images.
- You can use the images that are included in the SDK. 

When you have a large amount of data, image classes, and tags to upload, it's faster to use the SDK. However, you can choose an option in the next sections and complete the steps to upload data the way that works best for you. 

### Upload data option 1: UI upload

1. Create a project in the Custom Vision portal:

   1. Go to [https://www.customvision.ai/projects](https://www.customvision.ai/projects?azure-portal=true) and sign in. Select **New project**.
   1. In **Create a new project**, enter or select the following values:

      | Name | Value |
      | -------|------- |
      | **Name** | *A project name of your choice.* |
      | **Description**  | *A short description of the model.* |
      | **Resource Group** | *Select the resource group you created in the Azure portal.* |
      | **Project Types**  | Classification |
      | **Classification Types**  | Multiclass (Single tag per image) |
      | **Domains** | General |

      Select **Create project**.

      > [!NOTE]
      > If you want to export the model to deploy on a mobile device or in TensorFlow.js or IoT, under **Domains**, select a **compact** model option. You can change this option in settings after the project is created.

1. Add and tag an image:

   1. In your Custom Vision project, select **Add images**.  Go to the *bird_photos* folder. Complete these steps to upload the bird photos in each species folder:
      1. In your Custom Vision project, select **Add images**.
      1. In **Open**, go to the *birds_photo* folder where you extracted the images files from the dataset.
          :::image type="content" source="../media/unit-3-upload-photos-from-ui-1.png" alt-text="Screenshot that shows how to add images to a custom vision project.":::
      1. Browse to a bird species folder. Open the folder, so all images in the species folder are shown in the files pane.
      1. Select Ctrl + A to select all the images in the species folder, and then select **Open**.
          :::image type="content" source="../media/unit-3-upload-photos-from-ui-2.png" alt-text="Screenshot that shows how to select all images in a species folder.":::
      1. In **Image upload**, add a description in **My Tags** to indicate the species for the birds shown in the photos.
          :::image type="content" source="../media/unit-3-upload-photos-from-ui-3.png" alt-text="Screenshot that shows how to add a tag description to the uploaded photos.":::
      1. Select **Upload \<number\> files**.

   ![An animated GIF that demonstrates how to upload photos in Custom Vision](../media/upload-custom-vision-photos.gif)

### Upload data option 2: SDK upload

The Custom Vision SDK is available in the following languages: Python, .NET, Node.js, Go, and Java. We'll use Python and Jupyter Notebook. If you don't have these tools installed already, we recommend getting them with an Anaconda installation. You get Python and Jupyter Notebook when you [download Anaconda](https://www.anaconda.com/?azure-portal=true).

If you prefer to instead download the notebook and code, you can clone the repo by using the following command:
 
```bash
git clone https://github.com/MicrosoftDocs/mslearn-cv-classify-bird-species.git
```

Follow these steps to create the Jupyter notebook and paste code into the notebook:

1. Open a new Jupyter Notebook instance or the IDE of your choice. Then, run the following command to import the package:

   ```python
   !pip install azure-cognitiveservices-vision-customvision
   ```

1. Import the packages that are needed to run the script:

   ```python
   from azure.cognitiveservices.vision.customvision.training import CustomVisionTrainingClient
   from azure.cognitiveservices.vision.customvision.training.models import ImageFileCreateEntry
   from azure.cognitiveservices.vision.customvision.training.models import ImageFileCreateBatch
   from msrest.authentication import ApiKeyCredentials import numpy as np
   ```

1. Now use the following code to create the Custom Vision project. Before your run the code, replace the `<endpoint>` and `<key>` placeholders with the values for your Custom Vision resource.
   
   To get the Custom Vision resource values:
   1. In the [Azure portal](https://portal.azure.com/?azure-portal=true), go to your Custom Vision resource.
   1. On the resource menu, under **Resource Management**, select **Keys and Endpoint**.
   1. Copy the value from the **Endpoint** box. In the code, replace the `<endpoint>` placeholder with this value.
   1. To the right of the **KEY 1** box, select the copy icon. The key 1 value is copied to your clipboard. In the code, replace the `<key>` placeholder with this value.
   :::image type="content" source="../media/unit-3-sdk-upload-endpoint-key-values.png" alt-text="Screenshot that shows how to locate the endpoint and key values for a Custom Vision resource in the Azure portal.":::

   ```python
  
   ENDPOINT = "<endpoint>"

    # Replace with a valid key
    training_key = "<key>"
    credentials = ApiKeyCredentials(in_headers={"Training-key": training_key})
    publish_iteration_name = "classifyBirdModel"
    
    trainer = CustomVisionTrainingClient(ENDPOINT, credentials)
    
    # Create a new project
    print ("Creating project...")
    project = trainer.create_project("Bird Classification")
    
    print("Project created!")

   ```
1. Unzip the *bird_photos.zip* file that you downloaded earlier and save the files to the same directory where you saved your Jupyter Notebook file. Add the following code to change to the directory for the bird photos in your project.

    ```python
    # Change to the directory for the bird photos
    import os
    os.chdir('./bird_photos/custom_photos')
    ```

    > [!Warning]
    > Only run the code in this cell once. If you attempt to run the cell more than once without also restarting your Python kernel, the cell run will fail.

1. Add the following code to get the list of bird type tags. The tags are created based on the folder names in the bird_photos/custom_photos directory:

    ```python
    # Create a tag list from folders in bird directory
    tags = [name for name in os.listdir('.') if os.path.isdir(name)]
    print(tags)
    ```

1. Next, we create three functions that we’ll call in a `for` loop:
   - The `createTag` function creates a class tag in the Custom Vision project.
   - The `createImageList` function uses the tag name and tag ID to make an image list.
   - The `image_list` function uploads images in batches from the list.

   To create the three functions:

   1. In your Jupyter notebook file, add the `createTag` function code. The function creates an image name tag in the Custom Vision project.

   ```python
    tag_id = createTag(tag)
    print(f"tag creation done with tag id {tag_id}")
    image_list = createImageList(tag, tag_id)
    print("image_list created with length " + str(len(image_list)))

    # Break list into lists of 25 and upload in batches
    for i in range(0, len(image_list), 25):
        batch = ImageFileCreateBatch(images=image_list[i:i + 25])
        print(f'Upload started for batch {i} total items {len(image_list)} for tag {tag}...')
        uploadImageList(batch)
        print(f"Batch {i} Image upload completed. Total uploaded {len(image_list)} for tag {tag}")
   ```

  1. Next, add the code for the `createImageList` function. The function takes two parameters: a `tag` name from the list of folder names and the `tag_id` from the tag we created in the Custom Vision project. The function uses the base_image_url value to set the directory to the folder that contains the images for the `tag` we created from the folder names. Then, we append each image to the list, which we’ll use to upload in batches to the created `tag`:
  
      ```python
      def createImageList(tag, tag_id):
          # Set directory to current tag
          base_image_url = f"./{tag}/"
          photo_name_list = os.listdir(base_image_url)
          image_list = []
          for file_name in photo_name_list:
              with open(base_image_url+file_name, "rb") as image_contents:
                  image_list.append(ImageFileCreateEntry(name=base_image_url+file_name, contents=image_contents.read(), tag_ids=[tag_id]))
          return image_list
      ```
   1. The last code to add is for the `uploadImageList` function. We pass in the `image_list` that we created from the folder and then upload the list to the `tag`:

       ```python
       def uploadImageList(image_list):
        upload_result = trainer.create_images_from_files(project_id=project.id, batch=image_list)
        if not upload_result.is_batch_successful:
            print("Image batch upload failed.")
            for image in upload_result.images:
                print("Image status: ", image.status)
            exit(-1)
         ```

   1. Now we’ll add the code for our main method. For each tag, the method calls the three functions we just created. We loop through each tag (folder name) in the `tags` collection that we created from the folders in the bird_photos/custom_photos directory. Here are the steps in the `for` loop:
      1. Call the `createTag` function to create the class `tag` in the Custom Vision project.
      1. Call the `createImageList` function and with the `tag` name and `tag_id` values returned from Custom Vision. The function returns the list of images to upload.
      1. Call the `imageList` function to upload the images from the `image_list` in batches of 25. We upload in batches of 25 because Custom Vision time outs if we try to upload the entire dataset all at once.

         ```python
         for tag in tags: 
          tag_id = createTag(tag)
          print(f"tag creation done with tag id {tag_id}")
           image_list = createImageList(tag, tag_id)
         print("image_list created with length " + str(len(image_list)))
    
          # Break list into lists of 25 and upload in batches
          for i in range(0, len(image_list), 25):
              batch = ImageFileCreateBatch(images=image_list[i:i + 25])
              print(f'Upload started for batch {i} total items {len  (image_list)} for tag {tag}...')
              uploadImageList(batch)
              print(f"Batch {i} Image upload completed. Total uploaded  {len(image_list)} for tag {tag}")
           ```

        > [!Warning]
        > Run the code in this cell ony once. If you attempt to run the cell more than once without also deleting your Custom Vision project, the cell run will fail
 

## Train the model

We've created our dataset in Custom Vision, and now we can train our model. You can train the model by using the SDK, but we'll use the CustomVision.ai UI instead:

1. Go to [customvision.ai](https://www.customvision.ai/?azure-portal=true).
1. Select the **Bird Classification** project.
1. In the top navigation in the Custom Vision portal, at the right, select **Train**.
1. In the popup dialog, choose **Quick Training**, and then select **Train**.


When the training is finished, you get information about how the model is performing for the iteration. The information is displayed through metrics called precision, recall, and average precision (AP) for the model as a whole, and for each class. In the next step, we'll learn more about what these terms mean.

Now, it's time to upload the images that we'll use to train the machine learning model. There are two ways to upload images:

- In the Custom Vision portal, select, upload, and then tag images.
- In a tool like Jupyter Notebook, use the images that are included in the Custom Vision SDK. 

When you have a large amount of data, image classes, and tags to upload, it's faster to use the Custom Vision SDK. However, you can choose one of the options that are described in the next sections. Complete the steps to upload the images in the dataset the way that works best for you. 

## Use the Custom Vision portal to upload images

1. Create a project in the Custom Vision portal:

   1. Go to [https://www.customvision.ai/projects](https://www.customvision.ai/projects?azure-portal=true) and sign in. Select **New project**.

   1. In **Create new project**:

      1. For **Name**, enter a project name of your choice.

      1. For **Description**, enter a short description of the model.

      1. For **Resource group**, Select the resource group you created in the Azure portal.

      1. For **Project Types**, select **Classification**.

      1. For  **Classification Types**, select **Multiclass (Single tag per image)**.

      1. For **Domains**, select **General**.

      1. Select **Create project**.

          :::image type="content" source="../media/custom-vision-create-project.png" alt-text="Screenshot that shows how to create a new resource in the Custom Vision portal.":::

    > [!NOTE]
    > If you want to export the model to deploy on a mobile device or in TensorFlow.js or IoT, under **Domains**, select a **compact** model option. You can change this option in settings after the project is created.

1. Add images and tags for a bird species:

   1. In your Custom Vision project, select **Add images**.

       :::image type="content" source="../media/custom-vision-add-images.png" alt-text="Screenshot that highlights the Add images button in a Custom Vision project.":::

   1. In **Open**, go to the *birds-photo* folder where you extracted the images files from the dataset zip file. 

   1. Open a bird species folder.

   1. Select Ctrl + A to select all the images in the species folder, and then select **Open**.

      :::image type="content" source="../media/custom-vision-select-photos-folder.png" alt-text="Screenshot that shows selecting all images in a species folder.":::

   1. In **Image upload**, add a description in **My Tags** to indicate the species for the birds shown in the photos.

   1. Select **Upload \<number\> files**.

       :::image type="content" source="../media/custom-vision-tag-photos.png" alt-text="Screenshot that shows how to add a tag description to uploaded photos in Custom Vision.":::

1. Repeat the preceding step to upload the photos in each bird species folder in the downloaded dataset.

## Use the Custom Vision SDK to upload images

The Custom Vision SDK is available in the following programming languages: Python, .NET, Node.js, Go, and Java. We'll use Python and Jupyter Notebook. If you don't already have these tools installed, we recommend that you get them with an Anaconda installation. You get Python and Jupyter Notebook when you [download Anaconda](https://www.anaconda.com/?azure-portal=true).

If you prefer to instead download the notebook and code from GitHub, you can clone the repo by using the following command:
 
```bash
git clone https://github.com/MicrosoftDocs/mslearn-cv-classify-bird-species.git
```

Follow these steps to create the Jupyter notebook and paste code into the notebook:

1. Open a new Jupyter Notebook instance or the IDE of your choice. Then, run the following command to import the package:

   ```python
   !pip install azure-cognitiveservices-vision-customvision
   ```

1. Import the packages that you need to run the script:

    ```python
    from azure.cognitiveservices.vision.customvision.training import CustomVisionTrainingClient
    from azure.cognitiveservices.vision.customvision.training.models import ImageFileCreateEntry
    from azure.cognitiveservices.vision.customvision.training.models import ImageFileCreateBatch
    from msrest.authentication import ApiKeyCredentials 
    import numpy as np
    ```

1. Now use the following code to create the Custom Vision project. Before your run the code, replace the `<endpoint>` and `<key>` placeholders with the values for your Custom Vision resource.

   To get the Custom Vision resource values:

   1. In the [Azure portal](https://portal.azure.com/?azure-portal=true), go to your Custom Vision resource.

   1. In the resource menu, under **Resource Management**, select **Keys and Endpoint**.

   1. Copy the value from the **Endpoint** box. In the code, replace the `<endpoint>` placeholder with this value.

   1. For **KEY 1**, select the copy icon to copy the key. In the code, replace the `<key>` placeholder with this value.

      :::image type="content" source="../media/sdk-upload-endpoint-key-values.png" alt-text="Screenshot that highlights the endpoint and key values for a Custom Vision resource in the Azure portal.":::

   Your code will look like this example:

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

1. Unzip your downloaded *bird-photos.zip* file to the same directory where you saved your Jupyter Notebook file. Add the following code to change to the directory for the bird photos in your project.

   ```python
   # Change to the directory for the bird photos
   import os
   os.chdir('./bird-photos/custom-photos')
   ```

   > [!Warning]
   > Run the code in this cell only once. If you attempt to run the cell more than once without also restarting your Python kernel, the cell run fails.

1. Add the following code to get the list of bird type tags. The tags are created based on the folder names in the bird-photos/custom-photos directory:

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

   1. In your Jupyter Notebook file, add the `createTag` function code. The function creates an image name tag in the Custom Vision project.

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

   1. Next, add the code for the `createImageList` function. The function takes two parameters: a `tag` name from the list of folder names and the `tag_id` from the tag we created in the Custom Vision project. The function uses the `base_image_url` value to set the directory to the folder that contains the images for the `tag` we created from the folder names. Then, we append each image to the list, which we’ll use to upload in batches to the created `tag`:
  
       ```python
       def createImageList(tag, tag_id):
       
       # Set directory to current tag.
          base_image_url = f"./{tag}/"
          photo_name_list = os.listdir(base_image_url)
          image_list = []
          for file_name in photo_name_list:
              with open(base_image_url+file_name, "rb") as image_contents:
                  image_list.append(ImageFileCreateEntry(name=base_image_url+file_name, contents=image_contents.read(), tag_ids=[tag_id]))
          return image_list
      ```

   1. The last code to add is to create the `uploadImageList` function. We pass in the `image_list` that we created from the folder and then upload the list to the `tag`:

       ```python
       def uploadImageList(image_list):
             upload_result = trainer.create_images_from_files(project_id=project.id, batch=image_list)
             if not upload_result.is_batch_successful:
                print("Image batch upload failed.")
                for image in upload_result.images:
                     print("Image status: ", image.status)
                exit(-1)
         ```

1. Now, we’ll add the code for our main method. For each tag, the method calls the three functions we created. We loop through each tag (folder name) in the `tags` collection that we created from the folders in the bird-photos/custom-photos directory. Here are the steps in the `for` loop:

   1. Call the `createTag` function to create the class `tag` in the Custom Vision project.

   1. Call the `createImageList` function and with the `tag` name and `tag_id` values returned from Custom Vision. The function returns the list of images to upload.

   1. Call the `imageList` function to upload the images from the `image_list` in batches of 25. We upload in batches of 25 because Custom Vision time outs if we try to upload the entire dataset all at once.

       ```python
       for tag in tags: 
             tag_id = createTag(tag)
             print(f"tag creation done with tag id {tag_id}")
             image_list = createImageList(tag, tag_id)
             print("image_list created with length " + str(len(image_list)))

       # Break list into lists of 25 and upload in batches.
        for i in range(0, len(image_list), 25):
             batch = ImageFileCreateBatch(images=image_list[i:i + 25])
             print(f'Upload started for batch {i} total items {len  (image_list)} for tag {tag}...')
             uploadImageList(batch)
             print(f"Batch {i} Image upload completed. Total uploaded  {len(image_list)} for tag {tag}")
       ```

        > [!Warning]
        > Run the code in this cell only once. If you attempt to run the cell more than once without also deleting your Custom Vision project, the cell run fails.

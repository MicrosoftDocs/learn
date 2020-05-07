Let's build our model! We'll download the dataset, create our Azure service, upload the data, and then train the model.

## Download the data

The first thing we need to create our model is data! We'll use a subset of the NABirds dataset from the CLO to train our model. Download the .zip file that contains our [dataset](https://github.com/MicrosoftDocs/mslearn-cv-classify-bird-species/raw/master/bird_photos.zip).

## Create a Custom Vision API resource

Next, we'll create an API resource in Azure Cognitive Services Custom Vision to use:

1. Go to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. Select **Create a resource**.
1. Search for **Custom Vision**.
1. Select **Create**.
1. On the **Basics** tab, enter or select the required values.
1. Select **Review + create**.
1. When the deployment succeeds, a notification shows in the upper-right corner.
1. Select **Go to resource**.

![An animated GIF that demonstrates how to create a Custom Vision project](../media/create-custom-vision-service.gif)

## Upload data

Now, it's time to upload the data for training. There are a couple ways to upload data: you can either use the UI to browse, upload, and tag images, *or* you can use the SDK. 

With lots of data and image classes and tags to upload, it's faster to use the SDK. However, you can complete the steps in the next sections to upload data the way that works best for you. 

### Upload data option 1: UI upload

1. Create a project in the Custom Vision portal:

   1. Go to <https://www.customvision.ai/projects>.
   1. Select **Sign in**.
   1. Select **New project**.
   1. In **Create a new project**, enter or select the following values:

      | Name                 | Value                             |
      | ---------------------- | --------------------------------- |
      | **Name**           | *A project name of your choice.*               |
      | **Description**            | *A short description of the model.*  |
      | **Resource Group** | *Select the resource group you created in the Azure portal.*   |
      | **Project Types**          | Classification                    |
      | **Classification Types**   | Multiclass (Single tag per image) |
      | **Domains**                | General                           |

   1. Select **Create project** to create the project.

      > [!NOTE]
      > If you want to export the model to deploy on a mobile device or in TensorFlow.js or IoT, under **Domains**, select a **compact** model option. You can change this option in the settings after the project is created.

1. Add and tag an image:

   1. In your Custom Vision project, select **Add images**.
   1. Go to the *bird_photos* folder.
   1. Select Ctrl + A to select all the images for each bird species folder.
   1. Select **Open**.
   1. Add a tag for photos to indicate the bird species.
   1. Select **Upload \<number\> files**.
   1. Repeat the steps for each bird species (class).

   ![An animated GIF that demonstrates how to upload photos in Custom Vision](../media/upload-custom-vision-photos.gif)

### Upload data option 2: SDK upload

The Custom Vision SDK is available in the following languages: Python, .NET, Node.js, Go, and Java. We'll use Python and Jupyter Notebook. If you don't have these installed already, we recommend getting them with an Anaconda installation. You get Python and Jupyter Notebook when you [download Anaconda](https://www.anaconda.com/).

If you prefer to instead download the notebook and code, you can clone the repo by using the following command:
 
```bash
git clone https://github.com/MicrosoftDocs/mslearn-cv-classify-bird-species.git
```
To create the notebook and copy in the code: 

1. Open a new Jupyter Notebook instance or the IDE of your choice. Then, run the following command to import the package:

   ```python
   !pip install azure-cognitiveservices-vision-customvision
   ```

1. Import the packages that are needed to run the script:

   ```python
   from azure.cognitiveservices.vision.customvision.training import CustomVisionTrainingClient
   from azure.cognitiveservices.vision.customvision.training.models import ImageFileCreateEntry
   import numpy as np
   ```

1. Create the Custom Vision project. Update the endpoint and key with the values from the resource you created in Azure:

   ```python
   ENDPOINT = "<endpoint>"

   # Replace with a valid key
   training_key = "<key>"
   publish_iteration_name = "classifyBirdModel"

   trainer = CustomVisionTrainingClient(training_key, endpoint=ENDPOINT)

   # Create a new project
   print ("Creating project...")
   project = trainer.create_project("Bird Classification")

   print("Project created!")
   ```

1. Go to [customvision.ai](https://www.customvision.ai/) if you want to validate in the UI that the project was created.

1. Unzip *bird_photos.zip* and save it to directory where your Jupyter notebook is saved. Then, add the following code to get the list of bird type tags to be created based on the folder names in the *bird_photos* directory:

   ```python
   # Create a tag list from folders in bird directory
   import os
   os.chdir('./bird_photos')
   tags = [name for name in os.listdir('.') if os.path.isdir(name)]
   print(tags)
   ```

1. Next, we create three different functions that we'll call in the `for loop` to create each class and upload each image dataset:

   1. Create an image name tag in the Custom Vision project.

      ```python
      def createTag(tag):
          result = trainer.create_tag(project.id, tag)
          print(f'{tag} create with id: {result}')
          return result.id
      ```

   1. In the function, we pass in the tag name from the list of folder names and the tag ID from the tag we created in our project. the function takes the `base_image_url` value and sets the directory to the folder that contains the images for the tag we created from the folder names. Then, we append each image to the list, which we will use to upload in batches to the tag created:

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

   1. In the `uploadImageList` function, we pass in the `image_list` we created from the folder, and then upload that list to the tag:

      ```python
      def uploadImageList(image_list):
          upload_result = trainer.create_images_from_files(project.id, images=image_list)
          if not upload_result.is_batch_successful:
              print("Image batch upload failed.")
              for image in upload_result.images:
                  print("Image status: ", image.status)
              exit(-1)
      ```

   1. This method is our main method. It calls the functions we created for each tag. We will loop through each `tag` (folder name) in the `tags` collection we created from the folders in the *bird_photos* directory. 
   
      The steps in the loop:

      1. Call the `createTag` to create the class tag in Custom Vision.
      1. Call the `createImageList` function and send in the current `tag` name and `tag_id` value that was returned from Custom Vision. It returns our list of images to upload.
      1. We upload the images from the `image_list` in batches of 25. Custom Vision will time out if we try to upload the entire dataset at once.

         ```python
         for tag in tags:
             tag_id = createTag(tag)
             print(f"tag creation done with tag id {tag_id}")
             image_list = createImageList(tag, tag_id)
             print("image_list created with length " + str(len(image_list)))

             # Break list into lists of 25 and upload in batches
             for i in range(0, len(image_list), 25):
                 batch = image_list[i:i + 25]
                 print(f'Upload started for batch {i} total items {len(batch)} for tag {tag}...')
                 uploadImageList(batch)
                 print(f"Batch {i} Image upload completed. Total uploaded {len(batch)} for tag {tag}")
         ```

## Train the model

We have created our dataset in Custom Vision, and now we can train our model. You can train the model by using the SDK, but we'll use the CustomVision.ai UI instead by completing these steps:

1. Go to [customvision.ai](https://www.customvision.ai/).
1. Select the **Bird Classification** project.
1. Select **Train**.

When the training is finished, you get information about how the model is performing for the iteration. The information is displayed through metrics called precision, recall, and average precision (AP) for the model as a whole, and for each class. In the next step, we'll learn more about what each of these terms mean.

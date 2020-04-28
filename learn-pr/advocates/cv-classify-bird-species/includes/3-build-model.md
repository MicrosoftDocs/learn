Lets build our model. Here we will download the dataset, create our Azure service, upload the data, and train the model.

## TODO Add sandbox here

## 1. Download Data

The first thing we need to create our model is to get data! We are going to use a subset of the NA Bird dataset from Cornell to train our model. Download the zip file with our dataset from [here]().

## 2. Create Custom Vision API Resource

- Go to [portal.azure.com](https://portal.azure.com/)
- Select "Create Resource"
- Search "Custom Vision"
- Select "Create"
- Complete the required fields
- Select "Create"
- When the deployment succeeds you will get a notification in the top right corner.
- Select "Go to resource"

## 3. Upload Data

We are ready to upload the data for training. We can do this one of two ways. We can use the UI to browse upload and tag OR we can use the SDK. Follow the instructions for the way that works best for you. Note that with lots of data and images classes/tags it will be faster to use the SDK.

### Option 1: Steps for the UI upload

1. Create Project

- Select "Quick Start"
- Select "Custom Vision Portal" or go to https://www.customvision.ai/projects and login
- Select 'Sign in"
- Select "New Project"
  - Enter a Name and Resource Group and
  - Project Types: Classification
  - Classification Types: MultiClass General
  - Domains: General
- Create project

2. Add and tag images

- Select "Add Images" and navigate to the train folder for the scraped images
- Ctrl + A to select all the images in the folder
- Select "Open"
- Add tag for photos to indicate the bird species
- Select "Upload photos"
- Repeat these steps for each bird species (class)

### Option 2: SDK Upload

The Custom vision SDK is available in the following languages: Python, .Net, Node, Go and Java. We are going to use Python and Jupyter Notebooks. If you don't have these installed already I recommend getting them with Anaconda. You can download that [here](https://www.anaconda.com/)

1. Open a new jupyter notebook instance or the IDE of your choice. Then run the following command to import the package.

```python
!pip install azure-cognitiveservices-vision-customvision
```

2. Import the packages needed to run the script

```python
from azure.cognitiveservices.vision.customvision.training import CustomVisionTrainingClient
from azure.cognitiveservices.vision.customvision.training.models import ImageFileCreateEntry
import numpy as np
```

2.  Create the Custom Vision project. Update the endpoint and key with the values from the resource you created in Azure.

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

3. Go to [customvision.ai](customvision.ai) if you would like to validate the project was created in the UI.
4. Unzip the `bird_photos.zip` and save it to the same directory as the jupyter notebook. Then add the following code to get the list of bird type tags to be created based on the folder names in the `bird_photos` directory.

```python
#Create Tag List from folders in bird directory
import os
os.chdir('./bird_photos')
tags = [name for name in os.listdir('.') if os.path.isdir(name)]
print(tags)
```

5. Next we will create three different functions that we will call in the for loop to create each class and upload each image dataset.

- Create image name tag in Custom Vision project

```python
def createTag(tag):
    result = trainer.create_tag(project.id, tag)
    print(f'{tag} create with id: {result}')
    return result.id
```

- In the `createImageList` function we pass in the tag name from the list of folder names and the tag id from the tag we created in our project. It takes the `base_image_url` and sets the directory to the folder containing the images for the tag we created from the folder names. Then we append each image to the list which we will use to upload in batches to the tag created.

```python
def createImageList(tag, tag_id):
    #set directory to current tag
    base_image_url = f"./{tag}/"
    photo_name_list = os.listdir(base_image_url)
    image_list = []
    for file_name in photo_name_list:
        with open(base_image_url+file_name, "rb") as image_contents:
            image_list.append(ImageFileCreateEntry(name=base_image_url+file_name, contents=image_contents.read(), tag_ids=[tag_id]))
    return image_list
```

- In the `uploadImageList` function we will pass in the `image_list` we created from the folder and then upload that list to the tag.

```python
def uploadImageList(image_list):
    upload_result = trainer.create_images_from_files(project.id, images=image_list)
    if not upload_result.is_batch_successful:
        print("Image batch upload failed.")
        for image in upload_result.images:
            print("Image status: ", image.status)
        exit(-1)
```

- This is our main method that we call the functions we created for each tag. We will look through each `tag` (folder name) in the `tags` collection we created from the folders in the `bird_folder` directory.
- In the loop

1. Calling the `createTag` first to create the class tag in custom vision
2. Calling `createImageList` fucntion and sending in the current `tag` name and `tag_id` that was returned from custom vision. This returns our list of images to upload
3. Then we are uploading the images from the `image_list` in batches of 25 since it will timeout if try to upload the entire dataset at once.

```python
for tag in tags:
    tag_id = createTag(tag)
    print(f"tag creation done with tag id {tag_id}")
    image_list = createImageList(tag, tag_id)
    print("image_list created with length " + str(len(image_list)))

    #break list into lists of 25 and upload in batches
    for i in range(0, len(image_list), 25):
        batch = image_list[i:i + 25]
        print(f'Upload started for batch {i} total items {len(batch)} for tag {tag}...')
        uploadImageList(batch)
        print(f"Batch {i} Image upload completed. Total uploaded {len(batch)} for tag {tag}")
```

## 4. Train the Model

We have created our dataset in Custom Vision and now we can train our model. This can be done with the SDK but the steps below will use the CustomVision.ai UI.

- Navigate to CustomVision.ai and click the `Bird Classification` project that was created.
- Select "Train"
- Test your model
  - Select "Quick Test" from the upper right corner
  - Browse to local files and select a image from the test folder
  - The predication will appear on the right side of the window

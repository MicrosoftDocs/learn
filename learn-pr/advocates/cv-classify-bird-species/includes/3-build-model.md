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

3. Train the Model

- Select "Train"
- Test your model
  - Select "Quick Test" from the upper right corner
  - Browse to local files and select a image from the test folder
  - The predication will appear on the right side of the window

### Option 2: SDK Upload

The Custom vision SDK is available in the following languages: Python, .Net, Node, Go and Java. We are going to use Python and Jupyter Notebooks. If you don't have these installed already I recommend getting them with Anaconda. You can download that [here](https://www.anaconda.com/)

1. Open a new jupyter notebook instance and run the following command to import the package.

```python
!pip install azure-cognitiveservices-vision-customvision
```

2.  Create the project in custom vision. Update the keys with your keys from the resource you created in Azure.

```python
from azure.cognitiveservices.vision.customvision.training import CustomVisionTrainingClient
from azure.cognitiveservices.vision.customvision.training.models import ImageFileCreateEntry

ENDPOINT = "https://customvisinodemo.cognitiveservices.azure.com/"

# Replace with a valid key
training_key = "<Your key here>"
publish_iteration_name = "classifyBirdModel"

trainer = CustomVisionTrainingClient(training_key, endpoint=ENDPOINT)

# Create a new project
print ("Creating project...")
project = trainer.create_project("Bird Classification")
print("Project created!")
```

3. Go to [customvision.ai](customvision.ai) if you would like to validate the project was created in the UI.
4. Unzip the `bird_photos.zip` and save it to the same directory as the jupyter notebook. Then add the following code to get the list of bird type tags to be created.

```python
#Create Tag List from folders in bird directory
import os
os.chdir('./bird_photos')
tags = [name for name in os.listdir('.') if os.path.isdir(name)]
```

5.

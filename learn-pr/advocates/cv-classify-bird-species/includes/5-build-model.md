now we have data
create custom vision service
upload images in the portal OR use the cli OR both?

Awesome we have scraped a dataset to train our model. Now its time to create our Custom Vision service in Azure then upload and tag our data for training.

## Create Custom Vision Service

### Create Custom Vision Api Resource

- Go to [portal.azure.com](https://portal.azure.com/)
- Select "Create Resource"
- Search "Custom Vision"
- Select "Create"
- Complete the required fields
- Select "Create"
- When the deployment succeeds you will get a notification in the top right corner.
- Select "Go to resource"

## Upload Data

### Create Project

- Select "Quick Start"
- Select "Custom Vision Portal" or go to https://www.customvision.ai/projects and login
- Select 'Sign in"
- Select "New Project"
  - Enter a Name and Resource Group and
  - Project Types: Classification
  - Classification Types: MultiClass General
  - Domains: General
- Create project
- Add and tag images
  - Select "Add Images" and navigate to the train folder for the scraped images
  - Ctrl + A to select all the images in the folder
  - Select "Open"
  - Add tag for photos to indicate the yoga pose
  - Select "Upload photos"
  - Repeat these steps for each yoga pose (class)

## Train Model

- Select "Train"
- Test your model
  - Select "Quick Test" from the upper right corner
  - Browse to local files and select a image from the test folder
  - The predication will appear on the right side of the window

## Understand Results

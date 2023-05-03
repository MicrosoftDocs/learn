
Choose the best response for each question. Then select **Check your answers**.

## Multiple Choice
Which Image Analysis 4.0 feature generates an English sentence describing image contents, plus descriptions for other objects and regions within the image?
( ) Caption {{Incorrect. Caption generates a single, human-readable English sentence describing the image but doesn't create tags for individual objects and regions within the image.}}
(x) Dense Captions {{Correct. Dense Captions generates a single, human-readable English sentence describing the image and also creates tags for individual objects and regions within the image.}}
( ) Tags {{Incorrect. The Tags feature creates a list of labels or tags for the image and other features detected within it.}}

## Multiple Choice
Object detection models are used to do what?
( ) Classify images based on their primary subject matter. {{Incorrect. Image classification models are used to classify or categorize pictures based on their primary subject matter.}}
(x) Identify and categorize individual entities and their location within an image. {{Correct. Object detection models in computer vision identify and categorize individual entities or objects within an image.}}
( ) Create a list of labels for an image. {{Incorrect. Tagging models create a list of labels or tags for an image and other features identified within it.}}

## Multiple Choice
When using Vision Studio, what is the easiest way to generate a COCO annotation for a custom object detection model in Image Analysis 4.0?
(x) Use the Azure Machine Learning data-labeling workflow. {{Correct. In Image Analysis 4.0, the data-labeling workflow in Azure Machine Learning generates the COCO file for training data. Azure Machine Learning allows you to manually label your images and generate a COCO file that can be imported into Vision Studio.}}
( ) Use the Vision Studio COCO file generator utility after manually labeling images in the Dataset. {{Incorrect. Vision Studio doesn't contain a COCO file generator utility.}}
( ) Import a COCO file created manually in Visual Studio Code. {{Incorrect. COCO files are JSON files that can be created manually using tools like Visual Studio Code. However, using Visual Studio Code to create a COCO file isn't the easiest way to generate the file.}}
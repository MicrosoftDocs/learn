In some cases, pre-trained computer vision models may not provide the accuracy or precision necessary to produce the desired results. Image Analysis 4.0 allows developers to train a specialized model in these circumstances. The model customization capabilities provided by Image Analysis 4.0 enable developers to use their own images to train unique, custom models specific to their individual needs. The Florence foundation model makes the Image Analysis 4.0 models especially effective at few-shot learning, meaning accurate models can be created with fewer training images.

Custom models can be created for either image classification or object detection.

## Image classification

**Image classification** uses machine learning models to classify or categorize images based on their primary subject matter. For example, an image classification model selects the most prominent feature detected within a photograph, such as a dog, a herd of horses, or a famous landmark like the Grand Canyon, and classifies the image based on that feature. Image classification models are created by training them with images already evaluated and labeled with the desired classification.

## Object detection

**Object detection** in computer vision identifies and categorizes individual entities within an image. In Image Analysis 4.0, object detection models return an array of the objects detected within an image. This array contains a name and confidence score, which indicates the predicted probability that the entity identified is actually that object. The API output also includes an object's pixel coordinates or bounding box.

## Model training

The primary components of the model customization capabilities in Image Analysis 4.0 are the training images, a COCO file, a dataset object, and a model object.

### Training images

The collection of training images should include multiple examples for each label you're attempting to detect. You also want to set aside a few extra photos for testing your model once it has been trained. Training images must be stored in an Azure Storage Account container to be accessible to the model. To effectively train your model, you should use images with a visual variety. Select images that vary by camera angle, lighting, background, size, type, and other features that provide the model with enough mixture to recognize image content under different conditions.

Microsoft's Florence models provide excellent few-shot capabilities, achieving remarkable model performance with limited training images. However, providing more training data allows trained models to perform better generally.

### COCO files

When training custom models, the Common Object in Context (COCO) file format is used for storing information about training images and their associated annotations, such as the labeling information associated with each training image. In Image Analysis 4.0, the data-labeling workflow in Azure Machine Learning generates the COCO file for your training data. Azure Machine Learning allows you to manually label your images and generate a COCO file that can be imported into Vision Studio.

COCO files are JSON files that provide a standard format for indexing and organizing references to all training images, their associated labeling information, and, for object detection, the specified bounding box coordinates of each tag associated with the training images. COCO files must contain the `images`, `annotations`, and `categories` required fields and should be stored in the same Azure Storage container as the associated training images.

### Dataset object

The Dataset object is a data structure stored by the Image Analysis service that references the association file. You must create a Dataset object before creating and training a model.

### Model object

The Model object is a data structure stored by the Image Analysis service representing a custom model. It must be associated with a Dataset to perform initial training. Once trained, you can query your model by entering its name in the model-version query parameter of the Analyze Image API call.

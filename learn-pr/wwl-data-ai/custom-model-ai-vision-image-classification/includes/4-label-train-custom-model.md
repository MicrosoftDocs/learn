Once you upload your images to blob storage and created your dataset, the next step is to label your images and connect the resulting COCO file. If you already have a COCO file for your training images, you can skip the labeling step.

## Labeling your training images

Labeling your training images is done in Azure Machine Learning studio, using the Data Labeling Project. Having complete and accurate labels for your training images greatly improves the performance of your trained model. When you label your images, be sure to accurately assign labels and completely label all instances of each class.

In your dataset within Vision Studio, create a new Azure Machine Learning Data Labeling project or connect to an existing project if you created one in Azure Machine Learning studio.

![Screenshot of a new dataset in Vision Studio custom model project.](../media/new-dataset.png)

Once your project has been created, selecting that button will take you to Azure Machine Learning Studio and open up the labeling project. In Azure Machine Learning Data Labeling, you can add categories for your images or objects (such as apple, orange, banana). Once you have categories, start your project and go to the labeling tab. You need to label 3-5 images per category.

![Screenshot of a labeling fruit in Azure Machine Learning Studio.](../media/aml-studio-data-labeling-apply-labels.png)

There are tools with Azure Machine Learning to help with labeling, such as *ML-assisted labeling* which takes some labels that you provide for a subset of the images and tries to label the remaining images for you. If using these features, it's important to review the labels to ensure they're accurate. If they're not accurate, your trained model's performance decreases.

When the labeling is completed and all training images are correctly classified or labeled, you can add your COCO file to your dataset directly from your Azure Machine Learning workspace.

## Training your model

With all the training images labeled, the next step is training your model. When training a model select the model type, specify the dataset you want to use as training data, and indicate the training budget. The training budget is an upper bound of time for how long the training will run; the actual time used for training is often less than the specified budget.

Once your model is trained, selecting it allows you to view the performance of evaluation run. If an evaluation dataset isn't provided when training your model, it uses the default evaluation run. The default evaluation run takes a small set of the labeled images out of the training set, uses the trained model for predictions on that subset, and compares the predictions to the provided labels.

From the trained model page, you can trigger new evaluation runs on a different set of images or try out your own tests in Vision Studio by selecting the tab on the top of the page.

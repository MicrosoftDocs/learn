We'll now export our labeled dataset.  This task will produce a json file stored in an Azure Blog Storage container assigned to our Azure Machine Learning studio instance. The file contains url references to the raw image data and the label metadata for each image. We'll reference this dataset later to use in model training through a Jupyter Notebook instance.

## Export a labeled Azure Machine Learning dataset

1. After labeling all of your images (remember to label a minimum of 50 in order to prepare for training), we're now ready to export an annotation file. Navigate to the data labeling project and select **Export** then select **Azure ML Dataset**. This operation will export your image dataset as an AutoML-compatible Azure ML dataset named according to the format 'NAME_DATE_TIME'. 

    :::image type="content" source="../media/4-export-dataset.png" alt-text="A screenshot demonstrating how to export an Azure ML Dataset." lightbox="../media/4-export-dataset.png"::: 

1. Select the exported dataset.

    :::image type="content" source="../media/4-select-exported-dataset.png" alt-text="A screenshot showing where to select the exported Azure ML Dataset." lightbox="../media/4-select-exported-dataset.png":::

1. The previous step will open a screen showing the newly created dataset.  Copy the name of the Dataset and store it somewhere secure and accessible on your development machine as we'll use this value in the next module of the Learning Path.  In this example, the name is **soda_20220329_18449**.

    :::image type="content" source="../media/4-dataset-name.png" alt-text="A screenshot showing the name of the exported dataset." lightbox="../media/4-dataset-name.png":::
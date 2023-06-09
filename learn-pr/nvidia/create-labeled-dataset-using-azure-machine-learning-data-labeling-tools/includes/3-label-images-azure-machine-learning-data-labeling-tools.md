We're now ready to begin working with our newly created Azure Machine Learning Data Labeling project. To prepare our images for training an object detection model, we'll need to label our image data appropriately. This task will involve drawing a bounding box around the objects of interest in our dataset, which will be stored as metadata. This metadata will then be referenced during training to allow us to gauge the accuracy of our model as it is trained over time. The accuracy of our model is verified by referencing our labeled image data to determine that detected objects are being identified within the regions we've defined.

## Label images with Azure Machine Learning data labeling tools

1. Navigate to your Azure Machine Learning Data Labeling project by locating the **Manage** section on the left-hand pane and select **Data Labeling**, then select your newly created project.

    :::image type="content" source="../media/3-select-data-labeling-project.png" alt-text="A screenshot showing the newly created data labeling project." lightbox="../media/3-select-data-labeling-project.png"::: 

1.  On the resulting screen, select the **Label data** button. 

    :::image type="content" source="../media/3-select-label-data.png" alt-text="A screenshot showing where to begin labeling the image data." lightbox="../media/3-select-label-data.png"::: 

1. The previous step will open a labeling utility, which will allow you to draw bounding boxes and tag objects/defects present in your images. There are multiple keyboard shortcuts available, which can be reviewed under the **Shortcut Keys** panel. As you label images, select the **Submit** button to save the labeled image.  Repeat this process to label a minimum of 10 images (10 is the minimum amount of labeled samples required by aAzure Machine Learning Studio to successfully train an object detection model in an experiment task).

    :::image type="content" source="../media/3-label-images.png" alt-text="A screenshot showing images being labeled." lightbox="../media/3-label-images.png"::: 

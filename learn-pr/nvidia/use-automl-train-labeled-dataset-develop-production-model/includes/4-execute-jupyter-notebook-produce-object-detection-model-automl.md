In this section, we'll continue to work in the Jupyter notebook to execute the steps that will produce our object detection model. This task will be accomplished using [AutoML for computer vision](https://docs.microsoft.com/azure/machine-learning/concept-automated-ml). You'll be able to see your model in action by performing inference on a test sample that was never before seen by the model during training. 

## Execute the Jupyter Notebook to produce an object detection model using AutoML

1. If you haven't already, navigate to your Jupyter workspace and select the *AutoMLImage_ObjectDetection.ipynb* file to open the Jupyter notebook.

    :::image type="content" source="../media/3-open-notebook.png" alt-text="A screenshot again showing the Jupyter workspace with all necessary prerequisites." lightbox="../media/3-open-notebook.png"::: 

1. Continue to the **Configuring your AutoML run for image tasks** section and begin executing the cell in the **Using default hyperparameter values for the specified algorithm**.  This step will use an[AutoMLImageConfig](https://docs.microsoft.com/azure/machine-learning/how-to-auto-train-image-models) to create a model training configuration that will assign default hyperparameters to produce an optimized object detection model.

1. Continue to execute the cells in the **Submitting an AutoML run for Computer Vision Tasks** section. This operation will submit an experiment task that will run on the training instance that was assigned in the **Compute target setup** section.  After executing these cells, you can monitor the progress in Azure Machine Learning studio by navigating locating the **Assets** section on the left-hand pane and select **Experiments**

    :::image type="content" source="../media/4-experiments.png" alt-text="A screenshot showing registered experiments in Azure Machine Learning studio." lightbox="../media/4-experiments.png"::: 

    You can then select the running job, which should be named **automl-image-object-detection_latest_V3**. This action will allow you to view the progress of the model training.

    :::image type="content" source="../media/4-running-experiment.png" alt-text="A screenshot showing a running experiment in Azure Machine Learning studio." lightbox="../media/4-running-experiment.png":::

1. When the experiment has completed, you'll see the following.

    :::image type="content" source="../media/4-running-experiment-completed.png" alt-text="A screenshot showing a completed experiment in Azure Machine Learning studio." lightbox="../media/4-running-experiment-completed.png":::    

    Select the job **Display name** to bring up the job **Details** where you can view the results of the model training.

    :::image type="content" source="../media/4-job-details.png" alt-text="A screenshot showing the job details of the completed experiment in Azure Machine Learning studio." lightbox="../media/4-job-details.png":::  

1. Now that our model is trained, we can continue to execute the cells in the **Register the optimal vision model from the AutoML run** section. This process will automatically select the child run with the highest accuracy.

1. Continue to execute the cells in the **Download the model and other associated files e.g. labels** section.  There's an optional cell that you can run by specifying a specific AutoML **run_id**.  The output of either of these cells will supply the model and label into a newly created *models* folder that is accessible in your Jupyter workspace. Navigate to your Jupyter workspace and open the *models* folder and you'll see the **labels.json** and **model.onnx** output.  

    :::image type="content" source="../media/4-model-folder.png" alt-text="A screenshot showing the newly created model folder in the Jupyter workspace." lightbox="../media/4-model-folder.png":::

    Select **labels.json** and **model.onnx** then **Download** the output files.  These files are the trained model and it's associated labels.

    :::image type="content" source="../media/4-download-output.png" alt-text="A screenshot showing how to download the job output." lightbox="../media/4-download-output.png":::

1. Navigate back to the Jupyter notebook and execute all cells in the **Load the labels and ONNX model files** section.  This step will load the model output and labels to prepare for execution.

1. Continue to execute the cells in the **Get expected input and output details for an ONNX model**.  This task will analyze the model to determine the input and output shapes that define the Convolution Neural Network present in the model.

1. Continue to execute the cells in the **Image Inferencing Preprocessing** section.  This will  preprocess the *test_image1.jpg* sample that was uploaded to our workspace earlier.  The preprocessing step will transform the image to match the expect input shape that was determined in the previous step.

1. Continue to execute the cells in the **Object detection with YOLO** section.  This section will perform inference on the *test_image1.jpg* sample and demonstrate the object detection model output visually in the final cell.  Here you can see the accuracy of your model as it detects object on a never before seen image sample.

    :::image type="content" source="../media/4-model-output.png" alt-text="A screenshot showing how the model output when run on the test_image1 sample." lightbox="../media/4-model-output.png":::
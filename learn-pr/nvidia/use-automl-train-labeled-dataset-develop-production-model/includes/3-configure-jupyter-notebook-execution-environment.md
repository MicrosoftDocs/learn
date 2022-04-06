In this section, we'll work with the Jupyter notebook that was uploaded to our Jupyter workspace. We'll execute commands that will install dependencies to ensure that our environment can run later referenced AutoML tasks. This process will involve upgrading the [azureml Python SDK](https://pypi.org/project/azureml-sdk/) and installing the [torchvision](https://pypi.org/project/torchvision/) Python package.

## Configure the Jupyter notebook execution environment

1. Navigate to your Jupyter workspace and select the *AutoMLImage_ObjectDetection.ipynb* file to open the Jupyter notebook.

    :::image type="content" source="../media/3-open-notebook.png" alt-text="A screenshot showing the Jupyter workspace with all necessary prerequisites." lightbox="../media/3-open-notebook.png"::: 

1. If you receive a **Kernel not found** prompt, select **Python 3.8 - AzureML** from the dropdown as shown then select **Set Kernel**.

    :::image type="content" source="../media/3-set-kernel.png" alt-text="A screenshot showing how to set the kernel in the Jupyter notebook." lightbox="../media/3-set-kernel.png"::: 

1. Execute the cells in the **Environment Setup** section.  This can be done by selecting the cell, then pressing *Shift+Enter* on the keyboard.  Repeat this process for each cell and stop after running **pip install torchvision==0.9.1**.

    :::image type="content" source="../media/3-environment-setup.png" alt-text="A screenshot showing the cells within the environment setup successfully completed." lightbox="../media/3-environment-setup.png"::: 

1. After you've successfully executed the **pip install torchvision==0.9.1** task, you'll need to restart the Kernel. To restart the kernel, select the **Kernel** menu item and choose **Restart** from the dropdown.

    :::image type="content" source="../media/3-restart-kernel.png" alt-text="A screenshot showing how to reset the kernel in the Jupyter notebook." lightbox="../media/3-restart-kernel.png":::

1. Execute the **pip freeze* cell, which will list all installed python libraries, then execute the cell underneath it to import the libraries that will be used in further steps.

1. Continue to execute the cells in the **Workspace setup** section.  This step will read in the config.json file that was uploaded earlier and allow us to execute tasks against your Azure Machine Learning workspace.

1. Continue to execute the cells in the **Compute target setup** section.  You'll want to change the value of **compute_name** to match the name of the compute instance that exists in your Azure Machine Learning studio workspace. Otherwise, this script may either fail to create the instance (if an instance of the same name already exists in the same region) or it will create a second instance (the subsequent steps will still work but it will not use the existing resource).

    :::image type="content" source="../media/3-compute-target-setup.png" alt-text="A screenshot showing the compute target setup with the compute_name variable highlighted." lightbox="../media/3-compute-target-setup.png":::

1. Continue to execute the cells in the **Experiment Setup** section. This will create an Azure machine learning experiment that will allow us to track the status of the model during training.

1. Continue to execute the cells in the **Dataset with input Training Data** section.  Please note that you'll need to replace the **name** variable with the name of the Dataset that was exported at the end of the previous module.  This value can be obtained in your Azure Machine Learning studio instance in the left-hand pane, locate the **Assets** section and select **Datasets**. You can validate that the Dataset was imported properly by viewing the output in the **training_dataset.to_pandas_dataframe()** cell.

    :::image type="content" source="../media/3-dataset-name.png" alt-text="A screenshot showing where to obtain the name of the dataset to be used in the Jupyter notebook." lightbox="../media/3-dataset-name.png":::

    :::image type="content" source="../media/3-dataset-training-data.png" alt-text="A screenshot showing the output of the Dataset with Input Training Data section in the Jupyter notebook." lightbox="../media/3-dataset-training-data.png":::
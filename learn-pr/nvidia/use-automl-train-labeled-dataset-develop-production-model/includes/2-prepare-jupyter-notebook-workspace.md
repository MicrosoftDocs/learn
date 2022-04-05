The Azure Machine Learning compute instance is a secure, cloud-based Azure workstation that provides data scientists with a Jupyter Notebook server, JupyterLab, and a fully managed machine learning environment.  Previously we deployed a compute instance that we'll now use to execute a special notebook.  This notebook will allow us to train our object detection model using AutoML.  In this unit, we'll prepare the Jupyter notebook workspace with prerequisites that will allow us to run the notebook successfully.

## Prepare the Jupyter notebook workspace

1. Sign in to [Azure Machine Learning studio](https://ml.azure.com/), and select your workspace.

1. If you have already saved and are able to retrieve the config.json file from Module 1, you can skip the next two steps.  If you need to obtain this file again, open the [Azure [ortal](https://portal.azure.com) in a new tab and navigate to your Azure Machine Learning resource.  You can easily locate this resource by typing  “Azure Machine Learning” in the Azure search bar and choosing the Machine Learning icon.  This action will list all available Azure Machine Learning resources in your Azure Subscription.

    :::image type="content" source="../media/2-find-resource.png" alt-text="A screenshot that demonstrates how to navigate to your Azure Machine Learning resource." lightbox="../media/2-find-resource.png":::  

1. When you've successfully navigated to your Azure Machine Learning resource, notice in the **Overview** section there will be a button labeled "Download config.json".  Select this button to download the configuration and store it somewhere secure and accessible so that it may be used in upcoming steps.
 
    :::image type="content" source="../media/2-download-config.png" alt-text="A screenshot showing where to Download the Azure Machine Learning workspace configuration." lightbox="../media/2-download-config.png":::

1.  On the left-hand pane, locate the **Manage** section and select **Compute**, then select the **Jupyter** link that corresponds to the earlier deployed compute instance. 

    :::image type="content" source="../media/1-open-jupyter-instance.png" alt-text="A screenshot showing where to launch the Jupyter link." lightbox="../media/1-open-jupyter-instance.png"::: 

1. Select the **Users** directory, then select your username.

    :::image type="content" source="../media/1-select-user-directory.png" alt-text="A screenshot showing how to navigate to the user directory in the Jupyter instance." lightbox="../media/1-select-user-directory.png"::: 

1. Download and extract the following provided [Jupyter workspace files](https://github.com/microsoft/Develop-Custom-Object-Detection-Models-with-NVIDIA-and-Azure-ML-Studio/raw/main/jupyter_workspace_compressed.zip).  You'll need to decompress the included _jupyter_workspace_compressed.zip_ file as the included files will be referenced in the next step.

1. We'll now upload the prerequisite files and create a folder location in our workspace:

    1. Select the **Upload** button (top right) and upload the *config.json* file that was obtained in previous steps (this file isn't included in the .zip file, this file was obtained earlier in the Azure portal and is unique to your account).
 
    1. Select the **Upload** button (top right) and upload the *test_image1.jpg* file.
    
    1. Select the **Upload** button (top right) and upload the *yolo_onnx_preprocessing_utils.py* python script.

    1. Select the **Upload** button (top right) and upload the *AutoMLImage_ObjectDetection.ipynb* Jupyter notebook. 

        The final view of the workspace should look like the following:

    :::image type="content" source="../media/2-jupyter-workspace.png" alt-text="A screenshot showing the Jupyter workspace with all necessary prerequisites." lightbox="../media/2-jupyter-workspace.png"::: 

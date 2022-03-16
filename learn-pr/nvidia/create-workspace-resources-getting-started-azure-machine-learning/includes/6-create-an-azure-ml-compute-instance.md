In this section, we'll create an online compute resource in Azure Machine Learning that will act as a pre-configured development environment.  This will provide the ability to execute Python code and run live Jupyter notebooks.  We will refence this development environment in additional modules that comprise the current Learning Path.

## Create an Azure Machine Learning Compute Instance

1. If you have not already launched the Azure Machine Learning Studio from the Machine Learning Overview mentioned at the end of the previous section, sign in to [Azure Machine Learning Studio](https://ml.azure.com/) now, and select your workspace.
  
1. On the left-hand pane, locate the "Manage" section and select "Compute".
 
    :::image type="content" source="../media/6-SelectCompute.png" alt-text="The Compute option is highlighted." lightbox="../media/6-SelectCompute.png":::  

1. On the resulting screen, select **+ New** to create a new compute instance.

    :::image type="content" source="../media/6-SelectNew.png" alt-text="The + New option is highlighted." lightbox="../media/6-SelectNew.png":::

1. In the **compute name** section, provide a unique value.  In the **Virtual machine type** section, select **GPU**.  Choose an appropriate machine from the list of populated options (suggested to choose **Standard_NC6**).  This instance will execute and train our custom object model using a Jupyter notebook in later steps.  When you have provided the appropriate values, select **Create** to begin the deployment of the compute instance.

    :::image type="content" source="../media/6-SelectCreate.png" alt-text="The Create option is highlighted." lightbox="../media/6-SelectCreate.png":::

1. The deployment should take a couple minutes to complete, but you are welcome to proceed to the next unit if you do not want to wait.  You should notice the **State** of the instance will eventually change from **Creating** to **Running**.  Once in the **Running** state, your compute instance is ready to access and use in upcoming sections of the Learning Path.

    :::image type="content" source="../media/6-ComputeInstanceCreating.png" alt-text="The compute instance is shown in the "Creating" state." lightbox="../media/6-ComputeInstanceCreating.png":::

    :::image type="content" source="../media/6-ComputeInstanceRunning.png" alt-text="The compute instance is shown in the "Running" state." lightbox="../media/6-ComputeInstanceRunning.png":::
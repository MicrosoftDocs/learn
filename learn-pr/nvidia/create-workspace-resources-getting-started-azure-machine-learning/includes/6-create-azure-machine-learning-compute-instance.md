In this section, we create an online compute resource in Azure Machine Learning that acts as a preconfigured development environment. This environment gives you the ability to execute Python code and run live Jupyter notebooks. We refence this development environment in other modules that comprise the current Learning Path.

## Create an Azure Machine Learning Compute Instance

1. Unless you already launched it from the Machine Learning Overview mentioned at the end of the previous section, sign in to [Azure Machine Learning studio](https://ml.azure.com/), and select your workspace.
  
1. On the left-hand pane, locate the **Manage** section and select **Compute**.

    :::image type="content" source="../media/6-select-compute.png" alt-text="A screenshot showing the Compute option is highlighted." lightbox="../media/6-select-compute.png":::  

1. On the resulting screen, select **+ New** to create a new compute instance.

    :::image type="content" source="../media/6-select-new.png" alt-text="A screenshot showing the + New option is highlighted." lightbox="../media/6-select-new.png":::

1. In the **compute name** section, provide a unique value. In the **Virtual machine type** section, select **GPU**. Choose an appropriate machine from the list of populated options. We suggest choosing **Standard_NC6**. This instance executes and trains our custom object model using a Jupyter notebook in later steps. When you're finished providing the appropriate values, select **Create** to begin the deployment of the compute instance.

    :::image type="content" source="../media/6-select-create.png" alt-text="A screenshot showing the Create option is highlighted." lightbox="../media/6-select-create.png":::

1. The deployment should take a couple minutes to complete, but you're welcome to proceed to the next unit if you don't want to wait. You should notice the **State** of the instance eventually change from **Creating** to **Running**. Once in the **Running** state, your compute instance is ready to access and use in upcoming sections of the Learning Path.

    :::image type="content" source="../media/6-compute-instance-creating.png" alt-text="A screenshot displays the compute instance shown in the Creating state." lightbox="../media/6-compute-instance-creating.png":::

    :::image type="content" source="../media/6-compute-instance-running.png" alt-text="A screenshot displays the compute instance shown in the Running state." lightbox="../media/6-compute-instance-running.png":::
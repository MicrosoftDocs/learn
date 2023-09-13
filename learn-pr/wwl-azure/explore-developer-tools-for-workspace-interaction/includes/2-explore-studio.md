

The easiest and most intuitive way to interact with the Azure Machine Learning workspace, is by using the **studio**. 

The Azure Machine Learning studio is a web portal, which provides an overview of all resources and assets available in the workspace. 

## Access the studio

After you've created an Azure Machine Learning workspace, there are two common ways to access the Azure Machine Learning studio:

- Launch the studio from the **Overview** page of the Azure Machine Learning workspace resource in the Azure portal. 
- Navigate to the studio directly by signing in at [https://ml.azure.com](https://ml.azure.com?azure-portal=true) using the credentials associated with your Azure subscription.

When you've opened your workspace in the Azure Machine Learning studio, a menu will appear in the sidebar. 

:::image type="content" source="../media/studio-home.png" alt-text="Diagram of different hyperparameter values resulting in different models by performing hyperparameter tuning.":::

The menu shows what you can do in the studio:

- **Author**: Create new jobs to train and track a machine learning model. 
- **Assets**: Create and review assets you use when training models. 
- **Manage**: Create and manage resources you need to train models.

To author a new job with the studio, you can use two graphical interfaces:

- **Designer**: A drag and drop interface that allows you to create *pipelines* with prebuilt (custom) *components*. 
- **Automated Machine Learning**: A wizard interface that enables you to train a model using a combination of algorithms and data preprocessing techniques to find the best model for your data.

Though you can use each tool at any time, you may prefer to use the studio whenever you want to use a *no-code* approach. Often, interacting with the workspace through the studio is ideal when you're exploring or when you quickly want to review your work. For example, use the studio if you want to verify that your pipeline ran successfully or what error messages were raised if the pipeline failed. 

For more repetitive work, or tasks that you'd like to automate, you may prefer to use the Azure CLI or Python SDK as these tools allow you to define your work in code.

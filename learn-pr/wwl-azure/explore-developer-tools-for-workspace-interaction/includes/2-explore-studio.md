

The easiest and most intuitive way to interact with the Azure Machine Learning workspace, is by using the **studio**. 

The Azure Machine Learning studio is a web portal, which provides an overview of all resources and assets available in the workspace. 

## Access the studio

After you've created an Azure Machine Learning workspace, there are two common ways to access the Azure Machine Learning studio:

- Launch the studio from the **Overview** page of the Azure Machine Learning workspace resource in the Azure portal.
- Navigate to the studio directly by signing in at [https://ml.azure.com](https://ml.azure.com?azure-portal=true) using the credentials associated with your Azure subscription.

When you've opened your workspace in the Azure Machine Learning studio, a menu appears in the sidebar.

:::image type="content" source="../media/studio-home.png" alt-text="Diagram of different hyperparameter values resulting in different models by performing hyperparameter tuning.":::

The menu shows what you can do in the studio:

- **Author**: Create new jobs to train and track a machine learning model.
- **Assets**: Create and review assets you use when training models.
- **Manage**: Create and manage resources you need to train models.

Though you can use each tool at any time, the studio is ideal for quick experimentation or when you want to explore your past jobs.

For example, use the studio if you want to verify that your pipeline ran successfully. Or when a pipeline job has failed, you can use the studio to navigate to the logs and review the error messages.

For more repetitive work, or tasks that you'd like to automate, the Azure CLI or Python SDK are better suited as these tools allow you to define your work in code.

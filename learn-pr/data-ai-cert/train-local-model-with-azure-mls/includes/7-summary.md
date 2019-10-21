In this module, you used the MNIST dataset to explore the Azure Machine Learning service. You learned that you can build and train your model both locally or via remote containers. You  trained a simple logistic regression model and a series of kNN models to find the one with the highest accuracy. The example you did was an image classification problem in which you want to determine the number contained in an image. Then you created an Azure Machine Learning experiment and used it to train a model. You submitted the model training run, monitored it, and retrieve the results.

Recall the two terms we defined:

**Run**, within the context of the Azure Machine Learning service, refers to Python code for a specific task, for example, training a model or tuning hyperparameters. Run does the job of logging metrics and upload result to Azure platform, it's a more natural way to keep track of jobs in your Workspace.

**Experiment** is a term referring to a composition of a series of runs. In the example, you have one run for the logistic regression model and another for the KNN model, and together they make up an experiment for you to compare results.

## Cleanup

To avoid additional costs in your Azure account, delete the resource group you created for this learning path. To remove all the resources we created in this module, follow these steps.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Find the resource group by selecting **Resource groups** in the Azure sidebar.

1. Select the resource group, and right-click on the row to open the context menu. You also can use the "..." button on the far-right side of the row.

1. Select **Delete resource group**.

1. Enter the name of the resource group, and select **Delete**. Azure removes all the resources for you.

## For further reading

Check out the following documentation links to learn more about using Azure Notebooks.

- [Azure Notebooks quickstart](https://docs.microsoft.com/azure/notebooks/quickstart-sign-in-azure-notebooks)
- [Explore HyperDrive with a Jupyter Notebook](https://github.com/Azure/MachineLearningNotebooks/blob/master/how-to-use-azureml/training-with-deep-learning/train-hyperparameter-tune-deploy-with-tensorflow/train-hyperparameter-tune-deploy-with-tensorflow.ipynb)

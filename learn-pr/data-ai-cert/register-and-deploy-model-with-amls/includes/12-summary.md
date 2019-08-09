In this module, you learned how to register and deploy a model at scale using the Azure Machine Learning service. You created a deployment workspace in the portal and your python script. You registered the model to the container registry and created a model scoring script used to define the call parameters needed by the REST API. Then you created a container image that defines the requirements of the deployment container and deployed your model to the container. Finally, you scored new data using the deployed container.

## Cleanup

To avoid additional costs in your Azure account, delete the **mslearn-amls** resource group. To remove all the resources we created in this module, follow these steps.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Find the **mslearn-amls** resource group by selecting **Resource groups** in the Azure sidebar.

1. Select the resource group, and right-click on the row to open the context menu. You also can use the "..." button on the far-right side of the row.

1. Select **Delete resource group**.

1. Enter the name of the resource group, and select **Delete**. Azure removes all the resources for you.

## For further reading

To explore the Azure Machine Learning service further with in-depth code samples, check out the [Machine Learning Notebook samples](https://github.com/Azure/MachineLearningNotebooks).

Check out all the details in the [Azure Machine Learning service documentation](https://docs.microsoft.com/azure/machine-learning/service/how-to-enable-data-collection).



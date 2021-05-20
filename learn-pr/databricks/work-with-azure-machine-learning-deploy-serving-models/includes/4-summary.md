In this module, you learned how to use Azure Databricks, MLflow, and Azure Machine Learning Python SDK to register trained models with Azure Machine Learning service and build container images that can be deployed as a scoring web service to either ACI for development and test and then subsequently to AKS to support production applications. As you develop newer version of your model, you also learned how to update an existing AKS deployment.

Now that you have concluded this module, you should know:

* Serve models with Azure Machine Learning

## Cleanup

If you plan to complete other Azure Databricks modules, don't delete your Azure Databricks instance yet. You can use the same environment for the other modules.

### Delete the Azure Databricks instance

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. In the left pane, select **Resource groups**, and then find the resource group that contains your Azure Databricks instance.
1. Select the resource group, and either right-click the row or use the **ellipsis** (**...**) button to open the context menu.
1. Select **Delete resource group**.
1. Enter the name of the resource group, and then select **Delete**.

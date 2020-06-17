In this module you learned how to use Azure Databricks and HorovodRunner to run distributed deep learning workloads. You learned how to shard the training data using both Pandas dataframe as well as Parquet files with Petastorm. Finally, you put your knowledge to the test by completing an exercise that required you to build a model and distribute the deep learning training process using both HorovodRunner and Petastorm.

Now that you have concluded this module, you should know:

* Use Horovod to train a distributed neural network
* Use Horovod to train a distributed neural network using Parquet files + Petastorm

## Cleanup

If you plan to complete other Azure Databricks modules, don't delete your Azure Databricks instance yet. You can use the same environment for the other modules.

### Delete the Azure Databricks instance

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. In the left pane, select **Resource groups**, and then find the resource group that contains your Azure Databricks instance.
1. Select the resource group, and either right-click the row or use the **ellipsis** (**...**) button to open the context menu.
1. Select **Delete resource group**.
1. Enter the name of the resource group, and then select **Delete**.

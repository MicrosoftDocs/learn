When performing the batch movement of data to populate a data warehouse, it is typical for the data engineer to understand the schedule on which the data loads take place. In these circumstances, you may be able to predict the periods of downtime in the data loading and querying process and take advantage of the pause operations to minimize your costs.

In the Azure portal you can use the Pause command within the dedicated SQL pool
> [!div class="mx-imgBorder"]  
> ![Pause the compute in the Azure portal.](../media/pause-compute-azure-portal.png)

And this can also be used within Azure Synapse Studio, in the Manage hub.
> [!div class="mx-imgBorder"]  
> ![Auto-pause Spark compute in the Azure Synapse Studio.](../media/pause-compute-azure-synapse-studio.png)

Which allows you to enable it, and set the number of minutes idle
> [!div class="mx-imgBorder"]  
> ![Auto-pause settings in the Azure Synapse Studio.](../media/auto-pause-settings.png)

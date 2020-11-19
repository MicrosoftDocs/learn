In order to create a Spark pool in Azure Synapse Analytics, you would have to create a Synapse Analytics Workspace. 
If you haven't already done so, please use the following steps. 

To do so go to:

![Azure Portal Create Resource](../media/azure-portal-create-resource.png)

In the search environment type Azure Synapse and select Azure Synapse Analytics Workspace preview:

![Azure Synapse Analytics Workspace Preview](../media/azure-synapse-analytics-workspace-preview.png)

Once you click 'Create', you'll have some parameters to fill out.

![Azure Synapse Analytics Workspace Parameters](../media/azure-synapse-analytics-workspace-parameters.png)

Once you've filled out the parameters please click Create and wait till the resource gets deployed. 
Once the resource i.e. the Azure Synapse Analytics Workspace resource, is created, navigate to the resource and add a Spark Pool as follows:

![Azure Synapse Analytics Add Spark Pool](../media/add-spark-pool.png)

Once you've selected Create New Apache Spark pool you'll be redirected to the following screen in which you'll have to specify a couple of parameters:

![Create Apache Spark Pool including Parameters](../media/create-apache-spark-pool-parameters.png)

Once you've filled out the basic parameters, you could also navigate to the additional settings tab in which you can customize additional configuration parameters including autoscale and component versions.

![Additional Settings set up for new Spark Pool](../media/additional-settings-new-spark-pool.png)

Once you've finished setting the parameters, you can click create and the Spark pool will be created. 



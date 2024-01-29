In this exercise, you will learn how to enable Log Analytics to monitor & collect logs for cluster pool and cluster operations on HDInsight on AKS. 

To integrate Log Analytics with HDInsight on AKS cluster, it must be configured at the cluster pool level first. You can enable the integration during cluster pool creation or post the creation. Once the integration at cluster pool is enabled, it isn't possible to disable the integration. However, you can disable the log analytics for individual clusters, which are part of the same pool.
There are 2 ways you can enable Log Analytics for your cluster once you have configured it at cluster pool level:

1.	Enable Log Analytics during **cluster** creation
2.	Enable Log Analytics post **cluster** creation

## Prerequisites

Log Analytics workspace. You can think of this workspace as a unique logs environment with its own data repository, data sources, and solutions. Learn how to create a Log Analytics workspace.

 Note
1. Log Analytics must be enabled at cluster pool level first to enable it at a cluster level.
2. The configuration at cluster pool level is a global switch for all clusters in the cluster pool, therefore all clusters in the same cluster pool can only flow log to one Log Analytics workspace.


Let’s enable LA for the Spark cluster created in the previous module

For this exercise, *create LA workspace - mycontosoLA*

### Steps to configure LA at the cluster pool

1.	In the Azure portal search bar, type "HDInsight on AKS cluster pools" and select Azure HDInsight on AKS cluster pools to go to the cluster pools page. On the HDInsight on AKS cluster pools page, select your cluster pool. 

Cluster pool for this exercise – “contosopool”

  :::image type="content" source="../media/Picture20.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture20.png":::

  :::image type="content" source="../media/Picture21.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture21.png":::

2.	Navigate to the "Monitor settings" blade on the left side menu and click on "Configure" to enable Log Analytics.

  :::image type="content" source="../media/Picture22.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture22.png":::

 
3. Select the Log Analytics workspace created at the beginning (mycontosoLA) and click Ok.

  :::image type="content" source="../media/Picture23.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture23.png":::
 
4. Once configured, you can check the monitoring setting. It should have LA status as enabled

  :::image type="content" source="../media/Picture24.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture24.png":::

Now, LA is configured at the cluster pool. Let’s proceed to enable it for the Spark cluster created as part of this Lab


### Steps to enable LA at the cluster 


1.	Navigate to the "Monitor settings" blade, select Enable Log Analytics. Choose one or more types of logs you would like to collect and click Save.

  :::image type="content" source="../media/Picture25.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture25.png":::

  :::image type="content" source="../media/Picture26.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture26.png":::
 

### Access the log and run queries

1.	Navigate to the Monitoring section and select the Logs blade to query and analyze the collected data.

  :::image type="content" source="../media/Picture27.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture27.png":::

2.	A list of commonly used query templates is provided to choose from to simplify the process or you can write your own query using the provided console.

  :::image type="content" source="../media/Picture28.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture28.png":::

  :::image type="content" source="../media/Picture29.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture29.png":::
 

  Example 

  :::image type="content" source="../media/Picture30.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="../media/Picture30.png":::



 

There are various methods for creating an HDInsight on AKS cluster, this can range from using the Azure portal for an easy user interface, to scripted setups that can help with automated deployments. The following table shows the different methods you can use to set up an HDInsight on AKS  cluster. 

 |	Create Clusters with 	|	Web browser 	|	Command line 	|	REST API 	|	SDK 	|
 | --- | --- | --- | --- | --- |
|	Azure portal 	|	✔ 	|		|		|		|
|	Azure PowerShell 	|		|	✔ 	|		|		|
|	cURL 	|		|	✔ 	|	✔ 	|		|
|	.NET SDK 	|		|		|		|	✔ 	|
|	Azure Resource Manager template 	|	✔ 	|	✔ 	|		|		|


In this exercise, you will create an Azure HDInsight on AKS Spark Cluster (mycluster) using the Azure portal with few clicks.

There are three ways to create an Azure HDInsight on AKS cluster from the Azure portal: 

 
**Option 1**: Search and create “Azure HDInsight on AKS cluster” from the marketplace. 

:::image type="content" source="../media/search-create-zure-hdinsight-aks-cluster.png" alt-text="Screenshot shows Search and create “Azure HDInsight on AKS cluster” from the marketplace." lightbox="../media/search-create-zure-hdinsight-aks-cluster.png":::
 
**Option 2**: Search and select “Azure HDInsight on AKS clusters” in the Azure portal to create cluster from the page listing all HDInsight on AKS clusters. 


:::image type="content" source="../media/search-select-hdinsight-aks-clusters-azure-portal.png" alt-text="Screenshot shows search and select Azure HDInsight on AKS clusters in the Azure portal." lightbox="../media/search-select-hdinsight-aks-clusters-azure-portal.png":::
 

**Option 3**: Create cluster by selecting New in the Overview page of an existing cluster pool.  
 
:::image type="content" source="../media/create-cluster.png" alt-text="Screenshot shows create cluster." lightbox="../media/create-cluster.png":::

**Let’s create the cluster using option 2**
 
Once you are in HDInsight on AKS create cluster page, create the cluster by providing minimum number of inputs. This option prefills the prerequisite configuration fields with smart defaults and auto-creates mandatory resources. 

You can opt for “use advanced configuration” in case you want to customize and see more options. 

1. Select the existing cluster pool, or if you don’t have a cluster pool, you can create one by using quick link “Create new”  

1. Select cluster type – “Spark” and update the cluster name – “mycluster” 

   :::image type="content" source="../media/select-cluster-type.png" alt-text="Screenshot shows select cluster type." lightbox="../media/select-cluster-type.png":::
 

   - Virtual Machine SKU size is prefilled with the least costing recommended SKU. In the absence of any recommended SKU, it is prefilled with the SKU with the least vCores and maximum quota available at the time of cluster creation. The cluster would be created with a default constant number of five nodes. Flink and Trino clusters would have two head nodes while Spark clusters would have three head nodes. 
  
   - The user assigned managed identity and storage account will be auto created in the managed resource group.  

1. Click “Review + create” to review the configurations of the cluster. Once you click Create, “The Deployment is in progress” page is displayed while the cluster is being created.  

A message that "Your deployment is complete" would be displayed once the cluster is fully deployed and ready for use.  

:::image type="content" source="../media/configurations-cluster.png" alt-text="Screenshot shows configurations of the cluster." lightbox="../media/configurations-cluster.png":::

Your Spark cluster “mycluster” is now ready to use. 

 

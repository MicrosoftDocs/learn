Clusters are individual compute workloads such as Apache Spark, Apache Flink, and Trino, which can be created rapidly in a few minutes with preset configurations and few clicks.
Let’s see how you can manage a cluster using Azure portal.

1.	Sign in to [Azure portal](https://ms.portal.azure.com/).

1.	In the Azure portal search bar, type “HDInsight on AKS clusters” and select “Azure HDInsight on AKS clusters” from the drop-down list.

    :::image type="content" source="../media/portal-search-bar.png" alt-text="Screenshot shows Azure portal search bar." lightbox="../media/portal-search-bar.png":::
 
1.	Select your cluster name (mycluster) from the list page.

       :::image type="content" source="../media/select-cluster-name.png" alt-text="Screenshot shows select cluster name." lightbox="../media/select-cluster-name.png":::
 
### View cluster details

You can view the cluster details in the "Overview" blade of your cluster. It provides general information and easy access to the tools that are part of the cluster.

|	Property	|	Description	|
|	--	|	--	|
|	Resource group	|	The resource group in which cluster is created.	|
|	Cluster pool name	|	Cluster pool name inside which the cluster is created.	|
|	Cluster type	|	The type of the cluster such as Spark, Trino, or Flink.	|
|	HDInsight on AKS version	|	HDInsight on AKS cluster version. For more information. see versioning.	|
|	Cluster endpoint	|	The endpoint of the cluster.	|
|	Cluster package	|	Component versions associated with the cluster.	|
|	Subscription details	|	Subscription name and subscription ID.	|
|	Location	|	The region in which the cluster is deployed.	|
|	Cluster size details	|	Node size, node type, and number of nodes.	|

:::image type="content" source="../media/cluster-details.png" alt-text="Screenshot shows view the cluster details." lightbox="../media/cluster-details.png":::

### Manage cluster size

You can check and modify the number of worker nodes for your cluster using "Cluster size" blade in the Azure portal. There are two options to scale up/down your cluster:

- Manual scale
- Auto scale
  
:::image type="content" source="../media/worker-nodes.png" alt-text="Screenshot shows check and modify the number of worker nodes." lightbox="../media/worker-nodes.png":::

### Manage cluster access

HDInsight on AKS provides comprehensive and fine-grained access control at both control plane and data plane, which allows you to manage cluster resources and provide access to cluster data plane.

Learn how to [manage access to your cluster](/azure/hdinsight-aks/hdinsight-on-aks-manage-authorization-profile).

### Configure secure shell (SSH)

Secure shell (SSH) allows you to submit jobs and queries to your cluster directly. You can enable or disable SSH using "Secure shell (SSH)" blade in the Azure portal.

> [!Note]
> Enabling SSH will create additional VMs in the cluster. The maximum allowed secure shell nodes are 5.

:::image type="content" source="../media/submit-jobs-queries.png" alt-text="Screenshot shows secure shell (SSH) allows you to submit jobs and queries to your cluster directly." lightbox="../media/submit-jobs-queries.png":::
  

### Manage cluster configuration

HDInsight on AKS allows you to tweak the configuration properties to improve performance of your cluster with certain settings. For example, usage or memory settings. In the Azure portal, use "Configuration management" blade of your cluster to manage the configurations.
You can do the following actions:

- Update the existing service configurations or add new configurations.
- Export the service configurations using RestAPI.

Learn how to manage the [cluster configuration](/azure/hdinsight-aks/service-configuration).

:::image type="content" source="../media/configuration-properties.png" alt-text="Screenshot shows configuration properties." lightbox="../media/configuration-properties.png":::

### View service details

In the Azure portal, use "Services" blade in your cluster to check the health of the services running in your cluster. It includes the collection of the services and the status of each service running in the cluster. You can drill down on each service to check instance level details.

Learn how to check [service health](/azure/hdinsight-aks/service-health).

:::image type="content" source="../media/health-services-run.png" alt-text="Screenshot shows health of the services running in your cluster." lightbox="../media/health-services-run.png":::
  

